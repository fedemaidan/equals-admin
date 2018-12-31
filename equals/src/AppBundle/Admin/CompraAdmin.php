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
            $lote->setNumero('L'.$lote->getId());
            $lote->setCantidadDisponible($lote->getCantidadInicial());
            $lote->setCompra($compra);   
        }

        $this->update($compra);
    }
}
