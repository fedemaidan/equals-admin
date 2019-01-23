<?php
namespace AppBundle\Traits;

trait LoteEstadoTrait 
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
     * @var float
     *
     * @ORM\Column(name="cantidad", type="float")
     */
    private $cantidad;

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
     * @param float $cantidad
     *
     * @return LoteFaltante
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
     * Set producto
     *
     * @param \AppBundle\Entity\Producto $producto
     *
     * @return LoteFaltante
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
     * @return LoteFaltante
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
            return $this->getProducto()->getNombre().' '.$this->getCantidad().' kilos faltantes';
        else 
            return "Sin productos";
    }
}
