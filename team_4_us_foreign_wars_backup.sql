-- MySQL Script generated by MySQL Workbench
-- Sat May  9 15:45:04 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema us_foreign_wars
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema us_foreign_wars
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `us_foreign_wars` DEFAULT CHARACTER SET utf8 ;
USE `us_foreign_wars` ;

-- -----------------------------------------------------
-- Table `us_foreign_wars`.`basic_war_information`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_foreign_wars`.`basic_war_information` ;

CREATE TABLE IF NOT EXISTS `us_foreign_wars`.`basic_war_information` (
  `war_id` INT(11) NOT NULL AUTO_INCREMENT,
  `war_name` VARCHAR(45) NOT NULL,
  `war_start_date` DATE NOT NULL,
  `war_end_date` DATE NULL DEFAULT NULL,
  `war_result` VARCHAR(45) NULL DEFAULT NULL,
  `wounded_number` INT NULL DEFAULT NULL,
  `fatality_number` INT NULL DEFAULT NULL,
  PRIMARY KEY (`war_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `us_foreign_wars`.`countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_foreign_wars`.`countries` ;

CREATE TABLE IF NOT EXISTS `us_foreign_wars`.`countries` (
  `country_id` INT(11) NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(45) NOT NULL,
  `country_capital` VARCHAR(45) NOT NULL,
  `country_standing` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `us_foreign_wars`.`military_branches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_foreign_wars`.`military_branches` ;

CREATE TABLE IF NOT EXISTS `us_foreign_wars`.`military_branches` (
  `military_branch_id` INT(11) NOT NULL AUTO_INCREMENT,
  `military_branch_name` VARCHAR(45) NULL DEFAULT NULL,
  `country_id` INT(11) NOT NULL,
  `military_branch_status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`military_branch_id`),
  INDEX `fk_Military Branches_Countries1_idx` (`country_id` ASC),
  CONSTRAINT `fk_Military Branches_Countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `us_foreign_wars`.`countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `us_foreign_wars`.`us_war_allies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_foreign_wars`.`us_war_allies` ;

CREATE TABLE IF NOT EXISTS `us_foreign_wars`.`us_war_allies` (
  `ally_id` INT(11) NOT NULL AUTO_INCREMENT,
  `war_id` INT(11) NOT NULL,
  `country_id` INT(11) NOT NULL,
  PRIMARY KEY (`ally_id`),
  INDEX `fk_Ally List_has_Basic War Information_Basic War Informatio_idx` (`war_id` ASC),
  INDEX `fk_War Ally List_Countries1_idx` (`country_id` ASC),
  CONSTRAINT `fk_Ally List_has_Basic War Information_Basic War Information1`
    FOREIGN KEY (`war_id`)
    REFERENCES `us_foreign_wars`.`basic_war_information` (`war_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_War Ally List_Countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `us_foreign_wars`.`countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `us_foreign_wars`.`us_war_enemies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_foreign_wars`.`us_war_enemies` ;

CREATE TABLE IF NOT EXISTS `us_foreign_wars`.`us_war_enemies` (
  `enemy_id` INT(11) NOT NULL AUTO_INCREMENT,
  `war_id` INT(11) NOT NULL,
  `country_id` INT(11) NOT NULL,
  PRIMARY KEY (`enemy_id`),
  INDEX `fk_Basic War Information_has_Enemies_Basic War Information1_idx` (`war_id` ASC),
  INDEX `fk_War Enemy List_Countries1_idx` (`country_id` ASC),
  CONSTRAINT `fk_Basic War Information_has_Enemies_Basic War Information1`
    FOREIGN KEY (`war_id`)
    REFERENCES `us_foreign_wars`.`basic_war_information` (`war_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_War Enemy List_Countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `us_foreign_wars`.`countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `us_foreign_wars`.`war_battles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_foreign_wars`.`war_battles` ;

CREATE TABLE IF NOT EXISTS `us_foreign_wars`.`war_battles` (
  `battle_id` INT(11) NOT NULL AUTO_INCREMENT,
  `battle_name` VARCHAR(45) NULL DEFAULT NULL,
  `battle_city_location` VARCHAR(45) NULL DEFAULT NULL,
  `battle_country_location` VARCHAR(45) NULL DEFAULT NULL,
  `war_id` INT(11) NOT NULL,
  `battle_result` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`battle_id`),
  INDEX `fk_War Battles_Basic War Information1_idx` (`war_id` ASC),
  CONSTRAINT `fk_War Battles_Basic War Information1`
    FOREIGN KEY (`war_id`)
    REFERENCES `us_foreign_wars`.`basic_war_information` (`war_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `us_foreign_wars`.`war_leaders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_foreign_wars`.`war_leaders` ;

CREATE TABLE IF NOT EXISTS `us_foreign_wars`.`war_leaders` (
  `war_leader_id` INT(11) NOT NULL AUTO_INCREMENT,
  `war_leader_first_name` VARCHAR(45) NOT NULL,
  `war_leader_last_name` VARCHAR(45) NULL DEFAULT NULL,
  `war_id` INT(11) NOT NULL,
  `country_id` INT(11) NOT NULL,
  `war_leader_military_rank` VARCHAR(45) NULL DEFAULT NULL,
  `war_leader_political_rank` VARCHAR(45) NULL,
  `war_leader_birth_date` DATE NULL DEFAULT NULL,
  `war_leader_death_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`war_leader_id`),
  INDEX `fk_War Leaders_Basic War Information1_idx` (`war_id` ASC),
  INDEX `fk_War Leaders_Countries1_idx` (`country_id` ASC),
  CONSTRAINT `fk_War Leaders_Basic War Information1`
    FOREIGN KEY (`war_id`)
    REFERENCES `us_foreign_wars`.`basic_war_information` (`war_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_War Leaders_Countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `us_foreign_wars`.`countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Insert Data into Tables
-- -----------------------------------------------------

-- basic_war_information -- 
USE us_foreign_wars;
INSERT INTO `basic_war_information` VALUES 
(NULL,'The Revolutionary War','1775-04-19','1783-09-03', 'Patriot (American) victory', 6188, 4435),
(NULL,'War of 1812','1812-06-18','1815-02-18', 'No victory on any combatant side', 2260 , 4505),
(NULL,'Mexican-American War','1846-04-25','1848-02-02', 'American victory', 4152 , 1733),
(NULL,'American Civil War','1861-04-12','1865-04-09', 'Union victory', 281881, 214938),
(NULL,'Spanish-American War','1898-04-21','1898-08-13', 'American victory', 1662, 385),
(NULL,'World War I','1914-07-28','1918-11-11', 'Allied victory', 204002, 53402),
(NULL,'Russian Civil War','1917-11-07','1922-10-25', 'Red Army victory', 3000000, 2500000),
(NULL,'World War II','1939-09-01','1945-09-02', 'Allied victory', 670846, 291557),
(NULL,'Korean War','1950-06-25','1953-07-27', 'Military stalemate', 103284, 33739),
(NULL,'Vietnam War','1955-11-01','1975-04-30', 'North Vietnamese victory', 153303, 47434),
(NULL,'Laotian Civil War','1959-05-23','1975-12-02', 'Pathet Lao and North Vietnamese victory', 42000, 20000),
(NULL,'Tanker War','1980-10-07','1988-08-08', 'Military stalemate', 875000, 305000),
(NULL,'Gulf War','1990-08-02','1991-02-28','Coalition victory', 140000 , 60000),
(NULL,'Iraq War','2003-03-20','2011-12-18', 'American victory', 32000, 4421),
(NULL,'War on Terror','2001-10-07', NULL, 'War ongoing', 20320, 2440);

-- war_battles -- 
USE us_foreign_wars;
INSERT INTO war_battles VALUES 
(null, "Battle of Somme", "Nord-Pas-de-Calais", "France", (SELECT war_id FROM basic_war_information WHERE war_id = 6), "French and British victory"),
(null, "Battle of Vimy Ridge", "Nord-Pas-de-Calais", "France", (SELECT war_id FROM basic_war_information WHERE war_id = 6), "Canadian victory"),
(null, "Battle of Passchendaele", "Ypres", "Belgium",(SELECT war_id FROM basic_war_information WHERE war_id = 6), "German victory"),
(null, "First Battle of Seoul", "Seoul", "South Korea", (SELECT war_id FROM basic_war_information WHERE war_id = 9), "North Korean victory"),
(null, "Battle of Heartbreak Ridge", "Yanggu County", "North Korea", (SELECT war_id FROM basic_war_information WHERE war_id = 9), "American victory"),
(null, "Battle of Saratoga", "Saratoga", "United States", (SELECT war_id FROM basic_war_information WHERE war_id = 1), "American victory"),
(null, "Battle of Yorktown", "Yorktown", "United States", (SELECT war_id FROM basic_war_information WHERE war_id = 1), "American victory"),
(null, "Battle of Camden", "Camden", "United States", (SELECT war_id FROM basic_war_information WHERE war_id = 1), "British victory"),
(null, "Operation Anaconda", "Gardez", "Afghanistan", (SELECT war_id FROM basic_war_information WHERE war_id = 15), "American victory"),
(null, "Battle of Mexico City", "Mexico City", "Mexico", (SELECT war_id FROM basic_war_information WHERE war_id = 3), "American victory"),
(null, "Battle of Luzon", "Luzon", "Philippines", (SELECT war_id FROM basic_war_information WHERE war_id = 8), "American victory"),
(null, "Battle of Berlin", "Berlin", "Germany", (SELECT war_id FROM basic_war_information WHERE war_id = 8), "Allied victory"),
(null, "Battle of Antietam", "Antietam", "United States", (SELECT war_id FROM basic_war_information WHERE war_id = 4), "Union victory"),
(null, "Battle of Iwo Jima", "Iwo Jima", "Japan", (SELECT war_id FROM basic_war_information WHERE war_id = 8), "American victory"),
(null, "Battle of Medina Ridge", "Basrah", "Iraq", (SELECT war_id FROM basic_war_information WHERE war_id = 13), "American victory");

-- countries --
USE us_foreign_wars;
INSERT INTO countries VALUES 
(NULL, "United States of America", "Washington, D.C.", "Established"),
(NULL, "United Kingdom", "London", "Established"),
(NULL, "China", "Beijing", "Established"),
(NULL, "Germany", "Berlin", "Established"),
(NULL, "France", "Paris", "Established"),
(NULL, "Italy", "Rome", "Established"),
(NULL, "Czechoslovakia", "Prague", "Dissolved"),
(NULL, "North Korea", "Pyongyang", "Established"),
(NULL, "South Korea", "Seoul", "Established"),
(NULL, "Iraq", "Baghdad", "Established"),
(NULL, "Afghanistan", "Kabul", "Established"),
(NULL, "Canada", "Ottawa", "Established"),
(NULL, "Spain", "Madrid", "Established"),
(NULL, "Laos", "Vientiane", "Established"),
(NULL, "Vietnam", "Hanoi", "Established"),
(NULL, "Egypt", "Cairo", "Established"),
(NULL, "Russia", "Moscow", "Established"),
(NULL, "Soviet Union", "Moscow", "Dissolved"),
(NULL, "Greece","Athens", "Established"),
(NULL, "Yugoslavia","Belgrade", "Dissolved"),
(NULL, "East Germany", "East Berlin", "Dissolved"),
(NULL, "West Germany", "West Berlin", "Dissolved"),
(NULL, "Hungary", "Budapest", "Established"),
(NULL, "Austria", "Vienna", "Established"),
(NULL, "Morocco","Rabat", "Established"),
(NULL, "Cuba", "Havana", "Established"),
(NULL, "Poland", "Warsaw", "Established"),
(NULL, "Belgium", "Brussels", "Established"),
(NULL, "Ireland", "Dublin", "Established"),
(NULL, "Ceylon", "Colombo", "Dissolved"),
(NULL, "Puerto Rico", "San Juan", "Established"),
(NULL, "Romania", "Bucharest", "Established"),
(NULL, "Thailand", "Bangkok", "Established"),
(NULL, "Guam", "Hagåtña", "Established"),
(NULL, "Bulgaria", "Sofia", "Established"),
(NULL, "Philippines", "Manila", "Established"),
(NULL, "Finland", "Helsinki" ,"Established"),
(NULL, "Iran", "Tehran", "Established"),
(NULL, "India", "New Delhi", "Established"),
(NULL, "South Africa" ,"Cape Town", "Established"),
(NULL, "Brazil", "Brasilia", "Established"),
(NULL, "Croatia", "Zagreb", "Established"),
(NULL, "Japan", "Tokyo", "Established"),
(NULL, "Ottoman Empire", "Constantinople", "Dissolved"),
(NULL, "Portugal", "Lisbon", "Established"),
(NULL, "Armenia", "Yerevan", "Established"),
(NULL, "Australia", "Canberra", "Established"),
(NULL, "New Zealand", "Wellington", "Established"),
(NULL, "Turkey", "Ankara", "Established"),
(NULL, "Luxembourg", "Luxembourg City", "Established"),
(NULL, "Ethiopia", "Addis Ababa", "Established"),
(NULL, "Mexico", "Mexico City", "Established"),
(NULL, "Saudi Arabia", "Riyadh", "Established"),
(NULL, "Kuwait", "Kuwait City", "Established"),
(NULL, "Albaina", "Tirana", "Established"),
(NULL, "Ukraine", "Kyiv", "Established"),
(NULL, "Eritrea", "Asmara", "Established"),
(NULL, "Uzbekistan", "Tashkent", "Established"),
(NULL, "Argentina", "Buenos Aires", "Established"),
(NULL, "Paraguay", "Asuncion", "Established"),
(NULL, "Confederate States", "Richmond", "Dissolved");

-- war_leaders -- 
USE us_foreign_wars;
INSERT INTO war_leaders VALUES 
(null, "Douglas", "MacArthur", (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 1), "General", NULL, '1880-01-26', '1964-04-05'),
(null, "Winston", "Churchill", (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 2), NULL, "Prime Minister",'1874-11-30', '1965-01-24'),
(null, "Adolf", "Hitler", (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 4), NULL, "Dictator",'1889-04-20', '1945-04-30'),
(null, "Barack", "Obama", (SELECT war_id FROM basic_war_information WHERE war_id = 15), (SELECT country_id FROM countries WHERE country_id = 1), NULL, "President",'1961-08-04', NULL),
(null, "Hamid", "Karzai", (SELECT war_id FROM basic_war_information WHERE war_id = 15), (SELECT country_id FROM countries WHERE country_id = 11), NULL, "President",'1957-12-24', NULL),
(null, "Robert", "MacNamara", (SELECT war_id FROM basic_war_information WHERE war_id = 10), (SELECT country_id FROM countries WHERE country_id = 1), NULL, "Secretary of Defense",'1916-06-09', '2009-07-06'),
(null, "George", "Dewey", (SELECT war_id FROM basic_war_information WHERE war_id = 5), (SELECT country_id FROM countries WHERE country_id = 1), "Admiral", NULL,'1937-12-26', '1917-01-16'),
(null, "Lyndon", "Johnson", (SELECT war_id FROM basic_war_information WHERE war_id = 10), (SELECT country_id FROM countries WHERE country_id = 1), NULL, "President",'1908-08-27', '1973-01-22'),
(null, "George", "Washington", (SELECT war_id FROM basic_war_information WHERE war_id = 1), (SELECT country_id FROM countries WHERE country_id = 1), "Commander in Chief", "President",'1732-02-22', '1799-12-14'),
(null, "Stonewall", "Jackson", (SELECT war_id FROM basic_war_information WHERE war_id = 4), (SELECT country_id FROM countries WHERE country_id = 1), "General", NULL,'1824-01-21', '1863-05-10'),
(null, "Harry", "Truman", (SELECT war_id FROM basic_war_information WHERE war_id = 9), (SELECT country_id FROM countries WHERE country_id = 1), NULL, "President",'1884-05-08', '1972-12-26'),
(null, "Sung", "Kim II", (SELECT war_id FROM basic_war_information WHERE war_id = 9), (SELECT country_id FROM countries WHERE country_id = 8), NULL, "Dictator",'1912-04-15', '1994-07-08'),
(null, "Richard", "Cheney", (SELECT war_id FROM basic_war_information WHERE war_id = 13), (SELECT country_id FROM countries WHERE country_id = 1), NULL, "Secretary of Defense",'1941-01-30', NULL),
(null, "Zachary", "Taylor", (SELECT war_id FROM basic_war_information WHERE war_id = 3), (SELECT country_id FROM countries WHERE country_id = 1), "General", "President",'1784-11-24', '1850-07-09'),
(null, "David", "Twiggs", (SELECT war_id FROM basic_war_information WHERE war_id = 3), (SELECT country_id FROM countries WHERE country_id = 1), "General", NULL,'1790-02-14', '1862-07-15'),
(NULL, "Hosni",  "Mubarak", (SELECT war_id FROM basic_war_information WHERE war_id = 13), (SELECT country_id FROM countries WHERE country_id = 16), NULL, "President", '1928-05-04', '2020-02-25'),
(NULL, "Wade", "Hampton II", (SELECT war_id FROM basic_war_information WHERE war_id = 2), (SELECT country_id FROM countries WHERE country_id = 1), "Major General", NULL, '1791-04-21', '1858-02-10'),
(NULL, "James", "Baker", (SELECT war_id FROM basic_war_information WHERE war_id = 13), (SELECT country_id FROM countries WHERE country_id = 1), NULL, "Secretary of State", '1930-04-28', NULL),
(NULL, "Alexander", "Kolchak", (SELECT war_id FROM basic_war_information WHERE war_id = 7), (SELECT country_id FROM countries WHERE country_id = 18), NULL, "Supreme Ruler", '1874-11-16', '1920-02-07'),
(NULL, "George", "Stewart", (SELECT war_id FROM basic_war_information WHERE war_id = 7), (SELECT country_id FROM countries WHERE country_id = 1), "Officer", NULL, '1872-08-02', '1946-03-02'),
(NULL, "Tommy", "Franks", (SELECT war_id FROM basic_war_information WHERE war_id = 14), (SELECT country_id FROM countries WHERE country_id = 1), "General", NULL, '1945-06-17', NULL),
(NULL, "Grigory", "Kulik", (SELECT war_id FROM basic_war_information WHERE war_id = 7), (SELECT country_id FROM countries WHERE country_id = 18), "Commander",  NULL, '1890-11-09', '1950-08-24'),
(NULL, "Phineas", "Riall", (SELECT war_id FROM basic_war_information WHERE war_id = 2), (SELECT country_id FROM countries WHERE country_id = 2), "Officer", NULL, '1775-12-15', '1850-11-10'),
(NULL, "Madison", "James", (SELECT war_id FROM basic_war_information WHERE war_id = 2), (SELECT country_id FROM countries WHERE country_id = 1), NULL, "President", "1751-03-16", "1801-06-04"),
(NULL, "Ra\'ad", "al-Hamdani", (SELECT war_id FROM basic_war_information WHERE war_id = 14), (SELECT country_id FROM countries WHERE country_id = 10), "General", NULL, '1951-11-08', NULL),
(NULL, "Lloyd", "Austin III", (SELECT war_id FROM basic_war_information WHERE war_id = 14), (SELECT country_id FROM countries WHERE country_id = 1), "General", NULL, '1953-08-03', NULL),
(NULL, "Mohammad", "Omar", (SELECT war_id FROM basic_war_information WHERE war_id = 15), (SELECT country_id FROM countries WHERE country_id = 11), "Commander", NULL, '1960-01-01', '2013-04-23'),
(NULL, "John", "McColl", (SELECT war_id FROM basic_war_information WHERE war_id = 15), (SELECT country_id FROM countries WHERE country_id = 2), "Lieutenant", NULL, '1952-04-17', NULL),
(NULL, "Ngo Dinh", "Diem", (SELECT war_id FROM basic_war_information WHERE war_id = 10), (SELECT country_id FROM countries WHERE country_id = 15), NULL, "Prime Minister", '1901-01-03', '1963-11-02'),
(NULL, "Vang", "Pao", (SELECT war_id FROM basic_war_information WHERE war_id = 11), (SELECT country_id FROM countries WHERE country_id = 14), "Major General", NULL, '1929-12-08', '2011-01-06');

-- military_branches -- 
INSERT INTO `military_branches` VALUES 
(NULL,'US Army', (SELECT country_id FROM countries WHERE country_id = 1),'Active'), 
(NULL,'US Air Force', (SELECT country_id FROM countries WHERE country_id = 1), 'Active'),
(NULL,'US Navy Seals', (SELECT country_id FROM countries WHERE country_id = 1), 'Active'),
(NULL,'Heer', (SELECT country_id FROM countries WHERE country_id = 4), 'Dissolved'),
(NULL,'Kriegsmarine', (SELECT country_id FROM countries WHERE country_id = 4), 'Active'),
(NULL,'Luftwaffe', (SELECT country_id FROM countries WHERE country_id = 4), 'Active'),
(NULL,'Soviet Ground Forces', (SELECT country_id FROM countries WHERE country_id = 18), 'Dissolved'),
(NULL,'Soviet Navy', (SELECT country_id FROM countries WHERE country_id = 18), 'Dissolved'), 
(NULL,'Soviet Air Force', (SELECT country_id FROM countries WHERE country_id = 18), 'Dissolved'),
(NULL,'The British Army', (SELECT country_id FROM countries WHERE country_id = 2), 'Active'),
(NULL,'The Royal Navy', (SELECT country_id FROM countries WHERE country_id = 2), 'Active'),
(NULL,'The Royal Air Force', (SELECT country_id FROM countries WHERE country_id = 2), 'Active'),
(NULL,'Vietnam People\'s Ground Forces', (SELECT country_id FROM countries WHERE country_id = 15), 'Active'),
(NULL,'Vietnam People\'s Navy', (SELECT country_id FROM countries WHERE country_id = 15), 'Active'),
(NULL,'Vietnam People\'s Air Force', (SELECT country_id FROM countries WHERE country_id = 15), 'Active'), 
(NULL,'Italian Army', (SELECT country_id FROM countries WHERE country_id = 6), 'Active'),
(NULL,'Italian Navy', (SELECT country_id FROM countries WHERE country_id = 6), 'Active'),
(NULL,'Italian Air Force', (SELECT country_id FROM countries WHERE country_id = 6), 'Active');

-- us_war_allies -- 
USE us_foreign_wars;
INSERT INTO `us_war_allies` VALUES 
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 1), (SELECT country_id FROM countries WHERE country_id = 5)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 6), (SELECT country_id FROM countries WHERE country_id = 12)), 
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 7), (SELECT country_id FROM countries WHERE country_id = 17)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 6), (SELECT country_id FROM countries WHERE country_id = 43)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 6), (SELECT country_id FROM countries WHERE country_id = 6)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 2)), 
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 15), (SELECT country_id FROM countries WHERE country_id = 3)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 14), (SELECT country_id FROM countries WHERE country_id = 10)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 25)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 9), (SELECT country_id FROM countries WHERE country_id = 9)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 10), (SELECT country_id FROM countries WHERE country_id = 47)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 10), (SELECT country_id FROM countries WHERE country_id = 33)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 10), (SELECT country_id FROM countries WHERE country_id = 36)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 10), (SELECT country_id FROM countries WHERE country_id = 14)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 10), (SELECT country_id FROM countries WHERE country_id = 48)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 50)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 27)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 20)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 19)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 28)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 39)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 13), (SELECT country_id FROM countries WHERE country_id = 53)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 13), (SELECT country_id FROM countries WHERE country_id = 54)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 13), (SELECT country_id FROM countries WHERE country_id = 16)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 15), (SELECT country_id FROM countries WHERE country_id = 45)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 15), (SELECT country_id FROM countries WHERE country_id = 35)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 22)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 9), (SELECT country_id FROM countries WHERE country_id = 49)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 13), (SELECT country_id FROM countries WHERE country_id = 59)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 60));

-- us_war_enemies--
USE us_foreign_wars;
INSERT INTO `us_war_enemies` VALUES 
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 1), (SELECT country_id FROM countries WHERE country_id = 2)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 3), (SELECT country_id FROM countries WHERE country_id = 52)), 
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 7), (SELECT country_id FROM countries WHERE country_id = 18)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 43)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 10), (SELECT country_id FROM countries WHERE country_id = 3)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 7)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 9), (SELECT country_id FROM countries WHERE country_id = 8)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 12), (SELECT country_id FROM countries WHERE country_id = 10)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 5), (SELECT country_id FROM countries WHERE country_id = 13)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 11), (SELECT country_id FROM countries WHERE country_id = 15)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 21)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 23)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 35)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 33)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 37)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 32)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 42)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 6)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 7), (SELECT country_id FROM countries WHERE country_id = 44)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 46)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 2), (SELECT country_id FROM countries WHERE country_id = 5)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 6), (SELECT country_id FROM countries WHERE country_id = 24)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 12), (SELECT country_id FROM countries WHERE country_id = 38)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 15), (SELECT country_id FROM countries WHERE country_id = 57)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 8), (SELECT country_id FROM countries WHERE country_id = 55)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 5), (SELECT country_id FROM countries WHERE country_id = 34)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 5), (SELECT country_id FROM countries WHERE country_id = 31)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 4), (SELECT country_id FROM countries WHERE country_id = 61)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 2), (SELECT country_id FROM countries WHERE country_id = 12)),
(NULL, (SELECT war_id FROM basic_war_information WHERE war_id = 6), (SELECT country_id FROM countries WHERE country_id = 4));

-- -----------------------------------------------------
-- Create Views for Queries
-- -----------------------------------------------------

-- Selects military war leaders from their respective countries --
USE us_foreign_wars;
CREATE OR REPLACE VIEW viewMilitaryWarLeaders AS
SELECT 
    CONCAT(war_leader_first_name, " ", war_leader_last_name) AS 'Leader Name', 
    war_leader_military_rank AS 'Military Rank',
    country_name AS 'Country',
    war_name AS 'War Fought'
FROM basic_war_information
JOIN war_leaders USING(war_id)
JOIN countries USING(country_id)
WHERE war_leader_military_rank IN
	(SELECT war_leader_military_rank
    FROM war_leaders
    WHERE war_leader_military_rank IS NOT NULL)
GROUP BY war_name
ORDER BY war_id;

-- Selects military branches that are currently active -- 
USE us_foreign_wars;
CREATE OR REPLACE VIEW viewActiveMilitaryBranches AS
SELECT DISTINCT(country_name) AS 'Country',
 military_branch_status AS 'Military Branch Status',
 military_branch_name AS 'Military Branch Name'
FROM countries JOIN military_branches
USING (country_id)
WHERE military_branch_status = "Active"
ORDER BY country_name;

-- Selects average number of wounded and dead from wars after the Spanish-American war --
USE us_foreign_wars;
CREATE OR REPLACE VIEW viewAverageNumbers AS
SELECT 
ROUND(AVG(wounded_number)) AS 'Average Number of Wounded',
ROUND(AVG(fatality_number)) AS 'Average Number of Fatalities'
FROM basic_war_information 
WHERE war_id > 5;

-- Selects the countries, capitals, and current country status of US enemies during WW2  --
USE us_foreign_wars;
CREATE OR REPLACE VIEW viewCountryStandingsWWII AS
SELECT country_name, country_capital, war_name, country_standing
FROM basic_war_information JOIN
us_war_enemies USING(war_id)
JOIN countries USING(country_id)
WHERE war_id = 8;

-- Selects the leaders of Dissolved Countries -- 
USE us_foreign_wars;
CREATE OR REPLACE VIEW viewLeadersDissolved AS
SELECT country_name AS 'Country', 
CONCAT(war_leader_first_name,' ', war_leader_last_name) AS 'War Leader'
FROM countries JOIN war_leaders USING(country_id)
WHERE country_standing = 'Dissolved';

-- Select wars, their result, and the # of deaths with wars over 50000 --
USE us_foreign_wars;
CREATE OR REPLACE VIEW viewDeadly_wars AS
SELECT war_name, war_result, fatality_number
FROM basic_war_information
WHERE fatality_number > 50000;

-- Calculates Days at war for each war in the database in descending order -- 
USE us_foreign_wars;
CREATE OR REPLACE VIEW viewDaysAtWar AS
SELECT war_name AS WarName,
DATEDIFF(war_end_date, war_start_date) AS DaysAtWar
FROM basic_war_information
GROUP BY DaysAtWar DESC;
