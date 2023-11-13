<?php

class Regisztral {
    public function regisztral($csaladi_nev, $uto_nev, $bejelentkezes, $jelszo, $jogosultsag) {
        try {
            $conn = Database::getConnection();
            
            $sqlSelect = "SELECT id FROM felhasznalok WHERE bejelentkezes = :bejelentkezes";
            $stmt = $conn->prepare($sqlSelect);
            $stmt->execute(array(':bejelentkezes' => $bejelentkezes));

            if ($stmt->fetch(PDO::FETCH_ASSOC)) {
                return "A felhasználói név már foglalt!";
            } else {
                $sqlInsert = "INSERT INTO felhasznalok (id, csaladi_nev, uto_nev, bejelentkezes, jelszo, jogosultsag) 
                              VALUES (0, :csaladi_nev, :uto_nev, :bejelentkezes, :jelszo, :jogosultsag)";
                $stmt = $conn->prepare($sqlInsert);
                $hashedPassword = password_hash($jelszo, PASSWORD_DEFAULT);
                $stmt->execute(array(
                    ':csaladi_nev' => $csaladi_nev,
                    ':uto_nev' => $uto_nev,
                    ':bejelentkezes' => $bejelentkezes,
                    ':jelszo' => $hashedPassword,
                    ':jogosultsag' => $jogosultsag
                ));

                $newId = $conn->lastInsertId();
                return "A regisztráció sikeres. Azonosítója: {$newId}";
            }
        } catch (PDOException $e) {
            return "Hiba történt: " . $e->getMessage();
        }
    }
}
?>