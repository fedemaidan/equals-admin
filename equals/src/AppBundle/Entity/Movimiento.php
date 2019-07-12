<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Movimiento
 *
 * @ORM\Table(name="movimiento")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\MovimientoRepository")
 */
class Movimiento
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
     * @ORM\Column(name="operacion", type="string", length=255)
     */
    private $operacion;

    /**
     * @var int
     *
     * @ORM\Column(name="kilos", type="decimal",  precision=10, scale=2, nullable=false)
     */
    private $kilos;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="fecha", type="datetime")
     */
    private $fecha;

    /**
     * @var Compra
     * @ORM\ManyToOne(targetEntity="Compra")
     * @ORM\JoinColumn(nullable=true)
     */
    private $compra;

    /**
     * @var Remito
     * @ORM\ManyToOne(targetEntity="Remito", cascade={"persist", "remove"})
     * @ORM\JoinColumn(nullable=true)
     */
    private $remito;


    /**
     * @var Lote
     * @ORM\ManyToOne(targetEntity="Lote")
     * @ORM\JoinColumn(nullable=true)
     */
    private $lote;

    /**
     * @var Lote
     * @ORM\ManyToOne(targetEntity="Fabricacion", cascade={"persist", "remove"})
     * @ORM\JoinColumn(nullable=true)
     */
    private $fabricacion;

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
     * Set operacion
     *
     * @param string $operacion
     *
     * @return Movimiento
     */
    public function setOperacion($operacion)
    {
        $this->operacion = $operacion;

        return $this;
    }

    /**
     * Get operacion
     *
     * @return string
     */
    public function getOperacion()
    {
        return $this->operacion;
    }

    /**
     * Set kilos
     *
     * @param integer $kilos
     *
     * @return Movimiento
     */
    public function setKilos($kilos)
    {
        $this->kilos = $kilos;

        return $this;
    }

    /**
     * Get kilos
     *
     * @return int
     */
    public function getKilos()
    {
        return $this->kilos;
    }

    /**
     * Set fecha
     *
     * @param \DateTime $fecha
     *
     * @return Movimiento
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

    /**
     * Set compra
     *
     * @param \AppBundle\Entity\Compra $compra
     *
     * @return Movimiento
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
     * Set remito
     *
     * @param \AppBundle\Entity\Remito $remito
     *
     * @return Movimiento
     */
    public function setRemito(\AppBundle\Entity\Remito $remito = null)
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

    /**
     * Set lote
     *
     * @param \AppBundle\Entity\Lote $lote
     *
     * @return Movimiento
     */
    public function setLote(\AppBundle\Entity\Lote $lote = null)
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
     * @return Movimiento
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
