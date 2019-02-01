<?php

namespace AppBundle\Traits;

use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * Timestampable Trait, usable with PHP >= 5.4
 *
 */
trait TimestampableEntityTrait
{
    /**
     * @var \DateTime
     *
     * @Gedmo\Timestampable(on="create")
     * @ORM\Column(name="fecha_creacion", type="datetime")
     */
    private $fechaCreacion;

    /**
     * @var \DateTime
     *
     * @Gedmo\Timestampable(on="update")
     * @ORM\Column(name="fecha_modificacion", type="datetime")
     */
    private $fechaModificacion;

    /**
     * Sets fechaCreacion.
     *
     * @param  \DateTime $fechaCreacion
     * @return $this
     */
    public function setFechaCreacion(\DateTime $fechaCreacion)
    {
        $this->fechaCreacion = $fechaCreacion;

        return $this;
    }

    /**
     * Returns fechaCreacion.
     *
     * @return \DateTime
     */
    public function getFechaCreacion()
    {
        return $this->fechaCreacion;
    }

    /**
     * Sets fechaModificacion.
     *
     * @param  \DateTime $fechaModificacion
     * @return $this
     */
    public function setFechaModificacion(\DateTime $fechaModificacion)
    {
        $this->fechaModificacion = $fechaModificacion;

        return $this;
    }

    /**
     * Returns fechaModificacion.
     *
     * @return \DateTime
     */
    public function getFechaModificacion()
    {
        return $this->fechaModificacion;
    }
}