-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: equals
-- ------------------------------------------------------
-- Server version	5.7.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acl_classes`
--

DROP TABLE IF EXISTS `acl_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_classes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class_type` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_69DD750638A36066` (`class_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_classes`
--

LOCK TABLES `acl_classes` WRITE;
/*!40000 ALTER TABLE `acl_classes` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_entries`
--

DROP TABLE IF EXISTS `acl_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_entries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(10) unsigned NOT NULL,
  `object_identity_id` int(10) unsigned DEFAULT NULL,
  `security_identity_id` int(10) unsigned NOT NULL,
  `field_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ace_order` smallint(5) unsigned NOT NULL,
  `mask` int(11) NOT NULL,
  `granting` tinyint(1) NOT NULL,
  `granting_strategy` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `audit_success` tinyint(1) NOT NULL,
  `audit_failure` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_46C8B806EA000B103D9AB4A64DEF17BCE4289BF4` (`class_id`,`object_identity_id`,`field_name`,`ace_order`),
  KEY `IDX_46C8B806EA000B103D9AB4A6DF9183C9` (`class_id`,`object_identity_id`,`security_identity_id`),
  KEY `IDX_46C8B806EA000B10` (`class_id`),
  KEY `IDX_46C8B8063D9AB4A6` (`object_identity_id`),
  KEY `IDX_46C8B806DF9183C9` (`security_identity_id`),
  CONSTRAINT `FK_46C8B8063D9AB4A6` FOREIGN KEY (`object_identity_id`) REFERENCES `acl_object_identities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_46C8B806DF9183C9` FOREIGN KEY (`security_identity_id`) REFERENCES `acl_security_identities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_46C8B806EA000B10` FOREIGN KEY (`class_id`) REFERENCES `acl_classes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_entries`
--

LOCK TABLES `acl_entries` WRITE;
/*!40000 ALTER TABLE `acl_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_object_identities`
--

DROP TABLE IF EXISTS `acl_object_identities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_object_identities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_object_identity_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned NOT NULL,
  `object_identifier` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `entries_inheriting` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_9407E5494B12AD6EA000B10` (`object_identifier`,`class_id`),
  KEY `IDX_9407E54977FA751A` (`parent_object_identity_id`),
  CONSTRAINT `FK_9407E54977FA751A` FOREIGN KEY (`parent_object_identity_id`) REFERENCES `acl_object_identities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_object_identities`
--

LOCK TABLES `acl_object_identities` WRITE;
/*!40000 ALTER TABLE `acl_object_identities` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_object_identities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_object_identity_ancestors`
--

DROP TABLE IF EXISTS `acl_object_identity_ancestors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_object_identity_ancestors` (
  `object_identity_id` int(10) unsigned NOT NULL,
  `ancestor_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`object_identity_id`,`ancestor_id`),
  KEY `IDX_825DE2993D9AB4A6` (`object_identity_id`),
  KEY `IDX_825DE299C671CEA1` (`ancestor_id`),
  CONSTRAINT `FK_825DE2993D9AB4A6` FOREIGN KEY (`object_identity_id`) REFERENCES `acl_object_identities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_825DE299C671CEA1` FOREIGN KEY (`ancestor_id`) REFERENCES `acl_object_identities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_object_identity_ancestors`
--

LOCK TABLES `acl_object_identity_ancestors` WRITE;
/*!40000 ALTER TABLE `acl_object_identity_ancestors` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_object_identity_ancestors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl_security_identities`
--

DROP TABLE IF EXISTS `acl_security_identities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_security_identities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `username` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8835EE78772E836AF85E0677` (`identifier`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl_security_identities`
--

LOCK TABLES `acl_security_identities` WRITE;
/*!40000 ALTER TABLE `acl_security_identities` DISABLE KEYS */;
/*!40000 ALTER TABLE `acl_security_identities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `direccionFiscal` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `direccionEntrega` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cuit` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoNombre1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoTelefono1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoMail1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoNombre2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoTelefono2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoMail2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoNombre3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoTelefono3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoMail3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_F41C9B253A909126` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'ALFAJORES JORGITO S.A.','Salcedo 3982 CABA','33 Orientales 1840 CABA','33-51603319-9','Carolina Papatanasi','4921-6051/2/3 int. 115','proveedores@alfajores-jorgito.com',NULL,NULL,NULL,NULL,NULL,NULL),(2,'ARCOR S.A.I.C','Ruta 191 Km 4,5 - San Pedro - BUENOS AIRES - ARGENTINA','Transporte HADA - Río cuarto 4911 POMPEYA - CABA','30-50279317-5','E-Cup','4310-9500 int. 9742',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'BAGLEY ARGENTINA S.A. (SAN PEDRO)','Ruta 191 Km 4,5 - San Pedro - BUENOS AIRES - ARGENTINA','Transporte HADA - Río cuarto 4911 POMPEYA - CABA','30-70889878-0','E-Cup','4310-9500 int. 9041 Joaquin',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'COMPLEJO ALIMENTICIO SAN SALVADOR S.A.','Ruta Provincial 302 Km 14 - Colombres - TUCUMÁN','Transporte Gomez - Monteagudo 459 - Parque Patricios - CABA','30-71182832-6','Matias Auad','0381-4842800 int 2176','mauad@complejosansalvador.com.ar','Lucas Farías','0381-5081485 int 2138','lfarias@complejosansalvador.com.ar',NULL,NULL,NULL),(5,'DOÑA NOLY S.R.L.','Av. Marcelo T. de Alvear 4497 (1678) - Caseros - Prov. de BUENOS AIRES','Francisco Suarez 4544 - Ciudadela - BUENOS AIRES','30-58337002-8','Sol','4759-9999 int 244 L a V de 9 a 13 hs.','pagos@noly.com.ar','Jorgelina Nazzo (Cuentas Corrientes)','4759-9999','jnazzo@noly.com.ar','D. Buss (Facturas)','compras@noly.com.ar','dbuss@noly.com.ar'),(6,'FARDI S.A.','60 - Anastacio Gonzalez 5641 - Villa Libertad - BUENOS AIRES','60 - Anastacio Gonzalez 5641 - Villa Libertad - BUENOS AIRES','30-71132654-1','Maria Fardini','4752-4963 / 15-3631-3050','gerencia@fardi.com.ar',NULL,NULL,'proveedores@fardi.com.ar',NULL,NULL,NULL),(7,'FLAIR S.R.L.','Intendente Lumbreras 1800 - General Rodriguez - BUENOS AIRES','Ruta 24 y Av. Corrientes - Gral. Rodriguez - BUENOS AIRES','30-68833527-9','Abel Ledesma','0237-4858850/4625429','ledesma.abel@flair.com.ar',NULL,NULL,NULL,NULL,NULL,NULL),(8,'GENERAL CEREALS S.A.','Venezuela 3854 - Villa Martelli - BUENOS AIRES','Planta Industrial - Ruta 5 Km 77,5 - Luján - Pcia. BUENOS AIRES','30-67986437-4','Federico Stumpf  - COMPRADOR','4709-8900','federico.stumpf@georgalos.com.ar','Miriam Andreoli','proveedores@georgalos.com.ar','miriam.andreoli@georgalos.com.ar','Marcelo Correa',NULL,'marcelo.correa@georgalos.com.ar'),(9,'GRANOTEC ARGENTINA S.A.','Einstein esq Gral. Savio (1616) Garin - BUENOS AIRES','Einstein esq Gral. Savio (1616) Garin - BUENOS AIRES','30-64572286-4','Susana Cantoni - TESORERÍA','03327-444416/7/8/9 INT 116','scantoni@granotec.com.ar','Enrique Gomez','03327-444416/7/8/9 int 111','egomez@granotec.com.ar','Mayra','03327-444416/7/8/9 int 101','mpacheco@granotec.com.ar'),(10,'GRUPO LOMA BLANCA S.A.','Yrigoyen Hipólito 1145 Piso 3 Dpto E - Capital federal - CABA','Ruta 24 y Av. Corrientes - Gral. Rodriguez - BUENOS AIRES','30-71021221-6','Victor','0237-4654645/465-4647 Jueves de 15 a 17 hs.','harinaslomablanca@yahoo.com.ar',NULL,NULL,NULL,NULL,NULL,NULL),(11,'INDUSTRIAS PARA EL ARTE S.A.','Cerrito 5192 - La Tablada - BUENOS AIRES','Cerrito 5192 - La Tablada - BUENOS AIRES','30-70734379-2','Bosquero','4652-3112/13/2550/51','bosquero@induart.com.ar',NULL,NULL,NULL,NULL,NULL,NULL),(12,'LAGOMARSINO S.A.','San Martín 229 Piso 7 - Capital Federal - CABA','Estevez 55 - Avellaneda - BUENOS AIRES','30-54171633-1','Ailin','4321-6821 de 10:30 a 16 hs.','pagos@lagomarsino.com.ar',NULL,'insumos@lagomarsino.com','compras@lagomarsino.com',NULL,NULL,'proveedores@lagomarsino.com.ar'),(13,'LIMINDAR S.A.','Camino General Belgrano 2041 - Lanus - BUENOS AIRES','Camino General Belgrano 2041 - Lanus - BUENOS AIRES','30-59374846-0','Fidel','4265-0089/4204-5303','ffarez2007@yahoo.com.ar',NULL,NULL,'compras@limindar.com.ar',NULL,NULL,NULL),(14,'MOLINO ARGENTINO S A I C A G E I','Avda. Domingo Cabred 451 - Doctor Domingo Cabred - BUENOS AIRES','Avda. Domingo Cabred 451 - Doctor Domingo Cabred - BUENOS AIRES','30-53510190-2',NULL,'02323-496050/4312-1170','proveedores@molinoargentino.com.ar',NULL,NULL,NULL,NULL,NULL,NULL),(15,'NOVOZYNES BIOAG S.A.','10 Parque Industrial Pilar 753 - Pilar - BUENOS AIRES','Calle 10 Nª 753 - PARQUE INDUSTRIAL PILAR 7547 (1929) Pilar - BUENOS AIRES','30-61291775-9','Silvia Bustos PAGOS de 9 a 16 hs','02304-496100','slvb@novozymes.com',NULL,NULL,NULL,NULL,NULL,NULL),(16,'POL CON CONO SUR S.A.','Uruguay 469 Piso 5 - CABA','Alfredo Palacios 4562 - VILLA INSUPERABLE- BUENOS AIRES','30-64134150-5','José','15-5874-9012','polcon@speedy.com.ar',NULL,NULL,NULL,NULL,NULL,NULL),(17,'PULVER S.R.L.','Av. Velez Sarfield 279 - CABA','Av. Velez Sarfield 279 - CABA','30-64020570-5','Daniel Tamburini','4304-3578/0675','dtamburini@pulver.com.ar','Yamila','4304-3578/0675 Lu, Ma, Mi de 9 a 12',NULL,NULL,NULL,NULL),(18,'TAXONERA S.A.','Av. Segurola 1865 -  CABA','Av. Segurola 1865 - CABA','33-50511080-9','Alejandra Chicalone CONTADORA','4567-5050','alejandra.chicalone@taxonera.com','Nelida Pelacini','4567-5050 int 107 pagos@taxonera.com','nelida.pelacini@taxonera.com','Ricardo',NULL,'compras@taxonera.com'),(19,'UNILEVER DE ARGENTINA S.A.','Alferez Hipólito Bouchard 4191 - Munro - BUENOS AIRES','Ruta 8 Km 60, Calle 8 entre 5 y 9 - PARQUE INDUSTRIAL PILAR','30-50109269-6','Sebastián Vargas','www.cobranzas.com','sebastian.vargas@unilever.com','Marcelo Rivara COMPRAS','+54 261 15 5034782','marcelo.rivara@unilever.com',NULL,NULL,NULL),(20,'PRODUCTOS VEN HOR S.A.','28 - Catalinas De Boile 3629 - San Martín - BUENOS AIRES','28 - Catalinas De Boile 3629 - San Martín - BUENOS AIRES','30-68841959-6','Natalia','4755-4999/4713-3443 Viernes de 15 a 17 hs.','administracion@venhor.com.ar',NULL,NULL,'personal@venhor.com.ar',NULL,NULL,NULL),(21,'WORDCHEMIE S.R.L.','Av. Eva Perón 5080 - Capital federal - CABA','Estanislao Zeballos 453 AVELLANEDA - BUENOS AIRES','30-71431640-7','Marcelo Siri','4222-1765','marcelosiri@wordchemie.com.ar',NULL,NULL,NULL,NULL,NULL,NULL),(22,'A.A.A.7ªDÍA - GRANIX','Uriarte 2429 Capital Federal - CABA','San Martín 4625 - FLORIDA - BUENOS AIRES','30-50097401-6',NULL,'4730-8000','proveedores@granix.com.ar',NULL,NULL,NULL,NULL,NULL,NULL),(23,'MOLINOS BALATON S.A.','Moreno y Ruta Nº75 0 - San Cayetano - BUENOS AIRES','San Martín 4625 - FLORIDA - BUENOS AIRES','30-50097401-6','Mariana Campobreda 02983-15-646427','02983-44122/471122/1491','mcampo@molinosbalaton.com.ar',NULL,NULL,NULL,NULL,NULL,NULL),(24,'DOMCA S.A.','Parque Industrial Gualeguaychu - Ruta 14 y 16 - ENTRE RÍOS - ARGENTINA','Transporte Mostto - Portella 3447 - CABA','30-69322435-3','Alicia Parma','03446-493009','aliciaparma@gmail.com',NULL,NULL,'domcaargentina@fibertel.com.ar',NULL,NULL,NULL),(25,'RALLADISIMO S.R.L','Infanta Isabel 3155 - Villa Libertad (1650) - BUENOS AIRES','Infanta Isabel 3155 - Villa Libertad (1650) - BUENOS AIRES','33-68024813-9','Fernando','4844-5877','info@ralladisimo.com.ar',NULL,NULL,NULL,NULL,NULL,NULL),(26,'TEMFLOR S.R.L.','347 3517','Calle 347 (Vucetich) Nª3517 - QUILMES OESTE - BUENOS AIRES','30-63022270-9','María Elisa','4200-8916 / 15-4175-8895','gerencia@temflor.com.ar',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_audit`
--

DROP TABLE IF EXISTS `cliente_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `direccionFiscal` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `direccionEntrega` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cuit` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoNombre1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoTelefono1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoMail1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoNombre2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoTelefono2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoMail2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoNombre3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoTelefono3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoMail3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_3a6f9752c9c1a086a793129375ebc921_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_audit`
--

LOCK TABLES `cliente_audit` WRITE;
/*!40000 ALTER TABLE `cliente_audit` DISABLE KEYS */;
INSERT INTO `cliente_audit` VALUES (1,60,'ALFAJORES JORGITO S.A.','Salcedo 3982 CABA','33 Orientales 1840 CABA','33-51603319-9','Carolina Papatanasi','4921-6051/2/3 int. 115','proveedores@alfajores-jorgito.com',NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(2,62,'ARCOR S.A.I.C','Ruta 191 Km 4,5 - San Pedro - BUENOS AIRES - ARGENTINA','Transporte HADA - Río cuarto 4911 POMPEYA - CABA','30-50279317-5','E-Cup','4310-9500 int. 9742',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(3,70,'BAGLEY ARGENTINA S.A.','Ruta 191 Km 4,5 - San Pedro - BUENOS AIRES - ARGENTINA','Transporte HADA - Río cuarto 4911 POMPEYA - CABA','30-70889878-0','E-Cup','4310-9500 int. 9041 Joaquin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(3,265,'BAGLEY ARGENTINA S.A. (SAN PEDRO)','Ruta 191 Km 4,5 - San Pedro - BUENOS AIRES - ARGENTINA','Transporte HADA - Río cuarto 4911 POMPEYA - CABA','30-70889878-0','E-Cup','4310-9500 int. 9041 Joaquin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UPD'),(4,74,'COMPLEJO ALIMENTICIO SAN SALVADOR S.A.','Ruta Provincial 302 Km 14 - Colombres - TUCUMÁN','Transporte Gomez - Monteagudo 459 - Parque Patricios - CABA','30-71182832-6','Matias Auad','0381-4842800 int 2176','mauad@complejosansalvador.com.ar','Lucas Farías','0381-5081485 int 2138','lfarias@complejosansalvador.com.ar',NULL,NULL,NULL,'INS'),(5,76,'DOÑA NOLY S.R.L.','Av. Marcelo T. de Alvear 4497 (1678) - Caseros - Prov. de BUENOS AIRES','Francisco Suarez 4544 - Ciudadela - BUENOS AIRES','30-58337002-8','Sol','4759-9999 int 244 L a V de 9 a 13 hs.','pagos@noly.com.ar','Jorgelina Nazzo (Cuentas Corrientes)','4759-9999','jnazzo@noly.com.ar','D. Buss (Facturas)',NULL,'dbuss@noly.com.ar','INS'),(5,77,'DOÑA NOLY S.R.L.','Av. Marcelo T. de Alvear 4497 (1678) - Caseros - Prov. de BUENOS AIRES','Francisco Suarez 4544 - Ciudadela - BUENOS AIRES','30-58337002-8','Sol','4759-9999 int 244 L a V de 9 a 13 hs.','pagos@noly.com.ar','Jorgelina Nazzo (Cuentas Corrientes)','4759-9999','jnazzo@noly.com.ar','D. Buss (Facturas)','compras@noly.com.ar','dbuss@noly.com.ar','UPD'),(6,78,'FARDI S.A.','60 - Anastacio Gonzalez 5641 - Villa Libertad - BUENOS AIRES','60 - Anastacio Gonzalez 5641 - Villa Libertad - BUENOS AIRES','30-71132654-1','Maria Fardini','4752-4963 / 15-3631-3050','gerencia@fardi.com.ar',NULL,NULL,'proveedores@fardi.com.ar',NULL,NULL,NULL,'INS'),(7,79,'FLAIR S.R.L.','Intendente Lumbreras 1800 - General Rodriguez - BUENOS AIRES','Ruta 24 y Av. Corrientes - Gral. Rodriguez - BUENOS AIRES','30-68833527-9','Abel Ledesma','0237-4858850/4625429','ledesma.abel@flair.com.ar',NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(8,80,'GENERAL CEREALS S.A.','Venezuela 3854 - Villa Martelli - BUENOS AIRES','Planta Industrial - Ruta 5 Km 77,5 - Luján - Pcia. BUENOS AIRES','30-67986437-4','Federico Stumpf  - COMPRADOR','4709-8900','federico.stumpf@georgalos.com.ar','Miriam Andreoli','proveedores@georgalos.com.ar','miriam.andreoli@georgalos.com.ar','Marcelo Correa',NULL,'marcelo.correa@georgalos.com.ar','INS'),(9,84,'GRANOTEC ARGENTINA S.A.','Einstein esq Gral. Savio (1616) Garin - BUENOS AIRES','Einstein esq Gral. Savio (1616) Garin - BUENOS AIRES','30-64572286-4','Susana Cantoni - TESORERÍA','03327-444416/7/8/9 INT 116','scantoni@granotec.com.ar','Enrique Gomez','03327-444416/7/8/9 int 111','egomez@granotec.com.ar','Mayra','03327-444416/7/8/9 int 101','mpacheco@granotec.com.ar','INS'),(10,85,'GRUPO LOMA BLANCA S.A.','Yrigoyen Hipólito 1145 Piso 3 Dpto E - Capital federal - CABA','Ruta 24 y Av. Corrientes - Gral. Rodriguez - BUENOS AIRES','30-71021221-6','Victor','0237-4654645/465-4647 Jueves de 15 a 17 hs.','harinaslomablanca@yahoo.com.ar',NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(11,86,'INDUSTRIAS PARA EL ARTE S.A.','Cerrito 5192 - La Tablada - BUENOS AIRES','Cerrito 5192 - La Tablada - BUENOS AIRES','30-70734379-2','Bosquero','4652-3112/13/2550/51','bosquero@induart.com.ar',NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(12,87,'LAGOMARSINO S.A.','San Martín 229 Piso 7 - Capital Federal - CABA','Estevez 55 - Avellaneda - BUENOS AIRES','30-54171633-1','Ailin','4321-6821 de 10:30 a 16 hs.','pagos@lagomarsino.com.ar',NULL,'insumos@lagomarsino.com','compras@lagomarsino.com',NULL,NULL,'proveedores@lagomarsino.com.ar','INS'),(13,88,'LIMINDAR S.A.','Camino General Belgrano 2041 - Lanus - BUENOS AIRES','Camino General Belgrano 2041 - Lanus - BUENOS AIRES','30-59374846-0','Fidel','4265-0089/4204-5303','ffarez2007@yahoo.com.ar',NULL,NULL,'compras@limindar.com.ar',NULL,NULL,NULL,'INS'),(14,89,'MOLINO ARGENTINO S A I C A G E I','Avda. Domingo Cabred 451 - Doctor Domingo Cabred - BUENOS AIRES','Avda. Domingo Cabred 451 - Doctor Domingo Cabred - BUENOS AIRES','30-53510190-2',NULL,'02323-496050/4312-1170','proveedores@molinoargentino.com.ar',NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(15,90,'NOVOZYNES BIOAG S.A.','10 Parque Industrial Pilar 753 - Pilar - BUENOS AIRES','Calle 10 Nª 753 - PARQUE INDUSTRIAL PILAR 7547 (1929) Pilar - BUENOS AIRES','30-61291775-9','Silvia Bustos PAGOS de 9 a 16 hs','02304-496100','slvb@novozymes.com',NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(16,91,'POL CON CONO SUR S.A.','Uruguay 469 Piso 5 - CABA','Alfredo Palacios 4562 - VILLA INSUPERABLE- BUENOS AIRES','30-64134150-5','José','15-5874-9012',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(16,92,'POL CON CONO SUR S.A.','Uruguay 469 Piso 5 - CABA','Alfredo Palacios 4562 - VILLA INSUPERABLE- BUENOS AIRES','30-64134150-5','José','15-5874-9012','polcon@speedy.com.ar',NULL,NULL,NULL,NULL,NULL,NULL,'UPD'),(17,93,'PULVER S.R.L.','Av. Velez Sarfield 279 - CABA','Av. Velez Sarfield 279 - CABA','30-64020570-5','Daniel Tamburini','4304-3578/0675','dtamburini@pulver.com.ar','Yamila','4304-3578/0675 Lu, Ma, Mi de 9 a 12',NULL,NULL,NULL,NULL,'INS'),(18,94,'TAXONERA S.A.','Av. Segurola 1865 - Capital federal - CABA','Av. Segurola 1865 - Capital federal - CABA','33-50511080-9','Alejandra Chicalone CONTADORA','4567-5050','alejandra.chicalone@taxonera.com','Nelida Pelacini','4567-5050 int 107 pagos@taxonera.com','nelida.pelacini@taxonera.com','Ricardo',NULL,'compras@taxonera.com','INS'),(18,213,'TAXONERA S.A.','Av. Segurola 1865 -  CABA','Av. Segurola 1865 - CABA','33-50511080-9','Alejandra Chicalone CONTADORA','4567-5050','alejandra.chicalone@taxonera.com','Nelida Pelacini','4567-5050 int 107 pagos@taxonera.com','nelida.pelacini@taxonera.com','Ricardo',NULL,'compras@taxonera.com','UPD'),(19,95,'UNILEVER DE ARGENTINA S.A.','Alferez Hipólito Bouchard 4191 - Munro - BUENOS AIRES','Ruta 8 Km 60, Calle 8 entre 5 y 9 - PARQUE INDUSTRIAL PILAR','30-50109269-6','Sebastián Vargas','www.cobranzas.com','sebastian.vargas@unilever.com','Marcelo Rivara COMPRAS','+54 261 15 5034782','marcelo.rivara@unilever.com',NULL,NULL,NULL,'INS'),(20,100,'PRODUCTOS VEN HOR S.A.','28 - Catalinas De Boile 3629 - San Martín - BUENOS AIRES','28 - Catalinas De Boile 3629 - San Martín - BUENOS AIRES','30-68841959-6','Natalia','4755-4999/4713-3443 Viernes de 15 a 17 hs.','administracion@venhor.com.ar',NULL,NULL,'personal@venhor.com.ar',NULL,NULL,NULL,'INS'),(21,101,'WORDCHEMIE S.R.L.','Av. Eva Perón 5080 - Capital federal - CABA','Estanislao Zeballos 453 AVELLANEDA - BUENOS AIRES','30-71431640-7','Marcelo Siri','4222-1765','marcelosiri@wordchemie.com.ar',NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(22,102,'A.A.A.7ªDÍA - GRANIX','Uriarte 2429 Capital Federal - CABA','San Martín 4625 - FLORIDA - BUENOS AIRES','30-50097401-6',NULL,'4730-8000','proveedores@granix.com.ar',NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(23,103,'MOLINOS BALATON S.A.','Moreno y Ruta Nº75 0 - San Cayetano - BUENOS AIRES','San Martín 4625 - FLORIDA - BUENOS AIRES','30-50097401-6','Mariana Campobreda 02983-15-646427','02983-44122/471122/1491','mcampo@molinosbalaton.com.ar',NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(24,104,'DOMCA S.A.','Parque Industrial Gualeguaychu - Ruta 14 y 16 - ENTRE RÍOS - ARGENTINA','Transporte Mostto - Portella 3447 - CABA','30-69322435-3','Alicia Parma','03446-493009','domcaargentina@fibertel.com.ar',NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(24,105,'DOMCA S.A.','Parque Industrial Gualeguaychu - Ruta 14 y 16 - ENTRE RÍOS - ARGENTINA','Transporte Mostto - Portella 3447 - CABA','30-69322435-3','Alicia Parma','03446-493009','aliciaparma@gmail.com',NULL,NULL,'domcaargentina@fibertel.com.ar',NULL,NULL,NULL,'UPD'),(25,106,'RALLADISIMO S.R.L','Infanta Isabel 3155 - Villa Libertad (1650) - BUENOS AIRES','Infanta Isabel 3155 - Villa Libertad (1650) - BUENOS AIRES','33-68024813-9','Fernando','4844-5877','info@ralladisimo.com.ar',NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(26,108,'TEMFLOR S.R.L.','347 3517','Calle 347 (Vucetich) Nª3517 - QUILMES OESTE - BUENOS AIRES','30-63022270-9','María Elisa','4200-8916 / 15-4175-8895','gerencia@temflor.com.ar',NULL,NULL,NULL,NULL,NULL,NULL,'INS');
/*!40000 ALTER TABLE `cliente_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `proveedor_id` int(11) DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL,
  `fecha_modificacion` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9EC131FFCB305D73` (`proveedor_id`),
  CONSTRAINT `FK_9EC131FFCB305D73` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES (1,2,'2019-04-16 13:44:14','2019-04-16 13:44:14'),(2,2,'2019-04-16 13:47:57','2019-04-16 13:47:57'),(3,1,'2019-04-16 14:23:52','2019-04-16 14:23:52'),(4,1,'2019-04-16 14:25:25','2019-04-16 14:25:25'),(5,1,'2019-04-16 14:30:03','2019-04-16 14:30:03'),(6,3,'2019-04-16 15:02:48','2019-04-16 15:02:48'),(7,3,'2019-04-16 15:04:15','2019-04-16 15:04:15'),(8,4,'2019-04-16 15:06:51','2019-04-16 15:06:51'),(9,4,'2019-04-16 15:08:23','2019-04-16 15:08:23'),(10,5,'2019-04-16 15:10:38','2019-04-16 15:10:38'),(11,2,'2019-04-30 15:49:25','2019-04-30 15:49:25'),(12,6,'2019-05-07 15:32:43','2019-05-07 15:32:43'),(13,2,'2019-05-13 19:56:13','2019-05-13 19:56:13'),(14,2,'2019-05-21 17:31:50','2019-05-21 17:31:50'),(15,4,'2019-05-21 17:36:56','2019-05-21 17:36:56'),(16,6,'2019-05-30 18:40:24','2019-05-30 18:40:24'),(17,5,'2019-06-06 19:19:25','2019-06-06 19:19:25');
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra_audit`
--

DROP TABLE IF EXISTS `compra_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compra_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `proveedor_id` int(11) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_47d81495cda0edb67b5ffbd546d6706d_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra_audit`
--

LOCK TABLES `compra_audit` WRITE;
/*!40000 ALTER TABLE `compra_audit` DISABLE KEYS */;
INSERT INTO `compra_audit` VALUES (1,112,2,'2019-04-16 13:44:14','2019-04-16 13:44:14','INS'),(2,114,2,'2019-04-16 13:47:57','2019-04-16 13:47:57','INS'),(3,116,1,'2019-04-16 14:23:52','2019-04-16 14:23:52','INS'),(4,118,1,'2019-04-16 14:25:25','2019-04-16 14:25:25','INS'),(5,120,1,'2019-04-16 14:30:03','2019-04-16 14:30:03','INS'),(6,184,3,'2019-04-16 15:02:48','2019-04-16 15:02:48','INS'),(7,188,3,'2019-04-16 15:04:15','2019-04-16 15:04:15','INS'),(8,193,4,'2019-04-16 15:06:51','2019-04-16 15:06:51','INS'),(9,195,4,'2019-04-16 15:08:23','2019-04-16 15:08:23','INS'),(10,197,5,'2019-04-16 15:10:38','2019-04-16 15:10:38','INS'),(11,234,2,'2019-04-30 15:49:25','2019-04-30 15:49:25','INS'),(12,256,6,'2019-05-07 15:32:43','2019-05-07 15:32:43','INS'),(13,286,2,'2019-05-13 19:56:13','2019-05-13 19:56:13','INS'),(13,521,2,'2019-05-13 19:56:13','2019-05-13 19:56:13','DEL'),(14,310,2,'2019-05-21 17:31:50','2019-05-21 17:31:50','INS'),(15,312,4,'2019-05-21 17:36:56','2019-05-21 17:36:56','INS'),(16,391,6,'2019-05-30 18:40:24','2019-05-30 18:40:24','INS'),(17,477,5,'2019-06-06 19:19:25','2019-06-06 19:19:25','INS');
/*!40000 ALTER TABLE `compra_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fabricacion`
--

DROP TABLE IF EXISTS `fabricacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fabricacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `formula_enzimatica_id` int(11) NOT NULL,
  `estado` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cantidad` decimal(7,2) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  `fecha_modificacion` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_63C5045CBACB0BC7` (`formula_enzimatica_id`),
  CONSTRAINT `FK_63C5045CBACB0BC7` FOREIGN KEY (`formula_enzimatica_id`) REFERENCES `formula_enzimatica` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fabricacion`
--

LOCK TABLES `fabricacion` WRITE;
/*!40000 ALTER TABLE `fabricacion` DISABLE KEYS */;
INSERT INTO `fabricacion` VALUES (1,19,'fabricado',100.00,'2019-04-23 13:59:45','2019-04-23 14:11:39'),(2,19,'fabricado',500.00,'2019-05-08 16:04:54','2019-05-08 16:08:53'),(3,1,'fabricado',750.00,'2019-05-13 18:21:59','2019-05-24 15:27:44'),(4,9,'fabricado',500.00,'2019-05-13 18:22:28','2019-05-24 15:27:46'),(5,17,'fabricado',750.00,'2019-05-13 18:22:46','2019-05-24 15:27:49'),(7,15,'fabricado',400.00,'2019-05-13 19:02:31','2019-05-24 15:27:52'),(13,1,'fabricado',250.00,'2019-06-06 18:59:39','2019-06-06 19:20:01'),(14,17,'fabricado',1500.00,'2019-06-06 19:03:27','2019-06-06 19:20:04'),(15,9,'fabricado',500.00,'2019-06-06 19:04:51','2019-06-06 19:20:07'),(16,13,'pendiente',300.00,'2019-06-06 19:06:16','2019-06-06 19:06:16'),(17,4,'fabricado',500.00,'2019-06-06 19:08:12','2019-06-11 14:16:27'),(18,15,'fabricado',500.00,'2019-06-06 19:09:36','2019-06-06 19:19:32'),(19,2,'fabricado',250.00,'2019-06-06 19:10:44','2019-06-06 19:19:47'),(20,18,'fabricado',200.00,'2019-06-06 19:12:29','2019-06-06 19:19:38'),(21,14,'pendiente',400.00,'2019-06-12 16:20:33','2019-06-12 16:20:33');
/*!40000 ALTER TABLE `fabricacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fabricacion_audit`
--

DROP TABLE IF EXISTS `fabricacion_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fabricacion_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `formula_enzimatica_id` int(11) DEFAULT NULL,
  `estado` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cantidad` decimal(7,2) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_3eaf8d9ec7653b88b54f725140e50d63_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fabricacion_audit`
--

LOCK TABLES `fabricacion_audit` WRITE;
/*!40000 ALTER TABLE `fabricacion_audit` DISABLE KEYS */;
INSERT INTO `fabricacion_audit` VALUES (1,208,19,'pendiente',100.00,'2019-04-23 13:59:45','2019-04-23 13:59:45','INS'),(1,209,19,'fabricado',100.00,'2019-04-23 13:59:45','2019-04-23 14:11:39','UPD'),(2,259,19,'pendiente',500.00,'2019-05-08 16:04:54','2019-05-08 16:04:54','INS'),(2,260,19,'fabricado',500.00,'2019-05-08 16:04:54','2019-05-08 16:08:53','UPD'),(3,271,1,'pendiente',750.00,'2019-05-13 18:21:59','2019-05-13 18:21:59','INS'),(3,331,1,'fabricado',750.00,'2019-05-13 18:21:59','2019-05-24 15:27:44','UPD'),(4,272,9,'pendiente',500.00,'2019-05-13 18:22:28','2019-05-13 18:22:28','INS'),(4,334,9,'fabricado',500.00,'2019-05-13 18:22:28','2019-05-24 15:27:46','UPD'),(5,273,17,'pendiente',750.00,'2019-05-13 18:22:46','2019-05-13 18:22:46','INS'),(5,337,17,'fabricado',750.00,'2019-05-13 18:22:46','2019-05-24 15:27:49','UPD'),(6,274,15,'inconsistente',500.00,'2019-05-13 18:22:56','2019-05-13 18:22:56','INS'),(6,275,15,'inconsistente',500.00,'2019-05-13 18:22:56','2019-05-13 18:22:56','DEL'),(6,276,15,'inconsistente',400.00,'2019-05-13 18:22:56','2019-05-13 18:32:35','UPD'),(6,278,15,'inconsistente',400.00,'2019-05-13 18:22:56','2019-05-13 18:32:35','DEL'),(7,283,15,'pendiente',400.00,'2019-05-13 19:02:31','2019-05-13 19:02:31','INS'),(7,340,15,'fabricado',400.00,'2019-05-13 19:02:31','2019-05-24 15:27:52','UPD'),(8,389,1,'pendiente',500.00,'2019-05-30 18:38:04','2019-05-30 18:38:04','INS'),(8,390,1,'pendiente',500.00,'2019-05-30 18:38:04','2019-05-30 18:38:26','UPD'),(8,414,1,'fabricado',500.00,'2019-05-30 18:38:04','2019-06-05 13:26:34','UPD'),(8,437,1,'fabricado',500.00,'2019-05-30 18:38:04','2019-06-05 13:26:34','DEL'),(9,393,17,'pendiente',1500.00,'2019-05-30 18:56:16','2019-05-30 18:56:16','INS'),(9,417,17,'fabricado',1500.00,'2019-05-30 18:56:16','2019-06-05 13:27:41','UPD'),(9,442,17,'fabricado',1500.00,'2019-05-30 18:56:16','2019-06-05 13:27:41','DEL'),(10,394,9,'pendiente',500.00,'2019-05-30 18:57:12','2019-05-30 18:57:12','INS'),(10,420,9,'fabricado',500.00,'2019-05-30 18:57:12','2019-06-05 13:28:14','UPD'),(10,448,9,'fabricado',500.00,'2019-05-30 18:57:12','2019-06-05 13:28:14','DEL'),(11,395,13,'pendiente',500.00,'2019-05-30 18:58:18','2019-05-30 18:58:18','INS'),(11,425,13,'pendiente',500.00,'2019-05-30 18:58:18','2019-05-30 18:58:18','DEL'),(11,454,13,'pendiente',500.00,'2019-05-30 18:58:18','2019-05-30 18:58:18','DEL'),(12,396,13,'pendiente',500.00,'2019-05-30 18:58:56','2019-05-30 18:58:56','INS'),(12,423,13,'pendiente',500.00,'2019-05-30 18:58:56','2019-05-30 18:58:56','DEL'),(12,424,13,'pendiente',500.00,'2019-05-30 18:58:56','2019-05-30 18:58:56','DEL'),(12,426,13,'fabricado',500.00,'2019-05-30 18:58:56','2019-06-05 13:30:31','UPD'),(12,460,13,'fabricado',500.00,'2019-05-30 18:58:56','2019-06-05 13:30:31','DEL'),(13,467,1,'pendiente',250.00,'2019-06-06 18:59:39','2019-06-06 18:59:39','INS'),(13,488,1,'fabricado',250.00,'2019-06-06 18:59:39','2019-06-06 19:20:01','UPD'),(14,468,17,'pendiente',1500.00,'2019-06-06 19:03:27','2019-06-06 19:03:27','INS'),(14,491,17,'fabricado',1500.00,'2019-06-06 19:03:27','2019-06-06 19:20:04','UPD'),(15,469,9,'pendiente',500.00,'2019-06-06 19:04:51','2019-06-06 19:04:51','INS'),(15,494,9,'fabricado',500.00,'2019-06-06 19:04:51','2019-06-06 19:20:07','UPD'),(16,470,13,'pendiente',300.00,'2019-06-06 19:06:16','2019-06-06 19:06:16','INS'),(17,471,4,'pendiente',500.00,'2019-06-06 19:08:12','2019-06-06 19:08:12','INS'),(17,540,4,'fabricado',500.00,'2019-06-06 19:08:12','2019-06-11 14:16:27','UPD'),(18,472,15,'pendiente',500.00,'2019-06-06 19:09:36','2019-06-06 19:09:36','INS'),(18,479,15,'fabricado',500.00,'2019-06-06 19:09:36','2019-06-06 19:19:32','UPD'),(19,473,2,'pendiente',250.00,'2019-06-06 19:10:44','2019-06-06 19:10:44','INS'),(19,485,2,'fabricado',250.00,'2019-06-06 19:10:44','2019-06-06 19:19:47','UPD'),(20,474,18,'pendiente',200.00,'2019-06-06 19:12:29','2019-06-06 19:12:29','INS'),(20,482,18,'fabricado',200.00,'2019-06-06 19:12:29','2019-06-06 19:19:38','UPD'),(21,556,14,'pendiente',400.00,'2019-06-12 16:20:33','2019-06-12 16:20:33','INS');
/*!40000 ALTER TABLE `fabricacion_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formula_enzimatica`
--

DROP TABLE IF EXISTS `formula_enzimatica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formula_enzimatica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_resultante_id` int(11) DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_38DE34053A909126` (`nombre`),
  KEY `IDX_38DE340536CBE815` (`producto_resultante_id`),
  CONSTRAINT `FK_38DE340536CBE815` FOREIGN KEY (`producto_resultante_id`) REFERENCES `producto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formula_enzimatica`
--

LOCK TABLES `formula_enzimatica` WRITE;
/*!40000 ALTER TABLE `formula_enzimatica` DISABLE KEYS */;
INSERT INTO `formula_enzimatica` VALUES (1,7,'E-BALANCE XB40'),(2,8,'E-BALANCE XT78'),(3,9,'E-BALANCE ST86'),(4,10,'E-BALANCE ST50'),(5,11,'E-BALANCE FL'),(6,12,'E-BALANCE B21'),(7,13,'E-BALANCE B20'),(8,14,'E-BALANCE AA5000'),(9,15,'E-FORCE MV11'),(10,16,'E-FORCE MV303'),(13,17,'E-FORCE MV33'),(14,18,'E-BALANCE A150'),(15,19,'E-FORCE GL'),(16,20,'E-BALANCE XBK-BX1'),(17,21,'E-POWER GOX'),(18,22,'EQUALMIX ADA 23'),(19,23,'EQUALMIX ADA 100');
/*!40000 ALTER TABLE `formula_enzimatica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formula_enzimatica_audit`
--

DROP TABLE IF EXISTS `formula_enzimatica_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formula_enzimatica_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `producto_resultante_id` int(11) DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_ebdb27691c01dcfb095c04afe678c391_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formula_enzimatica_audit`
--

LOCK TABLES `formula_enzimatica_audit` WRITE;
/*!40000 ALTER TABLE `formula_enzimatica_audit` DISABLE KEYS */;
INSERT INTO `formula_enzimatica_audit` VALUES (1,50,7,'E-BALANCE XB40','INS'),(2,51,8,'E-BALANCE XT78','INS'),(3,52,9,'E-BALANCE ST86','INS'),(4,53,10,'E-BALANCE ST50','INS'),(5,55,11,'E-BALANCE FL','INS'),(6,56,12,'E-BALANCE B21','INS'),(7,57,13,'E-BALANCE B20','INS'),(8,58,14,'E-BALANCE AA5000','INS'),(9,59,15,'E-FORCE MV11','INS'),(10,61,16,'E-FORCE MV33','INS'),(10,63,16,'E-FORCE MV303','UPD'),(13,64,17,'E-FORCE MV33','INS'),(14,65,18,'E-BALANCE A150','INS'),(15,66,19,'E-FORCE GL','INS'),(16,67,20,'E-BALANCE XBK-BX1','INS'),(17,68,21,'E-POWER GOX','INS'),(18,71,22,'EQUALMIX ADA 23','INS'),(19,72,23,'EQUALMIX ADA 100','INS');
/*!40000 ALTER TABLE `formula_enzimatica_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fos_user_group`
--

DROP TABLE IF EXISTS `fos_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fos_user_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_583D1F3E5E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fos_user_group`
--

LOCK TABLES `fos_user_group` WRITE;
/*!40000 ALTER TABLE `fos_user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `fos_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fos_user_group_audit`
--

DROP TABLE IF EXISTS `fos_user_group_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fos_user_group_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_791eaf97b684af9208d1f1d958a5729e_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fos_user_group_audit`
--

LOCK TABLES `fos_user_group_audit` WRITE;
/*!40000 ALTER TABLE `fos_user_group_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `fos_user_group_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fos_user_user`
--

DROP TABLE IF EXISTS `fos_user_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fos_user_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email_canonical` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `locked` tinyint(1) NOT NULL,
  `expired` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `credentials_expired` tinyint(1) NOT NULL,
  `credentials_expire_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `firstname` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `biography` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locale` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timezone` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebook_uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebook_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebook_data` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json)',
  `twitter_uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `twitter_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `twitter_data` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json)',
  `gplus_uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gplus_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gplus_data` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json)',
  `token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `two_step_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C560D76192FC23A8` (`username_canonical`),
  UNIQUE KEY `UNIQ_C560D761A0D96FBF` (`email_canonical`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fos_user_user`
--

LOCK TABLES `fos_user_user` WRITE;
/*!40000 ALTER TABLE `fos_user_user` DISABLE KEYS */;
INSERT INTO `fos_user_user` VALUES (1,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-14 03:28:35',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-14 03:28:35',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL);
/*!40000 ALTER TABLE `fos_user_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fos_user_user_audit`
--

DROP TABLE IF EXISTS `fos_user_user_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fos_user_user_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username_canonical` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_canonical` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `locked` tinyint(1) DEFAULT NULL,
  `expired` tinyint(1) DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `credentials_expired` tinyint(1) DEFAULT NULL,
  `credentials_expire_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `firstname` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `biography` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locale` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timezone` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebook_uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebook_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebook_data` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json)',
  `twitter_uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `twitter_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `twitter_data` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json)',
  `gplus_uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gplus_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gplus_data` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json)',
  `token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `two_step_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_782dc0f82f289145b1d57ca1c16ae709_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fos_user_user_audit`
--

LOCK TABLES `fos_user_user_audit` WRITE;
/*!40000 ALTER TABLE `fos_user_user_audit` DISABLE KEYS */;
INSERT INTO `fos_user_user_audit` VALUES (1,1,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==',NULL,0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-02 16:38:05',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'INS'),(1,2,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-02 17:45:43',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-02 17:45:43',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,3,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-03 12:54:27',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-03 12:54:27',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,38,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-04 14:08:09',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-04 14:08:09',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,54,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-04 14:54:05',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-04 14:54:05',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,107,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-08 19:43:44',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-08 19:43:44',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,109,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-10 16:31:17',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-10 16:31:17',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,110,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-12 14:06:36',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-12 14:06:36',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,111,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-16 13:40:03',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-16 13:40:03',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,186,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-16 15:03:10',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-16 15:03:10',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,191,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-16 15:06:10',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-16 15:06:10',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,200,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-23 13:38:02',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-23 13:38:02',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,201,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-23 13:45:34',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-23 13:45:34',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,218,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-24 15:19:38',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-24 15:19:38',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,219,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-24 15:54:07',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-24 15:54:07',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,220,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-25 15:16:00',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-25 15:16:00',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,223,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-25 16:20:47',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-25 16:20:47',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,225,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-25 18:50:28',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-25 18:50:28',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,229,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-26 16:32:41',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-26 16:32:41',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,230,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-29 17:23:54',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-29 17:23:54',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,232,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-30 15:35:02',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-30 15:35:02',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,241,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-30 16:14:48',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-30 16:14:48',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,242,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-04-30 18:42:00',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-04-30 18:42:00',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,244,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-02 13:40:01',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-02 13:40:01',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,245,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-02 18:05:17',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-02 18:05:17',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,246,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-02 18:05:35',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-02 18:05:35',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,247,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-02 18:20:17',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-02 18:20:17',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,248,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-02 18:20:32',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-02 18:20:32',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,249,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-06 18:09:53',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-06 18:09:53',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,253,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-07 15:30:15',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-07 15:30:15',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,258,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-08 16:02:14',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-08 16:02:14',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,264,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-09 14:14:09',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-09 14:14:09',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,267,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-09 20:04:43',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-09 20:04:43',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,268,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-10 17:48:27',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-10 17:48:27',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,269,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-10 17:52:26',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-10 17:52:26',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,270,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-13 15:02:57',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-13 15:02:57',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,277,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-13 18:41:22',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-13 18:41:22',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,284,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-13 19:37:12',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-13 19:37:12',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,289,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-14 13:11:20',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-14 13:11:20',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,294,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-14 18:35:48',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-14 18:35:48',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,295,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-15 13:36:39',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-15 13:36:39',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,296,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-16 13:53:01',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-16 13:53:01',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,298,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-17 14:18:26',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-17 14:18:26',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,302,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-21 13:01:45',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-21 13:01:45',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,303,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-21 14:53:43',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-21 14:53:43',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,308,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-21 15:11:13',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-21 15:11:13',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,309,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-21 16:26:00',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-21 16:26:00',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,314,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-21 18:07:38',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-21 18:07:38',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,317,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-22 12:31:19',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-22 12:31:19',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,320,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-23 16:00:44',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-23 16:00:44',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,321,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-24 13:23:55',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-24 13:23:55',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,328,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-24 15:06:28',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-24 15:06:28',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,352,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-24 16:54:43',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-24 16:54:43',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,356,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-24 17:12:10',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-24 17:12:10',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,361,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-27 17:35:12',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-27 17:35:12',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,362,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-27 18:42:40',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-27 18:42:40',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,364,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-27 18:58:24',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-27 18:58:24',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,373,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-28 12:48:57',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-28 12:48:57',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,374,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-28 13:07:38',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-28 13:07:38',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,378,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-30 12:49:31',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-30 12:49:31',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,379,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-30 12:55:51',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-30 12:55:51',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,380,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-30 15:59:07',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-30 15:59:07',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,386,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-30 18:17:55',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-30 18:17:55',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,387,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-30 18:36:01',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-30 18:36:01',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,400,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-05-30 19:26:29',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-05-30 19:26:29',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,401,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-03 19:37:59',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-03 19:37:59',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,408,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-03 19:55:22',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-03 19:55:22',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,409,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-04 17:11:01',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-04 17:11:01',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,411,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-05 12:44:27',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-05 12:44:27',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,413,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-05 13:19:50',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-05 13:19:50',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,429,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-05 13:55:04',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-05 13:55:04',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,431,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-05 20:24:30',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-05 20:24:30',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,432,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-05 22:22:40',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-05 22:22:40',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,461,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-05 22:28:56',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-05 22:28:56',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,462,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-06 17:46:32',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-06 17:46:32',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,466,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-06 18:51:10',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-06 18:51:10',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,503,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-10 13:14:48',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-10 13:14:48',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,504,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-10 16:37:59',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-10 16:37:59',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,537,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-10 19:25:48',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-10 19:25:48',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,538,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-10 20:29:01',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-10 20:29:01',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,539,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-11 12:50:57',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-11 12:50:57',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,543,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-11 14:19:17',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-11 14:19:17',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,554,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-11 17:47:49',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-11 17:47:49',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,555,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-12 14:49:07',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-12 14:49:07',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,557,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-13 17:41:44',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-13 17:41:44',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD'),(1,565,'admin','admin','admin','admin',1,'ezblw4f4vxw80cccswk0g8wos8wcw4s','+0B4pyuR5La+DSL7XaBjtzro83RkKICSSSAZfqDwK2F5ep4lJd6dXUmMNpnnfEb/lQrKPKnbKqNGaDIf2o+Q5A==','2019-06-14 03:28:35',0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL,'2019-04-02 16:38:05','2019-06-14 03:28:35',NULL,NULL,NULL,NULL,NULL,'u',NULL,NULL,NULL,NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'null',NULL,NULL,'UPD');
/*!40000 ALTER TABLE `fos_user_user_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fos_user_user_group`
--

DROP TABLE IF EXISTS `fos_user_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fos_user_user_group` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `IDX_B3C77447A76ED395` (`user_id`),
  KEY `IDX_B3C77447FE54D947` (`group_id`),
  CONSTRAINT `FK_B3C77447A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_user_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B3C77447FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_user_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fos_user_user_group`
--

LOCK TABLES `fos_user_user_group` WRITE;
/*!40000 ALTER TABLE `fos_user_user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `fos_user_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingrediente`
--

DROP TABLE IF EXISTS `ingrediente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingrediente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) DEFAULT NULL,
  `formula_enzimatica_id` int(11) NOT NULL,
  `porcentaje` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BFB4A41E7645698E` (`producto_id`),
  KEY `IDX_BFB4A41EBACB0BC7` (`formula_enzimatica_id`),
  CONSTRAINT `FK_BFB4A41E7645698E` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`),
  CONSTRAINT `FK_BFB4A41EBACB0BC7` FOREIGN KEY (`formula_enzimatica_id`) REFERENCES `formula_enzimatica` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingrediente`
--

LOCK TABLES `ingrediente` WRITE;
/*!40000 ALTER TABLE `ingrediente` DISABLE KEYS */;
INSERT INTO `ingrediente` VALUES (1,39,1,95.61),(2,32,1,1.26),(3,33,1,3.13),(4,39,2,90.44),(5,32,2,8.00),(6,33,2,1.56),(7,39,3,94.17),(8,32,3,4.18),(9,33,3,1.65),(10,39,4,95.22),(11,32,4,4.00),(12,33,4,0.78),(13,39,5,96.92),(14,34,5,3.08),(15,39,6,93.19),(16,32,6,4.00),(17,33,6,2.81),(18,39,7,90.75),(19,32,7,5.50),(20,33,7,3.75),(21,39,8,96.82),(22,14,8,3.18),(23,39,9,88.11),(24,32,9,6.00),(25,33,9,2.81),(26,34,9,3.08),(27,39,10,86.00),(28,32,10,5.00),(29,33,10,3.00),(30,34,10,6.00),(31,39,13,82.08),(32,32,13,6.67),(33,33,13,3.75),(34,34,13,7.50),(35,32,14,100.00),(36,39,15,92.00),(37,38,15,1.00),(38,33,15,1.00),(39,36,15,5.00),(40,39,16,50.00),(41,33,16,50.00),(42,39,17,98.00),(43,37,17,2.00),(44,39,18,76.53),(45,40,18,23.47),(46,40,19,100.00),(47,32,15,1.00);
/*!40000 ALTER TABLE `ingrediente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_remito`
--

DROP TABLE IF EXISTS `item_remito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_remito` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) DEFAULT NULL,
  `remito_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_38179FD17645698E` (`producto_id`),
  KEY `IDX_38179FD193DA9FED` (`remito_id`),
  CONSTRAINT `FK_38179FD17645698E` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`),
  CONSTRAINT `FK_38179FD193DA9FED` FOREIGN KEY (`remito_id`) REFERENCES `remito` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_remito`
--

LOCK TABLES `item_remito` WRITE;
/*!40000 ALTER TABLE `item_remito` DISABLE KEYS */;
INSERT INTO `item_remito` VALUES (1,19,1,150),(2,23,2,100),(3,10,2,100),(4,28,3,1000),(5,17,4,25),(6,2,5,9600),(7,4,6,203),(8,21,7,500),(9,5,8,350),(10,10,9,100),(11,23,9,100),(12,3,10,700),(13,1,14,700),(14,29,15,500),(15,15,15,25),(16,3,16,4000),(18,1,18,1300),(19,21,19,250),(20,15,19,250),(21,19,19,150),(22,7,19,250),(23,23,20,100),(24,10,20,100),(25,5,21,100),(26,29,22,400),(27,15,23,250),(28,21,23,250),(29,7,23,200),(30,19,23,50),(31,9,24,75),(32,19,24,75),(33,11,24,25),(34,2,25,4800),(35,7,27,50),(36,19,27,100),(37,23,29,100),(38,10,29,100),(39,21,30,350),(40,28,31,25),(41,2,32,4800),(42,2,33,1200),(43,5,34,225),(44,3,35,100),(45,1,36,1500),(46,23,37,100),(47,10,37,100),(48,15,38,500),(49,8,40,200),(50,18,41,200),(51,23,42,100),(52,10,42,100),(53,21,43,400);
/*!40000 ALTER TABLE `item_remito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lote`
--

DROP TABLE IF EXISTS `lote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) DEFAULT NULL,
  `compra_id` int(11) DEFAULT NULL,
  `fabricacion_id` int(11) DEFAULT NULL,
  `numero` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cantidadInicial` decimal(10,2) NOT NULL,
  `cantidadDisponible` decimal(10,2) DEFAULT NULL,
  `cantidadReservada` decimal(10,2) DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_65B4329F7645698E` (`producto_id`),
  KEY `IDX_65B4329FF2E704D7` (`compra_id`),
  KEY `IDX_65B4329F8C85E1BC` (`fabricacion_id`),
  CONSTRAINT `FK_65B4329F7645698E` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`),
  CONSTRAINT `FK_65B4329F8C85E1BC` FOREIGN KEY (`fabricacion_id`) REFERENCES `fabricacion` (`id`),
  CONSTRAINT `FK_65B4329FF2E704D7` FOREIGN KEY (`compra_id`) REFERENCES `compra` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lote`
--

LOCK TABLES `lote` WRITE;
/*!40000 ALTER TABLE `lote` DISABLE KEYS */;
INSERT INTO `lote` VALUES (3,3,1,NULL,'214261',900.00,0.00,0.00,NULL,'2019-04-16 13:44:14'),(4,3,1,NULL,'210989',725.00,0.00,0.00,NULL,'2019-04-16 13:44:14'),(5,3,1,NULL,'212356',75.00,0.00,0.00,NULL,'2019-04-16 13:44:14'),(6,4,2,NULL,'21370414',231.00,28.00,0.00,NULL,'2019-04-16 13:47:57'),(7,4,2,NULL,'21370416',245.00,245.00,0.00,NULL,'2019-04-16 13:47:57'),(8,4,2,NULL,'21370417',7.00,7.00,0.00,NULL,'2019-04-16 13:47:57'),(9,4,2,NULL,'21370418',154.00,154.00,0.00,NULL,'2019-04-16 13:47:57'),(10,4,2,NULL,'21370419',112.00,112.00,0.00,NULL,'2019-04-16 13:47:57'),(11,32,3,NULL,'1806005',451.50,0.00,296.55,NULL,'2019-04-16 14:23:52'),(12,32,3,NULL,'1712208',232.98,84.52,123.46,NULL,'2019-04-16 14:23:52'),(13,33,4,NULL,'1806003',389.00,282.81,16.27,NULL,'2019-04-16 14:25:25'),(14,34,5,NULL,'1806002',39.28,0.00,0.00,NULL,'2019-04-16 14:30:03'),(15,36,5,NULL,'1901212',20.00,0.00,20.00,NULL,'2019-04-16 14:30:03'),(16,37,5,NULL,'1901213',18.15,0.00,0.00,NULL,'2019-04-16 14:30:03'),(17,15,NULL,NULL,'286',800.00,0.00,0.00,NULL,'2019-04-16 14:33:52'),(18,7,NULL,NULL,'277',300.00,0.00,0.00,NULL,'2019-04-16 14:38:19'),(19,7,NULL,NULL,'288',200.00,0.00,0.00,NULL,'2019-04-16 14:39:09'),(20,17,NULL,NULL,'282',500.00,375.00,0.00,NULL,'2019-04-16 14:40:45'),(21,8,NULL,NULL,'276',400.00,200.00,0.00,NULL,'2019-04-16 14:42:23'),(22,11,NULL,NULL,'220',25.00,0.00,0.00,NULL,'2019-04-16 14:43:12'),(23,11,NULL,NULL,'252',125.00,125.00,0.00,NULL,'2019-04-16 14:43:38'),(24,11,NULL,NULL,'287',250.00,250.00,0.00,NULL,'2019-04-16 14:44:11'),(25,9,NULL,NULL,'283',475.00,400.00,0.00,NULL,'2019-04-16 14:45:21'),(26,10,NULL,NULL,'281',500.00,0.00,0.00,NULL,'2019-04-16 14:46:00'),(27,19,NULL,NULL,'278',250.00,0.00,0.00,NULL,'2019-04-16 14:47:00'),(28,19,NULL,NULL,'284',100.00,0.00,0.00,NULL,'2019-04-16 14:47:23'),(29,21,NULL,NULL,'285',1000.00,0.00,0.00,NULL,'2019-04-16 14:48:03'),(30,20,NULL,NULL,'258',225.00,225.00,NULL,NULL,'2019-04-16 14:51:14'),(31,20,NULL,NULL,'267',25.00,25.00,NULL,NULL,'2019-04-16 14:51:53'),(32,20,NULL,NULL,'271',150.00,150.00,NULL,NULL,'2019-04-16 14:52:18'),(33,18,NULL,NULL,'279',200.00,0.00,0.00,NULL,'2019-04-16 14:55:51'),(34,22,NULL,NULL,'273',175.00,75.00,NULL,NULL,'2019-04-16 14:57:58'),(36,5,6,NULL,'OF173343',675.00,0.00,0.00,NULL,'2019-04-16 15:02:48'),(37,6,7,NULL,'OF171235',275.00,275.00,NULL,NULL,'2019-04-16 15:04:15'),(38,28,8,NULL,'20181116',6650.00,5625.00,0.00,NULL,'2019-04-16 15:06:51'),(39,29,9,NULL,'20180112',3500.00,2600.00,0.00,NULL,'2019-04-16 15:08:23'),(40,29,9,NULL,'20181116',3750.00,3750.00,0.00,NULL,'2019-04-16 15:08:23'),(41,23,10,NULL,'D1221',0.00,NULL,NULL,NULL,'2019-04-16 15:10:38'),(42,38,10,NULL,'112327',5.00,0.00,5.00,NULL,'2019-04-16 15:10:38'),(43,40,10,NULL,'D1221',1750.00,903.06,0.00,NULL,'2019-04-23 13:58:14'),(44,23,NULL,1,'L44',100.00,0.00,0.00,NULL,'2019-04-23 14:11:39'),(45,1,11,NULL,'214260',1000.00,0.00,0.00,NULL,'2019-04-30 15:49:25'),(46,1,11,NULL,'215960',1150.00,375.00,0.00,NULL,'2019-04-30 15:49:25'),(47,3,11,NULL,'215751',525.00,0.00,0.00,NULL,'2019-04-30 15:49:25'),(48,3,11,NULL,'215848',4625.00,2050.00,0.00,NULL,'2019-04-30 15:49:25'),(49,2,11,NULL,'214237',1200.00,0.00,0.00,NULL,'2019-04-30 15:49:25'),(50,2,11,NULL,'215867',15600.00,0.00,0.00,NULL,'2019-04-30 15:49:25'),(51,39,12,NULL,'L123/19',2500.00,0.00,460.02,NULL,'2019-05-07 15:32:43'),(52,23,NULL,2,'290',500.00,200.00,0.00,NULL,'2019-05-08 16:08:53'),(53,1,13,NULL,'214260  CARGA REPETIDA',0.00,0.00,0.00,NULL,'2019-05-13 19:56:13'),(54,1,13,NULL,'215960 CARGA REPETIDA',0.00,0.00,0.00,NULL,'2019-05-13 19:56:13'),(59,1,14,NULL,'216365',3000.00,1500.00,0.00,NULL,'2019-05-21 17:31:50'),(60,3,14,NULL,'215848',5500.00,5500.00,0.00,NULL,'2019-05-21 17:31:50'),(61,3,14,NULL,'216366',2500.00,2500.00,0.00,NULL,'2019-05-21 17:31:50'),(62,2,14,NULL,'215867',1200.00,0.00,0.00,NULL,'2019-05-21 17:31:50'),(63,2,14,NULL,'216175',12000.00,7200.00,0.00,NULL,'2019-05-21 17:31:50'),(64,36,15,NULL,'1901219',250.00,225.00,0.00,NULL,'2019-05-21 17:36:56'),(65,34,15,NULL,'1901218',400.00,348.48,22.50,NULL,'2019-05-21 17:36:56'),(66,33,15,NULL,'1901220',600.00,600.00,0.00,NULL,'2019-05-21 17:36:56'),(67,37,15,NULL,'1901222',200.00,173.15,0.00,NULL,'2019-05-21 17:36:56'),(68,32,15,NULL,'1901221',400.00,400.00,0.00,NULL,'2019-05-21 17:36:56'),(69,7,NULL,3,'291',750.00,750.00,0.00,NULL,'2019-05-24 15:27:44'),(70,15,NULL,4,'292',500.00,275.00,0.00,NULL,'2019-05-24 15:27:46'),(71,21,NULL,5,'293',750.00,0.00,0.00,NULL,'2019-05-24 15:27:49'),(72,19,NULL,7,'294',400.00,100.00,0.00,NULL,'2019-05-24 15:27:52'),(73,39,16,NULL,NULL,4000.00,117.90,246.24,NULL,'2019-05-30 18:40:24'),(78,38,17,NULL,'AB112338',4.00,4.00,NULL,NULL,'2019-06-06 19:19:25'),(79,19,NULL,18,'300',500.00,500.00,NULL,NULL,'2019-06-06 19:19:32'),(80,22,NULL,20,'302',200.00,200.00,NULL,NULL,'2019-06-06 19:19:38'),(81,8,NULL,19,'301',250.00,250.00,0.00,NULL,'2019-06-06 19:19:47'),(82,7,NULL,13,'295',250.00,250.00,NULL,NULL,'2019-06-06 19:20:01'),(83,21,NULL,14,'296',1500.00,1500.00,0.00,NULL,'2019-06-06 19:20:04'),(84,15,NULL,15,'297',500.00,500.00,NULL,NULL,'2019-06-06 19:20:07'),(85,10,NULL,17,'299',500.00,400.00,0.00,NULL,'2019-06-11 14:16:27');
/*!40000 ALTER TABLE `lote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lote_asignado`
--

DROP TABLE IF EXISTS `lote_asignado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lote_asignado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lote_id` int(11) NOT NULL,
  `remito_id` int(11) DEFAULT NULL,
  `fabricacion_id` int(11) DEFAULT NULL,
  `cantidad` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9E7DDAADB172197C` (`lote_id`),
  KEY `IDX_9E7DDAAD93DA9FED` (`remito_id`),
  KEY `IDX_9E7DDAAD8C85E1BC` (`fabricacion_id`),
  CONSTRAINT `FK_9E7DDAAD8C85E1BC` FOREIGN KEY (`fabricacion_id`) REFERENCES `fabricacion` (`id`),
  CONSTRAINT `FK_9E7DDAAD93DA9FED` FOREIGN KEY (`remito_id`) REFERENCES `remito` (`id`),
  CONSTRAINT `FK_9E7DDAADB172197C` FOREIGN KEY (`lote_id`) REFERENCES `lote` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lote_asignado`
--

LOCK TABLES `lote_asignado` WRITE;
/*!40000 ALTER TABLE `lote_asignado` DISABLE KEYS */;
INSERT INTO `lote_asignado` VALUES (1,27,1,NULL,150),(2,43,NULL,1,100),(3,44,2,NULL,100),(4,26,2,NULL,100),(5,38,3,NULL,1000),(6,20,4,NULL,25),(7,49,5,NULL,1200),(8,50,5,NULL,8400),(9,6,6,NULL,203),(10,29,7,NULL,500),(11,36,8,NULL,350),(12,43,NULL,2,500),(13,26,9,NULL,100),(14,52,9,NULL,100),(15,3,10,NULL,700),(16,51,NULL,3,717.075),(17,11,NULL,3,9.45),(18,13,NULL,3,23.475),(19,51,NULL,4,440.55),(20,11,NULL,4,30),(21,13,NULL,4,14.05),(22,14,NULL,4,15.4),(23,51,NULL,5,735),(24,16,NULL,5,15),(29,51,NULL,7,368),(30,42,NULL,7,4),(31,13,NULL,7,4),(32,15,NULL,7,20),(33,11,NULL,7,4),(34,45,14,NULL,700),(35,39,15,NULL,500),(36,17,15,NULL,25),(37,3,16,NULL,200),(38,4,16,NULL,725),(39,5,16,NULL,75),(40,47,16,NULL,525),(41,48,16,NULL,2475),(43,45,18,NULL,300),(44,46,18,NULL,1000),(45,29,19,NULL,250),(46,17,19,NULL,250),(47,27,19,NULL,100),(48,28,19,NULL,50),(49,18,19,NULL,250),(50,52,20,NULL,100),(51,26,20,NULL,100),(52,36,21,NULL,100),(53,39,22,NULL,400),(54,17,23,NULL,250),(55,29,23,NULL,250),(56,18,23,NULL,50),(57,19,23,NULL,150),(58,28,23,NULL,50),(59,25,24,NULL,75),(60,72,24,NULL,75),(61,22,24,NULL,25),(62,50,25,NULL,4800),(63,19,27,NULL,50),(64,72,27,NULL,100),(65,52,29,NULL,100),(66,26,29,NULL,100),(67,29,30,NULL,250),(68,71,30,NULL,100),(69,38,31,NULL,25),(72,62,32,NULL,1200),(73,63,32,NULL,3600),(74,63,33,NULL,1200),(75,36,34,NULL,225),(95,48,35,NULL,100),(96,46,36,NULL,125),(97,53,36,NULL,1000),(98,54,36,NULL,375),(99,52,37,NULL,100),(100,26,37,NULL,100),(101,17,38,NULL,275),(102,70,38,NULL,225),(103,51,NULL,13,239.025),(104,11,NULL,13,3.15),(105,13,NULL,13,7.825),(106,51,NULL,14,0.34999999999991),(107,73,NULL,14,1469.65),(108,16,NULL,14,3.15),(109,67,NULL,14,26.85),(110,73,NULL,15,440.55),(111,11,NULL,15,30),(112,13,NULL,15,14.05),(113,14,NULL,15,15.4),(114,73,NULL,16,246.24),(115,11,NULL,16,20.01),(116,13,NULL,16,11.25),(117,65,NULL,16,22.5),(118,73,NULL,17,476.1),(119,11,NULL,17,20),(120,13,NULL,17,3.9),(121,73,NULL,18,460),(122,42,NULL,18,1),(123,13,NULL,18,5),(124,64,NULL,18,25),(125,11,NULL,18,5),(126,73,NULL,19,226.1),(127,11,NULL,19,20),(128,13,NULL,19,3.9),(129,73,NULL,20,153.06),(130,43,NULL,20,46.94),(131,21,40,NULL,200),(132,33,41,NULL,200),(133,52,42,NULL,100),(134,85,42,NULL,100),(135,71,43,NULL,400),(136,11,NULL,21,276.54),(137,12,NULL,21,123.46);
/*!40000 ALTER TABLE `lote_asignado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lote_audit`
--

DROP TABLE IF EXISTS `lote_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lote_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `compra_id` int(11) DEFAULT NULL,
  `fabricacion_id` int(11) DEFAULT NULL,
  `numero` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cantidadInicial` decimal(10,2) DEFAULT NULL,
  `cantidadDisponible` decimal(10,2) DEFAULT NULL,
  `cantidadReservada` decimal(10,2) DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_645c8c9fa07e4d6fd87a70f220544dd5_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lote_audit`
--

LOCK TABLES `lote_audit` WRITE;
/*!40000 ALTER TABLE `lote_audit` DISABLE KEYS */;
INSERT INTO `lote_audit` VALUES (1,81,21,NULL,NULL,NULL,250.00,NULL,NULL,NULL,'2019-04-04 16:13:31','INS'),(1,82,21,NULL,NULL,'L1',250.00,250.00,NULL,NULL,'2019-04-04 16:13:31','UPD'),(1,83,21,NULL,NULL,'L1',250.00,250.00,NULL,NULL,'2019-04-04 16:13:31','DEL'),(2,96,19,NULL,NULL,NULL,350.00,NULL,NULL,NULL,'2019-04-04 17:23:59','INS'),(2,97,19,NULL,NULL,'L2',350.00,350.00,NULL,NULL,'2019-04-04 17:23:59','UPD'),(2,98,19,NULL,NULL,'L278',350.00,350.00,NULL,NULL,'2019-04-04 17:23:59','UPD'),(2,99,19,NULL,NULL,'L278',350.00,350.00,NULL,NULL,'2019-04-04 17:23:59','DEL'),(3,112,3,1,NULL,'214261',900.00,NULL,NULL,NULL,'2019-04-16 13:44:14','INS'),(3,113,3,1,NULL,'214261',900.00,900.00,NULL,NULL,'2019-04-16 13:44:14','UPD'),(3,266,3,1,NULL,'214261',900.00,200.00,700.00,NULL,'2019-04-16 13:44:14','UPD'),(3,291,3,1,NULL,'214261',900.00,0.00,900.00,NULL,'2019-04-16 13:44:14','UPD'),(3,299,3,1,NULL,'214261',900.00,0.00,200.00,NULL,'2019-04-16 13:44:14','UPD'),(3,402,3,1,NULL,'214261',900.00,0.00,0.00,NULL,'2019-04-16 13:44:14','UPD'),(4,112,3,1,NULL,'210989',725.00,NULL,NULL,NULL,'2019-04-16 13:44:14','INS'),(4,113,3,1,NULL,'210989',725.00,725.00,NULL,NULL,'2019-04-16 13:44:14','UPD'),(4,266,3,1,NULL,'210989',725.00,725.00,0.00,NULL,'2019-04-16 13:44:14','UPD'),(4,291,3,1,NULL,'210989',725.00,0.00,725.00,NULL,'2019-04-16 13:44:14','UPD'),(4,402,3,1,NULL,'210989',725.00,0.00,0.00,NULL,'2019-04-16 13:44:14','UPD'),(5,112,3,1,NULL,'212356',75.00,NULL,NULL,NULL,'2019-04-16 13:44:14','INS'),(5,113,3,1,NULL,'212356',75.00,75.00,NULL,NULL,'2019-04-16 13:44:14','UPD'),(5,266,3,1,NULL,'212356',75.00,75.00,0.00,NULL,'2019-04-16 13:44:14','UPD'),(5,291,3,1,NULL,'212356',75.00,0.00,75.00,NULL,'2019-04-16 13:44:14','UPD'),(5,402,3,1,NULL,'212356',75.00,0.00,0.00,NULL,'2019-04-16 13:44:14','UPD'),(6,114,4,2,NULL,'21370414',231.00,NULL,NULL,NULL,'2019-04-16 13:47:57','INS'),(6,115,4,2,NULL,'21370414',231.00,231.00,NULL,NULL,'2019-04-16 13:47:57','UPD'),(6,237,4,2,NULL,'21370414',231.00,28.00,203.00,NULL,'2019-04-16 13:47:57','UPD'),(6,252,4,2,NULL,'21370414',231.00,28.00,0.00,NULL,'2019-04-16 13:47:57','UPD'),(7,114,4,2,NULL,'21370416',245.00,NULL,NULL,NULL,'2019-04-16 13:47:57','INS'),(7,115,4,2,NULL,'21370416',245.00,245.00,NULL,NULL,'2019-04-16 13:47:57','UPD'),(7,237,4,2,NULL,'21370416',245.00,245.00,0.00,NULL,'2019-04-16 13:47:57','UPD'),(8,114,4,2,NULL,'21370417',7.00,NULL,NULL,NULL,'2019-04-16 13:47:57','INS'),(8,115,4,2,NULL,'21370417',7.00,7.00,NULL,NULL,'2019-04-16 13:47:57','UPD'),(8,237,4,2,NULL,'21370417',7.00,7.00,0.00,NULL,'2019-04-16 13:47:57','UPD'),(9,114,4,2,NULL,'21370418',154.00,NULL,NULL,NULL,'2019-04-16 13:47:57','INS'),(9,115,4,2,NULL,'21370418',154.00,154.00,NULL,NULL,'2019-04-16 13:47:57','UPD'),(9,237,4,2,NULL,'21370418',154.00,154.00,0.00,NULL,'2019-04-16 13:47:57','UPD'),(10,114,4,2,NULL,'21370419',112.00,NULL,NULL,NULL,'2019-04-16 13:47:57','INS'),(10,115,4,2,NULL,'21370419',112.00,112.00,NULL,NULL,'2019-04-16 13:47:57','UPD'),(10,237,4,2,NULL,'21370419',112.00,112.00,0.00,NULL,'2019-04-16 13:47:57','UPD'),(11,116,32,3,NULL,'1806005',451.50,NULL,NULL,NULL,'2019-04-16 14:23:52','INS'),(11,117,32,3,NULL,'1806005',451.50,451.50,NULL,NULL,'2019-04-16 14:23:52','UPD'),(11,271,32,3,NULL,'1806005',451.50,442.05,9.45,NULL,'2019-04-16 14:23:52','UPD'),(11,272,32,3,NULL,'1806005',451.50,412.05,39.45,NULL,'2019-04-16 14:23:52','UPD'),(11,283,32,3,NULL,'1806005',451.50,408.05,43.45,NULL,'2019-04-16 14:23:52','UPD'),(11,333,32,3,NULL,'1806005',451.50,408.05,34.00,NULL,'2019-04-16 14:23:52','UPD'),(11,336,32,3,NULL,'1806005',451.50,408.05,4.00,NULL,'2019-04-16 14:23:52','UPD'),(11,342,32,3,NULL,'1806005',451.50,408.05,0.00,NULL,'2019-04-16 14:23:52','UPD'),(11,389,32,3,NULL,'1806005',451.50,401.75,6.30,NULL,'2019-04-16 14:23:52','UPD'),(11,394,32,3,NULL,'1806005',451.50,371.75,36.30,NULL,'2019-04-16 14:23:52','UPD'),(11,395,32,3,NULL,'1806005',451.50,338.40,69.65,NULL,'2019-04-16 14:23:52','UPD'),(11,396,32,3,NULL,'1806005',451.50,305.05,103.00,NULL,'2019-04-16 14:23:52','UPD'),(11,416,32,3,NULL,'1806005',451.50,305.05,96.70,NULL,'2019-04-16 14:23:52','UPD'),(11,422,32,3,NULL,'1806005',451.50,305.05,66.70,NULL,'2019-04-16 14:23:52','UPD'),(11,428,32,3,NULL,'1806005',451.50,305.05,33.35,NULL,'2019-04-16 14:23:52','UPD'),(11,434,32,3,NULL,'1806005',451.50,311.35,33.35,NULL,'2019-04-16 14:23:52','UPD'),(11,444,32,3,NULL,'1806005',451.50,341.35,33.35,NULL,'2019-04-16 14:23:52','UPD'),(11,450,32,3,NULL,'1806005',451.50,341.35,0.00,NULL,'2019-04-16 14:23:52','UPD'),(11,456,32,3,NULL,'1806005',451.50,374.70,0.00,NULL,'2019-04-16 14:23:52','UPD'),(11,467,32,3,NULL,'1806005',451.50,371.55,3.15,NULL,'2019-04-16 14:23:52','UPD'),(11,469,32,3,NULL,'1806005',451.50,341.55,33.15,NULL,'2019-04-16 14:23:52','UPD'),(11,470,32,3,NULL,'1806005',451.50,321.54,53.16,NULL,'2019-04-16 14:23:52','UPD'),(11,471,32,3,NULL,'1806005',451.50,301.54,73.16,NULL,'2019-04-16 14:23:52','UPD'),(11,472,32,3,NULL,'1806005',451.50,296.54,78.16,NULL,'2019-04-16 14:23:52','UPD'),(11,473,32,3,NULL,'1806005',451.50,276.54,98.16,NULL,'2019-04-16 14:23:52','UPD'),(11,481,32,3,NULL,'1806005',451.50,276.54,93.16,NULL,'2019-04-16 14:23:52','UPD'),(11,487,32,3,NULL,'1806005',451.50,276.54,73.16,NULL,'2019-04-16 14:23:52','UPD'),(11,490,32,3,NULL,'1806005',451.50,276.54,70.01,NULL,'2019-04-16 14:23:52','UPD'),(11,496,32,3,NULL,'1806005',451.50,276.54,40.01,NULL,'2019-04-16 14:23:52','UPD'),(11,542,32,3,NULL,'1806005',451.50,276.54,20.01,NULL,'2019-04-16 14:23:52','UPD'),(11,556,32,3,NULL,'1806005',451.50,0.00,296.55,NULL,'2019-04-16 14:23:52','UPD'),(12,116,32,3,NULL,'1712208',232.98,NULL,NULL,NULL,'2019-04-16 14:23:52','INS'),(12,117,32,3,NULL,'1712208',232.98,232.98,NULL,NULL,'2019-04-16 14:23:52','UPD'),(12,271,32,3,NULL,'1712208',232.98,232.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,272,32,3,NULL,'1712208',232.98,232.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,283,32,3,NULL,'1712208',232.98,232.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,389,32,3,NULL,'1712208',232.98,232.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,394,32,3,NULL,'1712208',232.98,232.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,395,32,3,NULL,'1712208',232.98,232.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,396,32,3,NULL,'1712208',232.98,232.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,467,32,3,NULL,'1712208',232.98,232.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,469,32,3,NULL,'1712208',232.98,232.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,470,32,3,NULL,'1712208',232.98,232.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,471,32,3,NULL,'1712208',232.98,232.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,472,32,3,NULL,'1712208',232.98,232.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,473,32,3,NULL,'1712208',232.98,232.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,530,32,3,NULL,'1712208',232.98,207.98,0.00,NULL,'2019-04-16 14:23:52','UPD'),(12,556,32,3,NULL,'1712208',232.98,84.52,123.46,NULL,'2019-04-16 14:23:52','UPD'),(13,118,33,4,NULL,'1806003',389.00,NULL,NULL,NULL,'2019-04-16 14:25:25','INS'),(13,119,33,4,NULL,'1806003',389.00,389.00,NULL,NULL,'2019-04-16 14:25:25','UPD'),(13,271,33,4,NULL,'1806003',389.00,365.53,23.48,NULL,'2019-04-16 14:25:25','UPD'),(13,272,33,4,NULL,'1806003',389.00,351.48,37.53,NULL,'2019-04-16 14:25:25','UPD'),(13,274,33,4,NULL,'1806003',389.00,346.48,42.53,NULL,'2019-04-16 14:25:25','UPD'),(13,281,33,4,NULL,'1806003',389.00,351.48,42.53,NULL,'2019-04-16 14:25:25','UPD'),(13,283,33,4,NULL,'1806003',389.00,347.48,46.53,NULL,'2019-04-16 14:25:25','UPD'),(13,333,33,4,NULL,'1806003',389.00,347.48,23.06,NULL,'2019-04-16 14:25:25','UPD'),(13,336,33,4,NULL,'1806003',389.00,347.48,9.01,NULL,'2019-04-16 14:25:25','UPD'),(13,342,33,4,NULL,'1806003',389.00,347.48,5.01,NULL,'2019-04-16 14:25:25','UPD'),(13,389,33,4,NULL,'1806003',389.00,331.83,20.66,NULL,'2019-04-16 14:25:25','UPD'),(13,394,33,4,NULL,'1806003',389.00,317.78,34.71,NULL,'2019-04-16 14:25:25','UPD'),(13,395,33,4,NULL,'1806003',389.00,299.03,53.46,NULL,'2019-04-16 14:25:25','UPD'),(13,396,33,4,NULL,'1806003',389.00,280.28,72.21,NULL,'2019-04-16 14:25:25','UPD'),(13,416,33,4,NULL,'1806003',389.00,280.28,56.56,NULL,'2019-04-16 14:25:25','UPD'),(13,422,33,4,NULL,'1806003',389.00,280.28,42.51,NULL,'2019-04-16 14:25:25','UPD'),(13,428,33,4,NULL,'1806003',389.00,280.28,23.76,NULL,'2019-04-16 14:25:25','UPD'),(13,435,33,4,NULL,'1806003',389.00,295.93,23.76,NULL,'2019-04-16 14:25:25','UPD'),(13,445,33,4,NULL,'1806003',389.00,309.98,23.76,NULL,'2019-04-16 14:25:25','UPD'),(13,451,33,4,NULL,'1806003',389.00,309.98,5.01,NULL,'2019-04-16 14:25:25','UPD'),(13,457,33,4,NULL,'1806003',389.00,328.73,5.01,NULL,'2019-04-16 14:25:25','UPD'),(13,467,33,4,NULL,'1806003',389.00,320.91,12.84,NULL,'2019-04-16 14:25:25','UPD'),(13,469,33,4,NULL,'1806003',389.00,306.86,26.89,NULL,'2019-04-16 14:25:25','UPD'),(13,470,33,4,NULL,'1806003',389.00,295.61,38.14,NULL,'2019-04-16 14:25:25','UPD'),(13,471,33,4,NULL,'1806003',389.00,291.71,42.04,NULL,'2019-04-16 14:25:25','UPD'),(13,472,33,4,NULL,'1806003',389.00,286.71,47.04,NULL,'2019-04-16 14:25:25','UPD'),(13,473,33,4,NULL,'1806003',389.00,282.81,50.94,NULL,'2019-04-16 14:25:25','UPD'),(13,481,33,4,NULL,'1806003',389.00,282.81,45.94,NULL,'2019-04-16 14:25:25','UPD'),(13,487,33,4,NULL,'1806003',389.00,282.81,42.04,NULL,'2019-04-16 14:25:25','UPD'),(13,490,33,4,NULL,'1806003',389.00,282.81,34.22,NULL,'2019-04-16 14:25:25','UPD'),(13,496,33,4,NULL,'1806003',389.00,282.81,20.17,NULL,'2019-04-16 14:25:25','UPD'),(13,542,33,4,NULL,'1806003',389.00,282.81,16.27,NULL,'2019-04-16 14:25:25','UPD'),(14,120,34,5,NULL,'1806002',39.28,NULL,NULL,NULL,'2019-04-16 14:30:03','INS'),(14,121,34,5,NULL,'1806002',39.28,39.28,NULL,NULL,'2019-04-16 14:30:03','UPD'),(14,272,34,5,NULL,'1806002',39.28,23.88,15.40,NULL,'2019-04-16 14:30:03','UPD'),(14,336,34,5,NULL,'1806002',39.28,23.88,0.00,NULL,'2019-04-16 14:30:03','UPD'),(14,394,34,5,NULL,'1806002',39.28,8.48,15.40,NULL,'2019-04-16 14:30:03','UPD'),(14,395,34,5,NULL,'1806002',39.28,0.00,23.88,NULL,'2019-04-16 14:30:03','UPD'),(14,422,34,5,NULL,'1806002',39.28,0.00,8.48,NULL,'2019-04-16 14:30:03','UPD'),(14,446,34,5,NULL,'1806002',39.28,15.40,8.48,NULL,'2019-04-16 14:30:03','UPD'),(14,452,34,5,NULL,'1806002',39.28,15.40,0.00,NULL,'2019-04-16 14:30:03','UPD'),(14,469,34,5,NULL,'1806002',39.28,0.00,15.40,NULL,'2019-04-16 14:30:03','UPD'),(14,496,34,5,NULL,'1806002',39.28,0.00,0.00,NULL,'2019-04-16 14:30:03','UPD'),(15,120,36,5,NULL,NULL,20.00,NULL,NULL,NULL,'2019-04-16 14:30:03','INS'),(15,121,36,5,NULL,NULL,20.00,20.00,NULL,NULL,'2019-04-16 14:30:03','UPD'),(15,122,36,5,NULL,'1901212',20.00,20.00,NULL,NULL,'2019-04-16 14:30:03','UPD'),(15,123,36,5,NULL,'1901212',20.00,20.00,NULL,NULL,'2019-04-16 14:30:03','UPD'),(15,274,36,5,NULL,'1901212',20.00,0.00,20.00,NULL,'2019-04-16 14:30:03','UPD'),(15,282,36,5,NULL,'1901212',20.00,20.00,20.00,NULL,'2019-04-16 14:30:03','UPD'),(15,283,36,5,NULL,'1901212',20.00,0.00,40.00,NULL,'2019-04-16 14:30:03','UPD'),(15,342,36,5,NULL,'1901212',20.00,0.00,20.00,NULL,'2019-04-16 14:30:03','UPD'),(16,120,37,5,NULL,'1901213',18.15,NULL,NULL,NULL,'2019-04-16 14:30:03','INS'),(16,121,37,5,NULL,'1901213',18.15,18.15,NULL,NULL,'2019-04-16 14:30:03','UPD'),(16,273,37,5,NULL,'1901213',18.15,3.15,15.00,NULL,'2019-04-16 14:30:03','UPD'),(16,339,37,5,NULL,'1901213',18.15,3.15,0.00,NULL,'2019-04-16 14:30:03','UPD'),(16,393,37,5,NULL,'1901213',18.15,0.00,3.15,NULL,'2019-04-16 14:30:03','UPD'),(16,419,37,5,NULL,'1901213',18.15,0.00,0.00,NULL,'2019-04-16 14:30:03','UPD'),(16,439,37,5,NULL,'1901213',18.15,3.15,0.00,NULL,'2019-04-16 14:30:03','UPD'),(16,468,37,5,NULL,'1901213',18.15,0.00,3.15,NULL,'2019-04-16 14:30:03','UPD'),(16,493,37,5,NULL,'1901213',18.15,0.00,0.00,NULL,'2019-04-16 14:30:03','UPD'),(17,124,15,NULL,NULL,NULL,800.00,NULL,NULL,NULL,'2019-04-16 14:33:52','INS'),(17,125,15,NULL,NULL,'L17',800.00,800.00,NULL,NULL,'2019-04-16 14:33:52','UPD'),(17,126,15,NULL,NULL,'L286',800.00,800.00,NULL,NULL,'2019-04-16 14:33:52','UPD'),(17,290,15,NULL,NULL,'L286',800.00,775.00,25.00,NULL,'2019-04-16 14:33:52','UPD'),(17,297,15,NULL,NULL,'L286',800.00,525.00,275.00,NULL,'2019-04-16 14:33:52','UPD'),(17,300,15,NULL,NULL,'L286',800.00,525.00,25.00,NULL,'2019-04-16 14:33:52','UPD'),(17,305,15,NULL,NULL,'L286',800.00,525.00,0.00,NULL,'2019-04-16 14:33:52','UPD'),(17,319,15,NULL,NULL,'L286',800.00,275.00,250.00,NULL,'2019-04-16 14:33:52','UPD'),(17,330,15,NULL,NULL,'L286',800.00,275.00,0.00,NULL,'2019-04-16 14:33:52','UPD'),(17,382,15,NULL,NULL,'286',800.00,275.00,0.00,NULL,'2019-04-16 14:33:52','UPD'),(17,463,15,NULL,NULL,'286',800.00,0.00,275.00,NULL,'2019-04-16 14:33:52','UPD'),(17,536,15,NULL,NULL,'286',800.00,0.00,0.00,NULL,'2019-04-16 14:33:52','UPD'),(18,127,7,NULL,NULL,NULL,300.00,NULL,NULL,NULL,'2019-04-16 14:38:19','INS'),(18,128,7,NULL,NULL,'L18',300.00,300.00,NULL,NULL,'2019-04-16 14:38:19','UPD'),(18,129,7,NULL,NULL,'L277',300.00,300.00,NULL,NULL,'2019-04-16 14:38:19','UPD'),(18,297,7,NULL,NULL,'L277',300.00,50.00,250.00,NULL,'2019-04-16 14:38:19','UPD'),(18,300,7,NULL,NULL,'L277',300.00,50.00,0.00,NULL,'2019-04-16 14:38:19','UPD'),(18,319,7,NULL,NULL,'L277',300.00,0.00,50.00,NULL,'2019-04-16 14:38:19','UPD'),(18,330,7,NULL,NULL,'L277',300.00,0.00,0.00,NULL,'2019-04-16 14:38:19','UPD'),(18,506,7,NULL,NULL,'277',300.00,0.00,0.00,NULL,'2019-04-16 14:38:19','UPD'),(19,130,7,NULL,NULL,NULL,200.00,NULL,NULL,NULL,'2019-04-16 14:39:09','INS'),(19,131,7,NULL,NULL,'L19',200.00,200.00,NULL,NULL,'2019-04-16 14:39:09','UPD'),(19,132,7,NULL,NULL,'L288',200.00,200.00,NULL,NULL,'2019-04-16 14:39:09','UPD'),(19,297,7,NULL,NULL,'L288',200.00,200.00,0.00,NULL,'2019-04-16 14:39:09','UPD'),(19,319,7,NULL,NULL,'L288',200.00,50.00,150.00,NULL,'2019-04-16 14:39:09','UPD'),(19,330,7,NULL,NULL,'L288',200.00,50.00,0.00,NULL,'2019-04-16 14:39:09','UPD'),(19,359,7,NULL,NULL,'L288',200.00,0.00,50.00,NULL,'2019-04-16 14:39:09','UPD'),(19,398,7,NULL,NULL,'L288',200.00,0.00,0.00,NULL,'2019-04-16 14:39:09','UPD'),(19,507,7,NULL,NULL,'288',200.00,0.00,0.00,NULL,'2019-04-16 14:39:09','UPD'),(20,133,17,NULL,NULL,NULL,500.00,NULL,NULL,NULL,'2019-04-16 14:40:45','INS'),(20,134,17,NULL,NULL,'L20',500.00,500.00,NULL,NULL,'2019-04-16 14:40:45','UPD'),(20,135,17,NULL,NULL,'L281',500.00,500.00,NULL,NULL,'2019-04-16 14:40:45','UPD'),(20,136,17,NULL,NULL,'L282',500.00,500.00,NULL,NULL,'2019-04-16 14:40:45','UPD'),(20,215,17,NULL,NULL,'L282',475.00,500.00,NULL,NULL,'2019-04-16 14:40:45','UPD'),(20,217,17,NULL,NULL,'L282',500.00,475.00,NULL,NULL,'2019-04-16 14:40:45','UPD'),(20,228,17,NULL,NULL,'L282',500.00,450.00,25.00,NULL,'2019-04-16 14:40:45','UPD'),(20,231,17,NULL,NULL,'L282',500.00,450.00,0.00,NULL,'2019-04-16 14:40:45','UPD'),(20,326,17,NULL,NULL,'L282',500.00,425.00,0.00,NULL,'2019-04-16 14:40:45','UPD'),(20,475,17,NULL,NULL,'L282',500.00,375.00,0.00,NULL,'2019-04-16 14:40:45','UPD'),(20,508,17,NULL,NULL,'282',500.00,375.00,0.00,NULL,'2019-04-16 14:40:45','UPD'),(21,137,8,NULL,NULL,NULL,400.00,NULL,NULL,NULL,'2019-04-16 14:42:23','INS'),(21,138,8,NULL,NULL,'L21',400.00,400.00,NULL,NULL,'2019-04-16 14:42:23','UPD'),(21,139,8,NULL,NULL,'L276',400.00,400.00,NULL,NULL,'2019-04-16 14:42:23','UPD'),(21,505,8,NULL,NULL,'L276',400.00,200.00,200.00,NULL,'2019-04-16 14:42:23','UPD'),(21,509,8,NULL,NULL,'276',400.00,200.00,200.00,NULL,'2019-04-16 14:42:23','UPD'),(21,561,8,NULL,NULL,'276',400.00,200.00,0.00,NULL,'2019-04-16 14:42:23','UPD'),(22,140,11,NULL,NULL,NULL,25.00,NULL,NULL,220.00,'2019-04-16 14:43:12','INS'),(22,141,11,NULL,NULL,'L22',25.00,25.00,NULL,220.00,'2019-04-16 14:43:12','UPD'),(22,142,11,NULL,NULL,'L220',25.00,25.00,NULL,NULL,'2019-04-16 14:43:12','UPD'),(22,351,11,NULL,NULL,'L220',25.00,0.00,25.00,NULL,'2019-04-16 14:43:12','UPD'),(22,405,11,NULL,NULL,'L220',25.00,0.00,0.00,NULL,'2019-04-16 14:43:12','UPD'),(22,510,11,NULL,NULL,'220',25.00,0.00,0.00,NULL,'2019-04-16 14:43:12','UPD'),(23,143,11,NULL,NULL,NULL,125.00,NULL,NULL,NULL,'2019-04-16 14:43:38','INS'),(23,144,11,NULL,NULL,'L23',125.00,125.00,NULL,NULL,'2019-04-16 14:43:38','UPD'),(23,145,11,NULL,NULL,'L252',125.00,125.00,NULL,NULL,'2019-04-16 14:43:38','UPD'),(23,351,11,NULL,NULL,'L252',125.00,125.00,0.00,NULL,'2019-04-16 14:43:38','UPD'),(23,511,11,NULL,NULL,'252',125.00,125.00,0.00,NULL,'2019-04-16 14:43:38','UPD'),(24,146,11,NULL,NULL,NULL,250.00,NULL,NULL,NULL,'2019-04-16 14:44:11','INS'),(24,147,11,NULL,NULL,'L24',250.00,250.00,NULL,NULL,'2019-04-16 14:44:11','UPD'),(24,148,11,NULL,NULL,'L287',250.00,250.00,NULL,NULL,'2019-04-16 14:44:11','UPD'),(24,351,11,NULL,NULL,'L287',250.00,250.00,0.00,NULL,'2019-04-16 14:44:11','UPD'),(24,512,11,NULL,NULL,'287',250.00,250.00,0.00,NULL,'2019-04-16 14:44:11','UPD'),(25,149,9,NULL,NULL,NULL,500.00,NULL,NULL,NULL,'2019-04-16 14:45:21','INS'),(25,150,9,NULL,NULL,'L25',500.00,500.00,NULL,NULL,'2019-04-16 14:45:21','UPD'),(25,151,9,NULL,NULL,'L283',500.00,500.00,NULL,NULL,'2019-04-16 14:45:21','UPD'),(25,222,9,NULL,NULL,'L283',475.00,475.00,NULL,NULL,'2019-04-16 14:45:21','UPD'),(25,351,9,NULL,NULL,'L283',475.00,400.00,75.00,NULL,'2019-04-16 14:45:21','UPD'),(25,405,9,NULL,NULL,'L283',475.00,400.00,0.00,NULL,'2019-04-16 14:45:21','UPD'),(25,513,9,NULL,NULL,'283',475.00,400.00,0.00,NULL,'2019-04-16 14:45:21','UPD'),(26,152,10,NULL,NULL,NULL,500.00,NULL,NULL,NULL,'2019-04-16 14:46:00','INS'),(26,153,10,NULL,NULL,'L26',500.00,500.00,NULL,NULL,'2019-04-16 14:46:00','UPD'),(26,154,10,NULL,NULL,'L281',500.00,500.00,NULL,NULL,'2019-04-16 14:46:00','UPD'),(26,212,10,NULL,NULL,'L281',500.00,400.00,100.00,NULL,'2019-04-16 14:46:00','UPD'),(26,226,10,NULL,NULL,'L281',500.00,400.00,0.00,NULL,'2019-04-16 14:46:00','UPD'),(26,263,10,NULL,NULL,'L281',500.00,300.00,100.00,NULL,'2019-04-16 14:46:00','UPD'),(26,285,10,NULL,NULL,'L281',500.00,300.00,0.00,NULL,'2019-04-16 14:46:00','UPD'),(26,301,10,NULL,NULL,'L281',500.00,200.00,100.00,NULL,'2019-04-16 14:46:00','UPD'),(26,304,10,NULL,NULL,'L281',500.00,200.00,0.00,NULL,'2019-04-16 14:46:00','UPD'),(26,366,10,NULL,NULL,'L281',500.00,100.00,100.00,NULL,'2019-04-16 14:46:00','UPD'),(26,397,10,NULL,NULL,'L281',500.00,100.00,0.00,NULL,'2019-04-16 14:46:00','UPD'),(26,410,10,NULL,NULL,'L281',500.00,0.00,100.00,NULL,'2019-04-16 14:46:00','UPD'),(26,465,10,NULL,NULL,'L281',500.00,0.00,0.00,NULL,'2019-04-16 14:46:00','UPD'),(26,514,10,NULL,NULL,'281',500.00,0.00,0.00,NULL,'2019-04-16 14:46:00','UPD'),(27,155,19,NULL,NULL,NULL,350.00,NULL,NULL,NULL,'2019-04-16 14:47:00','INS'),(27,156,19,NULL,NULL,'L27',350.00,350.00,NULL,NULL,'2019-04-16 14:47:00','UPD'),(27,157,19,NULL,NULL,'L278',350.00,350.00,NULL,NULL,'2019-04-16 14:47:00','UPD'),(27,202,19,NULL,NULL,'L278',350.00,200.00,150.00,NULL,'2019-04-16 14:47:00','UPD'),(27,221,19,NULL,NULL,'L278',250.00,100.00,150.00,NULL,'2019-04-16 14:47:00','UPD'),(27,224,19,NULL,NULL,'L278',250.00,100.00,0.00,NULL,'2019-04-16 14:47:00','UPD'),(27,297,19,NULL,NULL,'L278',250.00,0.00,100.00,NULL,'2019-04-16 14:47:00','UPD'),(27,300,19,NULL,NULL,'L278',250.00,0.00,0.00,NULL,'2019-04-16 14:47:00','UPD'),(27,515,19,NULL,NULL,'278',250.00,0.00,0.00,NULL,'2019-04-16 14:47:00','UPD'),(28,158,19,NULL,NULL,NULL,100.00,NULL,NULL,NULL,'2019-04-16 14:47:23','INS'),(28,159,19,NULL,NULL,'L28',100.00,100.00,NULL,NULL,'2019-04-16 14:47:23','UPD'),(28,160,19,NULL,NULL,'L284',100.00,100.00,NULL,NULL,'2019-04-16 14:47:23','UPD'),(28,202,19,NULL,NULL,'L284',100.00,100.00,0.00,NULL,'2019-04-16 14:47:23','UPD'),(28,297,19,NULL,NULL,'L284',100.00,50.00,50.00,NULL,'2019-04-16 14:47:23','UPD'),(28,300,19,NULL,NULL,'L284',100.00,50.00,0.00,NULL,'2019-04-16 14:47:23','UPD'),(28,319,19,NULL,NULL,'L284',100.00,0.00,50.00,NULL,'2019-04-16 14:47:23','UPD'),(28,330,19,NULL,NULL,'L284',100.00,0.00,0.00,NULL,'2019-04-16 14:47:23','UPD'),(28,384,19,NULL,NULL,'284',100.00,0.00,0.00,NULL,'2019-04-16 14:47:23','UPD'),(29,161,21,NULL,NULL,NULL,1250.00,NULL,NULL,NULL,'2019-04-16 14:48:03','INS'),(29,162,21,NULL,NULL,'L29',1250.00,1250.00,NULL,NULL,'2019-04-16 14:48:03','UPD'),(29,163,21,NULL,NULL,'L285',1250.00,1250.00,NULL,NULL,'2019-04-16 14:48:03','UPD'),(29,164,21,NULL,NULL,'L285',1000.00,1250.00,NULL,NULL,'2019-04-16 14:48:03','UPD'),(29,243,21,NULL,NULL,'L285',1000.00,750.00,500.00,NULL,'2019-04-16 14:48:03','UPD'),(29,251,21,NULL,NULL,'L285',1000.00,750.00,0.00,NULL,'2019-04-16 14:48:03','UPD'),(29,297,21,NULL,NULL,'L285',1000.00,500.00,250.00,NULL,'2019-04-16 14:48:03','UPD'),(29,300,21,NULL,NULL,'L285',1000.00,500.00,0.00,NULL,'2019-04-16 14:48:03','UPD'),(29,319,21,NULL,NULL,'L285',1000.00,250.00,250.00,NULL,'2019-04-16 14:48:03','UPD'),(29,330,21,NULL,NULL,'L285',1000.00,250.00,0.00,NULL,'2019-04-16 14:48:03','UPD'),(29,367,21,NULL,NULL,'L285',1000.00,0.00,250.00,NULL,'2019-04-16 14:48:03','UPD'),(29,399,21,NULL,NULL,'L285',1000.00,0.00,0.00,NULL,'2019-04-16 14:48:03','UPD'),(29,516,21,NULL,NULL,'285',1000.00,0.00,0.00,NULL,'2019-04-16 14:48:03','UPD'),(30,165,20,NULL,NULL,NULL,225.00,NULL,NULL,NULL,'2019-04-16 14:51:14','INS'),(30,166,20,NULL,NULL,'L30',225.00,225.00,NULL,NULL,'2019-04-16 14:51:14','UPD'),(30,167,20,NULL,NULL,'L258',225.00,225.00,NULL,NULL,'2019-04-16 14:51:14','UPD'),(30,517,20,NULL,NULL,'258',225.00,225.00,NULL,NULL,'2019-04-16 14:51:14','UPD'),(31,168,20,NULL,NULL,NULL,25.00,NULL,NULL,NULL,'2019-04-16 14:51:53','INS'),(31,169,20,NULL,NULL,'L31',25.00,25.00,NULL,NULL,'2019-04-16 14:51:53','UPD'),(31,170,20,NULL,NULL,'L267',25.00,25.00,NULL,NULL,'2019-04-16 14:51:53','UPD'),(31,518,20,NULL,NULL,'267',25.00,25.00,NULL,NULL,'2019-04-16 14:51:53','UPD'),(32,171,20,NULL,NULL,NULL,150.00,NULL,NULL,NULL,'2019-04-16 14:52:18','INS'),(32,172,20,NULL,NULL,'L32',150.00,150.00,NULL,NULL,'2019-04-16 14:52:18','UPD'),(32,173,20,NULL,NULL,'L271',150.00,150.00,NULL,NULL,'2019-04-16 14:52:18','UPD'),(32,519,20,NULL,NULL,'271',150.00,150.00,NULL,NULL,'2019-04-16 14:52:18','UPD'),(33,174,18,NULL,NULL,NULL,175.00,NULL,NULL,NULL,'2019-04-16 14:55:51','INS'),(33,175,18,NULL,NULL,'L33',175.00,175.00,NULL,NULL,'2019-04-16 14:55:51','UPD'),(33,176,18,NULL,NULL,'L279',175.00,175.00,NULL,NULL,'2019-04-16 14:55:51','UPD'),(33,520,18,NULL,NULL,'279',175.00,175.00,NULL,NULL,'2019-04-16 14:55:51','UPD'),(33,529,18,NULL,NULL,'279',200.00,200.00,NULL,NULL,'2019-04-16 14:55:51','UPD'),(33,533,18,NULL,NULL,'279',200.00,0.00,200.00,NULL,'2019-04-16 14:55:51','UPD'),(33,558,18,NULL,NULL,'279',200.00,0.00,0.00,NULL,'2019-04-16 14:55:51','UPD'),(34,177,22,NULL,NULL,NULL,175.00,NULL,NULL,NULL,'2019-04-16 14:57:58','INS'),(34,178,22,NULL,NULL,'L34',175.00,175.00,NULL,NULL,'2019-04-16 14:57:58','UPD'),(34,179,22,NULL,NULL,'L273',175.00,175.00,NULL,NULL,'2019-04-16 14:57:58','UPD'),(34,216,22,NULL,NULL,'L273',175.00,150.00,NULL,NULL,'2019-04-16 14:57:58','UPD'),(34,327,22,NULL,NULL,'L273',175.00,125.00,NULL,NULL,'2019-04-16 14:57:58','UPD'),(34,430,22,NULL,NULL,'273',175.00,125.00,NULL,NULL,'2019-04-16 14:57:58','UPD'),(34,476,22,NULL,NULL,'273',175.00,75.00,NULL,NULL,'2019-04-16 14:57:58','UPD'),(35,180,28,NULL,NULL,NULL,6650.00,NULL,NULL,NULL,'2019-04-16 15:00:03','INS'),(35,181,28,NULL,NULL,'L35',6650.00,6650.00,NULL,NULL,'2019-04-16 15:00:03','UPD'),(35,182,28,NULL,NULL,'L20181116',6650.00,6650.00,NULL,NULL,'2019-04-16 15:00:03','UPD'),(35,183,28,NULL,NULL,'L20181116',6650.00,6650.00,NULL,NULL,'2019-04-16 15:00:03','DEL'),(36,184,5,6,NULL,NULL,675.00,NULL,NULL,NULL,'2019-04-16 15:02:48','INS'),(36,185,5,6,NULL,NULL,675.00,675.00,NULL,NULL,'2019-04-16 15:02:48','UPD'),(36,187,5,6,NULL,'OF173345',675.00,675.00,NULL,NULL,'2019-04-16 15:02:48','UPD'),(36,250,5,6,NULL,'OF173345',675.00,325.00,350.00,NULL,'2019-04-16 15:02:48','UPD'),(36,254,5,6,NULL,'OF173345',675.00,325.00,0.00,NULL,'2019-04-16 15:02:48','UPD'),(36,315,5,6,NULL,'OF173345',675.00,225.00,100.00,NULL,'2019-04-16 15:02:48','UPD'),(36,316,5,6,NULL,'OF173343',675.00,225.00,100.00,NULL,'2019-04-16 15:02:48','UPD'),(36,329,5,6,NULL,'OF173343',675.00,225.00,0.00,NULL,'2019-04-16 15:02:48','UPD'),(36,377,5,6,NULL,'OF173343',675.00,0.00,225.00,NULL,'2019-04-16 15:02:48','UPD'),(36,383,5,6,NULL,'OF173343',675.00,0.00,0.00,NULL,'2019-04-16 15:02:48','UPD'),(37,188,6,7,NULL,'OF171235',275.00,NULL,NULL,NULL,'2019-04-16 15:04:15','INS'),(37,189,6,7,NULL,'OF171235',275.00,275.00,NULL,NULL,'2019-04-16 15:04:15','UPD'),(38,193,28,8,NULL,'20181116',6650.00,NULL,NULL,NULL,'2019-04-16 15:06:51','INS'),(38,194,28,8,NULL,'20181116',6650.00,6650.00,NULL,NULL,'2019-04-16 15:06:51','UPD'),(38,214,28,8,NULL,'20181116',6650.00,5650.00,1000.00,NULL,'2019-04-16 15:06:51','UPD'),(38,227,28,8,NULL,'20181116',6650.00,5650.00,0.00,NULL,'2019-04-16 15:06:51','UPD'),(38,368,28,8,NULL,'20181116',6650.00,5625.00,25.00,NULL,'2019-04-16 15:06:51','UPD'),(38,403,28,8,NULL,'20181116',6650.00,5625.00,0.00,NULL,'2019-04-16 15:06:51','UPD'),(39,195,29,9,NULL,'20180112',3500.00,NULL,NULL,NULL,'2019-04-16 15:08:23','INS'),(39,196,29,9,NULL,'20180112',3500.00,3500.00,NULL,NULL,'2019-04-16 15:08:23','UPD'),(39,290,29,9,NULL,'20180112',3500.00,3000.00,500.00,NULL,'2019-04-16 15:08:23','UPD'),(39,305,29,9,NULL,'20180112',3500.00,3000.00,0.00,NULL,'2019-04-16 15:08:23','UPD'),(39,318,29,9,NULL,'20180112',3500.00,2600.00,400.00,NULL,'2019-04-16 15:08:23','UPD'),(39,360,29,9,NULL,'20180112',3500.00,2600.00,0.00,NULL,'2019-04-16 15:08:23','UPD'),(40,195,29,9,NULL,'20181116',3750.00,NULL,NULL,NULL,'2019-04-16 15:08:23','INS'),(40,196,29,9,NULL,'20181116',3750.00,3750.00,NULL,NULL,'2019-04-16 15:08:23','UPD'),(40,290,29,9,NULL,'20181116',3750.00,3750.00,0.00,NULL,'2019-04-16 15:08:23','UPD'),(40,318,29,9,NULL,'20181116',3750.00,3750.00,0.00,NULL,'2019-04-16 15:08:23','UPD'),(41,197,23,10,NULL,'D1221',1750.00,NULL,NULL,NULL,'2019-04-16 15:10:38','INS'),(41,198,23,10,NULL,'D1221',1750.00,1750.00,NULL,NULL,'2019-04-16 15:10:38','UPD'),(41,203,23,10,NULL,'D1221',0.00,NULL,NULL,NULL,'2019-04-16 15:10:38','UPD'),(42,197,38,10,NULL,'112327',5.00,NULL,NULL,NULL,'2019-04-16 15:10:38','INS'),(42,198,38,10,NULL,'112327',5.00,5.00,NULL,NULL,'2019-04-16 15:10:38','UPD'),(42,274,38,10,NULL,'112327',5.00,0.00,5.00,NULL,'2019-04-16 15:10:38','UPD'),(42,280,38,10,NULL,'112327',5.00,5.00,5.00,NULL,'2019-04-16 15:10:38','UPD'),(42,283,38,10,NULL,'112327',5.00,1.00,9.00,NULL,'2019-04-16 15:10:38','UPD'),(42,342,38,10,NULL,'112327',5.00,1.00,5.00,NULL,'2019-04-16 15:10:38','UPD'),(42,472,38,10,NULL,'112327',5.00,0.00,6.00,NULL,'2019-04-16 15:10:38','UPD'),(42,481,38,10,NULL,'112327',5.00,0.00,5.00,NULL,'2019-04-16 15:10:38','UPD'),(43,204,40,10,NULL,NULL,1750.00,NULL,NULL,NULL,'2019-04-23 13:58:14','INS'),(43,205,40,10,NULL,'L43',1750.00,1750.00,NULL,NULL,'2019-04-23 13:58:14','UPD'),(43,206,40,10,NULL,'D2112',1750.00,1750.00,NULL,NULL,'2019-04-23 13:58:14','UPD'),(43,207,40,10,NULL,'D1221',1750.00,1750.00,NULL,NULL,'2019-04-23 13:58:14','UPD'),(43,208,40,10,NULL,'D1221',1750.00,1650.00,100.00,NULL,'2019-04-23 13:58:14','UPD'),(43,211,40,10,NULL,'D1221',1750.00,1650.00,0.00,NULL,'2019-04-23 13:58:14','UPD'),(43,259,40,10,NULL,'D1221',1750.00,1150.00,500.00,NULL,'2019-04-23 13:58:14','UPD'),(43,262,40,10,NULL,'D1221',1750.00,1150.00,0.00,NULL,'2019-04-23 13:58:14','UPD'),(43,474,40,10,NULL,'D1221',1750.00,1103.06,46.94,NULL,'2019-04-23 13:58:14','UPD'),(43,484,40,10,NULL,'D1221',1750.00,1103.06,0.00,NULL,'2019-04-23 13:58:14','UPD'),(43,532,40,10,NULL,'D1221',1750.00,903.06,0.00,NULL,'2019-04-23 13:58:14','UPD'),(44,209,23,NULL,1,NULL,100.00,NULL,NULL,NULL,'2019-04-23 14:11:39','INS'),(44,210,23,NULL,1,'L44',100.00,100.00,NULL,NULL,'2019-04-23 14:11:39','UPD'),(44,212,23,NULL,1,'L44',100.00,0.00,100.00,NULL,'2019-04-23 14:11:39','UPD'),(44,226,23,NULL,1,'L44',100.00,0.00,0.00,NULL,'2019-04-23 14:11:39','UPD'),(45,234,1,11,NULL,'214260',1000.00,NULL,NULL,NULL,'2019-04-30 15:49:25','INS'),(45,235,1,11,NULL,'214260',1000.00,1000.00,NULL,NULL,'2019-04-30 15:49:25','UPD'),(45,288,1,11,NULL,'214260',1000.00,300.00,700.00,NULL,'2019-04-30 15:49:25','UPD'),(45,293,1,11,NULL,'214260',1000.00,0.00,1000.00,NULL,'2019-04-30 15:49:25','UPD'),(45,306,1,11,NULL,'214260',1000.00,0.00,700.00,NULL,'2019-04-30 15:49:25','UPD'),(45,307,1,11,NULL,'214260',1000.00,0.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(46,234,1,11,NULL,'215960',1150.00,NULL,NULL,NULL,'2019-04-30 15:49:25','INS'),(46,235,1,11,NULL,'215960',1150.00,1150.00,NULL,NULL,'2019-04-30 15:49:25','UPD'),(46,288,1,11,NULL,'215960',1150.00,1150.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(46,293,1,11,NULL,'215960',1150.00,150.00,1000.00,NULL,'2019-04-30 15:49:25','UPD'),(46,306,1,11,NULL,'215960',1150.00,150.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(46,322,1,11,NULL,'215960',1150.00,150.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(46,323,1,11,NULL,'215960',1150.00,50.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(46,324,1,11,NULL,'215960',1150.00,50.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(46,325,1,11,NULL,'215960',1150.00,125.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(46,407,1,11,NULL,'215960',1150.00,0.00,125.00,NULL,'2019-04-30 15:49:25','UPD'),(46,526,1,11,NULL,'215960',1150.00,375.00,125.00,NULL,'2019-04-30 15:49:25','UPD'),(46,534,1,11,NULL,'215960',1150.00,375.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(47,234,3,11,NULL,'215751',525.00,NULL,NULL,NULL,'2019-04-30 15:49:25','INS'),(47,235,3,11,NULL,'215751',525.00,525.00,NULL,NULL,'2019-04-30 15:49:25','UPD'),(47,266,3,11,NULL,'215751',525.00,525.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(47,291,3,11,NULL,'215751',525.00,0.00,525.00,NULL,'2019-04-30 15:49:25','UPD'),(47,402,3,11,NULL,'215751',525.00,0.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(48,234,3,11,NULL,'215848',4625.00,NULL,NULL,NULL,'2019-04-30 15:49:25','INS'),(48,235,3,11,NULL,'215848',4625.00,4625.00,NULL,NULL,'2019-04-30 15:49:25','UPD'),(48,266,3,11,NULL,'215848',4625.00,4625.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(48,291,3,11,NULL,'215848',4625.00,2150.00,2475.00,NULL,'2019-04-30 15:49:25','UPD'),(48,402,3,11,NULL,'215848',4625.00,2150.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(48,406,3,11,NULL,'215848',4625.00,2050.00,100.00,NULL,'2019-04-30 15:49:25','UPD'),(48,464,3,11,NULL,'215848',4625.00,2050.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(49,234,2,11,NULL,'214237',1200.00,NULL,NULL,NULL,'2019-04-30 15:49:25','INS'),(49,235,2,11,NULL,'214237',1200.00,1200.00,NULL,NULL,'2019-04-30 15:49:25','UPD'),(49,236,2,11,NULL,'214237',1200.00,0.00,1200.00,NULL,'2019-04-30 15:49:25','UPD'),(49,238,2,11,NULL,'214237',1200.00,0.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(50,234,2,11,NULL,'215867',15600.00,NULL,NULL,NULL,'2019-04-30 15:49:25','INS'),(50,235,2,11,NULL,'215867',15600.00,15600.00,NULL,NULL,'2019-04-30 15:49:25','UPD'),(50,236,2,11,NULL,'215867',15600.00,7200.00,8400.00,NULL,'2019-04-30 15:49:25','UPD'),(50,238,2,11,NULL,'215867',15600.00,7200.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(50,239,2,11,NULL,'215867',15600.00,4800.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(50,240,2,11,NULL,'215867',15600.00,4800.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(50,292,2,11,NULL,'215867',15600.00,1200.00,3600.00,NULL,'2019-04-30 15:49:25','UPD'),(50,353,2,11,NULL,'215867',15600.00,15600.00,3600.00,NULL,'2019-04-30 15:49:25','UPD'),(50,354,2,11,NULL,'215867',15600.00,3600.00,3600.00,NULL,'2019-04-30 15:49:25','UPD'),(50,355,2,11,NULL,'215867',15600.00,4800.00,3600.00,NULL,'2019-04-30 15:49:25','UPD'),(50,357,2,11,NULL,'215867',15600.00,0.00,4800.00,NULL,'2019-04-30 15:49:25','UPD'),(50,375,2,11,NULL,'215867',15600.00,0.00,0.00,NULL,'2019-04-30 15:49:25','UPD'),(51,256,39,12,NULL,'L123/19',2500.00,NULL,NULL,NULL,'2019-05-07 15:32:43','INS'),(51,257,39,12,NULL,'L123/19',2500.00,2500.00,NULL,NULL,'2019-05-07 15:32:43','UPD'),(51,271,39,12,NULL,'L123/19',2500.00,1782.93,717.08,NULL,'2019-05-07 15:32:43','UPD'),(51,272,39,12,NULL,'L123/19',2500.00,1342.38,1157.63,NULL,'2019-05-07 15:32:43','UPD'),(51,273,39,12,NULL,'L123/19',2500.00,607.38,1892.63,NULL,'2019-05-07 15:32:43','UPD'),(51,274,39,12,NULL,'L123/19',2500.00,147.38,2352.63,NULL,'2019-05-07 15:32:43','UPD'),(51,279,39,12,NULL,'L123/19',2500.00,607.38,2352.63,NULL,'2019-05-07 15:32:43','UPD'),(51,283,39,12,NULL,'L123/19',2500.00,239.38,2720.63,NULL,'2019-05-07 15:32:43','UPD'),(51,333,39,12,NULL,'L123/19',2500.00,239.38,2003.56,NULL,'2019-05-07 15:32:43','UPD'),(51,336,39,12,NULL,'L123/19',2500.00,239.38,1563.01,NULL,'2019-05-07 15:32:43','UPD'),(51,339,39,12,NULL,'L123/19',2500.00,239.38,828.01,NULL,'2019-05-07 15:32:43','UPD'),(51,342,39,12,NULL,'L123/19',2500.00,239.38,460.01,NULL,'2019-05-07 15:32:43','UPD'),(51,389,39,12,NULL,'L123/19',2500.00,0.00,699.39,NULL,'2019-05-07 15:32:43','UPD'),(51,416,39,12,NULL,'L123/19',2500.00,0.00,460.01,NULL,'2019-05-07 15:32:43','UPD'),(51,433,39,12,NULL,'L123/19',2500.00,239.38,460.01,NULL,'2019-05-07 15:32:43','UPD'),(51,467,39,12,NULL,'L123/19',2500.00,0.35,699.04,NULL,'2019-05-07 15:32:43','UPD'),(51,468,39,12,NULL,'L123/19',2500.00,0.00,699.39,NULL,'2019-05-07 15:32:43','UPD'),(51,490,39,12,NULL,'L123/19',2500.00,0.00,460.37,NULL,'2019-05-07 15:32:43','UPD'),(51,493,39,12,NULL,'L123/19',2500.00,0.00,460.02,NULL,'2019-05-07 15:32:43','UPD'),(52,260,23,NULL,2,NULL,500.00,NULL,NULL,NULL,'2019-05-08 16:08:53','INS'),(52,261,23,NULL,2,'L52',500.00,500.00,NULL,NULL,'2019-05-08 16:08:53','UPD'),(52,263,23,NULL,2,'L52',500.00,400.00,100.00,NULL,'2019-05-08 16:08:53','UPD'),(52,285,23,NULL,2,'L52',500.00,400.00,0.00,NULL,'2019-05-08 16:08:53','UPD'),(52,301,23,NULL,2,'L52',500.00,300.00,100.00,NULL,'2019-05-08 16:08:53','UPD'),(52,304,23,NULL,2,'L52',500.00,300.00,0.00,NULL,'2019-05-08 16:08:53','UPD'),(52,348,23,NULL,2,'290',500.00,300.00,0.00,NULL,'2019-05-08 16:08:53','UPD'),(52,349,23,NULL,2,'L52',500.00,300.00,0.00,NULL,'2019-05-08 16:08:53','UPD'),(52,350,23,NULL,2,'290',500.00,300.00,0.00,NULL,'2019-05-08 16:08:53','UPD'),(52,366,23,NULL,2,'290',500.00,200.00,100.00,NULL,'2019-05-08 16:08:53','UPD'),(52,397,23,NULL,2,'290',500.00,200.00,0.00,NULL,'2019-05-08 16:08:53','UPD'),(52,410,23,NULL,2,'290',500.00,100.00,100.00,NULL,'2019-05-08 16:08:53','UPD'),(52,465,23,NULL,2,'290',500.00,100.00,0.00,NULL,'2019-05-08 16:08:53','UPD'),(52,531,23,NULL,2,'290',500.00,300.00,0.00,NULL,'2019-05-08 16:08:53','UPD'),(52,535,23,NULL,2,'290',500.00,200.00,100.00,NULL,'2019-05-08 16:08:53','UPD'),(52,560,23,NULL,2,'290',500.00,200.00,0.00,NULL,'2019-05-08 16:08:53','UPD'),(53,286,1,13,NULL,'214260',1000.00,NULL,NULL,NULL,'2019-05-13 19:56:13','INS'),(53,287,1,13,NULL,'214260',1000.00,1000.00,NULL,NULL,'2019-05-13 19:56:13','UPD'),(53,288,1,13,NULL,'214260',1000.00,1000.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(53,293,1,13,NULL,'214260',1000.00,1000.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(53,407,1,13,NULL,'214260',1000.00,0.00,1000.00,NULL,'2019-05-13 19:56:13','UPD'),(53,524,1,13,NULL,'214260',1000.00,0.00,1000.00,NULL,'2019-05-13 19:56:13','DEL'),(53,534,1,13,NULL,'214260',1000.00,0.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(53,562,1,13,NULL,'214260',0.00,0.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(53,564,1,13,NULL,'214260  CARGA REPETIDA',0.00,0.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(54,286,1,13,NULL,'215960',1150.00,NULL,NULL,NULL,'2019-05-13 19:56:13','INS'),(54,287,1,13,NULL,'215960',1150.00,1150.00,NULL,NULL,'2019-05-13 19:56:13','UPD'),(54,288,1,13,NULL,'215960',1150.00,1150.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(54,293,1,13,NULL,'215960',1150.00,1150.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(54,407,1,13,NULL,'215960',1150.00,775.00,375.00,NULL,'2019-05-13 19:56:13','UPD'),(54,525,1,13,NULL,'215960',1150.00,775.00,375.00,NULL,'2019-05-13 19:56:13','DEL'),(54,534,1,13,NULL,'215960',1150.00,775.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(54,563,1,13,NULL,'215960 CARGA REPETIDA',0.00,0.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(55,286,3,13,NULL,'215751',525.00,NULL,NULL,NULL,'2019-05-13 19:56:13','INS'),(55,287,3,13,NULL,'215751',525.00,525.00,NULL,NULL,'2019-05-13 19:56:13','UPD'),(55,291,3,13,NULL,'215751',525.00,525.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(55,406,3,13,NULL,'215751',525.00,525.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(55,522,3,13,NULL,'215751',525.00,525.00,0.00,NULL,'2019-05-13 19:56:13','DEL'),(56,286,3,13,NULL,'215848',4625.00,NULL,NULL,NULL,'2019-05-13 19:56:13','INS'),(56,287,3,13,NULL,'215848',4625.00,4625.00,NULL,NULL,'2019-05-13 19:56:13','UPD'),(56,291,3,13,NULL,'215848',4625.00,4625.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(56,406,3,13,NULL,'215848',4625.00,4625.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(56,523,3,13,NULL,'215848',4625.00,4625.00,0.00,NULL,'2019-05-13 19:56:13','DEL'),(57,286,2,13,NULL,'215867',13.00,NULL,NULL,NULL,'2019-05-13 19:56:13','INS'),(57,287,2,13,NULL,'215867',13.00,13.00,NULL,NULL,'2019-05-13 19:56:13','UPD'),(57,292,2,13,NULL,'215867',13.00,13.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(57,357,2,13,NULL,'215867',13.00,13.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(57,369,2,13,NULL,'215867',13.00,0.00,13.00,NULL,'2019-05-13 19:56:13','UPD'),(57,372,2,13,NULL,'215867',13.00,0.00,13.00,NULL,'2019-05-13 19:56:13','DEL'),(58,286,2,13,NULL,'214237',1.00,NULL,NULL,NULL,'2019-05-13 19:56:13','INS'),(58,287,2,13,NULL,'214237',1.00,1.00,NULL,NULL,'2019-05-13 19:56:13','UPD'),(58,292,2,13,NULL,'214237',1.00,1.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(58,357,2,13,NULL,'214237',1.00,1.00,0.00,NULL,'2019-05-13 19:56:13','UPD'),(58,369,2,13,NULL,'214237',1.00,0.00,1.00,NULL,'2019-05-13 19:56:13','UPD'),(58,371,2,13,NULL,'214237',1.00,0.00,1.00,NULL,'2019-05-13 19:56:13','DEL'),(59,310,1,14,NULL,'216365',3000.00,NULL,NULL,NULL,'2019-05-21 17:31:50','INS'),(59,311,1,14,NULL,'216365',3000.00,3000.00,NULL,NULL,'2019-05-21 17:31:50','UPD'),(59,407,1,14,NULL,'216365',3000.00,3000.00,0.00,NULL,'2019-05-21 17:31:50','UPD'),(59,527,1,14,NULL,'216365',3000.00,1500.00,0.00,NULL,'2019-05-21 17:31:50','UPD'),(60,310,3,14,NULL,'215848',5500.00,NULL,NULL,NULL,'2019-05-21 17:31:50','INS'),(60,311,3,14,NULL,'215848',5500.00,5500.00,NULL,NULL,'2019-05-21 17:31:50','UPD'),(60,406,3,14,NULL,'215848',5500.00,5500.00,0.00,NULL,'2019-05-21 17:31:50','UPD'),(61,310,3,14,NULL,'216366',2500.00,NULL,NULL,NULL,'2019-05-21 17:31:50','INS'),(61,311,3,14,NULL,'216366',2500.00,2500.00,NULL,NULL,'2019-05-21 17:31:50','UPD'),(61,406,3,14,NULL,'216366',2500.00,2500.00,0.00,NULL,'2019-05-21 17:31:50','UPD'),(62,310,2,14,NULL,'215867',1200.00,NULL,NULL,NULL,'2019-05-21 17:31:50','INS'),(62,311,2,14,NULL,'215867',1200.00,1200.00,NULL,NULL,'2019-05-21 17:31:50','UPD'),(62,357,2,14,NULL,'215867',1200.00,1200.00,0.00,NULL,'2019-05-21 17:31:50','UPD'),(62,369,2,14,NULL,'215867',1200.00,0.00,1200.00,NULL,'2019-05-21 17:31:50','UPD'),(62,412,2,14,NULL,'215867',1200.00,0.00,0.00,NULL,'2019-05-21 17:31:50','UPD'),(63,310,2,14,NULL,'216175',12000.00,NULL,NULL,NULL,'2019-05-21 17:31:50','INS'),(63,311,2,14,NULL,'216175',12000.00,12000.00,NULL,NULL,'2019-05-21 17:31:50','UPD'),(63,357,2,14,NULL,'216175',12000.00,12000.00,0.00,NULL,'2019-05-21 17:31:50','UPD'),(63,369,2,14,NULL,'216175',12000.00,8414.00,3586.00,NULL,'2019-05-21 17:31:50','UPD'),(63,370,2,14,NULL,'216175',12000.00,8400.00,3586.00,NULL,'2019-05-21 17:31:50','UPD'),(63,376,2,14,NULL,'216175',12000.00,7200.00,4800.00,NULL,'2019-05-21 17:31:50','UPD'),(63,404,2,14,NULL,'216175',12000.00,7200.00,3600.00,NULL,'2019-05-21 17:31:50','UPD'),(63,412,2,14,NULL,'216175',12000.00,7200.00,0.00,NULL,'2019-05-21 17:31:50','UPD'),(64,312,36,15,NULL,'1901219',250.00,NULL,NULL,NULL,'2019-05-21 17:36:56','INS'),(64,313,36,15,NULL,'1901219',250.00,250.00,NULL,NULL,'2019-05-21 17:36:56','UPD'),(64,472,36,15,NULL,'1901219',250.00,225.00,25.00,NULL,'2019-05-21 17:36:56','UPD'),(64,481,36,15,NULL,'1901219',250.00,225.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(65,312,34,15,NULL,'1901218',400.00,NULL,NULL,NULL,'2019-05-21 17:36:56','INS'),(65,313,34,15,NULL,'1901218',400.00,400.00,NULL,NULL,'2019-05-21 17:36:56','UPD'),(65,394,34,15,NULL,'1901218',400.00,400.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(65,395,34,15,NULL,'1901218',400.00,370.98,29.02,NULL,'2019-05-21 17:36:56','UPD'),(65,396,34,15,NULL,'1901218',400.00,333.48,66.52,NULL,'2019-05-21 17:36:56','UPD'),(65,428,34,15,NULL,'1901218',400.00,333.48,29.02,NULL,'2019-05-21 17:36:56','UPD'),(65,453,34,15,NULL,'1901218',400.00,333.48,0.00,NULL,'2019-05-21 17:36:56','UPD'),(65,458,34,15,NULL,'1901218',400.00,370.98,0.00,NULL,'2019-05-21 17:36:56','UPD'),(65,469,34,15,NULL,'1901218',400.00,370.98,0.00,NULL,'2019-05-21 17:36:56','UPD'),(65,470,34,15,NULL,'1901218',400.00,348.48,22.50,NULL,'2019-05-21 17:36:56','UPD'),(66,312,33,15,NULL,'1901220',600.00,NULL,NULL,NULL,'2019-05-21 17:36:56','INS'),(66,313,33,15,NULL,'1901220',600.00,600.00,NULL,NULL,'2019-05-21 17:36:56','UPD'),(66,389,33,15,NULL,'1901220',600.00,600.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(66,394,33,15,NULL,'1901220',600.00,600.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(66,395,33,15,NULL,'1901220',600.00,600.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(66,396,33,15,NULL,'1901220',600.00,600.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(66,467,33,15,NULL,'1901220',600.00,600.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(66,469,33,15,NULL,'1901220',600.00,600.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(66,470,33,15,NULL,'1901220',600.00,600.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(66,471,33,15,NULL,'1901220',600.00,600.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(66,472,33,15,NULL,'1901220',600.00,600.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(66,473,33,15,NULL,'1901220',600.00,600.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(67,312,37,15,NULL,'1901222',200.00,NULL,NULL,NULL,'2019-05-21 17:36:56','INS'),(67,313,37,15,NULL,'1901222',200.00,200.00,NULL,NULL,'2019-05-21 17:36:56','UPD'),(67,393,37,15,NULL,'1901222',200.00,173.15,26.85,NULL,'2019-05-21 17:36:56','UPD'),(67,419,37,15,NULL,'1901222',200.00,173.15,0.00,NULL,'2019-05-21 17:36:56','UPD'),(67,440,37,15,NULL,'1901222',200.00,200.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(67,468,37,15,NULL,'1901222',200.00,173.15,26.85,NULL,'2019-05-21 17:36:56','UPD'),(67,493,37,15,NULL,'1901222',200.00,173.15,0.00,NULL,'2019-05-21 17:36:56','UPD'),(68,312,32,15,NULL,'1901221',400.00,NULL,NULL,NULL,'2019-05-21 17:36:56','INS'),(68,313,32,15,NULL,'1901221',400.00,400.00,NULL,NULL,'2019-05-21 17:36:56','UPD'),(68,389,32,15,NULL,'1901221',400.00,400.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(68,394,32,15,NULL,'1901221',400.00,400.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(68,395,32,15,NULL,'1901221',400.00,400.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(68,396,32,15,NULL,'1901221',400.00,400.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(68,467,32,15,NULL,'1901221',400.00,400.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(68,469,32,15,NULL,'1901221',400.00,400.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(68,470,32,15,NULL,'1901221',400.00,400.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(68,471,32,15,NULL,'1901221',400.00,400.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(68,472,32,15,NULL,'1901221',400.00,400.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(68,473,32,15,NULL,'1901221',400.00,400.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(68,556,32,15,NULL,'1901221',400.00,400.00,0.00,NULL,'2019-05-21 17:36:56','UPD'),(69,331,7,NULL,3,NULL,750.00,NULL,NULL,NULL,'2019-05-24 15:27:44','INS'),(69,332,7,NULL,3,'L69',750.00,750.00,NULL,NULL,'2019-05-24 15:27:44','UPD'),(69,343,7,NULL,3,'291',750.00,750.00,NULL,NULL,'2019-05-24 15:27:44','UPD'),(69,344,7,NULL,3,'291',750.00,750.00,NULL,NULL,'2019-05-24 15:27:44','UPD'),(69,359,7,NULL,3,'291',750.00,750.00,0.00,NULL,'2019-05-24 15:27:44','UPD'),(70,334,15,NULL,4,NULL,500.00,NULL,NULL,NULL,'2019-05-24 15:27:46','INS'),(70,335,15,NULL,4,'L70',500.00,500.00,NULL,NULL,'2019-05-24 15:27:46','UPD'),(70,345,15,NULL,4,'292',500.00,500.00,NULL,NULL,'2019-05-24 15:27:46','UPD'),(70,463,15,NULL,4,'292',500.00,275.00,225.00,NULL,'2019-05-24 15:27:46','UPD'),(70,536,15,NULL,4,'292',500.00,275.00,0.00,NULL,'2019-05-24 15:27:46','UPD'),(71,337,21,NULL,5,NULL,750.00,NULL,NULL,NULL,'2019-05-24 15:27:49','INS'),(71,338,21,NULL,5,'L71',750.00,750.00,NULL,NULL,'2019-05-24 15:27:49','UPD'),(71,346,21,NULL,5,'293',750.00,750.00,NULL,NULL,'2019-05-24 15:27:49','UPD'),(71,367,21,NULL,5,'293',750.00,650.00,100.00,NULL,'2019-05-24 15:27:49','UPD'),(71,381,21,NULL,5,'293',750.00,400.00,100.00,NULL,'2019-05-24 15:27:49','UPD'),(71,399,21,NULL,5,'293',750.00,400.00,0.00,NULL,'2019-05-24 15:27:49','UPD'),(71,553,21,NULL,5,'293',750.00,0.00,400.00,NULL,'2019-05-24 15:27:49','UPD'),(71,559,21,NULL,5,'293',750.00,0.00,0.00,NULL,'2019-05-24 15:27:49','UPD'),(72,340,19,NULL,7,NULL,400.00,NULL,NULL,NULL,'2019-05-24 15:27:52','INS'),(72,341,19,NULL,7,'L72',400.00,400.00,NULL,NULL,'2019-05-24 15:27:52','UPD'),(72,347,19,NULL,7,'294',400.00,400.00,NULL,NULL,'2019-05-24 15:27:52','UPD'),(72,351,19,NULL,7,'294',400.00,325.00,75.00,NULL,'2019-05-24 15:27:52','UPD'),(72,359,19,NULL,7,'294',400.00,225.00,175.00,NULL,'2019-05-24 15:27:52','UPD'),(72,385,19,NULL,7,'294',400.00,125.00,175.00,NULL,'2019-05-24 15:27:52','UPD'),(72,388,19,NULL,7,'294',400.00,100.00,175.00,NULL,'2019-05-24 15:27:52','UPD'),(72,398,19,NULL,7,'294',400.00,100.00,75.00,NULL,'2019-05-24 15:27:52','UPD'),(72,405,19,NULL,7,'294',400.00,100.00,0.00,NULL,'2019-05-24 15:27:52','UPD'),(73,391,39,16,NULL,NULL,4000.00,NULL,NULL,NULL,'2019-05-30 18:40:24','INS'),(73,392,39,16,NULL,NULL,4000.00,4000.00,NULL,NULL,'2019-05-30 18:40:24','UPD'),(73,393,39,16,NULL,NULL,4000.00,2530.00,1470.00,NULL,'2019-05-30 18:40:24','UPD'),(73,394,39,16,NULL,NULL,4000.00,2089.45,1910.55,NULL,'2019-05-30 18:40:24','UPD'),(73,395,39,16,NULL,NULL,4000.00,1679.05,2320.95,NULL,'2019-05-30 18:40:24','UPD'),(73,396,39,16,NULL,NULL,4000.00,1268.65,2731.35,NULL,'2019-05-30 18:40:24','UPD'),(73,419,39,16,NULL,NULL,4000.00,1268.65,1261.35,NULL,'2019-05-30 18:40:24','UPD'),(73,422,39,16,NULL,NULL,4000.00,1268.65,820.80,NULL,'2019-05-30 18:40:24','UPD'),(73,428,39,16,NULL,NULL,4000.00,1268.65,410.40,NULL,'2019-05-30 18:40:24','UPD'),(73,438,39,16,NULL,NULL,4000.00,2738.65,410.40,NULL,'2019-05-30 18:40:24','UPD'),(73,443,39,16,NULL,NULL,4000.00,3179.20,410.40,NULL,'2019-05-30 18:40:24','UPD'),(73,449,39,16,NULL,NULL,4000.00,3179.20,0.00,NULL,'2019-05-30 18:40:24','UPD'),(73,455,39,16,NULL,NULL,4000.00,3589.60,0.00,NULL,'2019-05-30 18:40:24','UPD'),(73,467,39,16,NULL,NULL,4000.00,3589.60,0.00,NULL,'2019-05-30 18:40:24','UPD'),(73,468,39,16,NULL,NULL,4000.00,2119.95,1469.65,NULL,'2019-05-30 18:40:24','UPD'),(73,469,39,16,NULL,NULL,4000.00,1679.40,1910.20,NULL,'2019-05-30 18:40:24','UPD'),(73,470,39,16,NULL,NULL,4000.00,1433.16,2156.44,NULL,'2019-05-30 18:40:24','UPD'),(73,471,39,16,NULL,NULL,4000.00,957.06,2632.54,NULL,'2019-05-30 18:40:24','UPD'),(73,472,39,16,NULL,NULL,4000.00,497.06,3092.54,NULL,'2019-05-30 18:40:24','UPD'),(73,473,39,16,NULL,NULL,4000.00,270.96,3318.64,NULL,'2019-05-30 18:40:24','UPD'),(73,474,39,16,NULL,NULL,4000.00,117.90,3471.70,NULL,'2019-05-30 18:40:24','UPD'),(73,481,39,16,NULL,NULL,4000.00,117.90,3011.70,NULL,'2019-05-30 18:40:24','UPD'),(73,484,39,16,NULL,NULL,4000.00,117.90,2858.64,NULL,'2019-05-30 18:40:24','UPD'),(73,487,39,16,NULL,NULL,4000.00,117.90,2632.54,NULL,'2019-05-30 18:40:24','UPD'),(73,493,39,16,NULL,NULL,4000.00,117.90,1162.89,NULL,'2019-05-30 18:40:24','UPD'),(73,496,39,16,NULL,NULL,4000.00,117.90,722.34,NULL,'2019-05-30 18:40:24','UPD'),(73,542,39,16,NULL,NULL,4000.00,117.90,246.24,NULL,'2019-05-30 18:40:24','UPD'),(74,414,7,NULL,8,NULL,500.00,NULL,NULL,NULL,'2019-06-05 13:26:34','INS'),(74,415,7,NULL,8,'L74',500.00,500.00,NULL,NULL,'2019-06-05 13:26:34','UPD'),(74,436,7,NULL,8,'L74',500.00,500.00,NULL,NULL,'2019-06-05 13:26:34','DEL'),(75,417,21,NULL,9,NULL,1500.00,NULL,NULL,NULL,'2019-06-05 13:27:41','INS'),(75,418,21,NULL,9,'L75',1500.00,1500.00,NULL,NULL,'2019-06-05 13:27:41','UPD'),(75,441,21,NULL,9,'L75',1500.00,1500.00,NULL,NULL,'2019-06-05 13:27:41','DEL'),(76,420,15,NULL,10,NULL,500.00,NULL,NULL,NULL,'2019-06-05 13:28:14','INS'),(76,421,15,NULL,10,'L76',500.00,500.00,NULL,NULL,'2019-06-05 13:28:14','UPD'),(76,447,15,NULL,10,'L76',500.00,500.00,NULL,NULL,'2019-06-05 13:28:14','DEL'),(77,426,17,NULL,12,NULL,500.00,NULL,NULL,NULL,'2019-06-05 13:30:31','INS'),(77,427,17,NULL,12,'L77',500.00,500.00,NULL,NULL,'2019-06-05 13:30:31','UPD'),(77,459,17,NULL,12,'L77',500.00,500.00,NULL,NULL,'2019-06-05 13:30:31','DEL'),(78,477,38,17,NULL,'AB112338',4.00,NULL,NULL,NULL,'2019-06-06 19:19:25','INS'),(78,478,38,17,NULL,'AB112338',4.00,4.00,NULL,NULL,'2019-06-06 19:19:25','UPD'),(79,479,19,NULL,18,NULL,500.00,NULL,NULL,NULL,'2019-06-06 19:19:32','INS'),(79,480,19,NULL,18,'L79',500.00,500.00,NULL,NULL,'2019-06-06 19:19:32','UPD'),(79,497,19,NULL,18,'L300',500.00,500.00,NULL,NULL,'2019-06-06 19:19:32','UPD'),(79,528,19,NULL,18,'300',500.00,500.00,NULL,NULL,'2019-06-06 19:19:32','UPD'),(80,482,22,NULL,20,NULL,200.00,NULL,NULL,NULL,'2019-06-06 19:19:38','INS'),(80,483,22,NULL,20,'L80',200.00,200.00,NULL,NULL,'2019-06-06 19:19:38','UPD'),(80,498,22,NULL,20,'L302',200.00,200.00,NULL,NULL,'2019-06-06 19:19:38','UPD'),(80,546,22,NULL,20,'302',200.00,200.00,NULL,NULL,'2019-06-06 19:19:38','UPD'),(81,485,8,NULL,19,NULL,250.00,NULL,NULL,NULL,'2019-06-06 19:19:47','INS'),(81,486,8,NULL,19,'L81',250.00,250.00,NULL,NULL,'2019-06-06 19:19:47','UPD'),(81,499,8,NULL,19,'L301',250.00,250.00,NULL,NULL,'2019-06-06 19:19:47','UPD'),(81,505,8,NULL,19,'L301',250.00,250.00,0.00,NULL,'2019-06-06 19:19:47','UPD'),(81,547,8,NULL,19,'301',250.00,250.00,0.00,NULL,'2019-06-06 19:19:47','UPD'),(81,548,8,NULL,19,'301',250.00,250.00,0.00,NULL,'2019-06-06 19:19:47','UPD'),(82,488,7,NULL,13,NULL,250.00,NULL,NULL,NULL,'2019-06-06 19:20:01','INS'),(82,489,7,NULL,13,'L82',250.00,250.00,NULL,NULL,'2019-06-06 19:20:01','UPD'),(82,500,7,NULL,13,'L295',250.00,250.00,NULL,NULL,'2019-06-06 19:20:01','UPD'),(82,549,7,NULL,13,'295',250.00,250.00,NULL,NULL,'2019-06-06 19:20:01','UPD'),(82,550,7,NULL,13,'295',250.00,250.00,NULL,NULL,'2019-06-06 19:20:01','UPD'),(83,491,21,NULL,14,NULL,1500.00,NULL,NULL,NULL,'2019-06-06 19:20:04','INS'),(83,492,21,NULL,14,'L83',1500.00,1500.00,NULL,NULL,'2019-06-06 19:20:04','UPD'),(83,501,21,NULL,14,'L296',1500.00,1500.00,NULL,NULL,'2019-06-06 19:20:04','UPD'),(83,551,21,NULL,14,'296',1500.00,1500.00,NULL,NULL,'2019-06-06 19:20:04','UPD'),(83,553,21,NULL,14,'296',1500.00,1500.00,0.00,NULL,'2019-06-06 19:20:04','UPD'),(84,494,15,NULL,15,NULL,500.00,NULL,NULL,NULL,'2019-06-06 19:20:07','INS'),(84,495,15,NULL,15,'L84',500.00,500.00,NULL,NULL,'2019-06-06 19:20:07','UPD'),(84,502,15,NULL,15,'L297',500.00,500.00,NULL,NULL,'2019-06-06 19:20:07','UPD'),(84,552,15,NULL,15,'297',500.00,500.00,NULL,NULL,'2019-06-06 19:20:07','UPD'),(85,540,10,NULL,17,NULL,500.00,NULL,NULL,NULL,'2019-06-11 14:16:27','INS'),(85,541,10,NULL,17,'L85',500.00,500.00,NULL,NULL,'2019-06-11 14:16:27','UPD'),(85,544,10,NULL,17,'L85',500.00,400.00,100.00,NULL,'2019-06-11 14:16:27','UPD'),(85,545,10,NULL,17,'299',500.00,400.00,100.00,NULL,'2019-06-11 14:16:27','UPD'),(85,560,10,NULL,17,'299',500.00,400.00,0.00,NULL,'2019-06-11 14:16:27','UPD');
/*!40000 ALTER TABLE `lote_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lote_faltante`
--

DROP TABLE IF EXISTS `lote_faltante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lote_faltante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) DEFAULT NULL,
  `remito_id` int(11) DEFAULT NULL,
  `fabricacion_id` int(11) DEFAULT NULL,
  `cantidad` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EA5C8E967645698E` (`producto_id`),
  KEY `IDX_EA5C8E9693DA9FED` (`remito_id`),
  KEY `IDX_EA5C8E968C85E1BC` (`fabricacion_id`),
  CONSTRAINT `FK_EA5C8E967645698E` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`),
  CONSTRAINT `FK_EA5C8E968C85E1BC` FOREIGN KEY (`fabricacion_id`) REFERENCES `fabricacion` (`id`),
  CONSTRAINT `FK_EA5C8E9693DA9FED` FOREIGN KEY (`remito_id`) REFERENCES `remito` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lote_faltante`
--

LOCK TABLES `lote_faltante` WRITE;
/*!40000 ALTER TABLE `lote_faltante` DISABLE KEYS */;
INSERT INTO `lote_faltante` VALUES (5,38,NULL,18,4);
/*!40000 ALTER TABLE `lote_faltante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `codigo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kilosPorBolsa` decimal(7,2) NOT NULL,
  `textoIngredientes` varchar(4000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rnpa` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `textoDosis` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_A7BB06153A909126` (`nombre`),
  UNIQUE KEY `UNIQ_A7BB061520332D99` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'Extracto de Malta en Polvo EMS 190 DRY STANDARD','1003',25.00,'Cebada y Malta','027-00-008608','-'),(2,'Extracto de Malta Liquido EML 340 LIQUID GOLDEN LIGHT','1002',1200.00,'Cebada y Malta','027-00-001263','-'),(3,'Extracto de Malta en Polvo EMS 530 DRY SWEET','1001',25.00,'Cebada y Malta','027-00-001345','-'),(4,'Pechuga de Pollo Deshilada Liofilizada','1000',7.00,'Pollo','0240/19','-'),(5,'CARASPRAY FCG 106','2000',25.00,'Goma Arábiga','064-00-003076','-'),(6,'CARASPRAY ACG 103','2001',25.00,'Goma Arábiga','064-00-003162','-'),(7,'E-BALANCE XB40','20',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*, ENZIMA AMILASA, ENZIMA XILANASA,  MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2 mg/kg \"','02-600536','50-100 ppm'),(8,'E-BALANCE XT78','21',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA ENZIMA XILANASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm'),(9,'E-BALANCE ST86','22',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm'),(10,'E-BALANCE ST50','23',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm'),(11,'E-BALANCE FL','24',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*, ENZIMA LIPASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm'),(12,'E-BALANCE B21','25',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm'),(13,'E-BALANCE B20','26',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm'),(14,'E-BALANCE AA5000','27',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm'),(15,'E-FORCE MV11','30',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, ENZIMA LIPASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600579','50-100 ppm'),(16,'E-FORCE MV303','31',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, ENZIMA LIPASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600579','50-100 ppm'),(17,'E-FORCE MV33','32',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, ENZIMA LIPASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600579','50-100 ppm'),(18,'E-BALANCE A150','28',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','1-100 ppm'),(19,'E-FORCE GL','34',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, ENZIMA LIPASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600579','50-100 ppm'),(20,'E-BALANCE XBK BX1','29',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA XILANASA,  MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','1-100 ppm'),(21,'E-POWER GOX','60',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA GLUCOSA-OXIDASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-607795','50-100 ppm'),(22,'EQUALMIX ADA 23','51',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*, AZODICARBONAMIDA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-606289','10-40 ppm'),(23,'EQUALMIX ADA 100','52',25.00,'AZODICARBONAMIDA','02-606289','1-40 ppm'),(24,'ACIDO ASCORBICO','91',25.00,'ACIDO ASCORBICO','-','1-40 ppm'),(28,'MONOGLICERIDO DESTILADOS (DMG)','100',25.00,'MONOGLICERIDO DESTILADOS','083-00-002320','1-100 ppm'),(29,'ESTEAROIL LACTILATO DE SODIO (SSL)','101',25.00,'ESTEAROIL LACTILATO DE SODIO (SSL)','083-00-002409','1-100 ppm'),(30,'DATEM','102',25.00,'DATEM','083-00-002851','1-100 ppm'),(31,'AMILASA AML 1400 P','04',25.00,'AMILASA','-','-'),(32,'AMILASA ABK K100','01',25.00,'-','-','-'),(33,'XILANASA XBK-BX2','02',25.00,'-','-','-'),(34,'LIPASA LBKB400 P','03',25.00,'-','-','-'),(35,'LIPASA LBK 400','05',25.00,'-','-','-'),(36,'GLICOLIPASA PH400','06',25.00,'-','-','-'),(37,'GLUCO OXIDASA BG10000','07',25.00,'-','-','-'),(38,'NOVAMIL','08',5.00,'-','-','-'),(39,'HARINA TERMOTRATADA CRYSTAL','09',25.00,'-','-','-'),(40,'AZODICARBONAMIDA 100','11',25.00,'-','-','-'),(41,'SUSTITUTO M','70',25.00,'-','-','-');
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto_audit`
--

DROP TABLE IF EXISTS `producto_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `codigo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kilosPorBolsa` decimal(7,2) DEFAULT NULL,
  `textoIngredientes` varchar(4000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rnpa` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `textoDosis` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_a75780842c8b3ee502ead0dec35a7d69_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto_audit`
--

LOCK TABLES `producto_audit` WRITE;
/*!40000 ALTER TABLE `producto_audit` DISABLE KEYS */;
INSERT INTO `producto_audit` VALUES (1,4,'Extracto de Malta en Polvo EMS 190','1003',25.00,'Cebada y Malta','027-00-008608','-','INS'),(1,6,'Extracto de Malta en Polvo EMS 190 DRY STANDARD','1003',25.00,'Cebada y Malta','027-00-008608','-','UPD'),(2,5,'Extracto de Malta Liquido EML 340 GOLDEN LIGHT','1002',1200.00,'Cebada y Malta','027-00-001263','-','INS'),(2,14,'Extracto de Malta Liquido EML 340 LIQUID GOLDEN LIGHT','1002',1200.00,'Cebada y Malta','027-00-001263','-','UPD'),(3,7,'Extracto de Malta en Polvo EMS 530 DRY SWEET','1001',25.00,'Cebada y Malta','027-00-001345','-','INS'),(4,8,'Pechuga de Pollo Deshilada Liofilizada','1000',7.00,'Pollo','0240/19','-','INS'),(5,9,'CARASPRAY FCG 106','2000',25.00,'-','064-00-003076','-','INS'),(5,12,'CARASPRAY FCG 106','2000',25.00,'Goma Arábiga','064-00-003076','-','UPD'),(6,10,'CARASPRAY ACG 103','2001',25.00,NULL,'064-00-003162','-','INS'),(6,11,'CARASPRAY ACG 103','2001',25.00,'Goma Arábiga','064-00-003162','-','UPD'),(7,13,'E-BALANCE XB40','20',25.00,'Harina Termotratada, Enzima Amilasa, Enzima Xilanasa','02-600536','50-100 ppm','INS'),(7,15,'E-BALANCE XB40','20',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*, ENZIMA AMILASA, ENZIMA XILANASA,  MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2 mg/kg \"','02-600536','50-100 ppm','UPD'),(8,16,'E-BALANCE XT78','21',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA ENZIMA XILANASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm','INS'),(9,17,'E-BALANCE ST86','22',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm','INS'),(10,18,'E-BALANCE ST50','23',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm','INS'),(11,19,'E-BALANCE FL','24',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*, ENZIMA LIPASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm','INS'),(12,20,'E-BALANCE B21','25',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm','INS'),(13,21,'E-BALANCE B20','26',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm','INS'),(14,22,'E-BALANCE AA5000','27',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','50-100 ppm','INS'),(15,23,'E-FORCE MV11','30',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, ENZIMA LIPASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600579','50-100 ppm','INS'),(16,24,'E-FORCE MV303','31',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, ENZIMA LIPASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600579','50-100 ppm','INS'),(17,25,'E-FORCE MV33','32',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, ENZIMA LIPASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600579','50-100 ppm','INS'),(18,26,'E-BALANCE A150','28',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','1-100 ppm','INS'),(19,27,'E-FORCE GL','34',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA AMILASA, ENZIMA XILANASA, ENZIMA LIPASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600579','50-100 ppm','INS'),(20,28,'E-BALANCE','29',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA XILANASA,  MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','1-100 ppm','INS'),(20,29,'E-BALANCE XBK BX1','29',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA XILANASA,  MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-600536','1-100 ppm','UPD'),(21,30,'E-POWER GOX','60',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*,ENZIMA GLUCOSA-OXIDASA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-607795','50-100 ppm','INS'),(22,31,'EQUALMIX ADA 23','51',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*, AZODICARBONAMIDA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-606289','10-40 ppm','INS'),(23,32,'EQUALMIX ADA 100','52',25.00,'HARINA TERMOTRATADA ENRIQUECIDA*, AZODICARBONAMIDA, MEJORADOR DE LA HARINA: INS 1100 *Harina enriquecida en los términos de la ley 25.630: Hierro 30.0 mg/kg, Tiamina 6.6mg/kg, Riboflavina 1.3 mg/kg, Nicotinamida 13.0 mg/kg y Acido Folico 2.2','02-606289','1-40 ppm','INS'),(23,34,'EQUALMIX ADA 100','52',25.00,'AZODICARBONAMIDA','02-606289','1-40 ppm','UPD'),(24,33,'ACIDO ASCORBICO','91',25.00,'ACIDO ASCORBICO','-','1-40 ppm','INS'),(28,35,'MONOGLICERIDO DESTILADOS (DMG)','100',25.00,'MONOGLICERIDO DESTILADOS','083-00-002320','1-100 ppm','INS'),(29,36,'ESTEAROIL LACTILATO DE SODIO (SSL)','101',25.00,'ESTEAROIL LACTILATO DE SODIO (SSL)','083-00-002409','1-100 ppm','INS'),(30,37,'DATEM','102',25.00,'DATEM','083-00-002851','1-100 ppm','INS'),(31,40,'AMILASA AML 1400 P','04',25.00,'AMILASA','-','-','INS'),(32,41,'AMILASA ABK K100','01',25.00,'-','-','-','INS'),(33,42,'XILANASA XBK-BX2','02',25.00,'-','-','-','INS'),(34,43,'LIPASA LBKB400 P','03',25.00,'-','-','-','INS'),(35,44,'LIPASA LBK 400','05',25.00,'-','-','-','INS'),(36,45,'GLICOLIPASA PH400','06',25.00,NULL,'-','-','INS'),(36,46,'GLICOLIPASA PH400','06',25.00,'-','-','-','UPD'),(37,47,'GLUCO OXIDASA BG10000','07',25.00,'-','-','-','INS'),(38,48,'NOVAMIL','08',5.00,'-','-','-','INS'),(39,49,'HARINA TERMOTRATADA CRYSTAL','09',25.00,'-','-','-','INS'),(40,69,'AZODICARBONAMIDA 100','11',25.00,'-','-','-','INS'),(41,199,'SUSTITUTO M','70',25.00,'-','-','-','INS');
/*!40000 ALTER TABLE `producto_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoNombre1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoTelefono1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoMail1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoNombre2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoTelefono2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoMail2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoNombre3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoTelefono3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoMail3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_16C068CE3A909126` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'LEVEKING','NO 1. Shuanglong road chizhou economic and technological development zone anhui china',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'LIOTECNICA TECNOLOGIA EM ALIMENTOS S/A','AV. JOAO PAULO I, 900 - EMBU DAS ARTES - SP - BRAZIL','Cynthia Montero','+55 11 99607-9146','Cynthia.Montero@liotecnica.com.br','Patricia Garbe','+55 11-4785-238','Patricia.Garbe@liotecnica.com.br','Zuleica Meess V. da Costa','+55 11-4785-238','zuleica@liotecnica.com.br'),(3,'CARAGUM INTERNATIONAL','162/164 Chemin de la Madrague-Ville - 13015 MARSEILLE - FRANCE','AMANDINE VASSEUR','33 4 91 92 12 60','amandine@caragum.com','JEAN-CLAUDE TUR','+33 4 91 92 12 63','jc.tur@caragum.com',NULL,NULL,NULL),(4,'HENAN ZHENGTONG FOOD TECHNOLOGY','INTERSECTION OF GONGYE RD & JIANSHE RD, XINGYANG, HENAN PROVINCE, CHINA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'INMOBAL NUTRER SA','PARQUE INDUSTRIAL RUTA 15 - KM 125 - PARCELA 78 - PLANTA 005',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'MOLINO ARGENTINO','AV DOMINGO CABRED 451 - OPEN DOOR - LUJAN - BUENOS AIRES - ARGENTINA','NESTOR VENTIMIGLIA','+54 9 11 3200-4814',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor_audit`
--

DROP TABLE IF EXISTS `proveedor_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoNombre1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoTelefono1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoMail1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoNombre2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoTelefono2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoMail2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoNombre3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoTelefono3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactoMail3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_f760eb5632ffde0127b2c0df8fbb4d8a_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor_audit`
--

LOCK TABLES `proveedor_audit` WRITE;
/*!40000 ALTER TABLE `proveedor_audit` DISABLE KEYS */;
INSERT INTO `proveedor_audit` VALUES (1,39,'LEVEKING','NO 1. Shuanglong road chizhou economic and technological development zone anhui china',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(2,73,'LIOTECNICA TECNOLOGIA EM ALIMENTOS S/A','AV. JOAO PAULO I, 900 - EMBU DAS ARTES - SP - BRAZIL','Cynthia Montero','+55 11 99607-9146','Cynthia.Montero@liotecnica.com.br','Patricia Garbe','+55 11-4785-238','Patricia.Garbe@liotecnica.com.br','Zuleica Meess V. da Costa','+55 11-4785-238','zuleica@liotecnica.com.br','INS'),(3,75,'CARAGUM INTERNATIONAL','162/164 Chemin de la Madrague-Ville - 13015 MARSEILLE - FRANCE','AMANDINE VASSEUR','33 4 91 92 12 60','amandine@caragum.com','JEAN-CLAUDE TUR','+33 4 91 92 12 63','jc.tur@caragum.com',NULL,NULL,NULL,'INS'),(4,190,'HENAN ZHENGTONG FOOD TECHNOLOGY','INTERSECTION OF GONGYE RD & JIANSHE RD, XINGYANG, HENAN PROVINCE, CHINA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(5,192,'INMOBAL NUTRER SA','PARQUE INDUSTRIAL RUTA 15 - KM 125 - PARCELA 78 - PLANTA 005',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'INS'),(6,255,'MOLINO ARGENTINO','AV DOMINGO CABRED 451 - OPEN DOOR - LUJAN - BUENOS AIRES - ARGENTINA','NESTOR VENTIMIGLIA','+54 9 11 3200-4814',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'INS');
/*!40000 ALTER TABLE `proveedor_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remito`
--

DROP TABLE IF EXISTS `remito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remito` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) DEFAULT NULL,
  `numero` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ordenDeCompra` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL,
  `fecha_modificacion` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_BEEEEA1EF55AE19E` (`numero`),
  KEY `IDX_BEEEEA1EDE734E51` (`cliente_id`),
  CONSTRAINT `FK_BEEEEA1EDE734E51` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remito`
--

LOCK TABLES `remito` WRITE;
/*!40000 ALTER TABLE `remito` DISABLE KEYS */;
INSERT INTO `remito` VALUES (1,12,'776','vendido','14159','2019-04-23 13:46:38','2019-04-25 16:20:55'),(2,18,'777','vendido',NULL,'2019-04-23 14:13:44','2019-04-25 18:50:49'),(3,1,'778','vendido','1412','2019-04-23 14:23:18','2019-04-25 18:50:52'),(4,4,'779','vendido','23895','2019-04-25 19:22:35','2019-04-29 17:41:34'),(5,4,'780','vendido','29325','2019-04-30 15:42:32','2019-04-30 16:11:11'),(6,19,'781','vendido','4503233498','2019-04-30 15:56:57','2019-05-06 18:17:41'),(7,12,'782','vendido','14205','2019-04-30 18:42:39','2019-05-06 18:17:35'),(8,11,'783','vendido',NULL,'2019-05-06 18:16:37','2019-05-07 15:30:20'),(9,18,'784','vendido',NULL,'2019-05-08 16:13:02','2019-05-13 19:37:22'),(10,3,'785','vendido','52188519','2019-05-09 14:20:13','2019-05-17 14:19:46'),(14,22,'786','vendido','87912','2019-05-13 19:58:51','2019-05-21 14:54:33'),(15,5,'787','vendido','14873','2019-05-14 13:14:21','2019-05-21 14:54:06'),(16,8,'788','vendido','10050','2019-05-14 13:16:01','2019-06-03 19:38:41'),(18,22,'790','vendido','87912','2019-05-14 14:25:49','2019-05-21 14:54:16'),(19,12,'757','vendido','14288','2019-05-16 14:39:12','2019-05-17 14:24:48'),(20,18,'758','vendido',NULL,'2019-05-17 14:37:21','2019-05-21 14:53:53'),(21,21,'791','vendido',NULL,'2019-05-21 18:12:04','2019-05-24 15:06:28'),(22,17,'792','vendido',NULL,'2019-05-22 13:01:51','2019-05-24 17:56:01'),(23,12,'793','vendido','14288','2019-05-22 13:19:49','2019-05-24 15:06:36'),(24,10,'797','vendido',NULL,'2019-05-24 16:53:03','2019-06-03 19:39:10'),(25,4,'798','vendido','24648','2019-05-24 17:17:39','2019-05-28 13:49:12'),(27,12,'799','vendido','14288','2019-05-24 17:45:31','2019-05-30 19:18:52'),(29,18,'800','vendido',NULL,'2019-05-27 19:08:38','2019-05-30 19:18:36'),(30,12,'801','vendido','14387','2019-05-27 19:13:11','2019-05-30 19:18:59'),(31,26,'802','vendido',NULL,'2019-05-27 19:17:41','2019-06-03 19:38:49'),(32,4,'803','vendido','24648','2019-05-27 19:23:56','2019-06-05 12:46:26'),(33,8,'804','vendido','10248','2019-05-28 15:02:25','2019-06-03 19:39:03'),(34,11,'805','vendido',NULL,'2019-05-28 15:25:16','2019-05-30 16:22:36'),(35,2,'806','vendido','51911376','2019-06-03 19:45:38','2019-06-06 17:56:00'),(36,22,'807','vendido','88345','2019-06-03 19:46:52','2019-06-10 19:23:22'),(37,18,'808','vendido',NULL,'2019-06-04 17:13:30','2019-06-06 17:56:06'),(38,12,'794','vendido','14474','2019-06-06 17:48:14','2019-06-10 19:24:52'),(40,4,'809','vendido','24810','2019-06-10 16:49:26','2019-06-13 17:56:40'),(41,12,'810','vendido','14484','2019-06-10 18:57:09','2019-06-13 17:56:02'),(42,18,'811','vendido',NULL,'2019-06-10 19:24:30','2019-06-13 17:56:28'),(43,12,'812','vendido',NULL,'2019-06-11 14:33:21','2019-06-13 17:56:10');
/*!40000 ALTER TABLE `remito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remito_audit`
--

DROP TABLE IF EXISTS `remito_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remito_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `numero` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ordenDeCompra` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_bf5ddd9c48e420a1c1d521e93d9b2e13_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remito_audit`
--

LOCK TABLES `remito_audit` WRITE;
/*!40000 ALTER TABLE `remito_audit` DISABLE KEYS */;
INSERT INTO `remito_audit` VALUES (1,202,12,'776','pendiente','14159','2019-04-23 13:46:38','2019-04-23 13:46:38','INS'),(1,224,12,'776','vendido','14159','2019-04-23 13:46:38','2019-04-25 16:20:55','UPD'),(2,212,18,'777','pendiente',NULL,'2019-04-23 14:13:44','2019-04-23 14:13:44','INS'),(2,226,18,'777','vendido',NULL,'2019-04-23 14:13:44','2019-04-25 18:50:49','UPD'),(3,214,1,'778','pendiente','1412','2019-04-23 14:23:18','2019-04-23 14:23:18','INS'),(3,227,1,'778','vendido','1412','2019-04-23 14:23:18','2019-04-25 18:50:52','UPD'),(4,228,4,'779','pendiente','23895','2019-04-25 19:22:35','2019-04-25 19:22:35','INS'),(4,231,4,'779','vendido','23895','2019-04-25 19:22:35','2019-04-29 17:41:34','UPD'),(5,233,4,'780','inconsistente','29325','2019-04-30 15:42:32','2019-04-30 15:42:32','INS'),(5,236,4,'780','pendiente','29325','2019-04-30 15:42:32','2019-04-30 15:49:42','UPD'),(5,238,4,'780','vendido','29325','2019-04-30 15:42:32','2019-04-30 16:11:11','UPD'),(6,237,19,'781','pendiente','4503233498','2019-04-30 15:56:57','2019-04-30 15:56:57','INS'),(6,252,19,'781','vendido','4503233498','2019-04-30 15:56:57','2019-05-06 18:17:41','UPD'),(7,243,12,'782','pendiente','14205','2019-04-30 18:42:39','2019-04-30 18:42:39','INS'),(7,251,12,'782','vendido','14205','2019-04-30 18:42:39','2019-05-06 18:17:35','UPD'),(8,250,11,'783','pendiente',NULL,'2019-05-06 18:16:37','2019-05-06 18:16:37','INS'),(8,254,11,'783','vendido',NULL,'2019-05-06 18:16:37','2019-05-07 15:30:20','UPD'),(9,263,18,'784','pendiente',NULL,'2019-05-08 16:13:02','2019-05-08 16:13:02','INS'),(9,285,18,'784','vendido',NULL,'2019-05-08 16:13:02','2019-05-13 19:37:22','UPD'),(10,266,3,'785','pendiente','52188519','2019-05-09 14:20:13','2019-05-09 14:20:13','INS'),(10,299,3,'785','vendido','52188519','2019-05-09 14:20:13','2019-05-17 14:19:46','UPD'),(14,288,22,'786','pendiente','87912','2019-05-13 19:58:51','2019-05-13 19:58:51','INS'),(14,307,22,'786','vendido','87912','2019-05-13 19:58:51','2019-05-21 14:54:33','UPD'),(15,290,5,'787','pendiente','14873','2019-05-14 13:14:21','2019-05-14 13:14:21','INS'),(15,305,5,'787','vendido','14873','2019-05-14 13:14:21','2019-05-21 14:54:06','UPD'),(16,291,8,'788','pendiente','10050','2019-05-14 13:16:01','2019-05-14 13:16:01','INS'),(16,402,8,'788','vendido','10050','2019-05-14 13:16:01','2019-06-03 19:38:41','UPD'),(17,292,8,'789','pendiente','10248','2019-05-14 13:16:40','2019-05-14 13:16:40','INS'),(18,293,22,'790','pendiente','87912','2019-05-14 14:25:49','2019-05-14 14:25:49','INS'),(18,306,22,'790','vendido','87912','2019-05-14 14:25:49','2019-05-21 14:54:16','UPD'),(19,297,12,'757','pendiente','14288','2019-05-16 14:39:12','2019-05-16 14:39:12','INS'),(19,300,12,'757','vendido','14288','2019-05-16 14:39:12','2019-05-17 14:24:48','UPD'),(20,301,18,'758','pendiente',NULL,'2019-05-17 14:37:21','2019-05-17 14:37:21','INS'),(20,304,18,'758','vendido',NULL,'2019-05-17 14:37:21','2019-05-21 14:53:53','UPD'),(21,315,21,'791','pendiente',NULL,'2019-05-21 18:12:04','2019-05-21 18:12:04','INS'),(21,329,21,'791','vendido',NULL,'2019-05-21 18:12:04','2019-05-24 15:06:28','UPD'),(22,318,17,'792','pendiente',NULL,'2019-05-22 13:01:51','2019-05-22 13:01:51','INS'),(22,360,17,'792','vendido',NULL,'2019-05-22 13:01:51','2019-05-24 17:56:01','UPD'),(23,319,12,'793','pendiente','14288','2019-05-22 13:19:49','2019-05-22 13:19:49','INS'),(23,330,12,'793','vendido','14288','2019-05-22 13:19:49','2019-05-24 15:06:36','UPD'),(24,351,10,'797','pendiente',NULL,'2019-05-24 16:53:03','2019-05-24 16:53:03','INS'),(24,405,10,'797','vendido',NULL,'2019-05-24 16:53:03','2019-06-03 19:39:10','UPD'),(25,357,4,'798','pendiente','24648','2019-05-24 17:17:39','2019-05-24 17:17:39','INS'),(25,375,4,'798','vendido','24648','2019-05-24 17:17:39','2019-05-28 13:49:12','UPD'),(26,358,12,'799',NULL,'14288','2019-05-24 17:35:22','2019-05-24 17:35:22','INS'),(27,359,12,'799','pendiente','14288','2019-05-24 17:45:31','2019-05-24 17:45:31','INS'),(27,398,12,'799','vendido','14288','2019-05-24 17:45:31','2019-05-30 19:18:52','UPD'),(28,363,18,'800',NULL,NULL,'2019-05-27 18:43:42','2019-05-27 18:43:42','INS'),(28,365,18,'800',NULL,NULL,'2019-05-27 18:43:42','2019-05-27 18:43:42','DEL'),(29,366,18,'800','pendiente',NULL,'2019-05-27 19:08:38','2019-05-27 19:08:38','INS'),(29,397,18,'800','vendido',NULL,'2019-05-27 19:08:38','2019-05-30 19:18:36','UPD'),(30,367,12,'801','pendiente','14387','2019-05-27 19:13:11','2019-05-27 19:13:11','INS'),(30,399,12,'801','vendido','14387','2019-05-27 19:13:11','2019-05-30 19:18:59','UPD'),(31,368,26,'802','pendiente',NULL,'2019-05-27 19:17:41','2019-05-27 19:17:41','INS'),(31,403,26,'802','vendido',NULL,'2019-05-27 19:17:41','2019-06-03 19:38:49','UPD'),(32,369,4,'803','pendiente','24648','2019-05-27 19:23:56','2019-05-27 19:23:56','INS'),(32,412,4,'803','vendido','24648','2019-05-27 19:23:56','2019-06-05 12:46:26','UPD'),(33,376,8,'804','pendiente','10248','2019-05-28 15:02:25','2019-05-28 15:02:25','INS'),(33,404,8,'804','vendido','10248','2019-05-28 15:02:25','2019-06-03 19:39:03','UPD'),(34,377,11,'805','pendiente',NULL,'2019-05-28 15:25:16','2019-05-28 15:25:16','INS'),(34,383,11,'805','vendido',NULL,'2019-05-28 15:25:16','2019-05-30 16:22:36','UPD'),(35,406,2,'806','pendiente','51911376','2019-06-03 19:45:38','2019-06-03 19:45:38','INS'),(35,464,2,'806','vendido','51911376','2019-06-03 19:45:38','2019-06-06 17:56:00','UPD'),(36,407,22,'807','pendiente','88345','2019-06-03 19:46:52','2019-06-03 19:46:52','INS'),(36,534,22,'807','vendido','88345','2019-06-03 19:46:52','2019-06-10 19:23:22','UPD'),(37,410,18,'808','pendiente',NULL,'2019-06-04 17:13:30','2019-06-04 17:13:30','INS'),(37,465,18,'808','vendido',NULL,'2019-06-04 17:13:30','2019-06-06 17:56:06','UPD'),(38,463,12,'794','pendiente','14474','2019-06-06 17:48:14','2019-06-06 17:48:14','INS'),(38,536,12,'794','vendido','14474','2019-06-06 17:48:14','2019-06-10 19:24:52','UPD'),(40,505,4,'809','pendiente','24810','2019-06-10 16:49:26','2019-06-10 16:49:26','INS'),(40,561,4,'809','vendido','24810','2019-06-10 16:49:26','2019-06-13 17:56:40','UPD'),(41,533,12,'810','pendiente','14484','2019-06-10 18:57:09','2019-06-10 18:57:09','INS'),(41,558,12,'810','vendido','14484','2019-06-10 18:57:09','2019-06-13 17:56:02','UPD'),(42,535,18,'811','inconsistente',NULL,'2019-06-10 19:24:30','2019-06-10 19:24:30','INS'),(42,544,18,'811','pendiente',NULL,'2019-06-10 19:24:30','2019-06-11 14:19:36','UPD'),(42,560,18,'811','vendido',NULL,'2019-06-10 19:24:30','2019-06-13 17:56:28','UPD'),(43,553,12,'812','pendiente',NULL,'2019-06-11 14:33:21','2019-06-11 14:33:21','INS'),(43,559,12,'812','vendido',NULL,'2019-06-11 14:33:21','2019-06-13 17:56:10','UPD');
/*!40000 ALTER TABLE `remito_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=566 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
INSERT INTO `revisions` VALUES (1,'2019-04-02 16:38:05',''),(2,'2019-04-02 17:45:43','admin'),(3,'2019-04-03 12:54:27','admin'),(4,'2019-04-03 14:51:25','admin'),(5,'2019-04-03 14:52:55','admin'),(6,'2019-04-03 14:53:11','admin'),(7,'2019-04-03 14:54:12','admin'),(8,'2019-04-03 14:55:32','admin'),(9,'2019-04-03 14:58:36','admin'),(10,'2019-04-03 14:59:18','admin'),(11,'2019-04-03 14:59:39','admin'),(12,'2019-04-03 14:59:56','admin'),(13,'2019-04-03 15:16:33','admin'),(14,'2019-04-03 15:20:14','admin'),(15,'2019-04-03 15:31:52','admin'),(16,'2019-04-03 15:37:00','admin'),(17,'2019-04-03 15:39:23','admin'),(18,'2019-04-03 15:41:10','admin'),(19,'2019-04-03 15:43:25','admin'),(20,'2019-04-03 15:44:12','admin'),(21,'2019-04-03 15:45:02','admin'),(22,'2019-04-03 15:45:48','admin'),(23,'2019-04-03 15:48:38','admin'),(24,'2019-04-03 15:49:02','admin'),(25,'2019-04-03 15:49:22','admin'),(26,'2019-04-03 15:52:38','admin'),(27,'2019-04-03 15:54:16','admin'),(28,'2019-04-03 15:56:41','admin'),(29,'2019-04-03 15:57:04','admin'),(30,'2019-04-03 15:58:38','admin'),(31,'2019-04-03 16:01:49','admin'),(32,'2019-04-03 16:03:49','admin'),(33,'2019-04-03 16:08:31','admin'),(34,'2019-04-03 16:08:51','admin'),(35,'2019-04-03 16:14:00','admin'),(36,'2019-04-03 16:16:09','admin'),(37,'2019-04-03 16:20:44','admin'),(38,'2019-04-04 14:08:09','admin'),(39,'2019-04-04 14:14:34','admin'),(40,'2019-04-04 14:33:28','admin'),(41,'2019-04-04 14:34:32','admin'),(42,'2019-04-04 14:35:01','admin'),(43,'2019-04-04 14:35:21','admin'),(44,'2019-04-04 14:35:47','admin'),(45,'2019-04-04 14:39:19','admin'),(46,'2019-04-04 14:39:25','admin'),(47,'2019-04-04 14:40:59','admin'),(48,'2019-04-04 14:41:18','admin'),(49,'2019-04-04 14:42:05','admin'),(50,'2019-04-04 14:46:22','admin'),(51,'2019-04-04 14:47:50','admin'),(52,'2019-04-04 14:50:55','admin'),(53,'2019-04-04 14:51:58','admin'),(54,'2019-04-04 14:54:05','admin'),(55,'2019-04-04 14:59:04','admin'),(56,'2019-04-04 15:00:09','admin'),(57,'2019-04-04 15:01:18','admin'),(58,'2019-04-04 15:02:36','admin'),(59,'2019-04-04 15:03:59','admin'),(60,'2019-04-04 15:05:16','admin'),(61,'2019-04-04 15:13:07','admin'),(62,'2019-04-04 15:15:23','admin'),(63,'2019-04-04 15:16:06','admin'),(64,'2019-04-04 15:16:55','admin'),(65,'2019-04-04 15:17:45','admin'),(66,'2019-04-04 15:19:50','admin'),(67,'2019-04-04 15:22:09','admin'),(68,'2019-04-04 15:23:18','admin'),(69,'2019-04-04 15:24:55','admin'),(70,'2019-04-04 15:25:21','admin'),(71,'2019-04-04 15:25:43','admin'),(72,'2019-04-04 15:26:00','admin'),(73,'2019-04-04 15:36:21','admin'),(74,'2019-04-04 15:36:53','admin'),(75,'2019-04-04 15:42:40','admin'),(76,'2019-04-04 15:45:38','admin'),(77,'2019-04-04 15:47:20','admin'),(78,'2019-04-04 15:54:44','admin'),(79,'2019-04-04 16:01:07','admin'),(80,'2019-04-04 16:09:58','admin'),(81,'2019-04-04 16:13:31','admin'),(82,'2019-04-04 16:13:31','admin'),(83,'2019-04-04 16:14:02','admin'),(84,'2019-04-04 16:20:28','admin'),(85,'2019-04-04 16:25:45','admin'),(86,'2019-04-04 16:29:03','admin'),(87,'2019-04-04 16:35:21','admin'),(88,'2019-04-04 16:39:40','admin'),(89,'2019-04-04 16:44:24','admin'),(90,'2019-04-04 16:51:24','admin'),(91,'2019-04-04 16:56:39','admin'),(92,'2019-04-04 16:57:34','admin'),(93,'2019-04-04 17:02:19','admin'),(94,'2019-04-04 17:08:53','admin'),(95,'2019-04-04 17:17:53','admin'),(96,'2019-04-04 17:23:59','admin'),(97,'2019-04-04 17:23:59','admin'),(98,'2019-04-04 17:24:11','admin'),(99,'2019-04-04 17:24:34','admin'),(100,'2019-04-04 17:24:42','admin'),(101,'2019-04-04 18:20:03','admin'),(102,'2019-04-04 18:29:31','admin'),(103,'2019-04-04 18:34:28','admin'),(104,'2019-04-04 18:47:37','admin'),(105,'2019-04-04 18:49:34','admin'),(106,'2019-04-04 18:57:27','admin'),(107,'2019-04-08 19:43:44','admin'),(108,'2019-04-08 19:49:03','admin'),(109,'2019-04-10 16:31:17','admin'),(110,'2019-04-12 14:06:36','admin'),(111,'2019-04-16 13:40:03','admin'),(112,'2019-04-16 13:44:14','admin'),(113,'2019-04-16 13:44:14','admin'),(114,'2019-04-16 13:47:57','admin'),(115,'2019-04-16 13:47:57','admin'),(116,'2019-04-16 14:23:52','admin'),(117,'2019-04-16 14:23:52','admin'),(118,'2019-04-16 14:25:25','admin'),(119,'2019-04-16 14:25:25','admin'),(120,'2019-04-16 14:30:03','admin'),(121,'2019-04-16 14:30:03','admin'),(122,'2019-04-16 14:32:26','admin'),(123,'2019-04-16 14:32:32','admin'),(124,'2019-04-16 14:33:52','admin'),(125,'2019-04-16 14:33:52','admin'),(126,'2019-04-16 14:34:10','admin'),(127,'2019-04-16 14:38:19','admin'),(128,'2019-04-16 14:38:19','admin'),(129,'2019-04-16 14:38:27','admin'),(130,'2019-04-16 14:39:09','admin'),(131,'2019-04-16 14:39:09','admin'),(132,'2019-04-16 14:39:19','admin'),(133,'2019-04-16 14:40:45','admin'),(134,'2019-04-16 14:40:45','admin'),(135,'2019-04-16 14:40:57','admin'),(136,'2019-04-16 14:41:17','admin'),(137,'2019-04-16 14:42:23','admin'),(138,'2019-04-16 14:42:23','admin'),(139,'2019-04-16 14:42:29','admin'),(140,'2019-04-16 14:43:12','admin'),(141,'2019-04-16 14:43:12','admin'),(142,'2019-04-16 14:43:24','admin'),(143,'2019-04-16 14:43:38','admin'),(144,'2019-04-16 14:43:38','admin'),(145,'2019-04-16 14:43:44','admin'),(146,'2019-04-16 14:44:11','admin'),(147,'2019-04-16 14:44:11','admin'),(148,'2019-04-16 14:44:18','admin'),(149,'2019-04-16 14:45:21','admin'),(150,'2019-04-16 14:45:21','admin'),(151,'2019-04-16 14:45:32','admin'),(152,'2019-04-16 14:46:00','admin'),(153,'2019-04-16 14:46:00','admin'),(154,'2019-04-16 14:46:06','admin'),(155,'2019-04-16 14:47:00','admin'),(156,'2019-04-16 14:47:00','admin'),(157,'2019-04-16 14:47:09','admin'),(158,'2019-04-16 14:47:23','admin'),(159,'2019-04-16 14:47:23','admin'),(160,'2019-04-16 14:47:28','admin'),(161,'2019-04-16 14:48:03','admin'),(162,'2019-04-16 14:48:03','admin'),(163,'2019-04-16 14:48:10','admin'),(164,'2019-04-16 14:48:34','admin'),(165,'2019-04-16 14:51:14','admin'),(166,'2019-04-16 14:51:14','admin'),(167,'2019-04-16 14:51:21','admin'),(168,'2019-04-16 14:51:53','admin'),(169,'2019-04-16 14:51:53','admin'),(170,'2019-04-16 14:51:59','admin'),(171,'2019-04-16 14:52:18','admin'),(172,'2019-04-16 14:52:18','admin'),(173,'2019-04-16 14:52:24','admin'),(174,'2019-04-16 14:55:51','admin'),(175,'2019-04-16 14:55:51','admin'),(176,'2019-04-16 14:55:57','admin'),(177,'2019-04-16 14:57:58','admin'),(178,'2019-04-16 14:57:58','admin'),(179,'2019-04-16 14:58:06','admin'),(180,'2019-04-16 15:00:03','admin'),(181,'2019-04-16 15:00:03','admin'),(182,'2019-04-16 15:00:19','admin'),(183,'2019-04-16 15:01:30','admin'),(184,'2019-04-16 15:02:48','admin'),(185,'2019-04-16 15:02:48','admin'),(186,'2019-04-16 15:03:10','admin'),(187,'2019-04-16 15:03:28','admin'),(188,'2019-04-16 15:04:15','admin'),(189,'2019-04-16 15:04:15','admin'),(190,'2019-04-16 15:05:36','admin'),(191,'2019-04-16 15:06:10','admin'),(192,'2019-04-16 15:06:46','admin'),(193,'2019-04-16 15:06:51','admin'),(194,'2019-04-16 15:06:51','admin'),(195,'2019-04-16 15:08:23','admin'),(196,'2019-04-16 15:08:23','admin'),(197,'2019-04-16 15:10:38','admin'),(198,'2019-04-16 15:10:38','admin'),(199,'2019-04-16 15:12:34','admin'),(200,'2019-04-23 13:38:02','admin'),(201,'2019-04-23 13:45:34','admin'),(202,'2019-04-23 13:46:38','admin'),(203,'2019-04-23 13:57:17','admin'),(204,'2019-04-23 13:58:14','admin'),(205,'2019-04-23 13:58:14','admin'),(206,'2019-04-23 13:58:55','admin'),(207,'2019-04-23 13:59:16','admin'),(208,'2019-04-23 13:59:45','admin'),(209,'2019-04-23 14:11:39','admin'),(210,'2019-04-23 14:11:39','admin'),(211,'2019-04-23 14:11:39','admin'),(212,'2019-04-23 14:13:44','admin'),(213,'2019-04-23 14:22:23','admin'),(214,'2019-04-23 14:23:18','admin'),(215,'2019-04-23 17:01:08','admin'),(216,'2019-04-23 17:01:24','admin'),(217,'2019-04-23 17:02:01','admin'),(218,'2019-04-24 15:19:38','admin'),(219,'2019-04-24 15:54:07','admin'),(220,'2019-04-25 15:16:00','admin'),(221,'2019-04-25 16:19:39','admin'),(222,'2019-04-25 16:20:12','admin'),(223,'2019-04-25 16:20:47','admin'),(224,'2019-04-25 16:20:55','admin'),(225,'2019-04-25 18:50:28','admin'),(226,'2019-04-25 18:50:49','admin'),(227,'2019-04-25 18:50:52','admin'),(228,'2019-04-25 19:22:35','admin'),(229,'2019-04-26 16:32:41','admin'),(230,'2019-04-29 17:23:54','admin'),(231,'2019-04-29 17:41:34','admin'),(232,'2019-04-30 15:35:02','admin'),(233,'2019-04-30 15:42:32','admin'),(234,'2019-04-30 15:49:25','admin'),(235,'2019-04-30 15:49:25','admin'),(236,'2019-04-30 15:49:42','admin'),(237,'2019-04-30 15:56:57','admin'),(238,'2019-04-30 16:11:11','admin'),(239,'2019-04-30 16:13:14','admin'),(240,'2019-04-30 16:13:17','admin'),(241,'2019-04-30 16:14:48','admin'),(242,'2019-04-30 18:42:00','admin'),(243,'2019-04-30 18:42:39','admin'),(244,'2019-05-02 13:40:01','admin'),(245,'2019-05-02 18:05:17','admin'),(246,'2019-05-02 18:05:35','admin'),(247,'2019-05-02 18:20:17','admin'),(248,'2019-05-02 18:20:32','admin'),(249,'2019-05-06 18:09:53','admin'),(250,'2019-05-06 18:16:37','admin'),(251,'2019-05-06 18:17:35','admin'),(252,'2019-05-06 18:17:41','admin'),(253,'2019-05-07 15:30:15','admin'),(254,'2019-05-07 15:30:20','admin'),(255,'2019-05-07 15:31:46','admin'),(256,'2019-05-07 15:32:43','admin'),(257,'2019-05-07 15:32:43','admin'),(258,'2019-05-08 16:02:14','admin'),(259,'2019-05-08 16:04:54','admin'),(260,'2019-05-08 16:08:53','admin'),(261,'2019-05-08 16:08:53','admin'),(262,'2019-05-08 16:08:53','admin'),(263,'2019-05-08 16:13:02','admin'),(264,'2019-05-09 14:14:09','admin'),(265,'2019-05-09 14:19:38','admin'),(266,'2019-05-09 14:20:13','admin'),(267,'2019-05-09 20:04:43','admin'),(268,'2019-05-10 17:48:27','admin'),(269,'2019-05-10 17:52:26','admin'),(270,'2019-05-13 15:02:57','admin'),(271,'2019-05-13 18:21:59','admin'),(272,'2019-05-13 18:22:28','admin'),(273,'2019-05-13 18:22:46','admin'),(274,'2019-05-13 18:22:56','admin'),(275,'2019-05-13 18:32:12','admin'),(276,'2019-05-13 18:32:35','admin'),(277,'2019-05-13 18:41:22','admin'),(278,'2019-05-13 18:44:01','admin'),(279,'2019-05-13 18:57:11','admin'),(280,'2019-05-13 18:58:30','admin'),(281,'2019-05-13 18:59:23','admin'),(282,'2019-05-13 19:00:23','admin'),(283,'2019-05-13 19:02:31','admin'),(284,'2019-05-13 19:37:12','admin'),(285,'2019-05-13 19:37:22','admin'),(286,'2019-05-13 19:56:13','admin'),(287,'2019-05-13 19:56:14','admin'),(288,'2019-05-13 19:58:51','admin'),(289,'2019-05-14 13:11:20','admin'),(290,'2019-05-14 13:14:21','admin'),(291,'2019-05-14 13:16:01','admin'),(292,'2019-05-14 13:16:40','admin'),(293,'2019-05-14 14:25:49','admin'),(294,'2019-05-14 18:35:48','admin'),(295,'2019-05-15 13:36:39','admin'),(296,'2019-05-16 13:53:01','admin'),(297,'2019-05-16 14:39:12','admin'),(298,'2019-05-17 14:18:26','admin'),(299,'2019-05-17 14:19:46','admin'),(300,'2019-05-17 14:24:48','admin'),(301,'2019-05-17 14:37:21','admin'),(302,'2019-05-21 13:01:45','admin'),(303,'2019-05-21 14:53:43','admin'),(304,'2019-05-21 14:53:53','admin'),(305,'2019-05-21 14:54:06','admin'),(306,'2019-05-21 14:54:16','admin'),(307,'2019-05-21 14:54:33','admin'),(308,'2019-05-21 15:11:13','admin'),(309,'2019-05-21 16:26:00','admin'),(310,'2019-05-21 17:31:50','admin'),(311,'2019-05-21 17:31:50','admin'),(312,'2019-05-21 17:36:56','admin'),(313,'2019-05-21 17:36:56','admin'),(314,'2019-05-21 18:07:38','admin'),(315,'2019-05-21 18:12:04','admin'),(316,'2019-05-21 18:22:14','admin'),(317,'2019-05-22 12:31:19','admin'),(318,'2019-05-22 13:01:51','admin'),(319,'2019-05-22 13:19:49','admin'),(320,'2019-05-23 16:00:44','admin'),(321,'2019-05-24 13:23:55','admin'),(322,'2019-05-24 13:31:56','admin'),(323,'2019-05-24 13:32:15','admin'),(324,'2019-05-24 13:32:33','admin'),(325,'2019-05-24 13:33:49','admin'),(326,'2019-05-24 13:34:48','admin'),(327,'2019-05-24 13:35:40','admin'),(328,'2019-05-24 15:06:28','admin'),(329,'2019-05-24 15:06:28','admin'),(330,'2019-05-24 15:06:36','admin'),(331,'2019-05-24 15:27:44','admin'),(332,'2019-05-24 15:27:44','admin'),(333,'2019-05-24 15:27:44','admin'),(334,'2019-05-24 15:27:46','admin'),(335,'2019-05-24 15:27:46','admin'),(336,'2019-05-24 15:27:46','admin'),(337,'2019-05-24 15:27:49','admin'),(338,'2019-05-24 15:27:49','admin'),(339,'2019-05-24 15:27:49','admin'),(340,'2019-05-24 15:27:52','admin'),(341,'2019-05-24 15:27:52','admin'),(342,'2019-05-24 15:27:52','admin'),(343,'2019-05-24 15:29:53','admin'),(344,'2019-05-24 15:29:59','admin'),(345,'2019-05-24 15:30:16','admin'),(346,'2019-05-24 15:30:40','admin'),(347,'2019-05-24 15:30:57','admin'),(348,'2019-05-24 15:31:41','admin'),(349,'2019-05-24 15:35:40','admin'),(350,'2019-05-24 15:50:13','admin'),(351,'2019-05-24 16:53:03','admin'),(352,'2019-05-24 16:54:43','admin'),(353,'2019-05-24 17:00:50','admin'),(354,'2019-05-24 17:10:27','admin'),(355,'2019-05-24 17:11:48','admin'),(356,'2019-05-24 17:12:10','admin'),(357,'2019-05-24 17:17:39','admin'),(358,'2019-05-24 17:35:22','admin'),(359,'2019-05-24 17:45:31','admin'),(360,'2019-05-24 17:56:01','admin'),(361,'2019-05-27 17:35:12','admin'),(362,'2019-05-27 18:42:40','admin'),(363,'2019-05-27 18:43:42','admin'),(364,'2019-05-27 18:58:24','admin'),(365,'2019-05-27 18:58:29','admin'),(366,'2019-05-27 19:08:38','admin'),(367,'2019-05-27 19:13:11','admin'),(368,'2019-05-27 19:17:41','admin'),(369,'2019-05-27 19:23:56','admin'),(370,'2019-05-28 12:43:42','admin'),(371,'2019-05-28 12:44:42','admin'),(372,'2019-05-28 12:44:56','admin'),(373,'2019-05-28 12:48:57','admin'),(374,'2019-05-28 13:07:38','admin'),(375,'2019-05-28 13:49:12','admin'),(376,'2019-05-28 15:02:25','admin'),(377,'2019-05-28 15:25:16','admin'),(378,'2019-05-30 12:49:31','admin'),(379,'2019-05-30 12:55:51','admin'),(380,'2019-05-30 15:59:07','admin'),(381,'2019-05-30 16:02:34','admin'),(382,'2019-05-30 16:10:19','admin'),(383,'2019-05-30 16:22:36','admin'),(384,'2019-05-30 16:26:01','admin'),(385,'2019-05-30 16:51:03','admin'),(386,'2019-05-30 18:17:55','admin'),(387,'2019-05-30 18:36:01','admin'),(388,'2019-05-30 18:36:35','admin'),(389,'2019-05-30 18:38:04','admin'),(390,'2019-05-30 18:38:26','admin'),(391,'2019-05-30 18:40:24','admin'),(392,'2019-05-30 18:40:24','admin'),(393,'2019-05-30 18:56:16','admin'),(394,'2019-05-30 18:57:12','admin'),(395,'2019-05-30 18:58:18','admin'),(396,'2019-05-30 18:58:56','admin'),(397,'2019-05-30 19:18:36','admin'),(398,'2019-05-30 19:18:52','admin'),(399,'2019-05-30 19:18:59','admin'),(400,'2019-05-30 19:26:29','admin'),(401,'2019-06-03 19:37:59','admin'),(402,'2019-06-03 19:38:41','admin'),(403,'2019-06-03 19:38:49','admin'),(404,'2019-06-03 19:39:03','admin'),(405,'2019-06-03 19:39:10','admin'),(406,'2019-06-03 19:45:38','admin'),(407,'2019-06-03 19:46:52','admin'),(408,'2019-06-03 19:55:22','admin'),(409,'2019-06-04 17:11:01','admin'),(410,'2019-06-04 17:13:30','admin'),(411,'2019-06-05 12:44:27','admin'),(412,'2019-06-05 12:46:26','admin'),(413,'2019-06-05 13:19:50','admin'),(414,'2019-06-05 13:26:34','admin'),(415,'2019-06-05 13:26:34','admin'),(416,'2019-06-05 13:26:34','admin'),(417,'2019-06-05 13:27:41','admin'),(418,'2019-06-05 13:27:41','admin'),(419,'2019-06-05 13:27:41','admin'),(420,'2019-06-05 13:28:14','admin'),(421,'2019-06-05 13:28:14','admin'),(422,'2019-06-05 13:28:14','admin'),(423,'2019-06-05 13:28:39','admin'),(424,'2019-06-05 13:29:07','admin'),(425,'2019-06-05 13:29:17','admin'),(426,'2019-06-05 13:30:31','admin'),(427,'2019-06-05 13:30:31','admin'),(428,'2019-06-05 13:30:31','admin'),(429,'2019-06-05 13:55:04','admin'),(430,'2019-06-05 13:55:29','admin'),(431,'2019-06-05 20:24:30','admin'),(432,'2019-06-05 22:22:40','admin'),(433,'2019-06-05 22:22:48','admin'),(434,'2019-06-05 22:22:48','admin'),(435,'2019-06-05 22:22:48','admin'),(436,'2019-06-05 22:22:48','admin'),(437,'2019-06-05 22:22:48','admin'),(438,'2019-06-05 22:23:18','admin'),(439,'2019-06-05 22:23:18','admin'),(440,'2019-06-05 22:23:18','admin'),(441,'2019-06-05 22:23:18','admin'),(442,'2019-06-05 22:23:18','admin'),(443,'2019-06-05 22:23:23','admin'),(444,'2019-06-05 22:23:23','admin'),(445,'2019-06-05 22:23:23','admin'),(446,'2019-06-05 22:23:23','admin'),(447,'2019-06-05 22:23:23','admin'),(448,'2019-06-05 22:23:23','admin'),(449,'2019-06-05 22:23:25','admin'),(450,'2019-06-05 22:23:25','admin'),(451,'2019-06-05 22:23:25','admin'),(452,'2019-06-05 22:23:25','admin'),(453,'2019-06-05 22:23:25','admin'),(454,'2019-06-05 22:23:25','admin'),(455,'2019-06-05 22:23:28','admin'),(456,'2019-06-05 22:23:28','admin'),(457,'2019-06-05 22:23:28','admin'),(458,'2019-06-05 22:23:28','admin'),(459,'2019-06-05 22:23:28','admin'),(460,'2019-06-05 22:23:28','admin'),(461,'2019-06-05 22:28:56','admin'),(462,'2019-06-06 17:46:32','admin'),(463,'2019-06-06 17:48:14','admin'),(464,'2019-06-06 17:56:00','admin'),(465,'2019-06-06 17:56:06','admin'),(466,'2019-06-06 18:51:10','admin'),(467,'2019-06-06 18:59:39','admin'),(468,'2019-06-06 19:03:27','admin'),(469,'2019-06-06 19:04:51','admin'),(470,'2019-06-06 19:06:16','admin'),(471,'2019-06-06 19:08:12','admin'),(472,'2019-06-06 19:09:36','admin'),(473,'2019-06-06 19:10:44','admin'),(474,'2019-06-06 19:12:29','admin'),(475,'2019-06-06 19:16:23','admin'),(476,'2019-06-06 19:17:03','admin'),(477,'2019-06-06 19:19:25','admin'),(478,'2019-06-06 19:19:25','admin'),(479,'2019-06-06 19:19:32','admin'),(480,'2019-06-06 19:19:32','admin'),(481,'2019-06-06 19:19:32','admin'),(482,'2019-06-06 19:19:38','admin'),(483,'2019-06-06 19:19:38','admin'),(484,'2019-06-06 19:19:38','admin'),(485,'2019-06-06 19:19:47','admin'),(486,'2019-06-06 19:19:47','admin'),(487,'2019-06-06 19:19:47','admin'),(488,'2019-06-06 19:20:01','admin'),(489,'2019-06-06 19:20:01','admin'),(490,'2019-06-06 19:20:01','admin'),(491,'2019-06-06 19:20:04','admin'),(492,'2019-06-06 19:20:04','admin'),(493,'2019-06-06 19:20:04','admin'),(494,'2019-06-06 19:20:07','admin'),(495,'2019-06-06 19:20:07','admin'),(496,'2019-06-06 19:20:07','admin'),(497,'2019-06-06 19:20:59','admin'),(498,'2019-06-06 19:21:39','admin'),(499,'2019-06-06 19:21:57','admin'),(500,'2019-06-06 19:22:15','admin'),(501,'2019-06-06 19:22:30','admin'),(502,'2019-06-06 19:22:46','admin'),(503,'2019-06-10 13:14:48','admin'),(504,'2019-06-10 16:37:59','admin'),(505,'2019-06-10 16:49:26','admin'),(506,'2019-06-10 16:52:37','admin'),(507,'2019-06-10 16:52:57','admin'),(508,'2019-06-10 16:53:11','admin'),(509,'2019-06-10 16:53:26','admin'),(510,'2019-06-10 16:54:08','admin'),(511,'2019-06-10 16:54:22','admin'),(512,'2019-06-10 16:54:39','admin'),(513,'2019-06-10 16:55:00','admin'),(514,'2019-06-10 16:55:15','admin'),(515,'2019-06-10 16:55:28','admin'),(516,'2019-06-10 16:55:40','admin'),(517,'2019-06-10 16:55:56','admin'),(518,'2019-06-10 16:56:09','admin'),(519,'2019-06-10 16:56:22','admin'),(520,'2019-06-10 16:56:36','admin'),(521,'2019-06-10 18:19:44','admin'),(522,'2019-06-10 18:36:32','admin'),(523,'2019-06-10 18:37:01','admin'),(524,'2019-06-10 18:37:44','admin'),(525,'2019-06-10 18:38:46','admin'),(526,'2019-06-10 18:39:27','admin'),(527,'2019-06-10 18:40:02','admin'),(528,'2019-06-10 18:41:43','admin'),(529,'2019-06-10 18:48:51','admin'),(530,'2019-06-10 18:49:30','admin'),(531,'2019-06-10 18:52:31','admin'),(532,'2019-06-10 18:53:12','admin'),(533,'2019-06-10 18:57:09','admin'),(534,'2019-06-10 19:23:22','admin'),(535,'2019-06-10 19:24:30','admin'),(536,'2019-06-10 19:24:52','admin'),(537,'2019-06-10 19:25:48','admin'),(538,'2019-06-10 20:29:01','admin'),(539,'2019-06-11 12:50:57','admin'),(540,'2019-06-11 14:16:27','admin'),(541,'2019-06-11 14:16:27','admin'),(542,'2019-06-11 14:16:27','admin'),(543,'2019-06-11 14:19:17','admin'),(544,'2019-06-11 14:19:36','admin'),(545,'2019-06-11 14:21:29','admin'),(546,'2019-06-11 14:21:44','admin'),(547,'2019-06-11 14:21:54','admin'),(548,'2019-06-11 14:21:59','admin'),(549,'2019-06-11 14:22:10','admin'),(550,'2019-06-11 14:23:24','admin'),(551,'2019-06-11 14:23:34','admin'),(552,'2019-06-11 14:23:45','admin'),(553,'2019-06-11 14:33:21','admin'),(554,'2019-06-11 17:47:49','admin'),(555,'2019-06-12 14:49:07','admin'),(556,'2019-06-12 16:20:33','admin'),(557,'2019-06-13 17:41:44','admin'),(558,'2019-06-13 17:56:02','admin'),(559,'2019-06-13 17:56:10','admin'),(560,'2019-06-13 17:56:28','admin'),(561,'2019-06-13 17:56:40','admin'),(562,'2019-06-13 18:52:33','admin'),(563,'2019-06-13 18:53:21','admin'),(564,'2019-06-13 18:53:39','admin'),(565,'2019-06-14 03:28:35','admin');
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-14 12:59:29
