<?php
namespace AppBundle\Traits;


trait AdminLotesEstadoTrait
{

    /**
     * Add faltante
     *
     * @param \AppBundle\Entity\LoteFaltante $faltante
     *
     * @return Remito
     */
    public function addFaltante(\AppBundle\Entity\LoteFaltante $faltante)
    {
        $this->faltantes[] = $faltante;

        return $this;
    }

    /**
     * Remove faltante
     *
     * @param \AppBundle\Entity\LoteFaltante $faltante
     */
    public function removeFaltante(\AppBundle\Entity\LoteFaltante $faltante)
    {
        $this->faltantes->removeElement($faltante);
    }

    /**
     * Get faltantes
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getFaltantes()
    {
        return $this->faltantes;
    }

    /**
     * Add loteAsignado
     *
     * @param \AppBundle\Entity\LoteAsignado $loteAsignado
     *
     * @return Remito
     */
    public function addLoteAsignado(\AppBundle\Entity\LoteAsignado $loteAsignado)
    {
        $this->loteAsignados[] = $loteAsignado;

        return $this;
    }

    /**
     * Remove loteAsignado
     *
     * @param \AppBundle\Entity\LoteAsignado $loteAsignado
     */
    public function removeLoteAsignado(\AppBundle\Entity\LoteAsignado $loteAsignado)
    {
        $this->loteAsignados->removeElement($loteAsignado);
    }

    /**
     * Get loteAsignado
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getLoteAsignado()
    {
        return $this->loteAsignados;
    }
}
