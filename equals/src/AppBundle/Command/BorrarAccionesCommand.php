<?php
namespace AppBundle\Command;


use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Input\InputOption;
use AppBundle\Entity\Fabricacion;
use AppBundle\Entity\Remito;
use AppBundle\Entity\Compra;
use AppBundle\Entity\Lote;

class BorrarAccionesCommand extends ContainerAwareCommand
{

    protected function configure()
    {
        $this
            ->setName('borrar:acciones')
            ->setDescription('Borrar todas las accciones')
            // ->addOption('busqueda_id', null,         InputOption::VALUE_REQUIRED,    'Id de la busqueda');
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
 
        $eliminarAccionesService = $this->getContainer()->get('eliminarAcciones_service');
        $remitos = $this->getContainer()->get('doctrine')->getManager()->getRepository(Remito::class)->findAll();

        foreach ($remitos as $remito ) {
            $eliminarAccionesService->borrarRemito($remito->getId());
        }
        
        $output->writeln('Remitos borrados correctamente');

        $fabricaciones = $this->getContainer()->get('doctrine')->getManager()->getRepository(Fabricacion::class)->findAll();

        foreach ($fabricaciones as $fab ) {
            $eliminarAccionesService->borrarFabricacion($fab->getId());
        }

        $output->writeln('Fabricaciones borradas correctamente');

        $compras = $this->getContainer()->get('doctrine')->getManager()->getRepository(Compra::class)->findAll();

        foreach ($compras as $compra ) {
            $eliminarAccionesService->borrarCompra($compra->getId());
        }
        
        $output->writeln('Compras borradas correctamente');

        $lotes = $this->getContainer()->get('doctrine')->getManager()->getRepository(Lote::class)->findAll();

        foreach ($lotes as $lote ) {
            $this->getContainer()->get('doctrine')->getManager()->remove($lote);
            $this->getContainer()->get('doctrine')->getManager()->flush();
        }
        
        $output->writeln('Lotes borrados correctamente');
        
    }
}

?>