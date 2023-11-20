<?php

class Hirbekuld_Model {
	
	public function get_data($vars): array {

		$retData['eredmeny'] = "";
		if ($_SESSION['userid'] == 0 || !isset($_SESSION['userid'])) {
			$retData['eredmeny'] = "ERROR";
			$retData['uzenet'] = "Hír beküldése csak regisztrált felhasználók számára lehetséges!";
		} else {
			if (isset($vars['ujhir'])) {
				try {
					$connection = Database::getConnection();
					$sqlInsert = "insert into hirek(userid, hir) values(:userid, :hir)";
					$stmt = $connection->prepare($sqlInsert);
					$stmt->execute(array(
										'userid' => $_SESSION['userid'],
										'hir' => $vars['ujhir']
								   ));
					if ($stmt->rowCount()) {
						$retData['uzenet'] = "Köszönjük a megosztást.";
					} else {
						$retData['eredmeny'] = "ERROR";
						$retData['uzenet'] = "Sikertelen hírbeküldés.";
					}
				} catch (PDOException $e) {
					$retData['eredmeny'] = "ERROR";
					$retData['uzenet'] = "Hiba: " . $e->getMessage() . "<br>Hibás sor: " . $e->getLine();
				}
			}
		}
		return $retData;
	}
}