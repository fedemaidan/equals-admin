<?php

namespace AppBundle\Controller;

use Sonata\AdminBundle\Controller\CRUDController as Controller;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\StreamedResponse;
use AppBundle\Entity\Remito;

class RemitoCRUDController extends Controller
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
        $remito = $this->admin->getSubject();
        $success = true;

        if ($remito->getEstado() == Remito::Pendiente) {
            $remito->setEstado(Remito::Vendido);
            $this->container->get('adminLotes_service')->limpiarReservados($remito);

            $em = $this->getDoctrine()->getManager();
            $em->persist($remito);
            $em->flush();
        }

        if ($success) $this->addFlash('sonata_flash_success', 'El remito se confirmó con éxito');
        if ($dashboard) return new RedirectResponse('/admin/dashboard');

        return new RedirectResponse($this->admin->generateUrl('list', $this->admin->getFilterParameters()));
    }

    public function completarAction()
    {

        $dashboard = $this->get('request')->get('dashboard',false);
        $em = $this->getDoctrine()->getManager();
        $remito = $this->admin->getSubject();
        $success = true;

        foreach ($remito->getFaltantes() as $key => $faltante) {
            $cantidad = $this->container->get('adminLotes_service')->reservarLotesMasAntiguos($faltante->getProducto(), $faltante->getCantidad(), $remito);

            if ($cantidad == 0) {
                $remito->removeFaltante($faltante);
                $remito->setEstado(Remito::Pendiente);
                $em->remove($faltante);
            }
            else  {
                $faltante->setCantidad($cantidad);
                $this->addFlash('sonata_flash_error', 'Queda un faltante de '.$cantidad.' kilos de '.$faltante->getProducto()->getNombre());
                $success = false;
            }
        }

        $em->persist($remito);
        $em->flush();
        
        if ($success) $this->addFlash('sonata_flash_success', 'El remito se completó con éxito');
        if ($dashboard) return new RedirectResponse('/admin/dashboard');

        return new RedirectResponse($this->admin->generateUrl('list', $this->admin->getFilterParameters()));
    }

    public function imprimirAction()
    {
        $remito = $this->admin->getSubject();
        $doc = $remito->imprimir();
        $filename = "Remito-".$remito->getId().".xlsx";
         
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
    
}

