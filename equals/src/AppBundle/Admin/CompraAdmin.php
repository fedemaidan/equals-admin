<?php

namespace AppBundle\Admin;

use Sonata\AdminBundle\Admin\AbstractAdmin;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Sonata\AdminBundle\Form\FormMapper;
use Sonata\AdminBundle\Show\ShowMapper;
use AppBundle\Form\LoteType;

class CompraAdmin extends AbstractAdmin
{
    protected $datagridValues = [

        // display the first page (default = 1)
        '_page' => 1,

        // reverse order (default = 'ASC')
        '_sort_order' => 'DESC',

        // name of the ordered field (default = the model's id field, if any)
        '_sort_by' => 'id',
    ];

    use \AppBundle\Traits\LoteTrait;

    protected function configureDatagridFilters(DatagridMapper $datagridMapper)
    {
        $datagridMapper
            ->add('id')
            ->add('proveedor')
        ;
    }

    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->add('id')
            ->add('proveedor')
            ->add('getCosto','integer',['label' => "Costo"])
            ->add('getItemsHtml','html',['label' => "Items"])
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
            ->add('proveedor')
            ->add('lotes', CollectionType::class, [
                'attr' => ["class" => "col-md-6 col-xs-12"],
                'by_reference' => false, // Use this because of reasons
                'allow_add' => true, // True if you want allow adding new entries to the collection
                'allow_delete' => true, // True if you want to allow deleting entries
                'prototype' => true, // True if you want to use a custom form type
                'entry_type' => LoteType::class, // Form type for the Entity that is being attached to the object
            ]);
        ;

    }

    protected function configureShowFields(ShowMapper $showMapper)
    {
        $showMapper
            ->add('id')
            ->add('proveedor')
            ->add('lotes')
        ;
    }


    public function prePersist($object)
    {
        foreach ($object->getLotes() as $lote) {
            $lote->setCompra($object); 
        }
    }
    
    public function preUpdate($object)
    {
        foreach ($object->getLotes() as $lote) {
            $lote->setCompra($object);   
        }
    }

    public function postPersist($compra)
    {
        foreach ($compra->getLotes() as $lote) {
            $lote->setCantidadDisponible($lote->getCantidadInicial());
            $lote->setCompra($compra);
            $this->getConfigurationPool()->getContainer()->get('adminMovimientos_service')->crearMovimientoCompra($lote);
        }

        $this->update($compra);
    }
}
