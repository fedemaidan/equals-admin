<?php
namespace AppBundle\Traits;


trait LoteTrait 
{
	public function postLotePersist($lote) {
		$lote->setNumero('L'.$lote->getId());
        $lote->setCantidadDisponible($lote->getCantidadInicial());
        return $lote;
	}
}
