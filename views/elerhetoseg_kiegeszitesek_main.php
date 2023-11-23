<?php
$options = array(
    'location' => 'http://localhost/web2/soap/szerver/soapSzerver.php',
    'uri' => 'http://localhost/web2/soap/szerver/soapSzerver.php',
    'keep_alive' => false,
);

try {
    $kliens = new SoapClient(null, $options);

    $selectedMegnevezes = '';
    $selectedMertek = '';
    $selectedForgalomKorlatozas = '';

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $selectedMegnevezes = $_POST['megnevezes'];
        $selectedMertek = $_POST['mertek'];
        $selectedForgalomKorlatozas = $_POST['forgalomKorlatozas'];
    }

    $megnevezesek = $kliens->getMegnevezes();
    $mertek = $kliens->getMertek();
    $forgalomKorlatozasok = $kliens->getForgalomKorlatozasok($selectedMegnevezes, $selectedMertek);

    echo "<form method='post'>";

    echo "<h2>Megnevezések:</h2>";
    echo "<select name='megnevezes'>";
    foreach ($megnevezesek as $kulcs => $ertek) {
        $selected = ($kulcs == $selectedMegnevezes) ? 'selected' : '';
        echo "<option value='$kulcs' $selected>$ertek</option>";
    }
    echo "</select>";

    echo "<h2>Mértékek:</h2>";
    echo "<select name='mertek'>";
    foreach ($mertek as $kulcs => $ertek) {
        $selected = ($kulcs == $selectedMertek) ? 'selected' : '';
        echo "<option value='$kulcs' $selected>$ertek</option>";
    }
    echo "</select>";

    echo "<h2>Forgalomkorlátozások:</h2>";
    echo "<select name='forgalomKorlatozas'>";
    foreach ($forgalomKorlatozasok as $kulcs => $ertek) {
        $selected = ($kulcs == $selectedForgalomKorlatozas) ? 'selected' : '';
        $megnevezes = $megnevezesek[$ertek['megnevezes']];
        $mertekNev = $mertek[$ertek['mertek']];

        echo "<option value='$kulcs' $selected>$megnevezes - $mertekNev</option>";
    }
    echo "</select>";

    echo "<input type='submit' value='Kiválasztás'>";

    echo "</form>";

    // Kiválasztott forgalomkorlátozás adatainak megjelenítése
    if (!empty($selectedForgalomKorlatozas)) {
        $selectedData = $forgalomKorlatozasok[$selectedForgalomKorlatozas];
        echo "<h2>Kiválasztott Forgalomkorlátozás:</h2>";
        echo "Azonosító: $selectedForgalomKorlatozas<br>";
        echo "Útszám: " . $selectedData['utszam'] . "<br>";
        echo "Kezdet: " . $selectedData['kezdet'] . "<br>";
        echo "Vég: " . $selectedData['veg'] . "<br>";
        echo "Település: " . $selectedData['telepules'] . "<br>";
        echo "Mettől: " . $selectedData['mettol'] . "<br>";
        echo "Meddig: " . $selectedData['meddig'] . "<br>";
        echo "Sebesség: " . $selectedData['sebesseg'] . "<br>";
    }

} catch (SoapFault $e) {
    var_dump($e);
}
?>
