<?php

namespace AppBundle\Admin;

use Sonata\AdminBundle\Admin\AbstractAdmin;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Form\FormMapper;
use Sonata\AdminBundle\Show\ShowMapper;

class ClienteAdmin extends AbstractAdmin
{
    use \AppBundle\Traits\AdminContactoPersonalTrait;
    
    protected function configureDatagridFilters(DatagridMapper $datagridMapper)
    {
        $datagridMapper
            ->add('id')
            ->add('nombre')
            ->add('direccionFiscal')
            ->add('direccionEntrega')
            ->add('cuit');

        $datagridMapper = $this->addContactoPersonalDatagridMapper($datagridMapper);
    }

    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->add('id')
            ->add('nombre')
            ->add('direccionFiscal')
            ->add('direccionEntrega')
            ->add('cuit')
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
                    ->add('direccionFiscal')
                    ->add('direccionEntrega')
                    ->add('cuit')
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
            ->add('direccionFiscal')
            ->add('direccionEntrega')
            ->add('cuit')
            ->add('contactoNombre1')
            ->add('contactoTelefono1')
            ->add('contactoMail1')
            ->add('contactoNombre2')
            ->add('contactoTelefono2')
            ->add('contactoMail2')
            ->add('contactoNombre3')
            ->add('contactoTelefono3')
            ->add('contactoMail3')
        ;
    }
}
