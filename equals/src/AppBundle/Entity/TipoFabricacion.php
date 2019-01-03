<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * TipoFabricacion
 *
 * @ORM\Table(name="tipo_fabricacion")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\TipoFabricacionRepository")
 */
class TipoFabricacion
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
     * @ORM\Column(name="nombre", type="string", length=255, unique=true)
     */
    private $nombre;

    /**
     * @var Lote
     * @ORM\OneToMany(targetEntity="Ingrediente", mappedBy="tipoFabricacion",cascade={"persist"})
     */
    private $ingredientes;

    /**
     * @var Producto
     * @ORM\ManyToOne(targetEntity="Producto")
     * @ORM\JoinColumn(nullable=true)
     */
    private $productoResultante;


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
     * Set nombre
     *
     * @param string $nombre
     *
     * @return TipoFabricacion
     */
    public function setNombre($nombre)
    {
        $this->nombre = $nombre;

        return $this;
    }

    /**
     * Get nombre
     *
     * @return string
     */
    public function getNombre()
    {
        return $this->nombre;
    }
    /**
     * Constructor
     */
    public function __construct()
    {
        $this->ingredientes = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * Add ingrediente
     *
     * @param \AppBundle\Entity\Ingrediente $ingrediente
     *
     * @return TipoFabricacion
     */
    public function addIngrediente(\AppBundle\Entity\Ingrediente $ingrediente)
    {
        $this->ingredientes[] = $ingrediente;

        return $this;
    }

    /**
     * Remove ingrediente
     *
     * @param \AppBundle\Entity\Ingrediente $ingrediente
     */
    public function removeIngrediente(\AppBundle\Entity\Ingrediente $ingrediente)
    {
        $this->ingredientes->removeElement($ingrediente);
    }

    /**
     * Get ingredientes
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getIngredientes()
    {
        return $this->ingredientes;
    }

    /**
     * Set productoResultante
     *
     * @param \AppBundle\Entity\Producto $productoResultante
     *
     * @return TipoFabricacion
     */
    public function setProductoResultante(\AppBundle\Entity\Producto $productoResultante = null)
    {
        $this->productoResultante = $productoResultante;

        return $this;
    }

    /**
     * Get productoResultante
     *
     * @return \AppBundle\Entity\Producto
     */
    public function getProductoResultante()
    {
        return $this->productoResultante;
    }
}
