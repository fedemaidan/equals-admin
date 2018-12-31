<?php

namespace AppBundle\Admin;

use Sonata\AdminBundle\Admin\AbstractAdmin;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Form\FormMapper;
use Sonata\AdminBundle\Show\ShowMapper;

class ProveedorAdmin extends AbstractAdmin
{
    use \AppBundle\Traits\AdminContactoPersonalTrait;

    protected function configureDatagridFilters(DatagridMapper $datagridMapper)
    {
        $datagridMapper
            ->add('id')
            ->add('nombre')
            ->add('direccion',null, ["label" => "Dirección"]);
        $datagridMapper = $this->addContactoPersonalDatagridMapper($datagridMapper);
            
    }

    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->add('id')
            ->add('nombre')
            ->add('direccion',null, ["label" => "Dirección"])
            ->add('contactoTelefono1',null, ["label" => "Contacto teléfono 1"])
            ->add('contactoMail1',null, ["label" => "Contacto mail 1"])
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
            ->tab('Principal')
                ->with('Datos')
                    ->add('nombre')
                    ->add('direccion',null, ["label" => "Dirección"])
                ->end()
                ->with('Contacto 1')
                    ->add('contactoNombre1',null, ["label" => "Contacto nombre"])
                    ->add('contactoTelefono1',null, ["label" => "Contacto teléfono"])
                    ->add('contactoMail1',"email", ["label" => "Contacto mail", 'required' => false])
                ->end()
            ->end();
        $formMapper = $this->addContactoPersonalTabMasContacto($formMapper);
    }

    protected function configureShowFields(ShowMapper $showMapper)
    {
        $showMapper
            ->add('id')
            ->add('nombre')
            ->add('direccion',null, ["label" => "Dirección"]);
        $showMapper = $this->addContactoPersonalShow($showMapper);
    }
}
