<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * ItemRemito
 *
 * @ORM\Table(name="item_remito")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\ItemRemitoRepository")
 */
class ItemRemito
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
     * @ORM\Column(name="cantidad", type="integer")
     */
    private $cantidad;

    /**
     * @var Producto
     * @ORM\ManyToOne(targetEntity="Producto")
     */
    private $producto;

    /**
     * @var Remito
     * @ORM\ManyToOne(targetEntity="Remito")
     * @ORM\JoinColumn(nullable=false)
     */
    private $remito;


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
     * @param integer $cantidad
     *
     * @return ItemRemito
     */
    public function setCantidad($cantidad)
    {
        $this->cantidad = $cantidad;

        return $this;
    }

    /**
     * Get cantidad
     *
     * @return int
     */
    public function getCantidad()
    {
        return $this->cantidad;
    }

    /**
     * Set producto
     *
     * @param \AppBundle\Entity\Producto $producto
     *
     * @return ItemRemito
     */
    public function setProducto(\AppBundle\Entity\Producto $producto = null)
    {
        $this->producto = $producto;

        return $this;
    }

    /**
     * Get producto
     *
     * @return \AppBundle\Entity\Producto
     */
    public function getProducto()
    {
        return $this->producto;
    }

    /**
     * Set remito
     *
     * @param \AppBundle\Entity\Remito $remito
     *
     * @return ItemRemito
     */
    public function setRemito(\AppBundle\Entity\Remito $remito)
    {
        $this->remito = $remito;

        return $this;
    }

    /**
     * Get remito
     *
     * @return \AppBundle\Entity\Remito
     */
    public function getRemito()
    {
        return $this->remito;
    }

    public function __toString()
    {
        if ($this->getProducto())
            return $this->getProducto()->getNombre().' '.$this->getCantidad().' kilos';
        else 
            return "Sin producto";
    }
}
