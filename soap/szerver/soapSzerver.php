<?php
// Szolgaltatas.php

class Szolgaltatas {
    private $db;

    public function __construct() {
        // Adatbázis kapcsolat inicializálása
        $this->db = new mysqli('localhost', 'root', '', 'web2');

        if ($this->db->connect_error) {
            die('Connect Error (' . $this->db->connect_errno . ') ' . $this->db->connect_error);
        }
    }

    function getMegnevezes() {
        try {
            // SQL lekérdezés a megnevezes táblából csak azokkal a mezőkkel, amelyek kellenek a select-hez
            $result = $this->db->query('SELECT id, nev FROM megnevezes');

            $data = array();
            while ($row = $result->fetch_assoc()) {
                $data[$row['id']] = $row['nev'];
            }

            return $data;
        } catch (Exception $e) {
            // Hibakezelés SOAP hibával
            throw new SoapFault('Server', $e->getMessage());
        }
    }

    public function getMertek() {
        // SQL lekérdezés a mertek táblából csak azokkal a mezőkkel, amelyek kellenek a select-hez
        $result = $this->db->query('SELECT id, nev FROM mertek');

        $data = array();
        while ($row = $result->fetch_assoc()) {
            $data[$row['id']] = $row['nev'];
        }

        return $data;
    }

    function getForgalomKorlatozasok() {
        try {
            // SQL lekérdezés a korlatozas táblából csak azokkal a mezőkkel, amelyek kellenek a select-hez
            $result = $this->db->query('SELECT az, utszam, kezdet, veg, telepules, mettol, meddig, megnevid, mertekid, sebesseg FROM korlatozas');
    
            $data = array();
            while ($row = $result->fetch_assoc()) {
                $data[] = array(
                    'az' => $row['az'],
                    'utszam' => $row['utszam'],
                    'kezdet' => $row['kezdet'],
                    'veg' => $row['veg'],
                    'telepules' => $row['telepules'],
                    'mettol' => $row['mettol'],
                    'meddig' => $row['meddig'],
                    'megnevezes' => $this->getMegnevezesNev($row['megnevid']),
                    'mertek' => $this->getMertekNev($row['mertekid']),
                    'sebesseg' => $row['sebesseg']
                );
            }
    
            return $data;
        } catch (Exception $e) {
            // Hibakezelés SOAP hibával
            throw new SoapFault('Server', $e->getMessage());
        }
    }

    private function getMegnevezesNev($megnevezesId) {
        $stmt = $this->db->prepare("SELECT nev FROM megnevezes WHERE id = ?");
        $stmt->bind_param('i', $megnevezesId);
        $stmt->execute();
        $stmt->bind_result($nev);
        $stmt->fetch();
        $stmt->close();
        return $nev;
    }

    private function getMertekNev($mertekId) {
        $stmt = $this->db->prepare("SELECT nev FROM mertek WHERE id = ?");
        $stmt->bind_param('i', $mertekId);
        $stmt->execute();
        $stmt->bind_result($nev);
        $stmt->fetch();
        $stmt->close();
        return $nev;
    }
}

$options = array(
    'uri' => 'http://localhost/web2/soap/szerver/soapSzerver'
);

$server = new SoapServer(null, $options);
$server->setClass('Szolgaltatas');
$server->handle();
?>
