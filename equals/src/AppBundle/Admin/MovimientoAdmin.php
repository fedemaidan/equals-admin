<?php

namespace AppBundle\Admin;

use Sonata\AdminBundle\Admin\AbstractAdmin;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Form\FormMapper;
use Sonata\AdminBundle\Show\ShowMapper;
use Sonata\Form\Type\DateRangeType;
use Sonata\Form\Type\DatePickerType;
use Sonata\Form\Type\DateTimePickerType;


class MovimientoAdmin extends AbstractAdmin
{
    protected $datagridValues = [

        // display the first page (default = 1)
        '_page' => 1,

        // reverse order (default = 'ASC')
        '_sort_order' => 'DESC',

        // name of the ordered field (default = the model's id field, if any)
        '_sort_by' => 'fecha',
    ];

    protected function configureDatagridFilters(DatagridMapper $datagridMapper)
    {
        $datagridMapper
            ->add('id')
            ->add('operacion')
            ->add('kilos')
            ->add('fecha','doctrine_orm_date_range',array('date_format' => 'yyyy-MM-dd HH:mm:ss'))
            ->add('compra.proveedor',null,["label" => "Proveedor"])
            ->add('remito.numero',null,["label" => "Número de remito"])
            ->add('remito.cliente',null,["label" => "Cliente"])
            ->add('lote.producto',null,["label" => "Producto"])
            ->add('lote.numero',null,["label" => "Número de lote"])
        ;
    }

    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->add('fecha','datetime',array('date_format' => 'yyyy-MM-dd HH:mm:ss'))
            ->add('operacion',null,["label" => "Operación"])
            ->add('kilos',null,["label" => "Kilos"])
            ->add('remito.cliente',null,["label" => "Cliente"])
            ->add('remito.numero',null,["label" => "Nº Remito"])
            ->add('lote.producto',null,["label" => "Producto"])
            ->add('lote',null,["label" => "Nº Lote"])
            ->add('_action', null, [
                'actions' => [
                    'show' => [],
                    'edit' => [],
                    'delete' => [],
                ],
            ])
        ;
    }

    protected function configureFormFields(FormMapper $formMapper)
    {
        $formMapper
            ->add('id')
            ->add('operacion')
            ->add('kilos')
            ->add('fecha')
        ;
    }

    protected function configureShowFields(ShowMapper $showMapper)
    {
        $showMapper
            ->add('id')
            ->add('operacion')
            ->add('kilos')
            ->add('fecha')
        ;
    }

    public function getExportFields()
    {
        return ["Fecha" => 'fecha', 
                "Operación" =>'operacion', 
                "Kilos" => 'kilos', 
                "Cliente" =>'remito.cliente', 
                "Núm. Remito" => 'remito.numero', 
                "Producto" =>'lote.producto', 
                "Núm. Lote" =>'lote'
            ];
    }

    public function getExportFormats()
    {
        return ['xls'];
    }

    public function getDataSourceIterator()
    {
        $datasourceit = parent::getDataSourceIterator();
        $datasourceit->setDateTimeFormat('Y-m-d H:m'); //change this to suit your needs
        return $datasourceit;
    }
}
