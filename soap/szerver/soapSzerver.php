<?php
class Szolgaltatas {
    private $db;

    public function __construct() {
        // Adatbázis kapcsolat inicializálása
		$this->db = new mysqli('localhost', 'root', '', 'forgalomkorlat');

        if ($this->db->connect_error) {
            die('Connect Error (' . $this->db->connect_errno . ') ' . $this->db->connect_error);
        }
    }

	function getForgalomKorlatozasok() {
		try {
			// SQL lekérdezés a korlatozas táblából
			$result = $this->db->query('SELECT * FROM korlatozas');
	
			$data = array();
			while ($row = $result->fetch_assoc()) {
				$data[] = $row;
			}
	
			return $data;
		} catch (Exception $e) {
			// Hibakezelés SOAP hibával
			throw new SoapFault('Server', $e->getMessage());
		}
	}


   public function getMegnevezes() {
        // SQL lekérdezés a megnevezes táblából
        $result = $this->db->query('SELECT * FROM megnevezes');

        $data = array();
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }

        return $data;
    }

    public function getMertek() {
        // SQL lekérdezés a mertek táblából
        $result = $this->db->query('SELECT * FROM mertek');

        $data = array();
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }

        return $data;
    }


}

$options = array(
    'url' => 'http://localhost/forgalomkorlat_local/soap/szerver/soapSzerver'
);

$server = new SoapServer(null, $options);
$server->setClass('Szolgaltatas');
$server->handle();
?>