<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Worksheet\Drawing;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpWord\PhpWord;
use PhpOffice\PhpWord\IOFactory;


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

        $this->setStyles($sheet, "A1:H2", true, false, false, false);

        $sheet->getRowDimension('1')->setRowHeight($HEADER_HEIGHT);
        $sheet->getRowDimension('2')->setRowHeight($HEADER_HEIGHT);

        $sheet->setCellValue('A9', 'FECHA DE EMISION');
        $sheet->setCellValue('C9', date('d/m/Y'));
        $sheet->getColumnDimension('E')->setWidth(6);
        $sheet->setCellValue('E9', 'Lote N°');
        if($this->getLote()->first()){
            $sheet->setCellValue('F9', $this->getLote()->first()->getNumero());
        }
        $sheet->setCellValue('G9', 'Cantidad Kg');
        $sheet->getColumnDimension('G')->setWidth(9);
        $sheet->setCellValue('H9', $this->getCantidad());
        $this->setStyles($sheet, 'A9:H9', false, 8, false, false);
        $this->dibujarBordes($sheet, 'A9:B9');
        $this->dibujarBordes($sheet, 'C9');
        $this->dibujarTodosBordes($sheet, 'E9:H9');

        $sheet->setCellValue('A13', $this->getFormulaEnzimatica()->getNombre());
        $sheet->mergeCells('A13:F14');
        $this->setStyles($sheet, 'A13:F14', true, 14, \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER, false);
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
            if($ingrediente->getProducto()->getLotes()->first()){
                $sheet->setCellValue('F'.$fila, $ingrediente->getProducto()->getLotes()->first());
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

        $this->setStyles($sheet, 'A16:H'.$fila, true, 10, \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER, false);
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

    private function setStyles($sheet, $filas, $bold, $font_size, $horizontal_alignment, $vertical_alignment){

        $sheet->getStyle($filas)->getFont()->setBold($bold);

        if($font_size > 0){
            $sheet->getStyle($filas)->getFont()->setSize($font_size);
        }

        if($horizontal_alignment){
            $sheet->getStyle($filas)
                ->getAlignment()->setHorizontal($horizontal_alignment);
        }

        if($vertical_alignment){
            $sheet->getStyle($filas)
                ->getAlignment()->setVertical($vertical_alignment);
        }
        
    }

    public function imprimirEtiqueta() {
        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();

        //styles
        $this->setStyles($sheet, 'B3:C16', false, false, \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER, false);
        $this->setStyles($sheet, 'B3:B8', false, false, false, \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER);
        $this->setStyles($sheet, 'B13', false, false, false, \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER);
        $this->setStyles($sheet, 'C3:C8', false, false, false, \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER);
        $sheet->getStyle('B3:C16')->getAlignment()->setWrapText(true);

        $sheet->getColumnDimension('A')->setWidth(1);
        $sheet->getColumnDimension('B')->setWidth(50);
        $sheet->getColumnDimension('C')->setWidth(25);

        $sheet->getRowDimension(11)->setRowHeight(28);
        $sheet->getRowDimension(12)->setRowHeight(35);
        
        $this->setStyles($sheet, 'B3', false, 28, false, false);
        $this->setStyles($sheet, 'B6', false, 14, false, false);
        $this->setStyles($sheet, 'B7:B8', false, 10, false, false);
        $this->setStyles($sheet, 'B9:B10', false, 8, false, false);
        $this->setStyles($sheet, 'B11', true, 20, false, false);
        $this->setStyles($sheet, 'B12', false, 6, false, false);
        $this->setStyles($sheet, 'B13', false, 5, false, false);
        $this->setStyles($sheet, 'B16', false, 7, false, false);
        $this->setStyles($sheet, 'C3:C8', true, 6, false, false);
        $this->setStyles($sheet, 'C9:C10', false, 6, false, false);
        $this->setStyles($sheet, 'C12', true, 10, false, false);
        $sheet->getStyle('C12')->getFill()
          ->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)
          ->getStartColor()->setARGB('bfbfbf');

        $objDrawing = new Drawing();
        $objDrawing->setPath('LogoEquals.jpeg');
        $objDrawing->setHeight(70)->setCoordinates('C13');
        $objDrawing->setWorksheet($sheet);

        $this->dibujarBordes($sheet, 'B3:B16');
        $this->dibujarBordes($sheet, 'C3:C16');

        //first column
        $sheet->setCellValue('B3', $this->getFormulaEnzimatica()->getProductoResultante()->getNombre());
        $sheet->mergeCells('B3:B5');

        $sheet->setCellValue('B6', $this->getFormulaEnzimatica()->getNombre());
        $sheet->setCellValue('B7', 'USO INDUSTRIAL ALIMENTICIO');


        $lote = $this->getLote()->first();

        if($lote){
            $sheet->setCellValue('B8', 'Lote: '.$lote->getNumero());
        } else{
            $sheet->setCellValue('B8', 'Lote: *');
        }

        $elaboracion = $lote ? $lote->getFecha()->format('d/m/Y') : "*";

        $vto = $lote ? $lote->getFecha()->add(new \DateInterval('P1Y'))->format('d/m/Y') : "*";

        $sheet->setCellValue('B9', 'Fecha de elaboración: '.$elaboracion);

        $sheet->setCellValue('B10', 'Fecha de vencimiento: '.$vto);
        $sheet->setCellValue('B11', $this->getCantidad().'Kg.');

        $sheet->setCellValue('B12', 'Ingredientes: HARINA TERMOTRATADA ENRIQUECIDA*, ENZIMA XILANASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2 mg/kg');

        $sheet->setCellValue('B13','Dirección: Blvd. Azucena Villaflor 450 8° Piso Depto.03 (C1107CIJ) Ciudad Autónoma de Buenos Aires.
            Tel.Oficina: (011)-5775-0307     Email: info@equals.com.ar    Web: www.equals.com.ar');
        $sheet->mergeCells('B13:B15');

        $sheet->setCellValue('B16', 'Industria Argentina');

        //second column
        $sheet->setCellValue('C3', 'ALMACENAR EN ENVASE CERRADO EN LUGAR FRESCO Y SECO');
        $sheet->mergeCells('C3:C4');

        $sheet->setCellValue('C5', 'Alergeno: Contiene gluten');
        $sheet->mergeCells('C5:C6');

        $sheet->setCellValue('C7', 'Dosis de uso: 10 – 100 ppm');
        $sheet->mergeCells('C7:C8');

        $sheet->setCellValue('C9', 'RNE: 02-034.418');

        $sheet->setCellValue('C10', 'R.N.P.A. 02-600536');

        $sheet->setCellValue('C12', 'Comercializado por:
Equals S.A.
Jose Bonifacio 1191, CABA');

        $writer = new Xlsx($spreadsheet);
        return $writer;
    }

    public function imprimirCoa() {

        /* Este debe ser un docx */
        $phpWord = new \PhpOffice\PhpWord\PhpWord();
        
        $phpWord->addFontStyle('myOwnStyle', array('name'=>'Calibri', 'size'=>12));

        $section = $phpWord->addSection();
        $header = $section->addHeader();
        $header->addImage('LogoEquals.jpeg', array('width' => 210, 'height' => 70, 'alignment' => \PhpOffice\PhpWord\SimpleType\Jc::CENTER));

        $footer = $section->addFooter();
        $stylePreserve = array( 'bold' => true,'color' => '#70ad47','size' => 11, 'name' => 'Arial');

        $footer->addPreserveText('Azucena Villaflor 550 - C.A.B.A  Tel: 54 11 5775 0307',$stylePreserve, [ 'align' => 'center' ]);
        $footer->addPreserveText('www.equals.com.ar',$stylePreserve,[ 'align' => 'center' ]);

        $table = $section->addTable([ 'align' => 'center' ]);
        $table->addRow(400);
        // Add cells
        $fontStyleName = 'estiloTitulo';
        $phpWord->addFontStyle(
                $fontStyleName,
                array('name' => 'Calibri', 'size' => 14, 'color' => '1B2232', 'bold' => true)
            );

        $styleCell =
        [
            'borderColor' =>'black',
            'borderSize' => 9,
        ];

        $estiloTexto = 'estiloTexto';
        $phpWord->addFontStyle(
                $estiloTexto,
                array('name' => 'Calibri', 'size' => 12)
            );        
        $section->addText("");
        
        $section->addText("\n");

        $table->addCell(9000,$styleCell)->addText('PROTOCOLO DE ANALISIS',$fontStyleName,[ 'align' => 'center' ]);
        
        $section->addText("NOMBRE DEL PRODUCTO:         ".$this->getFormulaEnzimatica()->getProductoResultante()->getNombre(),
            $estiloTexto
        );

        $section->addText("");

        $lote = $this->getLote()->first();
        $numero = $lote ? $lote->getNumero() : "*";

        $section->addText("LOTE N°:         ".$numero, $estiloTexto);

        $section->addText("");
        $elaboracion = $lote ? $lote->getFecha()->format('d/m/Y') : "*";
        

        $section->addText("FECHA DE ELABORACION:         ".$elaboracion, $estiloTexto);

        $vto = $lote ? $lote->getFecha()->add(new \DateInterval('P1Y'))->format('d/m/Y') : "*";

        $section->addText("");

        $section->addText("FECHA DE VENCIMIENTO:         ".$vto, $estiloTexto );

        $section->addText('');
        $section->addText('');
        $section->addText('DEFINICION: Mezcla enzimática, regulador para harinas de trigo.???',$estiloTexto);
        $section->addText('');
        $section->addText('DESCRIPCION: Polvo de color blanco-crema , con aroma y sabor característico.???',$estiloTexto);
        $section->addText('');
        $section->addText('CALIDAD : Apto para consumo humano ???',$estiloTexto);
        $section->addText('');
        $section->addText('PRESENTACION: Bolsa de papel multipliego con lámina de polietileno interior, contenido 25 kilogramos ???',$estiloTexto);
        $section->addText('VIDA UTIL: 12 meses desde la fecha de elaboración. Almacenar en condiciones de humedad y temperatura adecuadas: 5°C a 25°C y hasta 65% HR ???',$estiloTexto);
        $section->addText('');
        $section->addText('RNE:     00000618 ???',$estiloTexto);
        $section->addText('');
        $section->addText('RNPA:    Exp. En trámite ???',$estiloTexto);
        $section->addText('');
        $section->addText('ESPECIFICACIONES TECNICAS:',$estiloTexto);
        $section->addText('');

        $rows = 5;
        $cols = 3;
        $table = $section->addTable(array('align' => 'center'));
        
        $styleCelda =
        [
            'borderColor' =>'#1F497D',
            'borderSize' => 4,
        ];

        $table->addRow();
        $table->addCell(2600,$styleCelda)->addText("ANALISIS",array('name' => 'Calibri', 'size' => 12, 'bold' => true, 'align' =>'center'));
        $table->addCell(2600,$styleCelda)->addText("ESPECIFICACION",array('name' => 'Calibri', 'size' => 12, 'bold' => true, 'align' =>'center'));
        $table->addCell(2600,$styleCelda)->addText("RESULTADO",array('name' => 'Calibri', 'size' => 12, 'bold' => true, 'align' =>'center') );
        for ($r = 1; $r <= $rows; $r++) {
            $table->addRow();
            for ($c = 1; $c <= $cols; $c++) {
                $table->addCell(2600,$styleCelda)->addText("??? ",$estiloTexto);
            }
        }

        $section->addText('');
        $section->addText('');
        $section->addText('INFORMACION NUTRICIONAL APROXIMADA:',$estiloTexto);
        $section->addText('');
        $section->addText('Tamaño de Porción: 100g???',$estiloTexto);
        $section->addText('');
        $section->addText('Carbohidratos 74,1g (VD : 25%) ; Proteínas 9,1 g ( VD: 12%); Grasas Totales : 1,8 g (VD : 3%);
            Grasas Saturadas 0g (VD : 0%); Fibra Alimentaria : 3 g (VD: 12%); Sodio : 0 mg 
            (VD : 0%) ; Valor Energético : 349 kcal (VD : 17%)???',$estiloTexto);
        $section->addText('');
        $section->addText('(VD : % Valores diarios con base a una dieta de 2000 kcal u 8400 kJoule)????',$estiloTexto);
        $section->addText('');
        $section->addText('');
        $section->addText('');
        $section->addText('RESPONSABLE DEL CERTIFICADO:   ???????',$estiloTexto);
        $section->addText('');
        $section->addText('');
        $section->addText('');
        $section->addText('FECHA DE EMISION: ????(fecha en la que descargas el COA o fecha en la que se genero la fabricación?)',$estiloTexto);

        $objWriter = IOFactory::createWriter($phpWord, 'Word2007');
        return $objWriter;

    }
}
