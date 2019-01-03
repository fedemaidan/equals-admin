<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Ingrediente
 *
 * @ORM\Table(name="ingrediente")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\IngredienteRepository")
 */
class Ingrediente
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
     * @ORM\JoinColumn(nullable=true)
     */
    private $producto;

    /**
     * @var TipoFabricacion
     * @ORM\ManyToOne(targetEntity="TipoFabricacion")
     * @ORM\JoinColumn(nullable=false)
     */
    private $tipoFabricacion;


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
     * @return Ingrediente
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
     * @return Ingrediente
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
     * Set compra
     *
     * @param \AppBundle\Entity\TipoFabricacion $compra
     *
     * @return Ingrediente
     */
    public function setCompra(\AppBundle\Entity\TipoFabricacion $compra)
    {
        $this->compra = $compra;

        return $this;
    }

    /**
     * Get compra
     *
     * @return \AppBundle\Entity\TipoFabricacion
     */
    public function getCompra()
    {
        return $this->compra;
    }

    /**
     * Set tipoFabricacion
     *
     * @param \AppBundle\Entity\TipoFabricacion $tipoFabricacion
     *
     * @return Ingrediente
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

    public function __toString()
    {
        return strval($this->getProducto().'  '.$this->getCantidad().'Kilos');
    }
}
