<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * LoteReservado
 *
 * @ORM\Table(name="lote_asignado")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\LoteAsignadoRepository")
 */
class LoteAsignado
{
    use \AppBundle\Traits\LoteEstadoTrait;

   /**
     * @var Lote
     * @ORM\ManyToOne(targetEntity="Lote")
     * @ORM\JoinColumn(nullable=false)
     */
    private $lote;

    /**
     * Set lote
     *
     * @param \AppBundle\Entity\Lote $lote
     *
     * @return LoteAsignado
     */
    public function setLote(\AppBundle\Entity\Lote $lote)
    {
        $this->lote = $lote;

        return $this;
    }

    /**
     * Get lote
     *
     * @return \AppBundle\Entity\Lote
     */
    public function getLote()
    {
        return $this->lote;
    }

    /**
     * Set fabricacion
     *
     * @param \AppBundle\Entity\Fabricacion $fabricacion
     *
     * @return LoteAsignado
     */
    public function setFabricacion(\AppBundle\Entity\Fabricacion $fabricacion = null)
    {
        $this->fabricacion = $fabricacion;

        return $this;
    }

    /**
     * Get fabricacion
     *
     * @return \AppBundle\Entity\Fabricacion
     */
    public function getFabricacion()
    {
        return $this->fabricacion;
    }
}
