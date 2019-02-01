<?php
namespace AppBundle\Traits;


trait LoteTrait 
{
	public function postLotePersist($lote) {
		if (!$lote->getNumero())
			$lote->setNumero('L'.$lote->getId());
        $lote->setCantidadDisponible($lote->getCantidadInicial());
        return $lote;
	}
}
