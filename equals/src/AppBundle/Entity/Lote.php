<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Lote
 *
 * @ORM\Table(name="lote")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\LoteRepository")
 */
class Lote
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
     * @var string
     *
     * @ORM\Column(name="numero", type="string", length=255, nullable=true, unique=true)
     */
    private $numero;

    /**
     * @var int
     *
     * @ORM\Column(name="cantidadInicial", type="integer")
     */
    private $cantidadInicial;

    /**
     * @var int
     *
     * @ORM\Column(name="cantidadDisponible", type="integer", nullable=true)
     */
    private $cantidadDisponible;

    /**
     * @var string
     *
     * @ORM\Column(name="costo", type="decimal",  precision=7, scale=2, nullable=true)
     */
    private $costo;

    /**
     * @var Producto
     * @ORM\ManyToOne(targetEntity="Producto")
     * @ORM\JoinColumn(nullable=true)
     */
    private $producto;

    /**
     * @var Compra
     * @ORM\ManyToOne(targetEntity="Compra")
     * @ORM\JoinColumn(nullable=true)
     */
    private $compra;


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
     * Set numero
     *
     * @param string $numero
     *
     * @return Lote
     */
    public function setNumero($numero)
    {
        $this->numero = $numero;

        return $this;
    }

    /**
     * Get numero
     *
     * @return string
     */
    public function getNumero()
    {
        return $this->numero;
    }

    
    /**
     * Set producto
     *
     * @param \AppBundle\Entity\Producto $producto
     *
     * @return Lote
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

    public function __toString()
    {
        if ($this->getProducto())
            return $this->getNumero().'-'.$this->getProducto()->getNombre();
        else 
            return strval($this->getNumero());
    }

    /**
     * Set cantidadInicial
     *
     * @param integer $cantidadInicial
     *
     * @return Lote
     */
    public function setCantidadInicial($cantidadInicial)
    {
        $this->cantidadInicial = $cantidadInicial;

        return $this;
    }

    /**
     * Get cantidadInicial
     *
     * @return integer
     */
    public function getCantidadInicial()
    {
        return $this->cantidadInicial;
    }

    /**
     * Set cantidadDisponible
     *
     * @param integer $cantidadDisponible
     *
     * @return Lote
     */
    public function setCantidadDisponible($cantidadDisponible)
    {
        $this->cantidadDisponible = $cantidadDisponible;

        return $this;
    }

    /**
     * Get cantidadDisponible
     *
     * @return integer
     */
    public function getCantidadDisponible()
    {
        return $this->cantidadDisponible;
    }

    /**
     * Set costo
     *
     * @param string $costo
     *
     * @return Lote
     */
    public function setCosto($costo)
    {
        $this->costo = $costo;

        return $this;
    }

    /**
     * Get costo
     *
     * @return string
     */
    public function getCosto()
    {
        return $this->costo;
    }

    /**
     * Set compra
     *
     * @param \AppBundle\Entity\Compra $compra
     *
     * @return Lote
     */
    public function setCompra(\AppBundle\Entity\Compra $compra = null)
    {
        $this->compra = $compra;

        return $this;
    }

    /**
     * Get compra
     *
     * @return \AppBundle\Entity\Compra
     */
    public function getCompra()
    {
        return $this->compra;
    }
}
