<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Cliente
 *
 * @ORM\Table(name="cliente")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\ClienteRepository")
 */
class Cliente
{

    use \AppBundle\Traits\DatosContactoPersonalTrait;
    
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
     * @var string
     *
     * @ORM\Column(name="direccionFiscal", type="string", length=255, nullable=true)
     */
    private $direccionFiscal;

    /**
     * @var string
     *
     * @ORM\Column(name="direccionEntrega", type="string", length=255, nullable=true)
     */
    private $direccionEntrega;

    /**
     * @var string
     *
     * @ORM\Column(name="cuit", type="string", length=255, nullable=true)
     */
    private $cuit;


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
     * @return Cliente
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
     * Set direccionFiscal
     *
     * @param string $direccionFiscal
     *
     * @return Cliente
     */
    public function setDireccionFiscal($direccionFiscal)
    {
        $this->direccionFiscal = $direccionFiscal;

        return $this;
    }

    /**
     * Get direccionFiscal
     *
     * @return string
     */
    public function getDireccionFiscal()
    {
        return $this->direccionFiscal;
    }

    /**
     * Set direccionEntrega
     *
     * @param string $direccionEntrega
     *
     * @return Cliente
     */
    public function setDireccionEntrega($direccionEntrega)
    {
        $this->direccionEntrega = $direccionEntrega;

        return $this;
    }

    /**
     * Get direccionEntrega
     *
     * @return string
     */
    public function getDireccionEntrega()
    {
        return $this->direccionEntrega;
    }

    /**
     * Set cuit
     *
     * @param string $cuit
     *
     * @return Cliente
     */
    public function setCuit($cuit)
    {
        $this->cuit = $cuit;

        return $this;
    }

    /**
     * Get cuit
     *
     * @return string
     */
    public function getCuit()
    {
        return $this->cuit;
    }
}
