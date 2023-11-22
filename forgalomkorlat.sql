-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2018. Már 05. 23:47
-- Kiszolgáló verziója: 10.1.19-MariaDB
-- PHP verzió: 7.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `forgalomkorlat`
--
CREATE DATABASE IF NOT EXISTS `forgalomkorlat` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `forgalomkorlat`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

CREATE TABLE IF NOT EXISTS `felhasznalok` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `csaladi_nev` varchar(45) NOT NULL DEFAULT '',
  `utonev` varchar(45) NOT NULL DEFAULT '',
  `bejelentkezes` varchar(12) NOT NULL DEFAULT '',
  `jelszo` varchar(40) NOT NULL DEFAULT '',
  `jogosultsag` varchar(3) NOT NULL DEFAULT '_1_',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`id`, `csaladi_nev`, `utonev`, `bejelentkezes`, `jelszo`, `jogosultsag`) VALUES
(1, 'Rendszer', 'Admin', 'Admin', sha1('admin'), '__1'),
(2, 'Családi_2', 'Utónév_2', 'Login2', sha1('login2'), '_1_'),
(3, 'Családi_3', 'Utónév_3', 'Login3', sha1('login3'), '_1_'),
(4, 'Családi_4', 'Utónév_4', 'Login4', sha1('login4'), '_1_'),
(5, 'Családi_5', 'Utónév_5', 'Login5', sha1('login5'), '_1_'),
(6, 'Családi_6', 'Utónév_6', 'Login6', sha1('login6'), '_1_'),
(7, 'Családi_7', 'Utónév_7', 'Login7', sha1('login7'), '_1_'),
(8, 'Családi_8', 'Utónév_8', 'Login8', sha1('login8'), '_1_'),
(9, 'Családi_9', 'Utónév_9', 'Login9', sha1('login9'), '_1_'),
(10, 'Családi_10', 'Utónév_10', 'Login10', sha1('login10'), '_1_');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `menu`
--

CREATE TABLE IF NOT EXISTS `menu` (
  `url` varchar(30) NOT NULL,
  `nev` varchar(30) NOT NULL,
  `szulo` varchar(30) NOT NULL,
  `jogosultsag` varchar(3) NOT NULL,
  `sorrend` tinyint(4) NOT NULL,
  PRIMARY KEY (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

 

--
-- A tábla adatainak kiíratása `menu`
--

INSERT INTO `menu` (`url`, `nev`, `szulo`, `jogosultsag`, `sorrend`) VALUES
('admin', 'Admin', '', '001', 80),
('belepes', 'Belépés', '', '100', 60),
('elerhetoseg', 'SOAP', '', '111', 30),
('kiegeszitesek', 'MNB', '', '011', 50),
('kilepes', 'Kilépés', '', '011', 70),
('hirek', 'Hírek', '', '111', 20),
('nyitolap', 'Nyitólap', '', '111', 10);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


--
-- Tábla szerkezet ehhez a táblához `hirek`
--

CREATE TABLE `hirek` (
  `id` int(10) UNSIGNED NOT NULL,
  `userid` int(10) UNSIGNED NOT NULL,
  `datum` timestamp NOT NULL DEFAULT current_timestamp(),
  `hir` text NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `hirek`
--

INSERT INTO `hirek` (`id`, `userid`, `datum`, `hir`) VALUES
(1, 1, '2023-11-15 21:00:00', 'teszthír'),
(2, 2, '2023-11-15 21:25:38', 'teszthír 2'),
(3, 1, '2023-11-15 21:38:22', 'Beküldött hír 1');


-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kommentek`
--

CREATE TABLE `kommentek` (
  `id` int(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `hirid` int(10) UNSIGNED NOT NULL,
  `datum` timestamp NOT NULL DEFAULT current_timestamp(),
  `komment` tinytext NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `kommentek`
--

INSERT INTO `kommentek` (`id`, `userid`, `hirid`, `datum`, `komment`) VALUES
(1, 3, 1, '2023-11-15 19:28:34', 'tesztkomment1');



-- INNENTŐL NYÚLOK BELE!!! HA NEM JÓ, TÖRÖLNI

-- megnevezes tábla

CREATE TABLE megnevezes (
    id INT PRIMARY KEY,
    nev VARCHAR(255)
);

INSERT INTO megnevezes (id, nev) VALUES
(1, 'kábel fektetés'),
(2, 'csomópont építés'),
(3, 'kátyúzás'),
(4, 'útépítés'),
(5, 'aszfaltmarás'),
(6, 'árvíz'),
(7, 'aszfaltozás'),
(8, 'hézagkiöntés'),
(9, 'nyomvályú megszüntetés'),
(10, 'csatorna'),
(11, 'árok- és padkarendezés');



-- mertek tábla

CREATE TABLE mertek (
    id INT PRIMARY KEY,
    nev VARCHAR(255)
);

INSERT INTO mertek (id, nev) VALUES
(1, 'útszűkület'),
(2, 'sávlezárás'),
(3, 'félpályás lezárás'),
(4, 'teljes lezárás'),
(5, 'nincs lezárás'),
(6, 'nehezen járható');


-- korlatozas tábla

CREATE TABLE korlatozas (
    az INT AUTO_INCREMENT PRIMARY KEY,
    utszam INT,
    kezdet DECIMAL(9,3),
    veg DECIMAL(9,3),
    telepules VARCHAR(255),
    mettol DATE,
    meddig DATE,
    megnevid INT,
    mertekid INT,
    sebesseg INT,
    FOREIGN KEY (`megnevid`) REFERENCES `megnevezes`(`id`),
    FOREIGN KEY (`mertekid`) REFERENCES `mertek`(`id`)
);

INSERT INTO korlatozas (utszam, kezdet, veg, telepules, mettol, meddig, megnevid, mertekid, sebesseg) VALUES 
(1, 74.820, 75.977, 'Almásfüzitő', '2010-06-03', '2010-06-21', 1, 1, 30),
(1, 169.410, 170.320, 'Levél', '2010-03-16', '2010-06-30', 2, 2, 40),
(3, 178.970, 187.145, 'Miskolc', '2010-05-31', '2010-06-30', 3, 1, 30),
(4, 304.000, 313.000, 'Nyírtass', '2010-05-29', '2010-10-05', 4, 1, 40),
(4, 306.000, 307.000, 'Nyírtass', '2010-03-24', '2010-10-05', 2, 1, 40),
(4, 336.580, 341.222, 'Záhony', '2010-05-29', '2010-10-05', 4, 1, 40),
(4, 287.790, 288.910, 'Nyírtura', '2010-03-10', '2010-10-05', 4, 1, 40),
(4, 319.250, 319.775, 'Kisvárda', '2010-05-29', '2010-10-05', 4, 1, 40),
(4, 313.000, 315.000, 'Pátroha', '2010-05-05', '2010-10-05', 4, 1, 40),
(4, 241.650, 248.480, 'Hajdúhadház - Téglás', '2010-07-08', '2010-07-30', 4, 5, 60),
(4, 248.480, 260.200, 'Újfehértó', '2010-03-16', '2010-10-30', 5, 1, 30),
(4, 336.580, 337.910, 'Tiszabezdéd', '2010-03-10', '2010-10-05', 2, 1, 40),
(4, 180.400, 200.100, 'Püspökladány - Hajdúszoboszló', '2010-03-09', '2010-07-31', 4, 3, 40),
(6, 66.300, 67.000, 'Dunaújváros', '2010-06-01', '2010-06-15', 6, 1, 40),
(8, 43.500, 44.600, 'Litér', '2010-10-15', '2010-11-30', 2, 1, 50),
(11, 37.740, 37.850, 'Dunabogdány', '2010-05-17', '2010-06-21', 4, 3, 30),
(11, 24.250, 24.300, 'Leányfalu', '2010-05-17', '2010-06-25', 4, 1, 30),
(11, 25.900, 26.100, 'Leányfalu', '2010-05-03', '2010-06-30', 4, 1, 30),
(13, 3.293, 3.948, 'Komárom', '2010-04-26', '2010-08-15', 2, 1, 40),
(21, 15.060, 16.530, 'Apc', '2010-03-15', '2010-09-30', 4, 1, 60),
(21, 7.850, 9.750, 'Lőrinci', '2010-03-15', '2010-09-30', 4, 1, 60),
(21, 57.800, 58.100, 'Salgótarján', '2010-05-17', '2010-06-15', 4, 2, 30),
(31, 27.540, 32.721, 'Maglód - Mende', '2010-03-17', '2010-06-18', 4, 3, 20),
(31, 34.107, 40.764, 'Mende', '2010-03-17', '2010-06-18', 4, 3, 20),
(31, 32.721, 34.107, 'Mende', '2010-03-17', '2010-06-18', 4, 3, 20),
(31, 25.515, 34.803, 'Maglód - Mende', '2010-03-09', '2010-07-27', 4, 3, 40),
(32, 57.282, 58.291, 'Újszász', '2010-03-17', '2010-06-15', 7, 3, 40),
(32, 27.400, 27.900, 'Jászberény', '2010-05-07', '2010-08-06', 2, 1, 30),
(38, 12.400, 12.400, 'Rakamaz', '2010-05-10', '2010-06-30', 4, 1, 30),
(42, 5.100, 5.800, 'Püspökladány', '2010-04-15', '2010-06-30', 2, 3, 40),
(42, 41.500, 41.600, 'Berettyóújfalu', '2010-06-03', '2010-06-30', 8, 3, 40),
(47, 1.115, 1.255, 'Debrecen', '2010-03-30', '2010-06-30', 4, 1, 30),
(47, 217.800, 218.100, 'Algyő', '2010-03-17', '2010-06-30', 4, 2, 60),
(55, 100.060, 100.175, 'Baja', '2010-03-22', '2010-07-31', 2, 4, 30),
(61, 154.520, 155.800, 'Böhönye - Vése', '2010-03-15', '2010-11-15', 7, 1, 50),
(61, 165.500, 166.200, 'Vése - Inke', '2010-03-15', '2010-11-15', 7, 1, 40),
(61, 157.150, 158.170, 'Vése', '2010-03-15', '2010-11-15', 7, 1, 50),
(61, 161.100, 163.200, 'Vése', '2010-03-15', '2010-11-15', 7, 1, 30),
(61, 176.900, 177.400, 'Iharosberény', '2010-03-15', '2010-11-15', 7, 1, 30),
(61, 183.900, 185.500, 'Pogányszentpéter', '2010-03-15', '2010-11-15', 7, 1, 30),
(61, 176.150, 176.600, 'Iharosberény', '2010-03-15', '2010-11-15', 7, 1, 30),
(61, 172.100, 173.500, 'Inke', '2010-03-15', '2010-11-15', 7, 1, 30),
(61, 167.500, 169.100, 'Inke', '2010-03-15', '2010-11-15', 7, 1, 30),
(67, 8.500, 9.500, 'Szigetvár - Szentlászló', '2010-05-24', '2010-06-25', 7, 3, 40),
(72, 6.400, 6.902, 'Litér', '2010-10-15', '2010-11-30', 2, 1, 50),
(75, 56.750, 58.725, 'Lenti', '2010-06-02', '2010-07-06', 5, 1, 40),
(76, 36.700, 40.785, 'Padár - Nagykapornak', '2010-05-31', '2010-06-30', 4, 3, 40),
(76, 27.400, 27.400, 'Zalacsány', '2010-06-01', '2010-06-30', 7, 2, 40),
(76, 40.785, 53.255, 'Alsónemesapáti - Zalaegerszeg', '2010-03-22', '2010-11-10', 4, 3, 40),
(81, 60.050, 60.450, 'Mezőörs', '2010-05-16', '2010-06-30', 6, 4, 30),
(81, 59.800, 70.000, 'Pér - Mezőörs', '2010-03-22', '2010-07-15', 4, 3, 30),
(86, 6.798, 8.557, 'Resznek', '2010-06-01', '2010-07-31', 4, 2, 40),
(86, 2.381, 5.390, 'Rédics', '2010-04-19', '2010-08-01', 7, 3, 40),
(86, 94.500, 98.600, 'Szeleste', '2010-09-08', '2010-11-30', 4, 1, 40),
(86, 19.500, 21.860, 'Kálócfa - Kozmadombja', '2010-04-19', '2010-08-31', 4, 3, 30),
(86, 159.950, 160.100, 'Bősárkány', '2010-04-26', '2010-06-30', 4, 3, 30),
(451, 25.135, 27.050, 'Csongrád', '2010-03-22', '2010-08-27', 2, 1, 40),
(471, 71.000, 72.150, 'Mátészalka', '2010-03-30', '2010-06-30', 4, 1, 30),
(471, 27.500, 28.800, 'Nyíradony', '2010-04-01', '2010-06-30', 10, 1, 30),
(1109, 6.650, 6.690, 'Csobánka', '2010-05-24', '2010-06-21', 4, 1, 30),
(1111, 26.200, 26.700, 'Esztergom', '2010-06-04', '2010-06-18', 10, 3, 30),
(1119, 27.970, 29.456, 'Tarján', '2010-05-13', '2010-06-15', 7, 3, 40),
(1406, 1.250, 2.860, 'Mosonmagyaróvár - Máriakálnok', '2010-06-03', '2010-07-15', 4, 1, 50),
(2105, 13.000, 14.386, 'Galgamácsa', '2010-05-16', '2010-06-30', 6, 4, NULL),
(2105, 13.000, 14.386, 'Galgamácsa', '2010-06-01', '2010-06-30', 6, 4, NULL),
(2109, 18.970, 19.850, 'Palotás', '2010-05-17', '2010-06-15', 4, 3, 30),
(2119, 4.865, 11.725, 'Balassagyarmat - Csitár', '2010-05-03', '2010-06-15', 4, 3, 40),
(2124, 9.615, 12.500, 'Cserháthaláp - Szanda', '2010-05-03', '2010-06-15', 4, 3, 40),
(2126, 2.100, 2.200, 'Ecseg', '2010-05-03', '2010-06-15', 4, 3, 40),
(2127, 2.550, 4.300, 'Csécse', '2010-05-03', '2010-06-15', 4, 3, 40),
(2206, 8.985, 10.472, 'Karancskeszi', '2010-04-06', '2010-06-30', 4, 1, 30),
(2301, 0.000, 2.600, 'Bátonyterenye - Rákóczibánya', '2010-05-03', '2010-06-15', 4, 3, 40),
(2302, 7.300, 7.500, 'Kazár', '2010-05-03', '2010-06-15', 4, 3, 30),
(2504, 0.350, 0.950, 'Eger', '2010-05-03', '2010-08-02', 10, 4, NULL),
(2504, 0.950, 1.720, 'Eger', '2010-05-03', '2010-08-02', 10, 1, 30),
(2505, 52.083, 53.023, 'Miskolc', '2010-05-31', '2010-06-30', 9, 3, 30),
(2505, 53.570, 58.500, 'Miskolc', '2010-05-31', '2010-06-30', 3, 3, 30),
(2507, 4.300, 4.350, 'Borsodnádasd', '2010-06-01', '2010-10-31', 10, 3, 30),
(2507, 3.900, 4.300, 'Borsodnádasd', '2010-06-01', '2010-07-31', 6, 3, 30),
(2519, 1.511, 3.632, 'Miskolc', '2010-05-31', '2010-06-30', 4, 3, 30),
(3216, 28.000, 28.500, 'Tiszabura - Tiszaroff', '2010-06-04', '2010-06-30', 6, 4, NULL),
(4422, 39.500, 39.101, 'Makó', '2010-07-24', '2010-08-31', 4, 2, 30),
(4516, 16.900, 16.165, 'Szentes', '2010-02-22', '2010-08-31', 4, 1, 30),
(4516, 16.145, 16.149, 'Szentes', '2010-05-28', '2010-06-15', 4, 1, 30),
(4517, 2.060, 2.060, 'Csongrád', '2010-03-22', '2010-08-27', 2, 1, 40),
(4519, 1.003, 1.003, 'Csongrád', '2010-03-22', '2010-08-27', 2, 1, 40),
(4609, 23.500, 24.000, 'Jászkarajenő', '2010-06-03', '2010-06-30', 6, 1, 40),
(4612, 0.000, 0.775, 'Abony', '2010-06-03', '2010-06-30', 7, 1, 30),
(4911, 0.777, 2.000, 'Nyíregyháza', '2010-03-16', '2010-10-30', 5, 1, 30),
(4918, 0.000, 3.000, 'Mátészalka - Nyírcsaholy', '2010-03-30', '2010-06-30', 4, 1, 30),
(5113, 5.775, 11.390, 'Őcsény - Decs', '2010-05-06', '2010-06-15', 7, 3, 30),
(5113, 11.390, 13.415, 'Decs', '2010-04-28', '2010-07-15', 6, 4, 30),
(5204, 0.000, 9.855, 'Bugyi - Kiskunlacháza', '2010-03-16', '2010-07-17', 4, 4, 30),
(5701, 0.000, 4.670, 'Bóly - Szederkény', '2010-03-01', '2010-08-31', 4, 4, NULL),
(5711, 4.000, 4.850, 'Kozármisleny', '2010-08-01', '2010-08-31', 4, 4, 30),
(6231, 0.175, 0.224, 'Paks', '2010-03-16', '2010-06-15', 4, 2, 30),
(6316, 2.610, 3.100, 'Medina', '2010-04-21', '2010-07-09', 7, 1, 40),
(6535, 16.082, 16.115, 'Tevel', '2010-06-03', '2010-06-25', 10, 3, 30),
(6541, 19.450, 19.600, 'Magyaregregy', '2010-04-09', '2010-08-31', 11, 3, 30),
(7306, 0.000, 2.195, 'Ajka', '2010-07-06', '2010-07-30', 4, 1, 30),
(7417, 0.650, 2.711, 'Kerkafalva', '2010-02-01', '2010-12-31', 10, 6, 30),
(7522, 19.500, 21.300, 'Esztergályhorváti', '2010-05-31', '2010-06-30', 10, 3, 40),
(7540, 3.747, 4.247, 'Letenye - Kistolmács', '2010-05-10', '2010-06-15', 7, 1, 40),
(8101, 32.137, 32.177, 'Szárliget', '2010-05-13', '2010-06-15', 7, 3, 30),
(8102, 17.500, 18.403, 'Budakeszi', '2010-04-12', '2010-06-30', 10, 1, 30),
(8113, 7.902, 11.595, 'Szárliget', '2010-05-13', '2010-06-15', 7, 3, 40),
(8116, 9.864, 15.697, 'Pákozd - Sukoró', '2010-03-16', '2010-06-30', 11, 1, 30),
(8127, 26.000, 26.400, 'Dad - Kocs', '2010-01-26', '2010-06-30', 10, 5, NULL),
(8135, 20.980, 21.040, 'Dad - Császár', '2010-05-31', '2010-06-18', 6, 3, 40),
(8135, 10.312, 10.612, 'Kecskéd', '2010-05-13', '2010-06-15', 7, 3, 40),
(8136, 18.017, 19.397, 'Nagyigmánd', '2010-03-24', '2010-06-30', 1, 2, 40),
(8139, 15.017, 15.017, 'Komárom', '2010-03-24', '2010-06-30', 1, 1, 40),
(8142, 0.511, 1.680, 'Komárom', '2010-03-24', '2010-06-30', 1, 1, 30),
(8147, 5.950, 6.050, 'Nagyigmánd', '2010-06-24', '2010-06-30', 4, 1, 40),
(8301, 17.706, 32.000, 'Bakonybél - Nagygyimót', '2010-06-03', '2010-06-30', 6, 1, 40),
(8302, 2.000, 25.000, 'Pápa - Gic', '2010-06-03', '2010-06-30', 6, 1, 40),
(8302, 18.671, 18.771, 'Pápateszér', '2010-02-24', '2010-06-30', 4, 3, 30),
(8416, 8.000, 9.000, 'Malomsok', '2010-06-02', '2010-06-30', 6, 3, 30),
(8437, 0.000, 2.200, 'Vashosszúfalu', '2010-03-25', '2010-07-23', 4, 3, 30),
(8445, 2.420, 3.013, 'Vép - Nemesbőd', '2010-04-23', '2010-11-15', 4, 5, 40),
(8446, 11.326, 12.207, 'Szeleste', '2010-09-08', '2010-09-30', 4, 1, 40),
(8446, 1.000, 2.200, 'Sárvár', '2010-03-29', '2010-08-30', 4, 3, 30),
(8453, 0.000, 1.055, 'Tokorcs - Kemenesmihályfa', '2010-03-16', '2010-07-13', 4, 3, 30),
(8509, 3.000, 7.200, 'Markotabödöge', '2010-06-01', '2010-06-17', 3, 3, 30),
(8627, 10.500, 11.000, 'Lövő', '2010-05-29', '2010-06-25', 4, 3, 30),
(8901, 2.400, 2.600, 'Szombathely', '2010-06-02', '2010-09-30', 2, 2, 30),
(11129, 0.151, 0.251, 'Tát', '2010-05-13', '2010-06-15', 7, 3, 40),
(12126, 0.030, 0.350, 'Borsosberény', '2010-05-17', '2010-06-15', 4, 3, 30),
(14101, 0.000, 1.000, 'Öttevény', '2010-06-01', '2010-06-16', 3, 3, 30),
(21112, 1.770, 7.085, 'Sződ', '2010-05-05', '2010-06-16', 7, 3, 30),
(21153, 6.250, 10.110, 'Legénd', '2010-05-03', '2010-06-15', 4, 3, 40),
(22101, 8.100, 9.800, 'Dejtár', '2010-05-03', '2010-06-15', 4, 3, 40),
(22109, 6.480, 7.234, 'Karancsalja', '2010-05-17', '2010-06-15', 4, 3, 30);
