<?php
namespace AppBundle\Traits;


trait AdminContactoPersonalTrait 
{
	public function addContactoPersonalDatagridMapper($datagridMapper) {
		return $datagridMapper	
			->add('contactoNombre1',null, ["label" => "Contacto nombre 1"])
            ->add('contactoTelefono1',null, ["label" => "Contacto teléfono 1"])
            ->add('contactoMail1',null, ["label" => "Contacto mail 1"])
            ->add('contactoNombre2',null, ["label" => "Contacto nombre 2"])
            ->add('contactoTelefono2',null, ["label" => "Contacto teléfono 2"])
            ->add('contactoMail2',null, ["label" => "Contacto mail 2"])
            ->add('contactoNombre3',null, ["label" => "Contacto nombre 3"])
            ->add('contactoTelefono3',null, ["label" => "Contacto teléfono 3"])
            ->add('contactoMail3',null, ["label" => "Contacto mail 3"]);
    }

    public function  addContactoPersonalTabMasContacto($formMapper) {
    	return $formMapper->tab('Mas contactos')
                ->with('Contacto 2')
                    ->add('contactoNombre2',null, ["label" => "Contacto nombre"])
                    ->add('contactoTelefono2',null, ["label" => "Contacto teléfono"])
                    ->add('contactoMail2',"email", ["label" => "Contacto mail", 'required' => false])
                ->end()
                ->with('Contacto 3')
                    ->add('contactoNombre3',null, ["label" => "Contacto nombre"])
                    ->add('contactoTelefono3',null, ["label" => "Contacto teléfono"])
                    ->add('contactoMail3',"email", ["label" => "Contacto mail", 'required' => false])
                ->end()
            ->end();
    }

    public function addContactoPersonalShow($showMapper) {
    	return $showMapper
    		->add('contactoNombre1',null, ["label" => "Contacto nombre 1"])
	    	->add('contactoTelefono1',null, ["label" => "Contacto teléfono 1"])
	        ->add('contactoMail1',null, ["label" => "Contacto mail 1"])
	        ->add('contactoNombre2',null, ["label" => "Contacto nombre 2"])
	        ->add('contactoTelefono2',null, ["label" => "Contacto teléfono 2"])
	        ->add('contactoMail2',null, ["label" => "Contacto mail 2"])
	        ->add('contactoNombre3',null, ["label" => "Contacto nombre 3"])
	        ->add('contactoTelefono3',null, ["label" => "Contacto teléfono 3"])
	        ->add('contactoMail3',null, ["label" => "Contacto mail 3"]);
    }
}

