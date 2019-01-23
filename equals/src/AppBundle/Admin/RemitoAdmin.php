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
            ->add('id')
            ->add('estado')
        ;
    }

    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->add('id')
            ->add('estado')
            ->add('cliente')
            ->add('_action', null, [
                'actions' => [
                    'actuar' => array(
                        'template' => 'AppBundle:RemitoCRUD:actuar.html.twig'
                    ),
                    'show' => [],
                    //'edit' => [],
                    'delete' => [],
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
            ->add('estado')
            ->add('ordenDeCompra')
            ->add('cliente')
            ->add('faltantes')
            ->add('itemsRemito')
        ;
    }

    public function prePersist($remito)
    {
        foreach ($remito->getItemsRemito() as $item) {
            $item->setRemito($remito); 
            $cantidad = $this->getConfigurationPool()->getContainer()->get('adminLotes_service')->reservarLotesMasAntiguos($item->getProducto(), $item->getCantidad(), $remito);
            
            if ($cantidad > 0) {
                $faltante = new LoteFaltante();
                $faltante->setProducto($item->getProducto());
                $faltante->setCantidad($cantidad);
                $faltante->setRemito($remito);
                $remito->addFaltante($faltante);
                $remito->setEstado(Remito::Inconsistente);
            }
            else
                $remito->setEstado(Remito::Pendiente);
        }
    }
    
    /* Deprecado */
    public function preUpdate($object)
    {
        foreach ($object->getItemsRemito() as $item) {
            $item->setRemito($object);   
        }
    }

}
