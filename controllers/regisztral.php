<?php

class Regisztral
{
	public function main(array $vars) {
	// Betöltjük a nézetet
	$view = new View_Loader($this->regisztral."_main");

	// Adatok beállítása a nézethez
	$viewData = [
		'uzenet' => 'Üdvözöljük a regisztrációnál!'
		// Egyéb adatokat is adhatsz át a nézethez, amire szükséged van
	];

	// Átadjuk a nézetnek az adatokat
	$view->assign('viewData', $viewData);
}
}

?>