<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Fabricacion
 *
 * @ORM\Table(name="fabricacion")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\FabricacionRepository")
 */
class Fabricacion
{
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var int
     *
     * @ORM\Column(name="cantidad", type="decimal",  precision=7, scale=2, nullable=false)
     */
    private $cantidad;

    /**
     * @var TipoFabricacion
     * @ORM\ManyToOne(targetEntity="TipoFabricacion")
     * @ORM\JoinColumn(nullable=false)
     */
    private $tipoFabricacion;

    /**
     * @var Lote
     * @ORM\OneToMany(targetEntity="Lote", mappedBy="fabricacion",cascade={"persist"})
     */
    private $lotes;

    /**
     * Get id
     *
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set cantidad
     *
     * @param float $cantidad
     *
     * @return Fabricacion
     */
    public function setCantidad($cantidad)
    {
        $this->cantidad = $cantidad;

        return $this;
    }

    /**
     * Get cantidad
     *
     * @return float
     */
    public function getCantidad()
    {
        return $this->cantidad;
    }
    /**
     * Constructor
     */
    public function __construct()
    {
        $this->lotes = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * Set tipoFabricacion
     *
     * @param \AppBundle\Entity\TipoFabricacion $tipoFabricacion
     *
     * @return Fabricacion
     */
    public function setTipoFabricacion(\AppBundle\Entity\TipoFabricacion $tipoFabricacion)
    {
        $this->tipoFabricacion = $tipoFabricacion;

        return $this;
    }

    /**
     * Get tipoFabricacion
     *
     * @return \AppBundle\Entity\TipoFabricacion
     */
    public function getTipoFabricacion()
    {
        return $this->tipoFabricacion;
    }

    /**
     * Add lote
     *
     * @param \AppBundle\Entity\Lote $lote
     *
     * @return Fabricacion
     */
    public function addLote(\AppBundle\Entity\Lote $lote)
    {
        $this->lotes[] = $lote;

        return $this;
    }

    /**
     * Remove lote
     *
     * @param \AppBundle\Entity\Lote $lote
     */
    public function removeLote(\AppBundle\Entity\Lote $lote)
    {
        $this->lotes->removeElement($lote);
    }

    /**
     * Get lotes
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getLotes()
    {
        return $this->lotes;
    }
}
