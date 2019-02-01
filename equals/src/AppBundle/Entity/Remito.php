<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;


/**
 * Remito
 *
 * @ORM\Table(name="remito")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\RemitoRepository")
 */
class Remito
{
    use \AppBundle\Traits\AdminLotesEstadoTrait;
    use \AppBundle\Traits\TimestampableEntityTrait;

    const Pendiente = "pendiente";
    const Inconsistente = "inconsistente";
    const Vendido = "vendido";
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var Lote
     * @ORM\OneToMany(targetEntity="ItemRemito", mappedBy="remito",cascade={"persist"})
     */
    private $itemsRemito;

    /**
    * @ORM\Column(name="estado", type="string", length=255, nullable=true)
    * @Assert\Choice({"pendiente","inconsistente" ,"vendido"})
    */
    private $estado;

    /**
    * @ORM\Column(name="ordenDeCompra", type="string", length=255, nullable=true)
    */
    private $ordenDeCompra;

    /**
     * @var Producto
     * @ORM\ManyToOne(targetEntity="Cliente")
     */
    private $cliente;

    /**
     * @var LoteFaltante
     * @ORM\OneToMany(targetEntity="LoteFaltante", mappedBy="remito",cascade={"persist"})
     */
    private $faltantes;

    /**
     * @var LoteAsignado
     * @ORM\OneToMany(targetEntity="LoteAsignado", mappedBy="remito",cascade={"persist"})
     */
    private $loteAsignados;

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
     * Constructor
     */
    public function __construct()
    {
        $this->itemsRemito = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * Set estado
     *
     * @param string $estado
     *
     * @return Remito
     */
    public function setEstado($estado)
    {
        $this->estado = $estado;

        return $this;
    }

    /**
     * Get estado
     *
     * @return string
     */
    public function getEstado()
    {
        return $this->estado;
    }

    /**
     * Add itemsRemito
     *
     * @param \AppBundle\Entity\ItemRemito $itemsRemito
     *
     * @return Remito
     */
    public function addItemsRemito(\AppBundle\Entity\ItemRemito $itemsRemito)
    {
        $this->itemsRemito[] = $itemsRemito;

        return $this;
    }

    /**
     * Remove itemsRemito
     *
     * @param \AppBundle\Entity\ItemRemito $itemsRemito
     */
    public function removeItemsRemito(\AppBundle\Entity\ItemRemito $itemsRemito)
    {
        $this->itemsRemito->removeElement($itemsRemito);
    }

    /**
     * Get itemsRemito
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getItemsRemito()
    {
        return $this->itemsRemito;
    }

    /**
     * Set cliente
     *
     * @param \AppBundle\Entity\Cliente $cliente
     *
     * @return Remito
     */
    public function setCliente(\AppBundle\Entity\Cliente $cliente = null)
    {
        $this->cliente = $cliente;

        return $this;
    }

    /**
     * Get cliente
     *
     * @return \AppBundle\Entity\Cliente
     */
    public function getCliente()
    {
        return $this->cliente;
    }

    /**
     * Set observaciones
     *
     * @param string $observaciones
     *
     * @return Remito
     */
    public function setObservaciones($observaciones)
    {
        $this->observaciones = $observaciones;

        return $this;
    }

    /**
     * Get observaciones
     *
     * @return string
     */
    public function getObservaciones()
    {
        return $this->observaciones;
    }

    public function imprimir() {
        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();
        $sheet->setCellValue('G4', $this->getFechaCreacion());
        $sheet->setCellValue('B9', $this->getCliente()->getNombre());
        $sheet->setCellValue('B11', $this->getCliente()->getDireccionFiscal());
        $sheet->setCellValue('B13', 'RESPONSABLE INSCRIPTO');
        $sheet->setCellValue('F13', $this->getCliente()->getCuit());
        $sheet->setCellValue('C15', $this->getCliente()->getDireccionEntrega());
        $sheet->setCellValue('B17', $this->getId());
        $sheet->setCellValue('H17', $this->getOrdenDeCompra());

        $writer = new Xlsx($spreadsheet);
        return $writer;
    }

    /**
     * Set ordenDeCompra
     *
     * @param string $ordenDeCompra
     *
     * @return Remito
     */
    public function setOrdenDeCompra($ordenDeCompra)
    {
        $this->ordenDeCompra = $ordenDeCompra;

        return $this;
    }

    /**
     * Get ordenDeCompra
     *
     * @return string
     */
    public function getOrdenDeCompra()
    {
        return $this->ordenDeCompra;
    }

    /**
     * Get loteAsignados
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getLoteAsignados()
    {
        return $this->loteAsignados;
    }
}
