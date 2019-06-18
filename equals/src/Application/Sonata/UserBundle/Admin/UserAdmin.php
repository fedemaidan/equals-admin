<?php

namespace Application\Sonata\UserBundle\Admin;

use Sonata\UserBundle\Admin\Model\UserAdmin as SonataUserAdmin;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Form\FormMapper;
use Knp\Menu\ItemInterface as MenuItemInterface;
use Sonata\AdminBundle\Admin\AdminInterface;

class UserAdmin extends SonataUserAdmin
{

    /**
     * {@inheritdoc}
     */
    protected function configureListFields(ListMapper $listMapper)
    {
        unset($this->listModes['mosaic']);

        $listMapper
            ->addIdentifier('username')
            ->add('groups')
            ->add('enabled', null, array('editable' => true))
            ->add('locked', null, array('editable' => true))
            ->add('createdAt', null, ['locale' => 'es', 'format' => 'd/m/y H:i'])
        ;
    }

    /**
     * {@inheritdoc}
     */
    protected function configureDatagridFilters(DatagridMapper $filterMapper)
    {
        $filterMapper
            ->add('id')
            ->add('username')
            ->add(
                'locked',
                null,
                [],
                'sonata_type_translatable_choice',
                [
                    'translation_domain' => 'SonataAdminBundle',
                    'choices' => [
                        1 => 'label_type_yes',
                        2 => 'label_type_no',
                    ],
                ]
            )
            ->add('groups')
        ;
    }

     /**
     * @param FormMapper $formMapper
     */
    protected function configureFormFields(FormMapper $formMapper)
    {

        parent::configureFormFields($formMapper);
        $formMapper->removeGroup('Profile','User');
        $formMapper->removeGroup('Social','User');
        $formMapper->removeGroup('Keys','Security');
        $formMapper->remove('email');
        //$formMapper->add('email', 'email', ['pattern' => "^[A-Za-z0-9\.|-|_]*[@]{1}[A-Za-z0-9\.|-|_]*[.]{1}[a-z]{2,5}$",
          //                                  'required' => false]);

        
    }


    public function getExportFields()
    {
        $results = array();
        $results[] = "id";
        $results[] = "username";
        $results[] = "groups";
        //$results[] = "enabled";
        //$results[] = "locked";
         
        return $results;
    }

    public function getExportFormats()
    {
        return ['csv'];
    }


    
}
