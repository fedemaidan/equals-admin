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
     * @ORM\Column(name="porcentaje", type="decimal",  precision=10, scale=2, nullable=false)
     */
    private $porcentaje;

    /**
     * @var Producto
     * @ORM\ManyToOne(targetEntity="Producto")
     * @ORM\JoinColumn(nullable=true)
     */
    private $producto;

    /**
     * @var FormulaEnzimatica
     * @ORM\ManyToOne(targetEntity="FormulaEnzimatica")
     * @ORM\JoinColumn(nullable=false)
     */
    private $formulaEnzimatica;


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
     * Set formulaEnzimatica
     *
     * @param \AppBundle\Entity\FormulaEnzimatica $formulaEnzimatica
     *
     * @return Ingrediente
     */
    public function setFormulaEnzimatica(\AppBundle\Entity\FormulaEnzimatica $formulaEnzimatica)
    {
        $this->formulaEnzimatica = $formulaEnzimatica;

        return $this;
    }

    /**
     * Get formulaEnzimatica
     *
     * @return \AppBundle\Entity\FormulaEnzimatica
     */
    public function getFormulaEnzimatica()
    {
        return $this->formulaEnzimatica;
    }

    public function __toString()
    {
        return strval($this->getPorcentaje().'%  de '.$this->getProducto());
    }

    /**
     * Set porcentaje
     *
     * @param string $porcentaje
     *
     * @return Ingrediente
     */
    public function setPorcentaje($porcentaje)
    {
        $this->porcentaje = $porcentaje;

        return $this;
    }

    /**
     * Get porcentaje
     *
     * @return string
     */
    public function getPorcentaje()
    {
        return $this->porcentaje;
    }
}
