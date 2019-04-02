<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Producto
 *
 * @ORM\Table(name="producto")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\ProductoRepository")
 */
class Producto
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
     * @var string
     *
     * @ORM\Column(name="codigo", type="string", length=255, unique=true)
     */
    private $codigo;

    /**
     * @var int
     *
     * @ORM\Column(name="kilosPorBolsa", type="decimal",  precision=7, scale=2, nullable=false)
     */
    private $kilosPorBolsa;

    /**
     * @var Lote
     * @ORM\OneToMany(targetEntity="Lote", mappedBy="producto")
     */
    private $lotes;

    /**
     * @var string
     *
     * @ORM\Column(name="textoIngredientes", type="string", length=4000, nullable=true)
     */
    private $textoIngredientes;


    /**
     * @var string
     *
     * @ORM\Column(name="rnpa", type="string", length=255)
     */
    private $rnpa;

    /**
     * @var string
     *
     * @ORM\Column(name="textoDosis", type="string", length=255)
     */
    private $textoDosis;

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
     * @return Producto
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
     * Set codigo
     *
     * @param string $codigo
     *
     * @return Producto
     */
    public function setCodigo($codigo)
    {
        $this->codigo = $codigo;

        return $this;
    }

    /**
     * Get codigo
     *
     * @return string
     */
    public function getCodigo()
    {
        return $this->codigo;
    }

     public function __toString()
    {
        return $this->getNombre().'-'.$this->getCodigo();
    }
    /**
     * Constructor
     */
    public function __construct()
    {
        $this->lotes = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * Add lote
     *
     * @param \AppBundle\Entity\Lote $lote
     *
     * @return Producto
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

    public function getCantidadDisponible() {
        $cantidad = 0;
        foreach ($this->lotes as $key => $lote) {
            $cantidad += $lote->getCantidadDisponible();
        }
        return $cantidad;
    }

    public function getCantidadReservada() {
        $cantidad = 0;
        foreach ($this->lotes as $key => $lote) {
            $cantidad += $lote->getCantidadReservada();
        }
        return $cantidad;
    }

    /**
     * Set kilosPorBolsa
     *
     * @param string $kilosPorBolsa
     *
     * @return Producto
     */
    public function setKilosPorBolsa($kilosPorBolsa)
    {
        $this->kilosPorBolsa = $kilosPorBolsa;

        return $this;
    }

    /**
     * Get kilosPorBolsa
     *
     * @return string
     */
    public function getKilosPorBolsa()
    {
        return $this->kilosPorBolsa;
    }

    /**
     * Set textoIngredientes
     *
     * @param string $textoIngredientes
     *
     * @return Producto
     */
    public function setTextoIngredientes($textoIngredientes)
    {
        $this->textoIngredientes = $textoIngredientes;

        return $this;
    }

    /**
     * Get textoIngredientes
     *
     * @return string
     */
    public function getTextoIngredientes()
    {
        return $this->textoIngredientes;
    }

    /**
     * Set rnpa
     *
     * @param string $rnpa
     *
     * @return Producto
     */
    public function setRnpa($rnpa)
    {
        $this->rnpa = $rnpa;

        return $this;
    }

    /**
     * Get rnpa
     *
     * @return string
     */
    public function getRnpa()
    {
        return $this->rnpa;
    }

    /**
     * Set textoDosis
     *
     * @param string $textoDosis
     *
     * @return Producto
     */
    public function setTextoDosis($textoDosis)
    {
        $this->textoDosis = $textoDosis;

        return $this;
    }

    /**
     * Get textoDosis
     *
     * @return string
     */
    public function getTextoDosis()
    {
        return $this->textoDosis;
    }
}
