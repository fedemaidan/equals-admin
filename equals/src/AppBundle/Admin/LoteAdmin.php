<?php

namespace AppBundle\Admin;

use Sonata\AdminBundle\Admin\AbstractAdmin;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Form\FormMapper;
use Sonata\AdminBundle\Show\ShowMapper;

class LoteAdmin extends AbstractAdmin
{
    use \AppBundle\Traits\LoteTrait;
    use \AppBundle\Traits\AdminWithOutAdminTrait;

    /**
     * @param DatagridMapper $datagridMapper
     */
    protected function configureDatagridFilters(DatagridMapper $datagridMapper)
    {
        $datagridMapper
            ->add('id')
            ->add('numero')
            ->add('cantidadInicial')
            ->add('cantidadDisponible')
            ->add('costo')
            ->add('producto')
        ;
    }

    /**
     * @param ListMapper $listMapper
     */
    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->add('id')
            ->add('numero')
            ->add('producto')
            ->add('cantidadInicial')
            ->add('cantidadDisponible')
            ->add('_action', null, array(
                'label' => 'Acciones',
                'actions' => array(
                    'show' => array(),
                    'edit' => array(),
                    'delete' => array(),
                )
            ))
        ;
    }

    /**
     * @param FormMapper $formMapper
     */
    protected function configureFormFields(FormMapper $formMapper)
    {
        $subject = $this->getSubject();

        if ($subject->getId() !== null) {
                $formMapper->add('numero');
        }

        $formMapper
            ->add('producto')
            ->add('cantidadInicial');

        if ($subject->getId() !== null) {
            $formMapper->add('cantidadDisponible');
        }
        $formMapper
            ->add('costo')
            ->add('compra')
        ;
    }

    /**
     * @param ShowMapper $showMapper
     */
    protected function configureShowFields(ShowMapper $showMapper)
    {
        $showMapper
            ->add('id')
            ->add('numero')
            ->add('cantidadInicial')
            ->add('cantidadDisponible')
            ->add('costo')
            ->add('producto')
            ->add('compra')
        ;
    }

    public function postPersist($lote)
    {
        $lote = $this->postLotePersist($lote);
        $this->update($lote);
    }
}
