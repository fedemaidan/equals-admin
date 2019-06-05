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

class EliminarAccionesService
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

    const Pendiente = "pendiente";
    const Inconsistente = "inconsistente";
    const Fabricado = "fabricado";

    public function borrarFabricacion($idFabricacion) {
    	$fabricacion = $this->em->getRepository(Fabricacion::class)->findOneById($idFabricacion);
    	
    	$this->borrarLotesAsignados($fabricacion->getLoteAsignados(), $fabricacion->getEstado());
    	$this->borrarLotesFaltantes($fabricacion);
    	
    	if ($fabricacion->getEstado() == "fabricado") {	
			$this->borrar($fabricacion->getLote()[0]);	
    	}

    	$this->borrar($fabricacion);
    	
    }
    
    /*
		Por cada loteAccion debo re-asignarle la cantidad extraida previamente y para luego borrarlo
    */
    private function borrarLotesAsignados($lotesAsignados, $estado) {
    	

		foreach ($lotesAsignados as $key => $loteAsignado) {
			$lote = $loteAsignado->getLote();

			//Hacer un strategy con el estado
			if ($estado == "pendiente") {
    			$loteReservado = $lote->getCantidadReservada();
				$loteReservado -= $loteAsignado->getCantidad();
				$lote->setCantidadReservada($loteReservado);
	    	}

	    	if ($estado == "fabricado") {
	    		$loteDisponible = $lote->getCantidadDisponible();
				$loteDisponible += $loteAsignado->getCantidad();
				$lote->setCantidadDisponible($loteDisponible);
	    	}

	    	$this->em->persist($lote);
	    	$this->borrar($loteAsignado);

    	}
    }

    private function borrarLotesFaltantes($elemento) {
    	$lotes = $elemento->getFaltantes();
    	foreach ($lotes as $key => $lote) {
    		$this->borrar($lote);
    	}
    }

    private function borrar($elemento) {
    	$this->em->remove($elemento);
    	$this->em->flush();
    }

}