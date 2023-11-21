<?php

class Elerhetoseg_alapinfok_Controller
{
	public $baseName = 'elerhetoseg_alapinfok';  //meghat�rozni, hogy melyik oldalon vagyunk
	public function main(array $vars) // a router �ltal tov�bb�tott param�tereket kapja
	{

		$MnbModel = new Mnb_Model;
        $retData = $MnbModel->mnb_currency($vars);
        $this->baseName = "elerhetoseg_alapinfok";

		//bet�ltj�k a n�zetet
		$view = new View_Loader($this->baseName."_main");

		foreach($retData as $name => $value)
            $view->assign($name, $value);
	}
}

?>
