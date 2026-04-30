/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: ArgusCiudadano
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `AC_Auditoria`
--

DROP TABLE IF EXISTS `AC_Auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_Auditoria` (
  `audit_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tabla` varchar(64) NOT NULL,
  `accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `registro_id` int(10) unsigned NOT NULL,
  `usuario_db` varchar(255) NOT NULL DEFAULT current_user(),
  `usuario_app` varchar(255) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `datos_antes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`datos_antes`)),
  `datos_despues` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`datos_despues`)),
  PRIMARY KEY (`audit_id`),
  KEY `idx_auditoria_tabla_fecha` (`tabla`,`fecha`),
  KEY `idx_auditoria_usuario_app` (`usuario_app`),
  KEY `idx_auditoria_usuario_db` (`usuario_db`),
  KEY `idx_auditoria_registro` (`tabla`,`registro_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AC_Domicilios`
--

DROP TABLE IF EXISTS `AC_Domicilios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_Domicilios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `calle` varchar(255) DEFAULT NULL,
  `interseccion_1` varchar(255) DEFAULT NULL,
  `interseccion_2` varchar(255) DEFAULT NULL,
  `numero` varchar(6) DEFAULT NULL,
  `medio` tinyint(4) DEFAULT 0,
  `kilometro` decimal(4,1) DEFAULT 0.0,
  `manzana` varchar(255) DEFAULT NULL,
  `monoblock` varchar(255) DEFAULT NULL,
  `escalera` varchar(30) DEFAULT NULL,
  `piso` varchar(2) DEFAULT NULL,
  `dpto` varchar(4) DEFAULT NULL,
  `local` varchar(6) DEFAULT NULL,
  `lote` varchar(100) DEFAULT NULL,
  `localidad` int(11) DEFAULT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hash` binary(32) GENERATED ALWAYS AS (unhex(sha2(concat_ws('|',coalesce(`calle`,''),coalesce(`interseccion_1`,''),coalesce(`interseccion_2`,''),coalesce(`numero`,''),coalesce(`medio`,''),coalesce(`kilometro`,''),coalesce(`manzana`,''),coalesce(`monoblock`,''),coalesce(`escalera`,''),coalesce(`piso`,''),coalesce(`dpto`,''),coalesce(`local`,''),coalesce(`localidad`,'')),256))) STORED,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uk_hash` (`hash`),
  KEY `AC_Domicilios_AC_aux_Localidades_FK` (`localidad`),
  CONSTRAINT `AC_Domicilios_AC_aux_Localidades_FK` FOREIGN KEY (`localidad`) REFERENCES `AC_aux_Localidades` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Domicilios_insert` AFTER INSERT ON `AC_Domicilios` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_despues`) VALUES ('AC_Domicilios', 'INSERT', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', NEW.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Domicilios_update` AFTER UPDATE ON `AC_Domicilios` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`,`datos_despues`) VALUES ('AC_Domicilios', 'UPDATE', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('modificado', OLD.modificado), JSON_OBJECT('modificado', NEW.modificado)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Domicilios_delete` AFTER DELETE ON `AC_Domicilios` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`) VALUES ('AC_Domicilios', 'DELETE', OLD.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', OLD.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `AC_Emails`
--

DROP TABLE IF EXISTS `AC_Emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_Emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `direccion` varchar(255) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `direccion` (`direccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Emails_insert` AFTER INSERT ON `AC_Emails` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_despues`) VALUES ('AC_Emails', 'INSERT', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', NEW.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Emails_update` AFTER UPDATE ON `AC_Emails` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`,`datos_despues`) VALUES ('AC_Emails', 'UPDATE', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('modificado', OLD.modificado), JSON_OBJECT('modificado', NEW.modificado)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Emails_delete` AFTER DELETE ON `AC_Emails` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`) VALUES ('AC_Emails', 'DELETE', OLD.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', OLD.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `AC_Personas`
--

DROP TABLE IF EXISTS `AC_Personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_Personas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cuit` bigint(20) unsigned DEFAULT NULL COMMENT 'CUIL/CUIT numerico sin guiones.',
  `persona_tipo` int(11) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `cuit` (`cuit`),
  KEY `AC_Personas_AC_aux_Persona_tipo_FK` (`persona_tipo`),
  CONSTRAINT `AC_Personas_AC_aux_Persona_tipo_FK` FOREIGN KEY (`persona_tipo`) REFERENCES `AC_aux_Persona_tipo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Personas_insert` AFTER INSERT ON `AC_Personas` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_despues`) VALUES ('AC_Personas', 'INSERT', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', NEW.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Personas_update` AFTER UPDATE ON `AC_Personas` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`,`datos_despues`) VALUES ('AC_Personas', 'UPDATE', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('modificado', OLD.modificado), JSON_OBJECT('modificado', NEW.modificado)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Personas_delete` AFTER DELETE ON `AC_Personas` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`) VALUES ('AC_Personas', 'DELETE', OLD.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', OLD.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `AC_Personas_fisicas`
--

DROP TABLE IF EXISTS `AC_Personas_fisicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_Personas_fisicas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `persona` int(11) NOT NULL,
  `cuil` bigint(20) unsigned NOT NULL,
  `doc_numero` bigint(20) unsigned NOT NULL,
  `doc_tipo` int(11) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `sexo_tipo` int(11) DEFAULT NULL,
  `nacimiento` date DEFAULT NULL,
  `nacionalidad` int(11) DEFAULT NULL,
  `estado_civil` int(11) DEFAULT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `cuil` (`cuil`),
  UNIQUE KEY `AC_Personas_fisicas_cuil_IDX` (`cuil`) USING BTREE,
  KEY `AC_Personas_fisicas_doc_numero_IDX` (`doc_numero`) USING BTREE,
  KEY `AC_Personas_fisicas_AC_Personas_FK` (`persona`),
  KEY `AC_Personas_fisicas_AC_aux_Doc_tipo_FK` (`doc_tipo`),
  KEY `AC_Personas_fisicas_AC_aux_Estado_civil_FK` (`estado_civil`),
  KEY `AC_Personas_fisicas_AC_aux_Sexo_tipo_FK` (`sexo_tipo`),
  KEY `AC_Personas_fisicas_AC_aux_Paises_FK` (`nacionalidad`),
  CONSTRAINT `AC_Personas_fisicas_AC_Personas_FK` FOREIGN KEY (`persona`) REFERENCES `AC_Personas` (`id`),
  CONSTRAINT `AC_Personas_fisicas_AC_aux_Doc_tipo_FK` FOREIGN KEY (`doc_tipo`) REFERENCES `AC_aux_Doc_tipo` (`id`),
  CONSTRAINT `AC_Personas_fisicas_AC_aux_Estado_civil_FK` FOREIGN KEY (`estado_civil`) REFERENCES `AC_aux_Estado_civil` (`id`),
  CONSTRAINT `AC_Personas_fisicas_AC_aux_Paises_FK` FOREIGN KEY (`nacionalidad`) REFERENCES `AC_aux_Paises` (`id`),
  CONSTRAINT `AC_Personas_fisicas_AC_aux_Sexo_tipo_FK` FOREIGN KEY (`sexo_tipo`) REFERENCES `AC_aux_Sexo_tipo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Personas_fisicas_insert` AFTER INSERT ON `AC_Personas_fisicas` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_despues`) VALUES ('AC_Personas_fisicas', 'INSERT', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', NEW.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Personas_fisicas_update` AFTER UPDATE ON `AC_Personas_fisicas` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`,`datos_despues`) VALUES ('AC_Personas_fisicas', 'UPDATE', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('modificado', OLD.modificado), JSON_OBJECT('modificado', NEW.modificado)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Personas_fisicas_delete` AFTER DELETE ON `AC_Personas_fisicas` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`) VALUES ('AC_Personas_fisicas', 'DELETE', OLD.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', OLD.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `AC_Personas_juridicas`
--

DROP TABLE IF EXISTS `AC_Personas_juridicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_Personas_juridicas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `persona` int(11) NOT NULL,
  `razon_social` varchar(255) NOT NULL,
  `nombre_fantasia` varchar(255) DEFAULT NULL,
  `fecha_constitucion` date DEFAULT NULL,
  `sociedad_tipo` int(11) DEFAULT NULL,
  `representante_legar` int(11) DEFAULT NULL,
  `actividad_principal` int(11) DEFAULT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `persona` (`persona`),
  KEY `sociedad_tipo` (`sociedad_tipo`),
  KEY `representante_legar` (`representante_legar`),
  KEY `actividad_principal` (`actividad_principal`),
  CONSTRAINT `AC_Personas_juridicas_ibfk_1` FOREIGN KEY (`persona`) REFERENCES `AC_Personas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `AC_Personas_juridicas_ibfk_2` FOREIGN KEY (`sociedad_tipo`) REFERENCES `AC_aux_Sociedad_tipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `AC_Personas_juridicas_ibfk_3` FOREIGN KEY (`representante_legar`) REFERENCES `AC_Personas_fisicas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `AC_Personas_juridicas_ibfk_4` FOREIGN KEY (`actividad_principal`) REFERENCES `AC_aux_Actividades_comerciales` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Personas_juridicas_insert` AFTER INSERT ON `AC_Personas_juridicas` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_despues`) VALUES ('AC_Personas_juridicas', 'INSERT', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', NEW.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Personas_juridicas_update` AFTER UPDATE ON `AC_Personas_juridicas` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`,`datos_despues`) VALUES ('AC_Personas_juridicas', 'UPDATE', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('modificado', OLD.modificado), JSON_OBJECT('modificado', NEW.modificado)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Personas_juridicas_delete` AFTER DELETE ON `AC_Personas_juridicas` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`) VALUES ('AC_Personas_juridicas', 'DELETE', OLD.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', OLD.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `AC_Sistemas`
--

DROP TABLE IF EXISTS `AC_Sistemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_Sistemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `habilitado` tinyint(1) DEFAULT 0,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Sistemas_insert` AFTER INSERT ON `AC_Sistemas` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_despues`) VALUES ('AC_Sistemas', 'INSERT', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', NEW.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Sistemas_update` AFTER UPDATE ON `AC_Sistemas` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`,`datos_despues`) VALUES ('AC_Sistemas', 'UPDATE', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('modificado', OLD.modificado), JSON_OBJECT('modificado', NEW.modificado)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Sistemas_delete` AFTER DELETE ON `AC_Sistemas` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`) VALUES ('AC_Sistemas', 'DELETE', OLD.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', OLD.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `AC_Telefonos`
--

DROP TABLE IF EXISTS `AC_Telefonos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_Telefonos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cod_pais` int(11) NOT NULL DEFAULT 54,
  `cod_area` int(11) NOT NULL,
  `numero` bigint(20) NOT NULL,
  `tel_tipo` int(11) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hash` binary(32) GENERATED ALWAYS AS (unhex(sha2(concat_ws('|',`cod_pais`,`cod_area`,`numero`),256))) STORED,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uk_hash` (`hash`),
  KEY `tel_tipo` (`tel_tipo`),
  CONSTRAINT `AC_Telefonos_ibfk_1` FOREIGN KEY (`tel_tipo`) REFERENCES `AC_aux_Tel_tipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Telefonos_insert` AFTER INSERT ON `AC_Telefonos` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_despues`) VALUES ('AC_Telefonos', 'INSERT', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', NEW.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Telefonos_update` AFTER UPDATE ON `AC_Telefonos` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`,`datos_despues`) VALUES ('AC_Telefonos', 'UPDATE', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('modificado', OLD.modificado), JSON_OBJECT('modificado', NEW.modificado)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_Telefonos_delete` AFTER DELETE ON `AC_Telefonos` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`) VALUES ('AC_Telefonos', 'DELETE', OLD.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', OLD.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `AC_aux_Actividades_comerciales`
--

DROP TABLE IF EXISTS `AC_aux_Actividades_comerciales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_aux_Actividades_comerciales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AC_aux_Doc_tipo`
--

DROP TABLE IF EXISTS `AC_aux_Doc_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_aux_Doc_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AC_aux_Domicilio_tipo`
--

DROP TABLE IF EXISTS `AC_aux_Domicilio_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_aux_Domicilio_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AC_aux_Estado_civil`
--

DROP TABLE IF EXISTS `AC_aux_Estado_civil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_aux_Estado_civil` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AC_aux_Localidades`
--

DROP TABLE IF EXISTS `AC_aux_Localidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_aux_Localidades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `codigo_postal` varchar(8) DEFAULT NULL,
  `partido` int(11) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hash` binary(32) GENERATED ALWAYS AS (unhex(sha2(concat_ws('|',`nombre`,coalesce(`codigo_postal`,''),`partido`),256))) STORED,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uk_hash` (`hash`),
  KEY `partido` (`partido`),
  CONSTRAINT `AC_aux_Localidades_ibfk_1` FOREIGN KEY (`partido`) REFERENCES `AC_aux_Partidos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2930 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AC_aux_Paises`
--

DROP TABLE IF EXISTS `AC_aux_Paises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_aux_Paises` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `iso2` varchar(2) DEFAULT NULL,
  `iso3` varchar(3) DEFAULT NULL,
  `codigo_tel` varchar(5) DEFAULT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AC_aux_Partidos`
--

DROP TABLE IF EXISTS `AC_aux_Partidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_aux_Partidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `codigo_postal` varchar(8) DEFAULT NULL,
  `provincia` int(11) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hash` binary(32) GENERATED ALWAYS AS (unhex(sha2(concat_ws('|',`nombre`,coalesce(`codigo_postal`,''),`provincia`),256))) STORED,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uk_hash` (`hash`),
  KEY `provincia` (`provincia`),
  CONSTRAINT `AC_aux_Partidos_ibfk_1` FOREIGN KEY (`provincia`) REFERENCES `AC_aux_Provincias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AC_aux_Persona_tipo`
--

DROP TABLE IF EXISTS `AC_aux_Persona_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_aux_Persona_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AC_aux_Provincias`
--

DROP TABLE IF EXISTS `AC_aux_Provincias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_aux_Provincias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `pais` int(11) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `pais` (`pais`),
  CONSTRAINT `AC_aux_Provincias_ibfk_1` FOREIGN KEY (`pais`) REFERENCES `AC_aux_Paises` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AC_aux_Sexo_tipo`
--

DROP TABLE IF EXISTS `AC_aux_Sexo_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_aux_Sexo_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AC_aux_Sociedad_tipo`
--

DROP TABLE IF EXISTS `AC_aux_Sociedad_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_aux_Sociedad_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `siglas` varchar(100) DEFAULT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AC_aux_Tel_tipo`
--

DROP TABLE IF EXISTS `AC_aux_Tel_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_aux_Tel_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AC_rel_Persona_domicilio`
--

DROP TABLE IF EXISTS `AC_rel_Persona_domicilio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_rel_Persona_domicilio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `persona` int(11) NOT NULL,
  `domicilio` int(11) NOT NULL,
  `domicilio_tipo` int(11) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `persona` (`persona`),
  KEY `domicilio` (`domicilio`),
  KEY `domicilio_tipo` (`domicilio_tipo`),
  CONSTRAINT `AC_rel_Persona_domicilio_ibfk_1` FOREIGN KEY (`persona`) REFERENCES `AC_Personas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `AC_rel_Persona_domicilio_ibfk_2` FOREIGN KEY (`domicilio`) REFERENCES `AC_Domicilios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `AC_rel_Persona_domicilio_ibfk_3` FOREIGN KEY (`domicilio_tipo`) REFERENCES `AC_aux_Domicilio_tipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_rel_Persona_domicilio_insert` AFTER INSERT ON `AC_rel_Persona_domicilio` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_despues`) VALUES ('AC_rel_Persona_domicilio', 'INSERT', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', NEW.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_rel_Persona_domicilio_update` AFTER UPDATE ON `AC_rel_Persona_domicilio` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`,`datos_despues`) VALUES ('AC_rel_Persona_domicilio', 'UPDATE', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('modificado', OLD.modificado), JSON_OBJECT('modificado', NEW.modificado)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_rel_Persona_domicilio_delete` AFTER DELETE ON `AC_rel_Persona_domicilio` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`) VALUES ('AC_rel_Persona_domicilio', 'DELETE', OLD.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', OLD.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `AC_rel_Persona_email`
--

DROP TABLE IF EXISTS `AC_rel_Persona_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_rel_Persona_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `persona` int(11) NOT NULL,
  `email` int(11) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `persona` (`persona`),
  KEY `email` (`email`),
  CONSTRAINT `AC_rel_Persona_email_ibfk_1` FOREIGN KEY (`persona`) REFERENCES `AC_Personas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `AC_rel_Persona_email_ibfk_2` FOREIGN KEY (`email`) REFERENCES `AC_Emails` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_rel_Persona_email_insert` AFTER INSERT ON `AC_rel_Persona_email` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_despues`) VALUES ('AC_rel_Persona_email', 'INSERT', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', NEW.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_rel_Persona_email_update` AFTER UPDATE ON `AC_rel_Persona_email` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`,`datos_despues`) VALUES ('AC_rel_Persona_email', 'UPDATE', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('modificado', OLD.modificado), JSON_OBJECT('modificado', NEW.modificado)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_rel_Persona_email_delete` AFTER DELETE ON `AC_rel_Persona_email` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`) VALUES ('AC_rel_Persona_email', 'DELETE', OLD.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', OLD.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `AC_rel_Persona_sistema`
--

DROP TABLE IF EXISTS `AC_rel_Persona_sistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_rel_Persona_sistema` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `persona` int(11) NOT NULL,
  `sistema` int(11) NOT NULL,
  `identificador` varchar(255) DEFAULT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `persona` (`persona`),
  KEY `sistema` (`sistema`),
  CONSTRAINT `AC_rel_Persona_sistema_ibfk_1` FOREIGN KEY (`persona`) REFERENCES `AC_Personas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `AC_rel_Persona_sistema_ibfk_2` FOREIGN KEY (`sistema`) REFERENCES `AC_Sistemas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_rel_Persona_sistema_insert` AFTER INSERT ON `AC_rel_Persona_sistema` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_despues`) VALUES ('AC_rel_Persona_sistema', 'INSERT', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', NEW.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_rel_Persona_sistema_update` AFTER UPDATE ON `AC_rel_Persona_sistema` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`,`datos_despues`) VALUES ('AC_rel_Persona_sistema', 'UPDATE', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('modificado', OLD.modificado), JSON_OBJECT('modificado', NEW.modificado)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_rel_Persona_sistema_delete` AFTER DELETE ON `AC_rel_Persona_sistema` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`) VALUES ('AC_rel_Persona_sistema', 'DELETE', OLD.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', OLD.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `AC_rel_Persona_telefono`
--

DROP TABLE IF EXISTS `AC_rel_Persona_telefono`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AC_rel_Persona_telefono` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `persona` int(11) NOT NULL,
  `telefono` int(11) NOT NULL,
  `creado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `persona` (`persona`),
  KEY `telefono` (`telefono`),
  CONSTRAINT `AC_rel_Persona_telefono_ibfk_1` FOREIGN KEY (`persona`) REFERENCES `AC_Personas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `AC_rel_Persona_telefono_ibfk_2` FOREIGN KEY (`telefono`) REFERENCES `AC_Telefonos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_rel_Persona_telefono_insert` AFTER INSERT ON `AC_rel_Persona_telefono` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_despues`) VALUES ('AC_rel_Persona_telefono', 'INSERT', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', NEW.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_rel_Persona_telefono_update` AFTER UPDATE ON `AC_rel_Persona_telefono` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`,`datos_despues`) VALUES ('AC_rel_Persona_telefono', 'UPDATE', NEW.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('modificado', OLD.modificado), JSON_OBJECT('modificado', NEW.modificado)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`taxpayer`@`%`*/ /*!50003 TRIGGER `trg_AC_rel_Persona_telefono_delete` AFTER DELETE ON `AC_rel_Persona_telefono` FOR EACH ROW BEGIN INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`) VALUES ('AC_rel_Persona_telefono', 'DELETE', OLD.id, CURRENT_USER(), COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT('id', OLD.id)); END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'ArgusCiudadano'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_crear_triggers_auditoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`taxpayer`@`%` PROCEDURE `sp_crear_triggers_auditoria`(
    IN p_tablas TEXT
)
BEGIN
    DECLARE v_tabla VARCHAR(64);
    DECLARE v_pos INT DEFAULT 1;
    DECLARE v_list TEXT;
    DECLARE v_done INT DEFAULT 0;           -- Declarado antes del cursor

    -- Crear tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmp_tablas_audit;
    CREATE TEMPORARY TABLE tmp_tablas_audit (`tabla` VARCHAR(64) PRIMARY KEY);

    -- Procesar lista de tablas
    SET v_list = CONCAT(TRIM(p_tablas), ',');

    WHILE v_pos > 0 DO
        SET v_tabla = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(v_list, ',', v_pos), ',', -1));
        
        IF v_tabla <> '' THEN
            INSERT IGNORE INTO tmp_tablas_audit (`tabla`) VALUES (v_tabla);
        END IF;
        
        SET v_pos = v_pos + 1;
        
        IF SUBSTRING_INDEX(v_list, ',', v_pos) = v_list THEN
            SET v_pos = 0;
        END IF;
    END WHILE;

    -- === CURSOR Y HANDLER (orden correcto) ===
    BEGIN
        DECLARE cur CURSOR FOR 
            SELECT `tabla` FROM tmp_tablas_audit;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

        OPEN cur;

        loop_tablas: LOOP
            FETCH cur INTO v_tabla;
            IF v_done THEN
                LEAVE loop_tablas;
            END IF;

            -- DROP triggers anteriores
            SET @sql = CONCAT('DROP TRIGGER IF EXISTS `trg_', v_tabla, '_insert`');
            PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

            SET @sql = CONCAT('DROP TRIGGER IF EXISTS `trg_', v_tabla, '_update`');
            PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

            SET @sql = CONCAT('DROP TRIGGER IF EXISTS `trg_', v_tabla, '_delete`');
            PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

            -- TRIGGER INSERT
            SET @sql = CONCAT(
                'CREATE TRIGGER `trg_', v_tabla, '_insert` AFTER INSERT ON `', v_tabla, '` FOR EACH ROW ',
                'BEGIN ',
                    'INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_despues`) ',
                    'VALUES (''', v_tabla, ''', ''INSERT'', NEW.id, CURRENT_USER(), ',
                    'COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT(''id'', NEW.id)); ',
                'END;'
            );
            PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

            -- TRIGGER UPDATE
            SET @sql = CONCAT(
                'CREATE TRIGGER `trg_', v_tabla, '_update` AFTER UPDATE ON `', v_tabla, '` FOR EACH ROW ',
                'BEGIN ',
                    'INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`,`datos_despues`) ',
                    'VALUES (''', v_tabla, ''', ''UPDATE'', NEW.id, CURRENT_USER(), ',
                    'COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), ',
                    'JSON_OBJECT(''modificado'', OLD.modificado), JSON_OBJECT(''modificado'', NEW.modificado)); ',
                'END;'
            );
            PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

            -- TRIGGER DELETE
            SET @sql = CONCAT(
                'CREATE TRIGGER `trg_', v_tabla, '_delete` AFTER DELETE ON `', v_tabla, '` FOR EACH ROW ',
                'BEGIN ',
                    'INSERT INTO `AC_Auditoria` (`tabla`,`accion`,`registro_id`,`usuario_db`,`usuario_app`,`ip`,`datos_antes`) ',
                    'VALUES (''', v_tabla, ''', ''DELETE'', OLD.id, CURRENT_USER(), ',
                    'COALESCE(@usuario_app, NULL), COALESCE(@ip_cliente, NULL), JSON_OBJECT(''id'', OLD.id)); ',
                'END;'
            );
            PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

        END LOOP loop_tablas;

        CLOSE cur;
    END;

    DROP TEMPORARY TABLE IF EXISTS tmp_tablas_audit;

    SELECT '✅ Triggers de auditoría creados correctamente' AS resultado,
           p_tablas AS tablas_procesadas;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-04-30 16:18:15
