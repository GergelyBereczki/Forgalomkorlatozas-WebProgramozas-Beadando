<?php
$options = array(
    'location' => 'http://localhost/forgalomkorlat_local/soap/szerver/soapSzerver.php',
    'uri' => 'http://localhost/forgalomkorlat_local/soap/szerver/soapSzerver.php',
    'keep_alive' => false,
);

try {
    $kliens = new SoapClient(null, $options);

    $forgalomKorlatozasok = $kliens->getForgalomKorlatozasok();
    $megnevezesek = $kliens->getMegnevezes();
    $mertek = $kliens->getMertek();

    echo "<h2>Forgalomkorlátozások:</h2>";
    echo "<pre>";
    print_r($forgalomKorlatozasok);
    echo "</pre>";

    echo "<h2>Megnevezések:</h2>";
    echo "<pre>";
    print_r($megnevezesek);
    echo "</pre>";

    echo "<h2>Mértékek:</h2>";
    echo "<pre>";
    print_r($mertek);
    echo "</pre>";
} catch (SoapFault $e) {
    var_dump($e);
}
?>