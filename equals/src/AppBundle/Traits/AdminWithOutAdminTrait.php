<?php
namespace AppBundle\Traits;


trait AdminWithOutAdminTrait 
{
	public function getDashboardActions()
    {
        $actions = parent::getDashboardActions();
        
        unset($actions['list']);
        unset($actions['create']);

        return $actions;
    }
}
