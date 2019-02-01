<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\StreamedResponse;
use AppBundle\Entity\Fabricacion;
use AppBundle\Entity\Producto;
use AppBundle\Entity\Remito;
use AppBundle\Entity\LoteFaltante;
use Symfony\Component\HttpFoundation\Response;

class DashboardController extends Controller
{
 
	/**
     * @Route("/remitos", name="remito_list")
    */

    public function remitosAction()
    {
    	$em = $this->getDoctrine()->getManager();
		$remitos = $em->getRepository(Remito::class)->findBy([],["fechaModificacion" => 'DESC']);
        $remitosArray = [];

        foreach ($remitos as $key => $rem) {
            $row = [];
            $row[] = $rem->getFechaModificacion()->format('Y-m-d');;
            $row[] = $rem->getId();
            $row[] = $rem->getCliente()->getNombre();
            $accionesPosibles = $this->botonesRemito($rem);
            
            $row[] = $accionesPosibles;
            $remitosArray[] = $row;
        }

        $return = [
            "data" => $remitosArray
        ];
    
        return new Response(json_encode($return));
    }


    /**
     * @Route("/fabricacion", name="fabricacion_list")
    */


    public function fabricacionAction()
    {
    	$em = $this->getDoctrine()->getManager();
        $fabricaciones = $em->getRepository(Fabricacion::class)->findBy([],["fechaModificacion" => 'DESC']);
        $fabricacionesArray = [];

        foreach ($fabricaciones as $key => $fab) {
            $row = [];
            $row[] = $fab->getFechaModificacion()->format('Y-m-d');;
            $row[] = $fab->getId();
            $row[] = $fab->getCantidad();
            $row[] = $fab->getFormulaEnzimatica()->getProductoResultante()->getNombre();
            $accionesPosibles = $this->botonesFabricacion($fab);
            
            $row[] = $accionesPosibles;
            $fabricacionesArray[] = $row;
        }

        $return = [
            "data" => $fabricacionesArray
        ];
    
        return new Response(json_encode($return));
    }
    /**
     * @Route("/stock", name="stock_list")
    */

    public function stockAction()
    {
    	$em = $this->getDoctrine()->getManager();
		$productos = $em->getRepository(Producto::class)->findAll();
		$productosArray = [];

		foreach ($productos as $key => $prod) {
			$row = [];
			$row[] = $prod->getNombre();
			$row[] = $this->container->get('adminLotes_service')->cantidadDisponibleDe($prod);
			$row[] = $this->container->get('adminLotes_service')->cantidadReservadaDe($prod);
			$productosArray[] = $row;
		}

		$return = [
			"data" => $productosArray
		];
  
        return new Response(json_encode($return));
    }


    /**
     * @Route("/faltantes", name="faltantes_list")
    */


    public function faltanteAction()
    {
        $em = $this->getDoctrine()->getManager();
        $faltantes = $em->getRepository(LoteFaltante::class)->findBy([],["id" => 'DESC']);
        $faltantesArray = [];

        foreach ($faltantes as $key => $fal) {
            $row = [];
            $row[] = $fal->getProducto()->getNombre();
            $row[] = $fal->getCantidad();
            $tipo = '';
            if ($fal->getRemito()) {
                $tipo = "REMITO";
                $accionesPosibles = $this->botonesRemito($fal->getRemito());
            }
            if ($fal->getFabricacion()) {
                $tipo = "FABRICACION";
                $accionesPosibles = $this->botonesFabricacion($fal->getFabricacion());
            }
            $row[] = $tipo;
            $row[] = $accionesPosibles;
            $faltantesArray[] = $row;
        }

        $return = [
            "data" => $faltantesArray
        ];
    
        return new Response(json_encode($return));
    }

    private function botonesRemito($rem) {
        switch ($rem->getEstado()) {
            case 'inconsistente':
                $accionesPosibles = '<a class="btn btn-sm btn-warning" href="'.$this->generateUrl('admin_app_remito_completar',["id"=> $rem->getId(), 'dashboard' => true]).'"><b>Completar</b></a>';
                break;
            
            case 'pendiente':
                $accionesPosibles = '<a class="btn btn-sm btn-success" href="'.$this->generateUrl('admin_app_remito_confirmar',["id"=> $rem->getId(), 'dashboard' => true]).'"><b>Confirmar </b></a>
                    <a class="btn btn-sm btn-info" href="'.$this->generateUrl('admin_app_remito_imprimir',["id"=> $rem->getId()]).'") }}"><b>Imprimir </b></a>';
                break;

            case 'vendido':
                $accionesPosibles = '<a class="btn btn-sm btn-info" href="'.$this->generateUrl('admin_app_remito_imprimir',["id"=> $rem->getId()]).'") }}"><b>Imprimir </b></a>';
                break;
        }

        return $accionesPosibles;
    }
    private function botonesFabricacion($fab) {
        switch ($fab->getEstado()) {
            case 'inconsistente':
                $accionesPosibles = '<a class="btn btn-sm btn-warning" href="'.$this->generateUrl('admin_app_fabricacion_completar',["id"=> $fab->getId(), 'dashboard' => true]).'"><b>Completar</b></a>';
                break;
            
            case 'pendiente':
                $accionesPosibles = '<a class="btn btn-sm btn-success" href="'.$this->generateUrl('admin_app_fabricacion_confirmar',["id"=> $fab->getId(), 'dashboard' => true]).'"><b>Confirmar </b></a>
                    <a class="btn btn-sm btn-info" href="'.$this->generateUrl('admin_app_fabricacion_imprimir',["id"=> $fab->getId()]).'") }}"><b>Imprimir </b></a>';
                break;

            case 'fabricado':
                $accionesPosibles = '<a class="btn btn-sm btn-info" href="'.$this->generateUrl('admin_app_fabricacion_imprimir',["id"=> $fab->getId()]).'") }}"><b>Imprimir </b></a>';
                break;
        }

        return $accionesPosibles;
    }
}

