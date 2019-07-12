<?php
namespace AppBundle\Form;
use AppBundle\Entity\Lote;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Sonata\Form\Type\DateTimePickerType;

class LoteType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('fecha', DateTimePickerType::class,array('date_format' => 'yyyy-MM-dd HH:mm:ss'))
            ->add('producto')
            ->add('cantidadInicial')
            ->add('numero')
            ->add('costo')
        ;
    }
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => Lote::class,
        ]);
    }
}