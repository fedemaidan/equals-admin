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
use AppBundle\Entity\ItemRemito;
use AppBundle\Entity\Lote;
use Symfony\Component\HttpFoundation\Response;

class DashboardController extends Controller
{
 
	/**
     * @Route("/remitos", name="remito_list")
    */

    public function remitosAction()
    {
    	$em = $this->getDoctrine()->getManager();
		$remitos = $em->getRepository(Remito::class)->getUltimoMes();

        $remitosArray = [];

        foreach ($remitos as $key => $rem) {
            $row = [];

            $row[] = $rem->getEstado() != "vendido" ? '<button type="button" class="btn btn-danger btn-sm" onclick="eliminar(\''.$this->generateUrl('eliminarRemito',["remito_id"=> $rem->getId()]).'\',this)"><i class="glyphicon glyphicon-remove"></i></button>' : "";
            $row[] = $rem->getFechaModificacion()->format('Y-m-d');;
            $row[] = $rem->getNumero();
            $row[] = $rem->getCliente()->getNombre();
            
            $accionesPosibles = $this->botonesRemito($rem);
            
            $row[] = $accionesPosibles;
            $row[] = '<button class="remito-control details-control"><i class="glyphicon glyphicon-plus"></i></button>';
            $items = $em->getRepository(ItemRemito::class)->findBy(['remito' => $rem]);
            $itemsReturn = [];
            foreach ($items as $key => $item) {
                $itemsReturn[] = ["producto" => $item->getProducto()->getNombre(), "cantidad" => $item->getCantidad()];
            }

            $row[] = $itemsReturn;
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
        $fabricaciones = $em->getRepository(Fabricacion::class)->getUltimoMes();
        $fabricacionesArray = [];

        foreach ($fabricaciones as $key => $fab) {
            $row = [];
            $row[] = $fab->getFechaModificacion()->format('Y-m-d');;
            $row[] = count($fab->getLote()) > 0 ? $fab->getNumero(): $fab->getNumero().'(No creado aun)';
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
            $row[] = '<button class="stock-control details-control"><i class="glyphicon glyphicon-plus"></i></button>';
            $lotes = $em->getRepository(Lote::class)->loteCantidadMayorACero($prod, 'cantidadDisponible');
            $lotesReturn = [];
            foreach ($lotes as $key => $lote) {
                $lotesReturn[] = ["fecha"=>$lote->getFecha()->format("Y-m-d"),"numero" => $lote->getNumero(), "cantidadDisponible" => $lote->getCantidadDisponible()];
             }
            
            $row[] = $lotesReturn;
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
                $accionesPosibles = $this->botonesRemito($fal->getRemito(), "F");
            }
            if ($fal->getFabricacion()) {
                $tipo = "FABRICACION";
                $accionesPosibles = $this->botonesFabricacion($fal->getFabricacion(),"F");
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

    private function botonesRemito($rem, $prefijo = "") {

        $idBoton = $prefijo."remitoId".$rem->getId();
        switch ($rem->getEstado()) {
            case 'inconsistente':
                //$accionesPosibles = '<button class="btn btn-sm btn-warning" href="'.$this->generateUrl('admin_app_remito_completar',["id"=> $rem->getId(), 'dashboard' => true]).'"><b>Completar</b></button>';
                $accionesPosibles = '<button class="btn btn-sm btn-warning" id="'.$idBoton.'" onclick="confirmar(\''.$this->generateUrl('admin_app_remito_completar',["id"=> $rem->getId(), 'dashboard' => true]).'\',\''.$idBoton.'\')" ><b>Completar</b></button>';

                break;
            
            case 'pendiente':
                $accionesPosibles = '<button class="btn btn-sm btn-success refresh" id="'.$idBoton.'" onclick="confirmar(\''.$this->generateUrl('admin_app_remito_confirmar',["id"=> $rem->getId(), 'dashboard' => true]).')\',\''.$idBoton.'\')" target="_blank"><b>Confirmar </b></button>
                    <a class="btn btn-sm btn-info" href="'.$this->generateUrl('admin_app_remito_imprimir',["id"=> $rem->getId()]).'") }}"><b>Imprimir </b></a>';
                break;

            case 'vendido':
                $accionesPosibles = '<a class="btn btn-sm btn-info" href="'.$this->generateUrl('admin_app_remito_imprimir',["id"=> $rem->getId()]).'") }}"><b>Imprimir </b></a>';
                break;
        }

        return $accionesPosibles;
    }
    private function botonesFabricacion($fab ,$prefijo = "") {
        $idBoton = $prefijo."fabricacionId".$fab->getId();

        switch ($fab->getEstado()) {
            case 'inconsistente':
                $accionesPosibles = '<button class="btn btn-sm btn-warning" id="'.$idBoton.'" onclick="confirmar(\''.$this->generateUrl('admin_app_fabricacion_completar',["id"=> $fab->getId(), 'dashboard' => true]).'\',\''.$idBoton.'\')"><b>Completar</b></button>';
                break;
            
            case 'pendiente':
                $accionesPosibles = '<a class="btn btn-sm btn-success"  target="_blank" id="'.$idBoton.'" onclick="confirmar(\''.$this->generateUrl('admin_app_fabricacion_confirmar',["id"=> $fab->getId(), 'dashboard' => true]).'\',\''.$idBoton.'\')"><b>Confirmar </b></a>
                    <a class="btn btn-sm btn-info" href="'.$this->generateUrl('admin_app_fabricacion_imprimirOrden',["id"=> $fab->getId()]).'") }}"><b>Orden</b></a>
                    <a class="btn btn-sm btn-info" href="'.$this->generateUrl('admin_app_fabricacion_imprimirEtiqueta',["id"=> $fab->getId()]).'") }}"><b>Etiqueta </b></a>
                    <a class="btn btn-sm btn-info" href="'.$this->generateUrl('admin_app_fabricacion_imprimirCoa',["id"=> $fab->getId()]).'") }}"><b>COA </b></a>';
                break;

            case 'fabricado':
                $accionesPosibles = '<a class="btn btn-sm btn-info" href="'.$this->generateUrl('admin_app_fabricacion_imprimirOrden',["id"=> $fab->getId()]).'") }}"><b>Orden </b></a>
                <a class="btn btn-sm btn-info" href="'.$this->generateUrl('admin_app_fabricacion_imprimirEtiqueta',["id"=> $fab->getId()]).'") }}"><b>Etiqueta </b></a>
                <a class="btn btn-sm btn-info" href="'.$this->generateUrl('admin_app_fabricacion_imprimirCoa',["id"=> $fab->getId()]).'") }}"><b>COA </b></a>';
                break;
        }

        return $accionesPosibles;
    }
}

