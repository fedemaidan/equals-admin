<?php

namespace AppBundle\Controller;

use Sonata\AdminBundle\Controller\CRUDController as Controller;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\StreamedResponse;
use AppBundle\Entity\Fabricacion;
use Symfony\Component\HttpFoundation\JsonResponse;

class FabricacionCRUDController extends Controller
{
    public function actuarAction()
    {
        $remito = $this->admin->getSubject();
        var_dump("expression");die;

        return new RedirectResponse($this->admin->generateUrl('list', $this->admin->getFilterParameters()));
    }

    public function confirmarAction()
    {

        $dashboard = $this->get('request')->get('dashboard',false);
        $fabricacion = $this->admin->getSubject();

        if ($fabricacion->getEstado() == Fabricacion::Pendiente) {
            $fabricacion->setEstado(Fabricacion::Fabricado);
            $this->container->get('adminLotes_service')->crearLote($fabricacion);
            $this->container->get('adminLotes_service')->limpiarReservados($fabricacion);
            
            $em = $this->getDoctrine()->getManager();

            $em->persist($fabricacion);
            $em->flush();                
        }

        $this->addFlash('sonata_flash_success', 'La fabricación se confirmó con éxito');

        if ($dashboard) {
            $msg = "La fabricación se confirmó con éxito";
            
            return new JsonResponse([
                    "success" => true,
                    "message" => $msg
                ]);
        }

        return new RedirectResponse($this->admin->generateUrl('list', $this->admin->getFilterParameters()));
    }

    public function completarAction()
    {
        $dashboard = $this->get('request')->get('dashboard',false);

        $em = $this->getDoctrine()->getManager();
        $fabricacion = $this->admin->getSubject();
        $success = true;

        foreach ($fabricacion->getFaltantes() as $key => $faltante) {
            $cantidad = $this->container->get('adminLotes_service')->reservarLotesMasAntiguos($faltante->getProducto(), $faltante->getCantidad(), $fabricacion, "fabricacion");


            if ($cantidad == 0) {
                $fabricacion->removeFaltante($faltante);
                $fabricacion->setEstado(Fabricacion::Pendiente);
                $em->remove($faltante);
            }
            else {
                $faltante->setCantidad($cantidad);
                $this->addFlash('sonata_flash_error', 'Queda un faltante de '.$cantidad.' kilos de '.$faltante->getProducto()->getNombre());
                $success = false;
            }
        }

        if ($success) {       
                $em->persist($fabricacion);
                $em->flush();
            }

        if ($success) $this->addFlash('sonata_flash_success', 'La fabricación se completó con éxito');
        
        if ($dashboard) {
            $msg = $success ? "La fabricación se completó con éxito" : "Error";
            
            return new JsonResponse([
                    "success" => $success,
                    "message" => $msg
                ]);
        }
        return new RedirectResponse($this->admin->generateUrl('list', $this->admin->getFilterParameters()));
    }

    public function imprimirOrdenAction()
    {
        $fabricacion = $this->admin->getSubject();
        $doc = $fabricacion->imprimirOrden();
        $filename = "Orden Nº ".$fabricacion->getNumero()." ".$fabricacion->getFormulaEnzimatica()->getProductoResultante()->getNombre().".xlsx";
         
        $response =  new StreamedResponse(
            function () use ($doc) {
                $doc->save('php://output');
            }
        );

        $response->headers->set('Content-Type', 'application/vnd.ms-excel');
        $response->headers->set('Content-Disposition', 'attachment;filename="'.$filename.'"');
        $response->headers->set('Cache-Control','max-age=0');
        
        return $response;
    }

    public function imprimirEtiquetaAction()
    {
        $fabricacion = $this->admin->getSubject();
        $doc = $fabricacion->imprimirEtiqueta();
        $filename = $fabricacion->getFormulaEnzimatica()->getProductoResultante()->getNombre()." (".$fabricacion->getNumero().") - etiqueta.xlsx";
         
        $response =  new StreamedResponse(
            function () use ($doc) {
                $doc->save('php://output');
            }
        );

        $response->headers->set('Content-Type', 'application/vnd.ms-excel');
        $response->headers->set('Content-Disposition', 'attachment;filename="'.$filename.'"');
        $response->headers->set('Cache-Control','max-age=0');
        
        return $response;
    }

    public function imprimirCoaAction()
    {
        $fabricacion = $this->admin->getSubject();
        $doc = $fabricacion->imprimirCoa();
        $filename = $fabricacion->getFormulaEnzimatica()->getProductoResultante()->getNombre(). "LOTE ".$fabricacion->getNumero().".docx";
         
        $response =  new StreamedResponse(
            function () use ($doc) {
                $doc->save('php://output');
            }
        );

        $response->headers->set('Content-Type', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document');
        $response->headers->set('Content-Disposition', 'attachment;filename="'.$filename.'"');
        $response->headers->set('Cache-Control','max-age=0');
        
        return $response;
    }
    
}

