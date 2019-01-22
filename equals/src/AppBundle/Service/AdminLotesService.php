<?php

namespace AppBundle\Service;

use Doctrine\ORM\EntityManager;
use Symfony\Component\DependencyInjection\Container;
use AppBundle\Entity\Lote;
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

	public function reservarLotesMasAntiguos( $producto, $cantidad ) {
		$lotes = $this->em->getRepository(Lote::class)->loteCantidadMayorACero($producto, 'cantidadDisponible');
		
		foreach ($lotes as $lote) {
			$cantidad = $lote->reservar($cantidad);
		}

		return $cantidad;
    }

    public function cantidadDisponibleDe($producto) {
    	return $this->em->getRepository(Lote::class)->sumDe($producto, 'cantidadDisponible');
    }

    public function cantidadReservadaDe($producto) {
    	return $this->em->getRepository(Lote::class)->sumDe($producto, 'cantidadReservada');
    }
}