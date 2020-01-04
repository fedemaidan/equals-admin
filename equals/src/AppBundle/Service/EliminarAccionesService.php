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
use AppBundle\Entity\Compra;

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

    public function borrarFabricacion($idFabricacion) {
    	$fabricacion = $this->em->getRepository(Fabricacion::class)->findOneById($idFabricacion);
    	
    	$this->borrarLotesAsignados($fabricacion->getLoteAsignados(), $fabricacion->getEstado());
    	$this->borrarLotesFaltantes($fabricacion);
    	
    	if ($fabricacion->getEstado() == "fabricado") {	
            $lote = $fabricacion->getLote()[0];
            $asignados = $this->em->getRepository(LoteAsignado::class)->findByLote($lote);
            foreach ($asignados as $loteAs) {
                $this->borrar($loteAs);
            }
			$this->borrar($lote);	
    	}

    	$this->borrar($fabricacion);
    	
    }

    public function borrarRemito($idRemito) {
        $remito = $this->em->getRepository(Remito::class)->findOneById($idRemito);
        
        $this->borrarLotesAsignados($remito->getLoteAsignados(), $remito->getEstado());
        $this->borrarLotesFaltantes($remito);
        $this->borrarItemsRemitos($remito);

        $this->borrar($remito);
        
    }
    
    public function borrarCompra($idCompra) {
        $compra = $this->em->getRepository(Compra::class)->findOneById($idCompra);
        
        foreach ($compra->getLotes() as $lote) {
            $this->borrar($lote);
        }
        
        $this->borrar($compra);
        
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

                $loteDisponible = $lote->getCantidadDisponible();
                $loteDisponible += $loteAsignado->getCantidad();
                $lote->setCantidadDisponible($loteDisponible);
	    	}

	    	if ($estado == "fabricado" || $estado == "vendido") {
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

    private function borrarItemsRemitos($remito) {
        $items = $remito->getItemsRemito();
        foreach ($items as $key => $item) {
            $this->borrar($item);
        }
    }

    private function borrar($elemento) {
    	$this->em->remove($elemento);
    	$this->em->flush();
    }

}