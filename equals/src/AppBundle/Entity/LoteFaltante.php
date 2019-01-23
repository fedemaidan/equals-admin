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

}
