<?php

namespace AppBundle\Admin;

use Sonata\AdminBundle\Admin\AbstractAdmin;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Form\FormMapper;
use Sonata\AdminBundle\Show\ShowMapper;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Sonata\AdminBundle\Route\RouteCollection;
use AppBundle\Form\ItemRemitoType;
use AppBundle\Entity\Remito;
use AppBundle\Entity\LoteFaltante;


class RemitoAdmin extends AbstractAdmin
{
    protected $datagridValues = [

        // display the first page (default = 1)
        '_page' => 1,

        // reverse order (default = 'ASC')
        '_sort_order' => 'DESC',

        // name of the ordered field (default = the model's id field, if any)
        '_sort_by' => 'fechaCreacion',
    ];

    protected function configureRoutes(RouteCollection $collection)
    {
        $collection->add('actuar', $this->getRouterIdParameter().'/actuar');
        $collection->add('confirmar', $this->getRouterIdParameter().'/confirmar');
        $collection->add('completar', $this->getRouterIdParameter().'/completar');
        $collection->add('imprimir', $this->getRouterIdParameter().'/imprimir');
    }

    protected function configureDatagridFilters(DatagridMapper $datagridMapper)
    {
        $datagridMapper
            ->add('numero')
            ->add('estado')
        ;
    }

    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->add('fechaCreacion','datetime',array('date_format' => 'yyyy-MM-dd'))
            ->add('numero')
            ->add('estado')
            ->add('cliente')
            ->add('faltantes')
            ->add('itemsRemito')
            ->add('_action', null, [
                'actions' => [
                    'actuar' => array(
                        'template' => 'AppBundle:RemitoCRUD:actuar.html.twig',
                    ),
                    'show' => [],
                ],
            ])
        ;
    }

    protected function configureFormFields(FormMapper $formMapper)
    {
        if (!$this->isCurrentRoute('create')) {
            $formMapper->add('estado');
        }
        $formMapper
            //->add('estado', 'choice', ['choices' => [ "pendiente" => "Pendiente", "vendido" => "Vendido"]])
            ->add('numero')
            ->add('cliente')
            ->add('ordenDeCompra')
            ->add('itemsRemito', CollectionType::class, [
                'by_reference' => false, // Use this because of reasons
                'allow_add' => true, // True if you want allow adding new entries to the collection
                'allow_delete' => true, // True if you want to allow deleting entries
                'prototype' => true, // True if you want to use a custom form type
                'entry_type' => ItemRemitoType::class, // Form type for the Entity that is being attached to the object
            ]);
        ;
    }

    protected function configureShowFields(ShowMapper $showMapper)
    {
        $showMapper
            ->add('id')
            ->add('numero')
            ->add('estado')
            ->add('ordenDeCompra')
            ->add('cliente')
            ->add('faltantes')
            ->add('itemsRemito')
        ;
    }

    public function prePersist($remito)
    {
        $this->getConfigurationPool()->getContainer()->get('adminLotes_service')->preInitRemito($remito);
    }

}
