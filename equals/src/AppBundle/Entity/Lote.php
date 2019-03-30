<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
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
     * @ORM\Column(name="numero", type="string", length=255, nullable=true)
     */
    private $numero;

    /**
     * @var int
     *
     * @ORM\Column(name="cantidadInicial", type="decimal",  precision=10, scale=2, nullable=false)
     */
    private $cantidadInicial;

    /**
     * @var int
     *
     * @ORM\Column(name="cantidadDisponible", type="decimal",  precision=10, scale=2, nullable=true)
     */
    private $cantidadDisponible;

    /**
     * @var int
     *
     * @ORM\Column(name="cantidadReservada", type="decimal",  precision=10, scale=2, nullable=true)
     */
    private $cantidadReservada;

    /**
     * @var string
     *
     * @ORM\Column(name="costo", type="decimal",  precision=10, scale=2, nullable=true)
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
     * @var Fabricacion
     * @ORM\ManyToOne(targetEntity="Fabricacion")
     * @ORM\JoinColumn(nullable=true)
     */
    private $fabricacion;

    /**
     * @var \DateTime
     * @Gedmo\Timestampable(on="create")
     * @ORM\Column(name="fecha", type="datetime", nullable=true)
     */
    private $fecha;

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

    /**
     * Set fabricacion
     *
     * @param \AppBundle\Entity\Fabricacion $fabricacion
     *
     * @return Lote
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

    /**
     * Set cantidadReservada
     *
     * @param string $cantidadReservada
     *
     * @return Lote
     */
    public function setCantidadReservada($cantidadReservada)
    {
        $this->cantidadReservada = $cantidadReservada;

        return $this;
    }

    /**
     * Get cantidadReservada
     *
     * @return string
     */
    public function getCantidadReservada()
    {
        return $this->cantidadReservada;
    }

    /**
     * Set fecha
     *
     * @param \DateTime $fecha
     *
     * @return Lote
     */
    public function setFecha($fecha)
    {
        $this->fecha = $fecha;

        return $this;
    }

    /**
     * Get fecha
     *
     * @return \DateTime
     */
    public function getFecha()
    {
        return $this->fecha;
    }

    public function reservar($cantidad) {
        if ($this->getCantidadDisponible() <= $cantidad) {
            $this->setCantidadReservada($this->getCantidadReservada() + $this->getCantidadDisponible());
            $cantidad -= $this->getCantidadDisponible();
            $this->setCantidadDisponible(0);
        }
        else  {
            $this->setCantidadDisponible($this->getCantidadDisponible() - $cantidad);
            $this->setCantidadReservada($this->getCantidadReservada() + $cantidad);
            $cantidad = 0;
        }

        return $cantidad;
    }
}
