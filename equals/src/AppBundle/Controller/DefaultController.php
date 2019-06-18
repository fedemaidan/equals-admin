<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;

class DefaultController extends Controller
{
    /**
     * @Route("/", name="homepage")
     */
    public function indexAction(Request $request)
    {
        // replace this example code with whatever you need
        return $this->render('default/index.html.twig', array(
            'base_dir' => realpath($this->container->getParameter('kernel.root_dir').'/..'),
        ));
    }

    /**
     * @Route("/eliminarFabricacion", name="eliminarFabricacion")
     */
    public function eliminarFabricacionAction(Request $request)
    {
        $idFabricacion = $request->get("fabricacion_id");

        $this->container->get("eliminarAcciones_service")->borrarFabricacion($idFabricacion);
        die;
        return $this->render('default/index.html.twig', array(
            'base_dir' => realpath($this->container->getParameter('kernel.root_dir').'/..'),
        ));
    }

    /**
     * @Route("/eliminarRemito", name="eliminarRemito")
     */
    public function eliminarRemitoAction(Request $request)
    {
        $idRemito = $request->get("remito_id");
        $success = true;
        $msg = "Remito eliminado";

        try {
            $this->container->get("eliminarAcciones_service")->borrarRemito($idRemito);
        }
        catch(\Exception $e) {
            $success = true;
            $msg = $e->getMessage();
        }

        return new JsonResponse([
                    "success" => $success,
                    "message" => $msg
                ]);
        
        }
    
}
