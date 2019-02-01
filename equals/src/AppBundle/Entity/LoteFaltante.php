<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * LoteFaltante
 *
 * @ORM\Table(name="lote_faltante")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\LoteFaltanteRepository")
 */
class LoteFaltante
{
    use \AppBundle\Traits\LoteEstadoTrait;

    /**
     * @var Producto
     * @ORM\ManyToOne(targetEntity="Producto")
     */
    private $producto;


    /**
     * Set fabricacion
     *
     * @param \AppBundle\Entity\Fabricacion $fabricacion
     *
     * @return LoteFaltante
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
