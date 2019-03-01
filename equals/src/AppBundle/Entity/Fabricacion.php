<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;


/**
 * Fabricacion
 *
 * @ORM\Table(name="fabricacion")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\FabricacionRepository")
 */
class Fabricacion
{

    const Pendiente = "pendiente";
    const Inconsistente = "inconsistente";
    const Fabricado = "fabricado";


    use \AppBundle\Traits\AdminLotesEstadoTrait;
    use \AppBundle\Traits\TimestampableEntityTrait;
    
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

        /**
    * @ORM\Column(name="estado", type="string", length=255, nullable=true)
    * @Assert\Choice({"pendiente","inconsistente" ,"fabricado"})
    */
    private $estado;


    /**
     * @var int
     *
     * @ORM\Column(name="cantidad", type="decimal",  precision=7, scale=2, nullable=false)
     */
    private $cantidad;

    /**
     * @var FormulaEnzimatica
     * @ORM\ManyToOne(targetEntity="FormulaEnzimatica")
     * @ORM\JoinColumn(nullable=false)
     */
    private $formulaEnzimatica;

    /**
     * @var LoteFaltante
     * @ORM\OneToMany(targetEntity="LoteFaltante", mappedBy="fabricacion",cascade={"persist"})
     */
    private $faltantes;

    /**
     * @var LoteFaltante
     * @ORM\OneToMany(targetEntity="Lote", mappedBy="fabricacion",cascade={"persist"})
     */
    private $lote;

    /**
     * @var LoteAsignado
     * @ORM\OneToMany(targetEntity="LoteAsignado", mappedBy="fabricacion",cascade={"persist"})
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
     * Set cantidad
     *
     * @param float $cantidad
     *
     * @return Fabricacion
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
     * Constructor
     */
    public function __construct()
    {
        
    }

    /**
     * Set formulaEnzimatica
     *
     * @param \AppBundle\Entity\FormulaEnzimatica $formulaEnzimatica
     *
     * @return Fabricacion
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


    /**
     * Set estado
     *
     * @param string $estado
     *
     * @return Fabricacion
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
     * Get loteAsignados
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getLoteAsignados()
    {
        return $this->loteAsignados;
    }

    /**
     * Add lote
     *
     * @param \AppBundle\Entity\Lote $lote
     *
     * @return Fabricacion
     */
    public function addLote(\AppBundle\Entity\Lote $lote)
    {
        $this->lote[] = $lote;

        return $this;
    }

    /**
     * Remove lote
     *
     * @param \AppBundle\Entity\Lote $lote
     */
    public function removeLote(\AppBundle\Entity\Lote $lote)
    {
        $this->lote->removeElement($lote);
    }

    /**
     * Get lote
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getLote()
    {
        return $this->lote;
    }

    public function imprimirOrden() {

        $HEADER_HEIGHT = 20;
        $TABLE_ROW_HEIGHT = 40;

        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();

        $sheet->setCellValue('A1', 'ORDEN DE FABRICACION');
        $sheet->setCellValue('H1', 'N° '.$this->getId());
        $this->dibujarBordes($sheet, 'A1:G1');
        $this->dibujarBordes($sheet, 'H1');

        $sheet->setCellValue('A2', $this->getFormulaEnzimatica()->getNombre());
        $this->dibujarBordes($sheet, 'A2:C2');

        $sheet->getStyle("A1:H2")->getFont()->setBold(true);

        $sheet->getRowDimension('1')->setRowHeight($HEADER_HEIGHT);
        $sheet->getRowDimension('2')->setRowHeight($HEADER_HEIGHT);

        $sheet->setCellValue('A9', 'FECHA DE EMISION');
        $sheet->setCellValue('C9', date('d/m/Y'));
        $sheet->getColumnDimension('E')->setWidth(6);
        $sheet->setCellValue('E9', 'Lote N°');
        if(current($this->getLote())){
            $sheet->setCellValue('F9', current($this->getLote())->getNumero());
        }
        $sheet->setCellValue('G9', 'Cantidad Kg');
        $sheet->getColumnDimension('G')->setWidth(9);
        $sheet->setCellValue('H9', $this->getCantidad());
        $sheet->getStyle("A9:H9")->getFont()->setSize(8);
        $this->dibujarBordes($sheet, 'A9:B9');
        $this->dibujarBordes($sheet, 'C9');
        $this->dibujarTodosBordes($sheet, 'E9:H9');

        $sheet->setCellValue('A13', $this->getFormulaEnzimatica()->getNombre());
        $sheet->mergeCells('A13:F14');
        $sheet->getStyle("A13:F14")->getFont()->setBold(true)->setSize(14);
        $sheet->getStyle("A13:F14")
            ->getAlignment()->setHorizontal(\PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER);
        $this->dibujarBordes($sheet, 'A13:F14');
        
        $sheet->setCellValue('A16', 'PRODUCTO');
        $sheet->mergeCells('A16:E16');
        $sheet->setCellValue('F16', 'LOTE');
        $sheet->setCellValue('G16', '%');
        $sheet->setCellValue('H16', $this->getCantidad());
        $sheet->getRowDimension('16')->setRowHeight($TABLE_ROW_HEIGHT);

        $fila = $fila_ini = 17;
        foreach ($this->getFormulaEnzimatica()->getIngredientes() as $ingrediente) {
            $sheet->setCellValue('A'.$fila, $ingrediente->getProducto());
            $sheet->mergeCells('A'.$fila.':E'.$fila);
            if(current($ingrediente->getProducto()->getLotes())){
                $sheet->setCellValue('F'.$fila, current($ingrediente->getProducto()->getLotes()));
            }
            $sheet->setCellValue('G'.$fila, $ingrediente->getPorcentaje());
            $sheet->setCellValue('H'.$fila, $this->getCantidad() * $ingrediente->getPorcentaje() / 100);
            $sheet->getRowDimension($fila)->setRowHeight($TABLE_ROW_HEIGHT);
            
            $fila++;
        }
        $sheet->setCellValue('A'.$fila, 'TOTAL');
        $sheet->mergeCells('A'.$fila.':E'.$fila);
        $sheet->setCellValue('G'.$fila, '=SUM(G'.$fila_ini.':G'.($fila-1).')');
        $sheet->setCellValue('H'.$fila, '=SUM(H'.$fila_ini.':H'.($fila-1).')');
        $sheet->getRowDimension($fila)->setRowHeight($TABLE_ROW_HEIGHT);

        $sheet->getStyle('A16:H'.$fila)->getFont()->setBold(true)->setSize(10);
        $sheet->getStyle('A16:H'.$fila)
            ->getAlignment()->setHorizontal(\PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER);
        $this->dibujarTodosBordes($sheet, 'A16:H'.$fila);

        $this->dibujarBordes($sheet, 'A1:H'.$fila);

        $writer = new Xlsx($spreadsheet);
        return $writer;
    }

    private function dibujarBordes($sheet, $filas){
        $sheet->getStyle($filas)
            ->getBorders()->getOutline()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THICK);
    }

    private function dibujarTodosBordes($sheet, $filas) {
        $styleArray = [
            'borders' => [
                'allBorders' => [
                    'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THICK
                ],
            ],
        ];
        $sheet->getStyle($filas)->applyFromArray($styleArray);

    }

    public function imprimirEtiqueta() {
        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();
     
        $writer = new Xlsx($spreadsheet);
        return $writer;
    }

    public function imprimirCoa() {
        /* Este debe ser un docx */
        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();
     
        $writer = new Xlsx($spreadsheet);
        return $writer;
    }



}
