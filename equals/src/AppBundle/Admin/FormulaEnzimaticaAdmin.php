<?php

namespace AppBundle\Admin;

use Sonata\AdminBundle\Admin\AbstractAdmin;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Form\FormMapper;
use Sonata\AdminBundle\Show\ShowMapper;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use AppBundle\Form\IngredienteType;
use Symfony\Component\HttpFoundation\RedirectResponse;

class FormulaEnzimaticaAdmin extends AbstractAdmin
{

    use \AppBundle\Traits\AdminWithOutAdminTrait;
    
    protected function configureDatagridFilters(DatagridMapper $datagridMapper)
    {
        $datagridMapper
            ->add('id')
            ->add('nombre')
            ->add('productoResultante')
            ->add('ingredientes.producto')
        ;
    }

    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->add('id')
            ->add('nombre')
            ->add('productoResultante')
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
            ->add('nombre')
            ->add('productoResultante')
            ->add('ingredientes', CollectionType::class, [
                'by_reference' => false, // Use this because of reasons
                'allow_add' => true, // True if you want allow adding new entries to the collection
                'allow_delete' => true, // True if you want to allow deleting entries
                'prototype' => true, // True if you want to use a custom form type
                'entry_type' => IngredienteType::class, // Form type for the Entity that is being attached to the object
            ]);
        ;
    }

    protected function configureShowFields(ShowMapper $showMapper)
    {
        $showMapper
            ->add('id')
            ->add('nombre')
            ->add('productoResultante')
            ->add('ingredientes')
        ;
    }

    public function prePersist($formula)
    {

        try {
            
            foreach ($formula->getIngredientes() as $ingrediente) {
                $ingrediente->setFormulaEnzimatica($formula); 
            }

            $formula->validaIngredientes();

        } catch (\Exception $e) {
            $this->getRequest()->getSession()->getFlashBag()->add("sonata_flash_error", $e->getMessage());
         
        }

    }
    
    public function preUpdate($formula)
    {
        try {
            
            foreach ($formula->getIngredientes() as $ingrediente) {
                $ingrediente->setFormulaEnzimatica($formula); 
            }

            $formula->validaIngredientes();

        } catch (\Exception $e) {
            $this->getRequest()->getSession()->getFlashBag()->add("sonata_flash_error", $e->getMessage());
        }

    }
}
