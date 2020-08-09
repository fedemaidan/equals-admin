<?php

namespace AppBundle\Service;

use Doctrine\ORM\EntityManager;
use Symfony\Component\DependencyInjection\Container;
use AppBundle\Entity\Lote;
use AppBundle\Entity\Movimiento;


class AdminMovimiento
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


   	public function crearMovimientoCompra($lote) {
   		$movimiento = $this->crearMovimiento($lote);
   		$movimiento->setCompra($lote->getCompra());

        $this->em->persist($movimiento);
   		$this->em->flush();
   	}

   	public function crearMovimientoFabricacion($fabricacion) {
   		$movimiento = $this->crearMovimiento($fabricacion->getLote()->first());
   		$movimiento->setFabricacion($fabricacion);

        $this->em->persist($movimiento);
   		$this->em->flush();
   	}

   	public function crearMovimientoEgreso($lote, $cantidad, $tipo, $obj) {
   		$movimiento = new Movimiento();
        $movimiento->setOperacion("egreso");
        $movimiento->setKilos($cantidad);
        $movimiento->setFecha(new \DateTime());
        $movimiento->setLote($lote);
        if ($tipo == "remito")
        	$movimiento->setRemito($obj);
        if ($tipo == "fabricacion")
            $movimiento->setFabricacion($obj);

        $this->em->persist($movimiento);
   	}

   	public function crearMovimiento($lote) {
   		$movimiento = new Movimiento();
        $movimiento->setOperacion("ingreso");
        $movimiento->setKilos($lote->getCantidadDisponible());
        $movimiento->setFecha($lote->getFecha());
        $movimiento->setLote($lote);
        return $movimiento;
   	}

}