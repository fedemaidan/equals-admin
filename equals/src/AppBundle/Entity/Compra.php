<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Compra
 *
 * @ORM\Table(name="compra")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\CompraRepository")
 */
class Compra
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
     * @var Producto
     * @ORM\ManyToOne(targetEntity="Proveedor")
     */
    private $proveedor;

    /**
     * @var Lote
     * @ORM\OneToMany(targetEntity="Lote", mappedBy="compra",cascade={"persist"})
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
     * Constructor
     */
    public function __construct()
    {
        $this->lotes = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * Set proveedor
     *
     * @param \AppBundle\Entity\Proveedor $proveedor
     *
     * @return Compra
     */
    public function setProveedor(\AppBundle\Entity\Proveedor $proveedor = null)
    {
        $this->proveedor = $proveedor;

        return $this;
    }

    /**
     * Get proveedor
     *
     * @return \AppBundle\Entity\Proveedor
     */
    public function getProveedor()
    {
        return $this->proveedor;
    }

    /**
     * Add lote
     *
     * @param \AppBundle\Entity\Lote $lote
     *
     * @return Compra
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

    public function __toString()
    {
        return $this->getId().'-'.$this->getProveedor();
    }
}