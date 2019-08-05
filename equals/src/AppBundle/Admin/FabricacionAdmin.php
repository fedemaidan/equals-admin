<?php

namespace AppBundle\Admin;

use Sonata\AdminBundle\Admin\AbstractAdmin;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Form\FormMapper;
use Sonata\AdminBundle\Show\ShowMapper;
use Sonata\AdminBundle\Route\RouteCollection;

class FabricacionAdmin extends AbstractAdmin
{
    protected $datagridValues = [

        // display the first page (default = 1)
        '_page' => 1,

        // reverse order (default = 'ASC')
        '_sort_order' => 'DESC',

        // name of the ordered field (default = the model's id field, if any)
        '_sort_by' => 'id',
    ];

    protected function configureRoutes(RouteCollection $collection)
    {
        $collection->add('actuar', $this->getRouterIdParameter().'/actuar');
        $collection->add('confirmar', $this->getRouterIdParameter().'/confirmar');
        $collection->add('completar', $this->getRouterIdParameter().'/completar');
        $collection->add('imprimirOrden', $this->getRouterIdParameter().'/imprimir/orden');
        $collection->add('imprimirEtiqueta', $this->getRouterIdParameter().'/imprimir/etiqueta');
        $collection->add('imprimirCoa', $this->getRouterIdParameter().'/imprimir/coa');
    }

    protected function configureDatagridFilters(DatagridMapper $datagridMapper)
    {
        $datagridMapper
            ->add('id')
            ->add('cantidad')
        ;
    }

    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->add('id')
            ->add('cantidad')
            ->add('estado')
            ->add('_action', null, [
                'actions' => [
                    'actuar' => array(
                        'template' => 'AppBundle:FabricacionCRUD:actuar.html.twig'
                    ),
                    'show' => []
                ],
            ])
        ;
    }

    protected function configureFormFields(FormMapper $formMapper)
    {
        $formMapper
            ->add('cantidad')
            ->add('formulaEnzimatica')

        ;
    }

    protected function configureShowFields(ShowMapper $showMapper)
    {
        $showMapper
            ->add('id')
            ->add('cantidad')
            ->add('formulaEnzimatica')   
            ->add('formulaEnzimatica.productoResultante')
            ->add('estado')
            ->add('faltantes')
        ;
    }

    public function prePersist($fabricacion)
    {
        $this->getConfigurationPool()->getContainer()->get('adminLotes_service')->preInitFabricacion($fabricacion);
    }

    public function postPersist($fabricacion)
    {
        $offset = 304-22; //PROXIMO NUMERO PEDIDO - ID EN EL MOMENTO EN EL QUE SE SOLICITO

        $fabricacion->setNumero($offset+$fabricacion->getId());
        
        $this->getModelManager()->getEntityManager($this->getClass())->persist($fabricacion);
        $this->getModelManager()->getEntityManager($this->getClass())->flush();
    }
}
