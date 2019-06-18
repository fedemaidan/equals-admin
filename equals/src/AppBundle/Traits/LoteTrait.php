<?php
namespace AppBundle\Traits;


trait LoteTrait 
{
	public function postLotePersist($lote) {

		if (!$lote->getNumero()) {
			$numero = $lote->getFabricacion()->getNumero();
			$lote->setNumero('L'.$numero);
		}
		
        $lote->setCantidadDisponible($lote->getCantidadInicial());
        return $lote;
	}
}
