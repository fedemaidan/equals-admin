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
        $remito = $this->admin->getSubject();

        if ($remito->getEstado() == Remito::Pendiente) {
            $remito->setEstado(Remito::Vendido);
            $em = $this->getDoctrine()->getManager();
            $em->persist($remito);
            $em->flush();                
        }

        return new RedirectResponse($this->admin->generateUrl('list', $this->admin->getFilterParameters()));
    }

    public function completarAction()
    {
        $em = $this->getDoctrine()->getManager();
        $remito = $this->admin->getSubject();
        foreach ($remito->getFaltantes() as $key => $faltante) {
            $cantidad = $this->container->get('adminLotes_service')->reservarLotesMasAntiguos($faltante->getProducto(), $faltante->getCantidad());

            if ($cantidad == 0) {
                $remito->removeFaltante($faltante);
                $remito->setEstado(Remito::Pendiente);
                $em->remove($faltante);
            }
            else if ($cantidad < $faltante->getCantidad()) {
                $faltante->setCantidad($cantidad);
            }
        }

        
        $em->persist($remito);
        $em->flush();

        return new RedirectResponse($this->admin->generateUrl('list', $this->admin->getFilterParameters()));
    }

    public function imprimirAction()
    {
        $remito = $this->admin->getSubject();
        $doc = $remito->imprimir();
        $filename = "Remito-".$remito->getId().".xlsx";
         
        //$doc->save('php://output');

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

