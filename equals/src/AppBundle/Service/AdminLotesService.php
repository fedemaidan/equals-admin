<?php

namespace AppBundle\Service;

use Doctrine\ORM\EntityManager;
use Symfony\Component\DependencyInjection\Container;
use AppBundle\Entity\Lote;
use AppBundle\Entity\LoteAsignado;
use AppBundle\Entity\LoteFaltante;
use AppBundle\Entity\Fabricacion;
use AppBundle\Entity\Producto;
use AppBundle\Entity\Remito;

class AdminLotesService
{

	private $container;
    use \AppBundle\Traits\LoteTrait;

    /**
    *
    * @var EntityManager
    */
    private $em;


    public function __construct( Container $container, EntityManager $entityManager )
    {
        $this->container = $container;
        $this->em = $entityManager;
    }

	public function reservarLotesMasAntiguos( $producto, $cantidad, $obj, $tipo = "remito" ) {
		$lotes = $this->em->getRepository(Lote::class)->loteCantidadMayorACero($producto, 'cantidadDisponible');
		
		foreach ($lotes as $lote) {
            $aux = $cantidad;
			$cantidad = $lote->reservar($cantidad);
            $cantidadReservada = $aux - $cantidad;
            if ($cantidadReservada > 0) {
                $loteAsignado = new LoteAsignado();
                $loteAsignado->setCantidad($cantidadReservada);
                $obj->addLoteAsignado($loteAsignado);
                $loteAsignado->setLote($lote);
                if ($tipo == "remito")
                    $loteAsignado->setRemito($obj);
                if ($tipo == "fabricacion")
                    $loteAsignado->setFabricacion($obj);

                $this->container->get('adminMovimientos_service')->crearMovimientoEgreso($lote, $cantidadReservada, $tipo, $obj);

            }
		}

		return $cantidad;
    }

    public function preInitRemito($remito) {
        foreach ($remito->getItemsRemito() as $item) {
            $item->setRemito($remito); 
            $cantidad = $this->reservarLotesMasAntiguos($item->getProducto(), $item->getCantidad(), $remito);
            
            if ($cantidad > 0) {
                $faltante = new LoteFaltante();
                $faltante->setProducto($item->getProducto());
                $faltante->setCantidad($cantidad);
                $faltante->setRemito($remito);
                $remito->addFaltante($faltante);
                $remito->setEstado(Remito::Inconsistente);
            }
            else
                $remito->setEstado(Remito::Pendiente);
        }
    }

    public function preInitFabricacion($fabricacion) {
        $ingredientes = $fabricacion->getFormulaEnzimatica()->getIngredientes();
        $estado = Fabricacion::Pendiente;
        foreach ($ingredientes as $ingre) {
            $cantidad = $ingre->getPorcentaje() * $fabricacion->getCantidad() / 100;
            $cantidad = $this->reservarLotesMasAntiguos($ingre->getProducto(), $cantidad, $fabricacion, 'fabricacion');
            
            if ($cantidad > 0) {
                $faltante = new LoteFaltante();
                $faltante->setProducto($ingre->getProducto());
                $faltante->setCantidad($cantidad);
                $faltante->setFabricacion($fabricacion);
                $fabricacion->addFaltante($faltante);
                $estado = Fabricacion::Inconsistente;
            }
        }

        $fabricacion->setEstado($estado);
    }


    public function limpiarReservados($obj) {
        foreach ($obj->getLoteAsignado() as $key => $asignado) {
            $lote = $asignado->getLote();
            $reservadaFinal = $lote->getCantidadReservada() - $asignado->getCantidad();
            $lote->setCantidadReservada($reservadaFinal);
        }
    }

    public function crearLote($fabricacion) {
        $lote = new Lote();
        $lote->setCantidadInicial($fabricacion->getCantidad());
        $lote->setProducto($fabricacion->getFormulaEnzimatica()->getProductoResultante());
        $lote->setFabricacion($fabricacion);
        $this->em->persist($lote);
        $this->em->flush();
        $this->postLotePersist($lote);
        $this->em->flush();

        $this->container->get('adminMovimientos_service')->crearMovimientoFabricacion($fabricacion);
        
    }

    public function cantidadDisponibleDe($producto) {
    	return $this->em->getRepository(Lote::class)->sumDe($producto, 'cantidadDisponible');
    }

    public function cantidadReservadaDe($producto) {
    	return $this->em->getRepository(Lote::class)->sumDe($producto, 'cantidadReservada');
    }

}