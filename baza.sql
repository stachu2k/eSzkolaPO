-- --------------------------------------------------------
-- Host:                         localhost
-- Wersja serwera:               5.6.21 - MySQL Community Server (GPL)
-- Serwer OS:                    Win32
-- HeidiSQL Wersja:              9.1.0.4867
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Zrzut struktury bazy danych eszkola
CREATE DATABASE IF NOT EXISTS `eszkola` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `eszkola`;


-- Zrzut struktury tabela eszkola.dzienniki
CREATE TABLE IF NOT EXISTS `dzienniki` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_klasa` int(10) unsigned NOT NULL,
  `semestr` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_klasa` (`id_klasa`),
  CONSTRAINT `dzienniki_ibfk_1` FOREIGN KEY (`id_klasa`) REFERENCES `klasy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Zrzut struktury tabela eszkola.kategorie_ocen
CREATE TABLE IF NOT EXISTS `kategorie_ocen` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Zrzut struktury tabela eszkola.klasy
CREATE TABLE IF NOT EXISTS `klasy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nr_roku` tinyint(1) NOT NULL,
  `lit_klasy` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_rok_szkolny` int(11) unsigned NOT NULL,
  `id_wychowawca` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_klasy_rok_szkolny` (`id_rok_szkolny`),
  KEY `FK_klasy_uzytkownicy` (`id_wychowawca`),
  CONSTRAINT `FK_klasy_rok_szkolny` FOREIGN KEY (`id_rok_szkolny`) REFERENCES `rok_szkolny` (`id`),
  CONSTRAINT `FK_klasy_uzytkownicy` FOREIGN KEY (`id_wychowawca`) REFERENCES `uzytkownicy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Zrzut struktury tabela eszkola.klasy_przydzial
CREATE TABLE IF NOT EXISTS `klasy_przydzial` (
  `id_klasa` int(10) unsigned NOT NULL,
  `id_uczen` int(10) unsigned NOT NULL,
  UNIQUE KEY `index1` (`id_klasa`,`id_uczen`),
  KEY `FK_klasy_przydzial_uzytkownicy` (`id_uczen`),
  CONSTRAINT `FK_klasy_przydzial_klasy` FOREIGN KEY (`id_klasa`) REFERENCES `klasy` (`id`),
  CONSTRAINT `FK_klasy_przydzial_uzytkownicy` FOREIGN KEY (`id_uczen`) REFERENCES `uzytkownicy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Zrzut struktury tabela eszkola.lekcje
CREATE TABLE IF NOT EXISTS `lekcje` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_plan` int(10) unsigned NOT NULL,
  `id_przedmiot` int(10) unsigned NOT NULL,
  `dzien_tyg` tinyint(1) NOT NULL,
  `godz_lek` tinyint(2) NOT NULL,
  `id_nauczyciel` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_plan` (`id_plan`),
  KEY `id_przedmiot` (`id_przedmiot`),
  KEY `lekcje_ibfk_3` (`id_nauczyciel`),
  CONSTRAINT `lekcje_ibfk_1` FOREIGN KEY (`id_plan`) REFERENCES `plany_lekcji` (`id`),
  CONSTRAINT `lekcje_ibfk_2` FOREIGN KEY (`id_przedmiot`) REFERENCES `przedmioty_szkolne` (`id`),
  CONSTRAINT `lekcje_ibfk_3` FOREIGN KEY (`id_nauczyciel`) REFERENCES `uzytkownicy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Zrzut struktury tabela eszkola.obecnosci
CREATE TABLE IF NOT EXISTS `obecnosci` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `obecnosc` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `data` date NOT NULL,
  `id_uczen` int(10) unsigned NOT NULL,
  `id_lekcja` int(10) unsigned NOT NULL,
  `id_dziennik` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_uczen` (`id_uczen`),
  KEY `id_lekcja` (`id_lekcja`),
  KEY `id_dziennik` (`id_dziennik`),
  CONSTRAINT `obecnosci_ibfk_1` FOREIGN KEY (`id_uczen`) REFERENCES `uzytkownicy` (`id`),
  CONSTRAINT `obecnosci_ibfk_2` FOREIGN KEY (`id_lekcja`) REFERENCES `uzytkownicy` (`id`),
  CONSTRAINT `obecnosci_ibfk_3` FOREIGN KEY (`id_dziennik`) REFERENCES `uzytkownicy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Zrzut struktury tabela eszkola.oceny
CREATE TABLE IF NOT EXISTS `oceny` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ocena` decimal(2,1) NOT NULL,
  `waga` tinyint(1) NOT NULL,
  `id_kategoria` int(10) unsigned NOT NULL,
  `komentarz` text COLLATE utf8_unicode_ci,
  `data` date NOT NULL,
  `id_przedmiot` int(10) unsigned NOT NULL,
  `id_uczen` int(10) unsigned NOT NULL,
  `id_nauczyciel` int(10) unsigned NOT NULL,
  `id_dziennik` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_przedmiot` (`id_przedmiot`),
  KEY `id_uczen` (`id_uczen`),
  KEY `id_nauczyciel` (`id_nauczyciel`),
  KEY `id_dziennik` (`id_dziennik`),
  CONSTRAINT `oceny_ibfk_1` FOREIGN KEY (`id_przedmiot`) REFERENCES `przedmioty_szkolne` (`id`),
  CONSTRAINT `oceny_ibfk_2` FOREIGN KEY (`id_uczen`) REFERENCES `uzytkownicy` (`id`),
  CONSTRAINT `oceny_ibfk_3` FOREIGN KEY (`id_nauczyciel`) REFERENCES `uzytkownicy` (`id`),
  CONSTRAINT `oceny_ibfk_4` FOREIGN KEY (`id_dziennik`) REFERENCES `dzienniki` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Zrzut struktury tabela eszkola.opiekunowie
CREATE TABLE IF NOT EXISTS `opiekunowie` (
  `id_uczen` int(10) unsigned NOT NULL,
  `id_rodzic` int(10) unsigned NOT NULL,
  UNIQUE KEY `unique_opiekun` (`id_uczen`,`id_rodzic`),
  KEY `FK_opiekunowie_uzytkownicy_2` (`id_rodzic`),
  CONSTRAINT `FK_opiekunowie_uzytkownicy` FOREIGN KEY (`id_uczen`) REFERENCES `uzytkownicy` (`id`),
  CONSTRAINT `FK_opiekunowie_uzytkownicy_2` FOREIGN KEY (`id_rodzic`) REFERENCES `uzytkownicy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Zrzut struktury tabela eszkola.plany_lekcji
CREATE TABLE IF NOT EXISTS `plany_lekcji` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_klasa` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_klasa` (`id_klasa`),
  CONSTRAINT `plany_lekcji_ibfk_1` FOREIGN KEY (`id_klasa`) REFERENCES `klasy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Zrzut struktury tabela eszkola.przedmioty_szkolne
CREATE TABLE IF NOT EXISTS `przedmioty_szkolne` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Zrzut struktury tabela eszkola.rok_szkolny
CREATE TABLE IF NOT EXISTS `rok_szkolny` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rok_od` date NOT NULL,
  `rok_do` date NOT NULL,
  `semestr1_od` date NOT NULL,
  `semestr1_do` date NOT NULL,
  `semestr2_od` date NOT NULL,
  `semestr2_do` date NOT NULL,
  `stan` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Zrzut struktury tabela eszkola.uwagi
CREATE TABLE IF NOT EXISTS `uwagi` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `opis` text COLLATE utf8_unicode_ci NOT NULL,
  `data` date NOT NULL,
  `id_uczen` int(10) unsigned NOT NULL,
  `id_nauczyciel` int(10) unsigned NOT NULL,
  `id_dziennik` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_uczen` (`id_uczen`),
  KEY `id_nauczyciel` (`id_nauczyciel`),
  KEY `id_dziennik` (`id_dziennik`),
  CONSTRAINT `uwagi_ibfk_1` FOREIGN KEY (`id_uczen`) REFERENCES `uzytkownicy` (`id`),
  CONSTRAINT `uwagi_ibfk_2` FOREIGN KEY (`id_nauczyciel`) REFERENCES `uzytkownicy` (`id`),
  CONSTRAINT `uwagi_ibfk_3` FOREIGN KEY (`id_dziennik`) REFERENCES `dzienniki` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Zrzut struktury tabela eszkola.uzytkownicy
CREATE TABLE IF NOT EXISTS `uzytkownicy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pesel` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `haslo` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `imie` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `nazwisko` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `data_ur` date DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `typ_konta` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `upr_admin` tinyint(1) DEFAULT NULL,
  `upr_dyrekcja` tinyint(1) DEFAULT NULL,
  `upr_planista` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
