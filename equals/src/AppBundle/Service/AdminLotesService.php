<?php

namespace AppBundle\Service;

use Doctrine\ORM\EntityManager;
use Symfony\Component\DependencyInjection\Container;
use AppBundle\Entity\Lote;
use AppBundle\Entity\LoteAsignado;
use AppBundle\Entity\Producto;

class AdminLotesService
{

	private $container;
    
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
            }
		}

		return $cantidad;
    }


    public function limpiarReservados($remito) {
        foreach ($remito->getLoteAsignado() as $key => $asignado) {
            $lote = $asignado->getLote();
            $reservadaFinal = $lote->getCantidadReservada() - $asignado->getCantidad();
            $lote->setCantidadReservada($reservadaFinal);
        }
    }


    public function cantidadDisponibleDe($producto) {
    	return $this->em->getRepository(Lote::class)->sumDe($producto, 'cantidadDisponible');
    }

    public function cantidadReservadaDe($producto) {
    	return $this->em->getRepository(Lote::class)->sumDe($producto, 'cantidadReservada');
    }
}