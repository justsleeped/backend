-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: sealflow
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `act_evt_log`
--

DROP TABLE IF EXISTS `act_evt_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_evt_log` (
  `LOG_NR_` bigint NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_evt_log`
--

LOCK TABLES `act_evt_log` WRITE;
/*!40000 ALTER TABLE `act_evt_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_evt_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ge_bytearray`
--

DROP TABLE IF EXISTS `act_ge_bytearray`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ge_bytearray`
--

LOCK TABLES `act_ge_bytearray` WRITE;
/*!40000 ALTER TABLE `act_ge_bytearray` DISABLE KEYS */;
INSERT INTO `act_ge_bytearray` VALUES ('57502',1,'StudentOrgSealApprovalProcess.bpmn20.xml','57501',_binary '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" xmlns:flowable=\"http://flowable.org/bpmn\" targetNamespace=\"http://www.flowable.org/processdef\">\n  <process id=\"StudentOrgSealApprovalProcess\" name=\"Èô¢Á´†ÂÆ°ÊâπÔºàÂ≠¶ÁîüÔºâ\" isExecutable=\"true\">\n    <startEvent id=\"StartEvent_1\" name=\"ÂºÄÂßã\">\n      <outgoing>Flow_1gtutt3</outgoing>\n    </startEvent>\n    <userTask id=\"headTeacherApproval\" name=\"Áè≠‰∏ª‰ªªÂÆ°Êâπ\" flowable:candidateGroups=\"2013952715229585409\" flowable:assignee=\"2013951215732350978\">\n      <incoming>Flow_1gtutt3</incoming>\n      <outgoing>Flow_1ln9kdp</outgoing>\n    </userTask>\n    <userTask id=\"counselorApproval\" name=\"ËæÖÂØºÂëòÂÆ°Êâπ\" flowable:candidateGroups=\"2013952827238473729\" flowable:assignee=\"2013951264663101441\">\n      <incoming>Flow_1f887dt</incoming>\n      <outgoing>Flow_096picz</outgoing>\n    </userTask>\n    <endEvent id=\"EndEvent_1\" name=\"ÂêåÊÑè\">\n      <incoming>Flow_0piie6u</incoming>\n    </endEvent>\n    <userTask id=\"deanApproval\" name=\"Èô¢ÈïøÂÆ°Êâπ\" flowable:candidateGroups=\"2013952886889865217\" flowable:assignee=\"2013951338067615746\">\n      <incoming>Flow_1bf6tjw</incoming>\n      <outgoing>Flow_179uijp</outgoing>\n    </userTask>\n    <sequenceFlow id=\"Flow_179uijp\" sourceRef=\"deanApproval\" targetRef=\"Gateway_dean\" />\n    <exclusiveGateway id=\"Gateway_headTeacher\" name=\"Áè≠‰∏ª‰ªªÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_1ln9kdp</incoming>\n      <outgoing>Flow_1qajers</outgoing>\n      <outgoing>Flow_1f887dt</outgoing>\n    </exclusiveGateway>\n    <exclusiveGateway id=\"Gateway_counselor\" name=\"ËæÖÂØºÂëòÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_096picz</incoming>\n      <outgoing>Flow_1bf6tjw</outgoing>\n      <outgoing>Flow_06phn3v</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_1bf6tjw\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_counselor\" targetRef=\"deanApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <exclusiveGateway id=\"Gateway_dean\" name=\"Èô¢ÈïøÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_179uijp</incoming>\n      <outgoing>Flow_0piie6u</outgoing>\n      <outgoing>Flow_0hf6ise</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_0piie6u\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_dean\" targetRef=\"EndEvent_1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <endEvent id=\"Event_00f37w1\" name=\"ÊãíÁªù\">\n      <incoming>Flow_1qajers</incoming>\n      <incoming>Flow_06phn3v</incoming>\n      <incoming>Flow_0hf6ise</incoming>\n    </endEvent>\n    <sequenceFlow id=\"Flow_1qajers\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_headTeacher\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_06phn3v\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_counselor\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_0hf6ise\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_dean\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_1gtutt3\" sourceRef=\"StartEvent_1\" targetRef=\"headTeacherApproval\" />\n    <sequenceFlow id=\"Flow_1ln9kdp\" sourceRef=\"headTeacherApproval\" targetRef=\"Gateway_headTeacher\" />\n    <sequenceFlow id=\"Flow_1f887dt\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_headTeacher\" targetRef=\"counselorApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_096picz\" sourceRef=\"counselorApproval\" targetRef=\"Gateway_counselor\" />\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_1\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_1\" bpmnElement=\"StudentOrgSealApprovalProcess\">\n      <bpmndi:BPMNEdge id=\"Flow_096picz_di\" bpmnElement=\"Flow_096picz\">\n        <omgdi:waypoint x=\"530\" y=\"178\" />\n        <omgdi:waypoint x=\"575\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1f887dt_di\" bpmnElement=\"Flow_1f887dt\">\n        <omgdi:waypoint x=\"395\" y=\"178\" />\n        <omgdi:waypoint x=\"430\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"402\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1ln9kdp_di\" bpmnElement=\"Flow_1ln9kdp\">\n        <omgdi:waypoint x=\"310\" y=\"178\" />\n        <omgdi:waypoint x=\"345\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1gtutt3_di\" bpmnElement=\"Flow_1gtutt3\">\n        <omgdi:waypoint x=\"168\" y=\"178\" />\n        <omgdi:waypoint x=\"210\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0hf6ise_di\" bpmnElement=\"Flow_0hf6ise\">\n        <omgdi:waypoint x=\"840\" y=\"203\" />\n        <omgdi:waypoint x=\"840\" y=\"270\" />\n        <omgdi:waypoint x=\"618\" y=\"270\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"844\" y=\"234\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_06phn3v_di\" bpmnElement=\"Flow_06phn3v\">\n        <omgdi:waypoint x=\"600\" y=\"203\" />\n        <omgdi:waypoint x=\"600\" y=\"252\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"604\" y=\"225\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1qajers_di\" bpmnElement=\"Flow_1qajers\">\n        <omgdi:waypoint x=\"370\" y=\"203\" />\n        <omgdi:waypoint x=\"370\" y=\"270\" />\n        <omgdi:waypoint x=\"582\" y=\"270\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"374\" y=\"234\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0piie6u_di\" bpmnElement=\"Flow_0piie6u\">\n        <omgdi:waypoint x=\"865\" y=\"178\" />\n        <omgdi:waypoint x=\"912\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"878\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1bf6tjw_di\" bpmnElement=\"Flow_1bf6tjw\">\n        <omgdi:waypoint x=\"625\" y=\"178\" />\n        <omgdi:waypoint x=\"670\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"637\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_179uijp_di\" bpmnElement=\"Flow_179uijp\">\n        <omgdi:waypoint x=\"770\" y=\"178\" />\n        <omgdi:waypoint x=\"815\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNShape id=\"_BPMNShape_StartEvent_2\" bpmnElement=\"StartEvent_1\">\n        <omgdc:Bounds x=\"132\" y=\"160\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"141\" y=\"203\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_1\" bpmnElement=\"headTeacherApproval\">\n        <omgdc:Bounds x=\"210\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_2\" bpmnElement=\"counselorApproval\">\n        <omgdc:Bounds x=\"430\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_EndEvent_1\" bpmnElement=\"EndEvent_1\">\n        <omgdc:Bounds x=\"912\" y=\"160\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"921\" y=\"203\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_1gx0z7o_di\" bpmnElement=\"deanApproval\">\n        <omgdc:Bounds x=\"670\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1078bu6_di\" bpmnElement=\"Gateway_headTeacher\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"345\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"332\" y=\"123\" width=\"77\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1mawix4_di\" bpmnElement=\"Gateway_counselor\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"575\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"562\" y=\"123\" width=\"77\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_0orv4am_di\" bpmnElement=\"Gateway_dean\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"815\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"807\" y=\"123\" width=\"66\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Event_00f37w1_di\" bpmnElement=\"Event_00f37w1\">\n        <omgdc:Bounds x=\"582\" y=\"252\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"589\" y=\"295\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>\n',0),('57503',1,'StudentOrgSealApprovalProcess.StudentOrgSealApprovalProcess.png','57501',_binary 'âPNG\r\n\Z\n\0\0\0\rIHDR\0\0æ\0\0*\0\0\02å}\0\0\"/IDATx^\Ì\››èú’ù\'\ûiÖ\ˆä\Ï\Œ\\rì´¸ôΩÄãDª\⁄Hôπ0nwcH[&¡Q\"πQ\÷n-Nêv|G 	X\⁄’ÜèvÉ\“v6\⁄lb\√Z\ \∆$∂Lòêìµì`É1ò¿q†\ˆ9\ﬁ.\œ\„”ß™OΩ=u™û\œG˙©\È\Á\ıP\ı|˝´\”Ou\ı\¬\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0S\“\Èt˛Ÿô3gæ˚”ü˛\Ù\˜Gé\È¸\ËG?R\rW\ı∏t\Ïÿ±Wè=˙\Ò\Û\√|ë∑Èóº1,˘ù~\…/\0C´ö¯3U\Èº˛˙\Îù\˜\ﬂøs\Â\ \’pÖ\«=<˛\œ=\˜\‹;UcˇL¸1?\‰m˙%oK~ß_\Ú¿\–\¬OÆCâõãjæ^{\Ìµ7´F˛≥¯9b~\»[9%oJ~\À)˘``\·\ÌZ~r]FÖ\Á°j\‰\ƒ\œ\ÛC\ﬁ\ )ycP\Ú[N\…/\0ø375Ω\n\œG¸1?‰≠¨í7!øeï¸0ê\‹F˛oø\÷9\Û\Ûˇ\“y\È\«_ªV\·ø√≤x;5Zi\‰\ÛM\ﬁ\ *yc\Ú[V\…/\0\…i\‰\Ô^:\ﬂ˘\Âˇ™\Ûãˇ~\ﬂ\rñÖu\Ò\ˆj¯\“\»ÁõºïU\Ú\∆ ‰∑¨í_\0í\”\»œæthC\Ô÷πóo\ÿ^\r_\Z˘|ì∑≤J\ﬁÑ¸ñU\Ú¿@r\Z˘ˇyvˇÜﬁ≠∞.\ﬁ^\r_\Z˘|ì∑≤J\ﬁÑ¸ñU\Ú¿@r\Z˘/\Ù\‡Üﬁ≠∞.\ﬁ^\r_\Z˘|ì∑≤J\ﬁÑ¸ñU\Ú¿@4\Ú≤J#üo\ÚVV\…Éêﬂ≤J~HN#üJ7\nÖu\Ò\ˆj¯\“\»ÁõºïU\Ú\∆ ‰∑¨í_\0í\”\»˝ìonh\‡\›\n\Î\‚\Ì\’\•ë\œ7y+´\‰çA\»oY%ø\0$ßë_<ˇb\Áóˇ\Û?lh\‚aYXoØÜ/ç|æ\…[Y%oB~\À*˘` 9ç<\‘oN<π°ëáe\Òvj¥ja#ˇ\Á\ÒÇy&oeU\Ûñ´Uπ\Ã%øeï¸\ˆ$ø\0)Yç¸É:ø˛ﬂèmh\‰aYX∑a{5tµ¨ë\ﬂZ\’\Î\Î_[A\ﬁ ™ñ\Â-W\ÎrôK~\À*˘Mí_Ä^6k\‰\Ô^:\ﬂ˘ªü<∫°âw+¨\€\ƒ˚©\·™Eçº€ú\˜¨mEìñ∑≤™Ey\À\’\ \\\Êíﬂ≤J~7ê_Ä~z6\Ú>\Ëº\ˆÎ£ùø˝ˇ~C\Ûé+l∂\ı\”\Ï—´%ç<˛ât¸˝‹í∑≤™%y\À\Á0˛æ\ı‰∑¨í\ﬂ\ƒyçø \’\»7˚©uØ\Ú\”\Ï—´çºW3\Óµ|Æ\»[Y’Çº\ÂÍïø^\À[I~\À*˘ΩÆWN{-hßT#\œ˘©uØ\n˚\∆\«S˘5\Áç|≥&º\Ÿ˙ô\'oe’ú\Á-\◊fπ\€l}k\»oY%ø\◊lñ\œ\Õ\÷¥G™ë\«\Õy–äèß\Úkéyn\Û\Õ\›n&\…[Y5\«yÀïõ∑\‹\Ì\Êö¸ñU\Úõù\À\‹\Ì\0\Ê[™ë´\È’ú6\ÚAõ\Ó†\€\œy+´\Ê4oπ\ÕŸ†\€\œ˘-´\‰w†<∫=\ÎVVVnﬁ∂m€ñ\≈\≈\≈G™ØG™˙MU\ÔU\’Yˇ\Zæ?≤æ~K\ÿ>>L\›;\Ôº\Û/:\Ùµo~\Ûõøÿ∑oﬂõ{\˜\Ó}ˇã_¸\‚G\·Bﬁµk\◊\’={\ˆ\\˛\ÍWø˙\ ◊æ\ˆµ\√\˜\›wﬂø©v˘£¯\Û@#/´Ê∞ë\€lá›Øh\ÚVV\Õa\ﬁr\rõØa\˜õ\Ú[V\…\Ô¿9vøVZZZ˙t5\'X´\Í\ ˙$7∑\¬\ˆkaˇ¯ò–∏\Áü~\◊\√?|˛û{\Ó\ÈTì\›\Œ3\œ<\”9y\Úd\Á\Ù\È”ùã/vÇ\5|ñá\ı\˜\ﬂˇG;w\ÓºRMÄ∏ºº¸\Ò¯ò≥L#/´Ê¨ëè\⁄dG›ø8\ÚVV\ÕY\ﬁrçö´Q\˜üY\Ú[V\…\ÔPF\›\ÓU\÷OV\◊\„â	\Ì0u</>L‹ã/æ¯oø˝\Ìoø˙Ö/|°\ÛΩ\Ô}Ø\Û\∆o\\õ\‰\Ê\n€á˝™	\\Ô\ÔΩ\˜\ﬁ\ÔV\Úü\∆\ÁòE\ZyY5Gç|\\\Õu\\\«\Èi\ıë£ùT\ÂÆÑºïUsî∑\\\„\ ”∏é3ê8Éq\„\Â\Ò˙Q\…oY%øC\◊qg3\Œhº<^?I+++7-..~´ö¨^{\˜gΩVWW;\Ï{£,¨\€\≈˚Ü\„Ö\„Ü\„\«ÁÑ±´Æ\À?˘¡~p(Lxüx\‚âŒª\Ôæ{\„åv@aˇpú\Í~o˚\ˆ\Ìüo\÷h\‰e’ú4\Úq7\’q\Ô©¶\Z7\‚˙∫^\Àr\»[Y5\'y\À5\Óç˚xõJ\ÂnRYMëﬂ≤J~G2\Ó\„eI\Â±\…\˜RMNoYZZ˙E}¬∫ºº\‹9p\‡@\Á‹πs\ÒT†Ø∞}\ÿ/\ÏMÄ_\Áâ\œ\rcS]7?\ı\‘S\˜•/}©s\ÊÃô¯\⁄I8^5ô~\ÁŒù˚\‚\Û\Œçº¨öÉF>©f:©\„&õ\Í§\Z±ºïUsê∑\\ì\ œ§éõî\ ›§≤ö\"øeï¸élR\«\Ì)ï\«&3úRMx?Q\’˘˙$uˇ˛˝ù≥g\œ\∆/˝\ˆ«â&øg\√˘\‚1¿»™k\Ó\ÊGy\‰\“<–πt\ÈR|=éE8\ÓﬁΩ{ﬂªÎÆªûå\œ?+4\Ú≤j\∆˘§õ\ËDéüj™ìj\ƒ\ÚVV\Õx\ﬁrM$75ì>˛u©\‹M*´)\Ú[V\…\ÔXL˙¯7H\Â±\…\«\÷\Ô\Ù^üÙÜª¥áä_\Óè$/∫˚{÷ù_∆™∫\Œ˛‰©ßû˙uò\ÙÜ\')œû=o\ﬂq\«_ç\«14\Ú≤jÜyΩyÜO@ˇ\‹˙\◊Q§é3\ˆ&ùj™ìj\ƒ\ÚVV\Õp\ﬁr\Õl.SRπõTVS‰∑¨íﬂ°§é\”H~ÉTõ\Ãp]¯ù\€˙€õw\Ï\ÿ\—9u\ÍT¸2,\¬q\√\Òkì\ﬂ¸\Œ/c~ß\˜\À_˛\Ú\ƒ\Ó\Ù\∆\¬y\Óæ˚\Ó\À’Ö¸\Ÿx,•\”\»À™m\‰qs˛\œUÖˇè\u\ÿ&\›\Ô8cm“©¶:©F,oe’å\Ê-\◊L\Á2%ïªIe5E~\À*˘Xø\„L<øA*èMf∏n˝É¨Æ\ﬂ\Èù‘§∑+ø~\Á7ú?¨∫∞>>\»j‹ø”ªôpæ\Ì€∑_∫˝\ˆ\€ˇ,S\…4\Ú≤jy\‹,?∑\ˇõj∑\‚Êö£ﬁúªu\◊\r[l<\Ô\–BSMU\Ó˙A\»[Y5Éy\À\Ác\Êrôg0\Œbº<^?*˘-´\‰w S\œog3\Œhº<^?.\Î≤\Ë\√\Ó$\Ù\\·\√\Ò\À˙â\Á©\›\ı˝–ü:bd\·OÖO]ûÜ\«{\Ï\’\ÍB˛F<¶íi\‰e’å5\ÚTìL5\◊Aötjˇˇ¥æ<ñ:\—‰≠¨ö±º\ÂJ\Â\"ï+πê¸ñU\Úõ\Ã_Jjˇ\÷\Â∑n[\Ì\Ô\ÙÜ†jR\ÙÅW\«\„±A∂\Áü~W∏\€{˘\Ú\Â¯:kD8\Ôùw\ﬁ˘\Œ\Ú\Ú\Ú\«„±ïJ#/´f®ë\˜ké©&õ”§S˚\ıj\Œ]˝\∆Qy+´f(oπ˙\Â!ï/πÄ¸ñU\Ú+ø\√ÿ∫uÎß∫\œ\\÷\„Q?ΩyP\·|\ı∑<á\Ò\ƒcÑ,?¸\˘µµµ¯\Zk‘ìO>y∫∫ê\ƒc+ïF^V\ÕH#\œiä©f€ØIß∂ﬂ¨9wÂåß\ÚVV\ÕH\ﬁr\Â\‰ ï≥\÷\Á2ó¸ñU\Ú+ø√®^£Øu\'ù\·\Ô\ÌNC8o\ÌÆ\ÔZ<F\ÿ\‘\ÂÀóˇ\ÂÆ]ª:.\\àØØFU\Áˇ\√\Ú\Ú\Ú\Î>¯\‡\«c,ëF^V\Õ@#§¶ön™Iß∂\Àm\Œ]Éåkj‰≠¨öÅº\Â\Z\‰˙O\Â≠’π\Ã%øeï¸\ Ô†™\◊\Á´&öW∫ìŒ¶\Ô\ˆvÖ\Û\÷&æW¬∏\‚±B_\ﬂˇ˛\˜\˜\Ì›ª7æ∂¶\‚\Óª\Ô˛mu!ˇy<\∆&U\Á∂™\€\‚\Â1çº¨j¢ë\Á^	\√4¡T\Û≠7\È\‘˙Aõs\◊0\„ã\‹\«T\ﬁ ™&\Úñ+\˜\ZJ\Ê∫O\Ân\Órô+\˜±óﬂ≤J~\Â∑.\Á9®\÷oŸ∂>\·\\]]ç_æ7*úø;ñ0Æx¨\–◊£è>˙∑\œ<\ÛL|]M\≈\„è?˛Buˇu<\∆&\’\¬\‘\˜çº¨j¢ë\Á^ëQö_™	á\Ô√ª\"\‚\Â\√6\ÁÆQ\∆9¥\‹\«T\ﬁ ™&\Úñ+\˜\ZäårΩ\œ}.s\Â>\ˆ\Ú[V\…ÔÜú∂2ø]9\œAµ¸\—\ÓvO?˝t¸\ÚΩQ\·¸µ1?\Zè˙⁄∑oﬂõ\'OûåØ´©8v\Ïÿããããá\‚16©¶æˇh\‰eUç<\˜⁄®G\”K5Èó£\ÔGm\Œ]\„\Ô@rSy+´ö\»[Æ\‹k®f\◊˘\\\Á2W\Óc/øeï¸\ o]\Œs∞¥¥t¥ª˛ƒâ\Ò\À\˜FÖ\Ûw\«\∆U\'l\Í˛˚\Ôø\Èø\›\€\À\À/ø¸\€\ÍB˛y<\∆&%˛H˛C†ëóUM4\Ú\ƒ5ëº6÷ç≥Ÿ•ö\Ù∏õs\◊8«Ω©\ƒcô|LÂ≠¨j\"oπ\◊N\Ú\ZZ7\Œ\Î{nsô+\Òò\'{˘-´\‰\˜ö\÷\Á∑+\Ò\ÿox™ØØtóO{\Œ\Œ_\„+\—ˇ\Ù∑k◊Æè\ﬁz\Î≠¯∫öäã/æ[]\ƒ\Á\„16)¸∏Æ˝C†ëóUM4\Úƒµ◊µkca2M.º\r+˛ât¯~7â\Ò\'%√∏Æ=¶\ÚVV5ë∑\\âk&Æk\◊\–\¬dÆ\Îπ\ÃeÆ\ƒc◊µ\«^~\À*˘ΩÆ\’˘\ÌJ<\ÊqÖ\Á\‡ª\ﬂO{\Œ\Œ\ﬂ\À\“\“\“\Â¯ˇ˙∫\Û\Œ;;WØ^çØ´©®\∆q9∏\"K#/´\‚\ÁgZu˚\Ì∑wn∫\È¶\–<\˜\ƒYAøüLá\Â\„¸\…t◊û¯ˇm\⁄?\Ájz?7•ó\\Nø\‚kHMØ\‚\Á¶\Ùíﬂ≤j\⁄sÜp˛\⁄x˛?\»\–\◊=\˜\‹su\⁄?Ω\Èz\„ç7˛\Ô∂r\Ô¯>ª\Õ[∑ä≠&~Çù∏&í\◊\∆\¬x≤õj\Œ\ÒO®\«›§\«9˛æèe\Ú1ï∑≤™âº\ÂJ\\;\…khaº\◊\ı\\\Á2W\‚1O>\ˆ\Ú[V…Ø¸\÷%˚\r\œA∏≥\⁄]>\Ì9É;æå\‰+_˘\ \Âiø_ø\ÎWø˙’âm\Â˝éo¸è\Ô5\”n\‰7˛}ΩJY\ﬂt5\—\»sØçu∑.å\ﬁ\‰R\Õ9¸\ÓQ\Í\”\'\«’§\«1\Ólπè©ºm\\W_\ﬂt5ë∑\\π\◊–∫[Føæ\Á>óπr˚i\Á7ÆÖDñB5µ~\⁄%ør\⁄\ ¸v\Â<\€¸é/\Û\‚Å8[ ß:ˇ¯\«?>R–ß:o~›¥˘B¢â÷óM{}\”\’D#œΩ6jFivΩös∑	ß÷è⁄§G\ÔPrSyÎøæ\Èj\"oπrØ°öQÆ\ÛT\Ó\Ê.óπr˚i\Á7ÆÖDv\Í\À&Ω~\⁄%ø\Ú[ó\Û¯Tg\Ê∆É>x∏îø\„˚\–C≠mõ˛\ﬂ\Ò\Ì¸∫i7\ÚÖD≠/õ\ˆ˙¶´âFû{mDÜiz©\Êõ˙î\…\‘v\√6\Èa\∆9≤\‹\«T\ﬁ˙Øo∫ö\»[Æ\‹k(2\Ã\ıû\ \€\\\Ê2W\Óc?\Ì¸∆µê\»N}Ÿ§\◊Oª\‰W~\ÎrûÉm˛é/\Ûb\ÔﬁΩˇ˙˛˚\Ôˇ(æ∞¶\‡\Í\Ú\Ú\Úã\’E¸\Á\ÒK4\ÌFæêh¢\ıe\”^\ﬂtï\‘\»i~©¶õj\Œ]©\Ìm“Éåo*\‰≠ˇ˙¶´\º\Â\Z\‰∫O\Â¨\ıπ\Ã5\Ì¸∆µê\»N}Ÿ§\◊Oª\‰W~UΩ6\ﬂ“ùlÆÆÆ∆Ø\ﬂµ{\˜\Óèj\ﬂ-\ÒX°Ø|\è\Ôæ˚\Ó+.\\àØ≠Fù;w\Ó\'\’¸ZO<\∆Mªë/$öh}Ÿ¥\◊7]3\–\»sö`™\Ÿ\ˆk\Œ]©˝rõtŒ∏¶N\ﬁ˙Øo∫f oπrÆˇTæ\‰r\0\”\Œo\\â\Ï‘óMz˝¥K~\ÂwP\À\À\À´^£_\ÈN8œû=øåoD8om\“{%å++l\Íæ˚\Ó˚\·\⁄\⁄Z|}5\Í\Î_ˇ˙\ﬂT\ÒÅxl•öv#_H4\—˙≤iØo∫f§ë\˜kÜ©&õ”úªR˚o÷§˚çß(\Ú\÷}\”5#y\À\’/©\\\…ÂÄ¶ùﬂ∏Ÿ©/õ\Ù˙ió¸\ˆ\Õ_]jˇ\÷Â∑´zç~\Ò⁄§\Û¿Å\Ò\À¯FÑ\Û\÷&æk\Ò!\À\Ú\Ú\Ú\«w\Ó\‹˘˚Àó/\«\◊X#.]∫\Ù≥\Íæ\∆è≠T\”n\‰â&Z_6\Ì\ıM\◊5\Ú^M\Òs\√7\ÁÆTìæ\ÎÜ-˛IØqI\ﬁ˙Øo∫f(oπz\Â\·sr9≤i\Á7ÆÖDv\Í\À&Ω~\⁄%øi}~ª∂n\›˙©Ó§≥zΩ\ﬁ¯]\ﬂpæ•••\Îos\„â\«\Ÿ\ÓΩ\˜\ﬁ\Ô>\Ò\ƒ\Òu÷à\Í\‹ˇ≠∫àøè©d\”n\‰7˛#|ΩJY\ﬂt\ÕX#øuacs¨7\◊aösW\ŒqR\Á/öºm\\W_\ﬂt\ÕX\ﬁr›∫∞19y ësú\‘˘\Á¬¥\Û\◊B\"K°öZ?\ÌíﬂÅ\Â\'u˛πSΩV?ﬁùx\Óﬂø?~9?Q\·|µªΩ\«\„±¡@nø˝\ˆ?[YYyØ\Èø\œu\‚ƒâ\\Á\·¸\ÒòJVZ#o{\Õ`#O5\…\–L\√OíSMu˝éì:o\Ò‰≠¨ö¡º\ÂJ\Â£_û\—\Ô8©\Û\Œ\r˘-´\‰w(˝éì:\Ô\\ZZZ˙d\ıö˝\√\Ó\Ù\\·\√\Ò\À˙â\Á©Mz?\„à\«€æ}˚_\ﬁs\œ=\Ô_∫t)æ\Ê&\‚¬Öˇ´∫ÄW\’g„±îN#/´f¥ë7\›,õ>\ﬂ\ÿ\»[Y5£y\À\’tNö>_\„‰∑¨íﬂ±j˙|S∑∏∏¯≠\Ó$4º\Â˘‘©S\Ò\À˚±\n«Øø\≈9ú?m\ÁŒù˚\ˆ\Ó\›˚^¯\«qí>¯\‡É_UÅ˘yu1ˇªx≥@#/´f∏ë7\’4õ:\œD\»[Y5\√y\À\’T^ö:\œT\…oY%øc\”\‘yä≤≤≤rS5}°;›±c\«\ƒ&ø\·∏\’˘Æ\ﬂa\Á\r\Áè\«#πÎÆªû‹≥g\œ€ì∫\Û{\·¬Ö\Á¬§∑∫Ä\√\ÔJ\Ã$çº¨ö\ÒF>\È\Ê9\È\„OúºïU3û∑\\ì\ŒÕ§è_˘-´\‰w,&}¸¢UØ\ﬂo©\Íl˝\Œ\Ô°Cá\‚ó˚#	«´\ﬂ\È]?\ﬂ-\ÒX`,\Ó∏„éØ\Ó‹π\Û\Ú∏\Áw˝wz_ô\’;Ω]\ZyY5ç|RMtR\«mîºïUsê∑\\ì\ œ§é[$˘-´\‰wdì:\ÓL©^\«¢>˘\r>Äj\‘O{˚Gdum\“\Œè∆™∫\–>ª}˚\ˆKè=\ˆÿ´\Ôæ˚n|m\‰\Ì∑\ﬂ~~˝”õ/Ñ\„\∆\Áö5\ZyY5\'ç|\‹\Õt\‹«õ\Zy+´\Ê$oπ∆ù£qØx\Ú[V\…\ÔH\∆}ºô\Ó¿n´Ω\Ì9T∏˚˛\ﬁ\Óπs\Á\‚©@_a˚∞_tó\˜\⁄€õ\√y\‚s\√DT\‡üV\‹7\Óº\Û\Œwæ\Ûù\Ôú~\„ç7Æ\∆kWœü?ˇì}˚\ˆ]˚\‰\Êpúpº¯≥H#/´Ê®ëè´©é\Î8Eê∑≤jé\Úñk\\y\Z\◊qfä¸ñU\Ú;¥qgÆÑﬂπ]ˇ¿´x\¬\⁄Y]]\Ì<x∞s\Ú\‰\…\Œ\È”ß;/^º69_\√\˜ayXø{\˜\Ó\r˚Ü\„Ö\„˙ù^¶byy˘\„\’Ex†ö∏^¯¸\Á?ˇª\«¸‘±c\«^|˘\Âó_y\Û\Õ7ˇ°∫éﬂΩp\·¬ôó^z\ÈD\ıè\ÍèzË°µjü´}˛>\Ï\ˆèè9\À4\Ú≤j\Œ\Z˘®\Õu\‘˝ã#oe’ú\Â-◊®π\Zuˇô%øeï¸e\‘˝\Á\ﬁ˙ü:∫˛w~G¨\„˛d•¯£≠[∑˛´\ÍÇ¸èãããá™ã\Ûg\€˛\È=˛\·\Î\œ\¬\Ú∞>l∂è04\Ú≤j˘∞Mv\ÿ˝ä&oe\’\Ê-◊∞˘\Zvøπ øeï¸ú\√a\˜k•\Í\ıˇß´π¿ZUW\⁄~∂_˚\«\«¶L#/´Ê¥ë\⁄l\›~f\»[Y5ßy\À5h\Œ\›~\Ó\»oY%ø\Âq\–\ÌY∑≤≤rs5ë›≤∏∏¯H\ı\ıHUø©\ÍΩ\ıIn¯\Zæ?≤æ~K\ÿ>>Pçº¨ö\„Fû\€ts∑õI\ÚVV\Õq\ﬁr\Â\Ê-wªπ&øeï¸f\Á2w;Ä˘¶ëóUs\ﬁ\»7kæõ≠üy\ÚVV\Õy\ﬁrmñª\Õ÷∑Ü¸ñU\Ú{\Õf˘\‹l=@{h\‰eU\ZyØ&\‹k˘\\ë∑≤™y\À\’+Ωñ∑í¸ñU\Ú{]Øú\ˆZ\–N\ZyY’íF7\„¯˚π%oeUK\Úñ+\Œa¸}\Î\…oY%ø7à\Û\ZÄF^Vµ®ëwõ\Úû\ıØ≠h\Œ\ÚVVµ(oπZô\À\\\Ú[V\…\Ô\Ú–èF^Vµ¨ë\ﬂ\Z>1|çW\Ã+y+´Zñ∑\\≠\Àe.˘-´\‰7I~z\—\»À™∂5\Ú\ı\›\Z\ÚVVµ-oπ⁄ñ\À\\\Ú[V\…oö¸\Ù†ëóUmk\‰mk\–\ÚVVµ-oπ⁄ñ\À\\\Ú[V\…oö¸\Ù†ëóUmk\‰mk\–\ÚVVµ-oπ⁄ñ\À\\\Ú[V\…oö¸\Ù†ëóUmk\‰mk\–\ÚVVµ-oπ⁄ñ\À\\\Ú[V\…oö¸\Ù†ëóUmk\‰mk\–\ÚVVµ-oπ⁄ñ\À\\\Ú[V\…oö¸\Ù†ëóUmk\‰mk\–\ÚVVµ-oπ⁄ñ\À\\\Ú[V\…oö¸\Ù†ëóUmk\‰mk\–\ÚVVµ-oπ⁄ñ\À\\\Ú[V\…oö¸\Ù†ëóUmk\‰mk\–\ÚVVµ-oπ⁄ñ\À\\\Ú[V\…oö¸\Ù†ëóUmk\‰mk\–\ÚVVµ-oπ⁄ñ\À\\\Ú[V\…oö¸\Ù†ëóUmk\‰mk\–\ÚVVµ-oπ⁄ñ\À\\\Ú[V\…oö¸\Ù†ëóUmk\‰mk\–\ÚVVµ-oπ⁄ñ\À\\\Ú[V\…oö¸\Ùp\‰»ëè\ﬁˇ˝\r\rE5_\’\Û\j\’\»?àü£y÷∂-o\ÂT\Ûñ´mπ\Ã%ø\Âî¸\ˆ&ø\0=;v\Ï\’\◊_}CSQ\Õ\◊\Ô~\˜ªˇZ5\Úü\≈\œ\—<k[Éñ∑r™çy\À’∂\\\Êí\ﬂrJ~{ì_Äé=˙\œ=\˜\‹;ØΩ\ˆ⁄õ~í=ù™\˜\◊~˚\€\ﬂ˛M\’\ƒ_©\Í3\Òs4\œ\⁄÷†\Âm˙\’\Êº\Âj[.s\…\Ô\ÙK~7\'ø\0}Ñ\Ê~rZ’ï\;3™\Ò\nè{x¸[\◊\ƒ\€ÿ†\√\Ûº˛|\À\€t™µy\À\’\∆\\\Ê\n\◊\Õ˙\ı#ø\”)˘›Ñ¸@Å4h(è\\\¬\Ïí_\0(ê\r\ÂëKò]\Ú\0“†°<r	≥K~†@\Z4îG.av\…/\0HÉÜ\Ú\»%\Ã.˘Äi\–PπÑ\Ÿ%ø\0P \r\Z\ #ó0ª\‰\0\n§ACy\‰fó¸@Å4h(O*ó´è\Ì§*w=–åT~Ä)”†°<©\\¶&±\Òƒ∑æÆ\◊2`≤R˘\0¶LÉÜ\Ú§rôöƒö¯ByR˘\0¶LÉÜ\Ú§rôöƒö¯ByR˘\0¶LÉÜ\Ú§rôöƒö¯ByR˘\0¶LÉÜ\Ú§rôöƒö¯ByR˘\0¶LÉÜ\Ú§r&±©\ ]4#ï_\0`\ 4h(è\\\¬\Ïí_\0(ê\r\ÂëKò]\Ú\0J5\Ë¯≠í\Ò[&\„\Â\Òz`4©\\≥!ïﬂ∏_\∆}3^Ø\0F‘´A\˜[∂\Ÿz`4©\\≥!ï\ﬂTè\‘W†A\Z4î\'ïK`6§\Úõ\Íë˙*\04HÉÜ\Ú§r	ÃÜT~S=R_Äi\–PûT.ÅŸê\ o™G\Í´\0\– \r\Z ì\ %0R˘M\ıH}\0\Z‘´Aß*w=êØ\ \‡≥!áõ‘≥\Ò~@ô\ÙU\0(P™AÕ©2x[b¢\◊m\Ò~@ô\ÙU\0(ê\r\”\Ó\Ë&&ª\Ó\ˆ\¬\“W†@\Z4L_∏£õò\∫\€3H_Äi\–PÜpg71\Èu∑fåæ\n\0“†°\·\Œnb\‚{[ºP6}\0\n§AC9¢ªæ\Ó\ˆ\¬\“W†@\Z4î#∫\Î{[º(üæ\n\0“†°,›ªæ\Òr`6\»/\0HÉÜ\ÈYYYππ\ \‡ñ\≈\≈\≈G™ØG™˙MU¨\ﬂ\Ò}o˝˚#\ÎÎ∑Ñ\Ì\„c\0e\—W†@\Z44oii\È\”U\ˆ÷™∫≤>\…Õ≠∞˝Z\ÿ?>&P}\0\n§ACs™	\Î\'´\ÃOLhá©\„\·x\Ò9Ä\È\n˘åó\0S¶A\√‰≠¨¨‹¥∏∏¯≠*o\≈\ÿ\’\’\’\Œ¡É;\'Oû\Ïú>}∫s\Ò\‚\≈NæÜ\Ô\√\Ú∞>l\Ôéééüò}\0\n§A\√dUªeii\È\ı	\Î\Ú\Úr\Á¿Åùs\Á\Œ]õ\‰\Ê\n€á˝\¬˛\—¯Öpû¯\‹@\Û\ÙU\0(ê\rìSMx?Q\’˘˙$uˇ˛˝ù≥g\œ\∆s⁄ÅÑ˝\√q¢\…\Ô\Ÿpæx@≥\ÙU\0(ê\rì\Ó¿\÷\'Ω\·.\Ì°Cá\‚9\ÏH\¬Ò¢ªøg\√y\„±\0\Õ\—W†@\Z4å_¯ù\€˙€õw\Ï\ÿ\—9u\ÍT<oãp\‹p¸\⁄\‰\˜ø\Û”£Ø@Å4hø\ı≤∫~ßwRìﬁÆp¸˙ù\ﬂp˛xL@3\ÙU\0(ê\r\„µ˛\'ã>\ÏNB>\œS\'\"úßv\◊\˜C\Í¶C_Äi\–0^\€jß7|\0Uì¢º:è\rò<}\0\n§A\√¯l›∫\ıS›âgx\Î\Ò®ü\ﬁ<®pæ˙[û\√x\‚1ì•Ø@Å4hü*Ok\›Ig¯{ª\”\Œ[ª\Îªèò,}\0\n§A\√x,//¨\ ”ïÓ§≥ÈªΩ]·ºµâ\Ôï0Æx¨¿\‰\Ë´\0P \r\Z6W\Â\‰Ÿ™nãó\◊U\Î∑t\'ú´´´\Ò|¥Q\·¸µ\…\Ôñx¨]\·ˇ)¸ø\≈ÀÅ\·\È´\0P \r\Z6WõD\ˆú\0W\À\Ìn\˜\Ù\”O\«s\—FÖ\Û\◊\∆¸hb¨\◊&º\›m\‚\ı¿\d\n\0\n§A\√\Êjì»û‡•••£\›\ı\'NúàÁ¢ç\n\Á\Ôé%å´;\∆x\¬€≠˙ˇ0\ZôÄi–∞πx¢X´\Î\‡\Í\Î+\›\ÂgŒúâÁ¢ç\nÁØç1å+9\·\ÌV\Ùøå@¶\0†@\Z4l.û(&*L*ˇ±˚˝[oΩ\œE\Œ_\€„Ω°\‚ˇ_`x2\0ä_\0+•FØ´WØ\∆s\—FÖ\Û\«cRJ5WqØ\0Ä\‚\≈/jk\ı\Ï∂\ı∑:/--]\Ó./\Èé\Ô˙∏º\’\0\0Ä\ﬁ\‚â\‚˙$\Ú∂hõb«∑6\∆\‰∏˛ˇ\0\0@\ıõ\v\Õ¬ß:w\≈\‡x=\0\0\0-\”o\¬€µmÜ˛éoWw/\0\0Ä\r™	\‰ñ\Ódsuu5ûã6j\˜\Ó\›\’&æ[\‚±\0\0¿¿ñóó?VM2Øt\'úgœûçÁ£ç\Á≠MzØÑq\≈c\0\0Ä°TÕµ\Ó§\Û¿Å\Òú¥·ºµâ\ÔZ<F\0\0\0\⁄÷≠[?’ùt.//7~\◊7úoii\È˙€ú\√x\‚1\0\0¿H™	\Á\Ò\Ó\ƒsˇ˛˝\Ò\‹t¢\¬˘jw{è\«c\0\0Äë---}≤öt~ÿùÄ>|8ûüND8Om\“˚aG<6\0\0\0ã\≈\≈\≈o\’\ﬂ\Ú|\Í‘©xû:V\·¯\ı∑8á\Û\«c\0\0Ä±YYYπ©öÄæ–ùà\Óÿ±cbì\ﬂp\‹\Í|\◊\Ô0á\ÛÜ\Û\«c\0\0Ä±™&†∑Tu∂~\Á\˜–°C\Òºu$\·x\ı;Ω\Î\Áª%\0\0\0LD5)˝D}\Ú*|\0’®ü\ˆ\ˆè>\»\Í⁄§7ú/\0\0\0L\‘˙ù\ﬂ\Îo{\Ó˛Üø∑{\Ó‹πxN\€W\ÿ>\Ï\›\ÂΩ\ˆ\ˆ\Êpû¯\‹\0\0\0–à\;∑\ÎxOX;´´´ùÉvNû<\Ÿ9}˙t\Á\‚≈ã\◊&π\·k¯>,\Îw\ÔﬁΩa\ﬂpºp\\ø\”\0\0@\÷ˇ\‘\—\ıø\Û;b\˜\'ã\0\0\0(R5a˝t5q]´\ÍJbB€Ø\¬\ˆkaˇ¯ò\0\0\0Púïïïõ´â\Ïñ\≈\≈\≈G™ØG™˙MU\Ô≠Or\√\◊\˝ë\ı\ı[\¬\ˆ\Ò1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0F\Òˇ\0\»\—BúØ\Í\0\0\0\0IENDÆB`Ç',1),('57506',1,'StudentPartySealApprovalProcess.bpmn20.xml','57505',_binary '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" xmlns:flowable=\"http://flowable.org/bpmn\" targetNamespace=\"http://www.flowable.org/processdef\">\n  <process id=\"StudentPartySealApprovalProcess\" name=\"ÂÖöÁ´†ÂÆ°ÊâπÔºàÂ≠¶ÁîüÔºâ\" isExecutable=\"true\">\n    <startEvent id=\"StartEvent_1\" name=\"ÂºÄÂßã\">\n      <outgoing>Flow_1gtutt3</outgoing>\n    </startEvent>\n    <userTask id=\"headTeacherApproval\" name=\"Áè≠‰∏ª‰ªªÂÆ°Êâπ\" flowable:candidateGroups=\"2013952715229585409\" flowable:assignee=\"2013951215732350978\">\n      <incoming>Flow_1gtutt3</incoming>\n      <outgoing>Flow_1ln9kdp</outgoing>\n    </userTask>\n    <userTask id=\"counselorApproval\" name=\"ËæÖÂØºÂëòÂÆ°Êâπ\" flowable:candidateGroups=\"2013952827238473729\" flowable:assignee=\"2013951264663101441\">\n      <incoming>Flow_1f887dt</incoming>\n      <outgoing>Flow_096picz</outgoing>\n    </userTask>\n    <endEvent id=\"EndEvent_1\" name=\"ÂêåÊÑè\">\n      <incoming>Flow_1ggs0xd</incoming>\n    </endEvent>\n    <userTask id=\"deanApproval\" name=\"Èô¢ÈïøÂÆ°Êâπ\" flowable:candidateGroups=\"2013952886889865217\" flowable:assignee=\"2013951338067615746\">\n      <incoming>Flow_1bf6tjw</incoming>\n      <outgoing>Flow_179uijp</outgoing>\n    </userTask>\n    <sequenceFlow id=\"Flow_179uijp\" sourceRef=\"deanApproval\" targetRef=\"Gateway_dean\" />\n    <exclusiveGateway id=\"Gateway_headTeacher\" name=\"Áè≠‰∏ª‰ªªÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_1ln9kdp</incoming>\n      <outgoing>Flow_1qajers</outgoing>\n      <outgoing>Flow_1f887dt</outgoing>\n    </exclusiveGateway>\n    <exclusiveGateway id=\"Gateway_counselor\" name=\"ËæÖÂØºÂëòÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_096picz</incoming>\n      <outgoing>Flow_1bf6tjw</outgoing>\n      <outgoing>Flow_06phn3v</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_1bf6tjw\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_counselor\" targetRef=\"deanApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <exclusiveGateway id=\"Gateway_dean\" name=\"Èô¢ÈïøÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_179uijp</incoming>\n      <outgoing>Flow_0piie6u</outgoing>\n      <outgoing>Flow_0hf6ise</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_0piie6u\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_dean\" targetRef=\"partySecretaryApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <endEvent id=\"Event_00f37w1\" name=\"ÊãíÁªù\">\n      <incoming>Flow_1qajers</incoming>\n      <incoming>Flow_06phn3v</incoming>\n      <incoming>Flow_0hf6ise</incoming>\n      <incoming>Flow_0vv7g2n</incoming>\n    </endEvent>\n    <sequenceFlow id=\"Flow_1qajers\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_headTeacher\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_06phn3v\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_counselor\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_0hf6ise\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_dean\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_1gtutt3\" sourceRef=\"StartEvent_1\" targetRef=\"headTeacherApproval\" />\n    <sequenceFlow id=\"Flow_1ln9kdp\" sourceRef=\"headTeacherApproval\" targetRef=\"Gateway_headTeacher\" />\n    <sequenceFlow id=\"Flow_1f887dt\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_headTeacher\" targetRef=\"counselorApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_096picz\" sourceRef=\"counselorApproval\" targetRef=\"Gateway_counselor\" />\n    <userTask id=\"partySecretaryApproval\" name=\"ÂÖöÂßî‰π¶ËÆ∞ÂÆ°Êâπ\" flowable:candidateGroups=\"2013952940048474113\" flowable:assignee=\"2013951382959251457\">\n      <incoming>Flow_0piie6u</incoming>\n      <outgoing>Flow_1prc4yx</outgoing>\n    </userTask>\n    <sequenceFlow id=\"Flow_1prc4yx\" sourceRef=\"partySecretaryApproval\" targetRef=\"Gateway_partySecretary\" />\n    <exclusiveGateway id=\"Gateway_partySecretary\" name=\"ÂÖöÂßî‰π¶ËÆ∞ÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_1prc4yx</incoming>\n      <outgoing>Flow_1ggs0xd</outgoing>\n      <outgoing>Flow_0vv7g2n</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_1ggs0xd\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_partySecretary\" targetRef=\"EndEvent_1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_0vv7g2n\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_partySecretary\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_1\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_1\" bpmnElement=\"StudentPartySealApprovalProcess\">\n      <bpmndi:BPMNEdge id=\"Flow_0vv7g2n_di\" bpmnElement=\"Flow_0vv7g2n\">\n        <omgdi:waypoint x=\"1120\" y=\"445\" />\n        <omgdi:waypoint x=\"1120\" y=\"520\" />\n        <omgdi:waypoint x=\"788\" y=\"520\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"1124\" y=\"481\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1ggs0xd_di\" bpmnElement=\"Flow_1ggs0xd\">\n        <omgdi:waypoint x=\"1145\" y=\"420\" />\n        <omgdi:waypoint x=\"1192\" y=\"420\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"1152\" y=\"402\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1prc4yx_di\" bpmnElement=\"Flow_1prc4yx\">\n        <omgdi:waypoint x=\"1060\" y=\"420\" />\n        <omgdi:waypoint x=\"1095\" y=\"420\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_096picz_di\" bpmnElement=\"Flow_096picz\">\n        <omgdi:waypoint x=\"590\" y=\"420\" />\n        <omgdi:waypoint x=\"625\" y=\"420\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1f887dt_di\" bpmnElement=\"Flow_1f887dt\">\n        <omgdi:waypoint x=\"455\" y=\"420\" />\n        <omgdi:waypoint x=\"490\" y=\"420\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"449\" y=\"402\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1ln9kdp_di\" bpmnElement=\"Flow_1ln9kdp\">\n        <omgdi:waypoint x=\"370\" y=\"420\" />\n        <omgdi:waypoint x=\"405\" y=\"420\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1gtutt3_di\" bpmnElement=\"Flow_1gtutt3\">\n        <omgdi:waypoint x=\"238\" y=\"420\" />\n        <omgdi:waypoint x=\"270\" y=\"420\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0hf6ise_di\" bpmnElement=\"Flow_0hf6ise\">\n        <omgdi:waypoint x=\"890\" y=\"445\" />\n        <omgdi:waypoint x=\"890\" y=\"520\" />\n        <omgdi:waypoint x=\"788\" y=\"520\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"894\" y=\"481\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_06phn3v_di\" bpmnElement=\"Flow_06phn3v\">\n        <omgdi:waypoint x=\"650\" y=\"445\" />\n        <omgdi:waypoint x=\"650\" y=\"520\" />\n        <omgdi:waypoint x=\"752\" y=\"520\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"699\" y=\"498\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1qajers_di\" bpmnElement=\"Flow_1qajers\">\n        <omgdi:waypoint x=\"430\" y=\"445\" />\n        <omgdi:waypoint x=\"430\" y=\"520\" />\n        <omgdi:waypoint x=\"752\" y=\"520\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"434\" y=\"481\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0piie6u_di\" bpmnElement=\"Flow_0piie6u\">\n        <omgdi:waypoint x=\"915\" y=\"420\" />\n        <omgdi:waypoint x=\"960\" y=\"420\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"919\" y=\"402\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1bf6tjw_di\" bpmnElement=\"Flow_1bf6tjw\">\n        <omgdi:waypoint x=\"675\" y=\"420\" />\n        <omgdi:waypoint x=\"730\" y=\"420\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"694\" y=\"402\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_179uijp_di\" bpmnElement=\"Flow_179uijp\">\n        <omgdi:waypoint x=\"830\" y=\"420\" />\n        <omgdi:waypoint x=\"865\" y=\"420\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNShape id=\"_BPMNShape_StartEvent_2\" bpmnElement=\"StartEvent_1\">\n        <omgdc:Bounds x=\"202\" y=\"402\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"211\" y=\"445\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_1\" bpmnElement=\"headTeacherApproval\">\n        <omgdc:Bounds x=\"270\" y=\"380\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_2\" bpmnElement=\"counselorApproval\">\n        <omgdc:Bounds x=\"490\" y=\"380\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_EndEvent_1\" bpmnElement=\"EndEvent_1\">\n        <omgdc:Bounds x=\"1192\" y=\"402\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"1201\" y=\"445\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_1gx0z7o_di\" bpmnElement=\"deanApproval\">\n        <omgdc:Bounds x=\"730\" y=\"380\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1078bu6_di\" bpmnElement=\"Gateway_headTeacher\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"405\" y=\"395\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"391.5\" y=\"371\" width=\"77\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1mawix4_di\" bpmnElement=\"Gateway_counselor\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"625\" y=\"395\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"612\" y=\"365\" width=\"77\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_0orv4am_di\" bpmnElement=\"Gateway_dean\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"865\" y=\"395\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"857\" y=\"371\" width=\"66\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Event_00f37w1_di\" bpmnElement=\"Event_00f37w1\">\n        <omgdc:Bounds x=\"752\" y=\"502\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"759\" y=\"545\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_0m324d5_di\" bpmnElement=\"partySecretaryApproval\">\n        <omgdc:Bounds x=\"960\" y=\"380\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_0m4br8x_di\" bpmnElement=\"Gateway_partySecretary\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"1095\" y=\"395\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"1076\" y=\"365\" width=\"88\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>\n',0),('57507',1,'StudentPartySealApprovalProcess.StudentPartySealApprovalProcess.png','57505',_binary 'âPNG\r\n\Z\n\0\0\0\rIHDR\0\0\÷\0\0$\0\0\0\“ˇ¶ó\0\0*IDATx^\Ì\›\·è\\\ÂΩ\Ω\˜J\Í+\“\ﬁ˚í7yïÅ\€\ÈãD≠\Z)\˜æ0ﬁô≈êµLÄ(ëº(´\rUqÇ\‘\Îw`•V\r`_µA\Ò;çö&v®•4&¡2\·ÜT\‹\‘NÇ\rÉ1ò[¿\·\¬\Ù<\€=æ≥œû\œ\ÃŒú\Ûõ3üè\Ù’≤sf\Œ9\Ã¯\Î˘\Õ\„ŸùÖ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0`¢zΩ\ﬁ?:w\Ó\‹w\ˆ≥ü˝\·¯\Ò\„Ω˝\ËGRsä˚˝\„ì\'Oæz\‚ƒâø\»\⁄Eﬂöèæ1.˝m>˙KN/õè^0\˜äa\‰\È\‚…∞\˜˙\ÎØ\˜\ﬁˇ˝\ﬁ’´W•\Ê§˚=\›ˇ\œ<\Û\Ã;≈Ä\Úπ¸1¢=\Ù≠˘\Ë\„\“\ﬂÊ£ø\‰\Ù≤˘\Ë%\0s/˝_z2Ãü$•˛º\ˆ\⁄ko\…\œ\Û«à\ˆ–∑8\—7F•øq¢øî\Ù2N\ÙÄπï\ﬁ6\Ô_¯b$=\≈@\ÚA˛\—˙\'˙∆®\Ù7N\Ùóí^∆â^0∑\“\ÔF»ü•π§\«#åh}ã}c˙+˙K¢ó±¢ó\0Ã•aíø{˚µﬁπ_¸ßﬁã?˛˙Z\“ß\À\Ú\Î\…\ˆb i7}ã}c˙+˙K¢ó±¢ó\0Ã•aíw/ø\“˚\’ˇm\Ôóˇ\ı\ﬁ\rIó•m˘\ıe¸H\⁄M\ﬂbE\ﬂÖ˛∆ä˛í\Ëe¨\Ë%\0siòÅ\‰¸ãG7\r#e.ºxl\”\ıe¸H\⁄M\ﬂbE\ﬂÖ˛∆ä˛í\Ëe¨\Ë%\0siòÅ\‰˝\‰\‡¶A§L⁄ñ__∆èÅ§\›\Ù-V\ÙçQ\Ëo¨\Ë/â^∆ä^0óÜH~\ı£6\r\"e“∂¸˙2~$\Ì¶o±¢oåBcEI\Ù2V\ÙÄπd âIª\È[¨\Ë£\–\ﬂX\—_ΩåΩ`.\r3ê§OO\ ë2i[~}?ív”∑X\—7F°ø±¢ø$z+z	¿\\\Zf ˘\ÕOøµi)ì∂\Â◊ó\Òc i7}ã}c˙+˙K¢ó±¢ó\0Ã•aíKØº\–˚\’ˇwõÜëtY⁄ñ__∆èÅ§\›\Ù-V\ÙçQ\Ëo¨\Ë/â^∆ä^0óÜHR~˚‹ìõítY~=\Ÿ^\Êp ˘\«˘m¶o±¢oåBcEI\Ù2V\ÙÄπ4\‘@\Ú¡Ω\ﬂ¸\œ\«6\r$È≤¥m\”\ıe\Ï\Ã\Ÿ@\Ú\È\"ØØù˙+˙\∆(\Ù7V\ÙóD/cE/òK\◊HﬁΩ¸J\Ôo˙»¶a§L⁄ñÆì\ﬂN\∆\À\r$\Â0≤o˝\Î\\%˙+˙\∆(\Ù7V\ÙóD/cE/òK[$|\–{\Ì7\'z\Û\ﬂ˛Õ¶!$O∫N∫Æ\ı\€~\Êd \…ˇÖ/ˇæµ\Ù-V\ÙçQ\Ëo¨\Ë/â^∆ä^0ó™í\Î˝\Î\ﬁV\ÒØ~\€\œ$[\r[]\ﬁ*˙+˙∂\Èr\–\ﬂX\—\ﬂMó\œ%ΩåΩ\‹t9\0\Û†j \Ê_\˜∂J∫mæ?>-HÆ7t\\o˚\Ã”∑X—∑Å\€\…\Ëo¨\Ë\Ô¿\ÌsC/cE/n†≠™í|\»5˘˛d¯¥x v\ÿ\ˆz3I\ﬂbEﬂÜæ˙-˙;\Ù\ıZM/cE/áæ\0mR5êHsi\È@2\Íê1\Í\ıgÜæ≈äæ≠\ı˙sKcE◊åz˝\÷\—\ÀX\—\À5£^üu\À\À\À7v:ùããã_è˘më\˜ä\Ù÷ø¶ÔèØoﬂëÆü\Ô\Íùw\ﬁ˘\'Gè˝˙∑æ\ı≠_8p\‡\Õ˝˚\˜øˇ•/}\È\„T\ª\Ôæ˚\√}˚\ˆ]˘\⁄◊æ\ˆ\Ú◊ø˛\ıc\˜\ﬁ{\Ôø,n\ÚG˘>\"3ê\ƒJíqáãqoöæ≈äæ]3\Ó\Ì\Êä˛∆ä˛^3\Ó\ÌZA/cE/Ø\˜vs©\€\Ì~∂xm}§\»\’\ıE¥aìÆ$\›>\ﬂ\'ƒ≥\œ>{\˜C=\Ù\ ]w\›\’€ø\ÔÈßü\Óù>}∫w\ˆ\Ï\Ÿﬁ•KózI˙öæOóß\Ì\˜\›w\ﬂ\«{\ˆ\Ïπz\ÔΩ\˜˛pii\Èì˘>#2ê\ƒJ\Àí\Ì€Ω}8˙+˙∂¡vo\ﬂz˙+˙ª¡vo?≥\Ù2V\ÙrÉ\Ìﬁæ\ı∫\›\ÓÕùN\ÁT≈Ç\Ÿ89ï\ˆóh\»/º\Ø}\Ù\—W\Ôº\Û\Œ\ﬁ\˜æ\˜Ω\ﬁoº±∂à6¨t˝tª={\ˆ¸\·û{\Ó˘nQ\?ÕèâÅ$VZ4êLjòi?+ü\ËUe\ÿ\Ì”¶o±¢oõLj?ìw5\Ôl~yæ}í\Ù7V\ÙwìI\ÌgÉº[y\«\Ú\À\Û\Ì”¶ó±¢óõLj?[ ªów0ø<\ﬂﬁÑ\Â\Â\Âø\›\Èt\÷~\n¨?+++Ω√á|CK⁄ûÆó\ﬂ6\Ì/\Ì7\Ì??&Pì¢Ø\ÚÉ¸\‡hZP{\‚â\'z\Ôæ˚\Ó\∆≥•€ß˝\≈~o◊Æ]ô/\nI¨¥d ô\Ù1\Ù˛™Ö|∏\Ëﬂ∂\’e”¢o±¢oï&Ωøm©\ÍgSù\÷\ﬂX\—\ﬂJì\ﬁ_eüö\Í`ΩåΩ¨4\È˝mP’∑H\Õu:ùõ∫\›\Ó/˚ƒñññz´´´Ω.\‰/©J\◊O∑K∑\œÿûO\«…è\rLY\—\ÀüzÍ©ø˝\Úóø\‹;w\Ó\\\ﬁ\ŸmI˚ª\Û\Œ;\ﬂﬂ≥gœÅ¸∏Hb•…¥Üá°\ˆ[5(D\Z.\Ù-V\ÙmK\”\⁄\Ô»™˙\ŸTß\ı7V\ÙwK\›oUüö\Í`ΩåΩ\‹“¥\ˆ[Ÿ∑H\Ì\◊\Ìv?U\‰ï˛E∞É\ˆŒü?üøÑI∫}\⁄O∂∏v>/?`Jä.\ﬁ¯\\√_æˇ˛˚{ó/_\Œ{:iø˚\˜\Ô\Ô\ˆ\€o2?~\”$±2\„\…‘ÜÜu\◊\›’†i∏–∑X—∑Å¶Ωˇ°T\ı≥©N\Îo¨\Ë\Ô@\€Uüö\Í`ΩåΩh*˚Ø\Í[§éñ\÷ﬂ©vmQ-Ω\À\Ï\Ë—£˘\À\ÊmI˚\ÀﬁΩv\ﬁ;◊†Eˇ˛‰©ßû˙MZTKO”î\ˆøoﬂæ∑oΩ\ı÷Ø\Â\Á\—$I¨\Ã\@\“?,§O\∆˝\¬˙\◊\Ì®\⁄\œ¿°§jPà4\\\Ë[¨\Ë\€U˚ÿ∑:T\ı≥©N\Îo¨\Ë\ÔU˚ôH´˙\‘T´\Ëe¨\Ë\ÂU˚ôH/˚U\ı-RGì\Ù;\œ˙¸s\˜\Ó›Ω3g\Œ\‰/ó\'\"\Ì7\Ìøoq\Ìyøs\r¶,˝NµØ|\Â+S{ßZ.\Áé;\Ó∏R¸\Û˘π4\≈@+3:ê\‰\√\»,í˛?\“\◊qáíA˚\Ÿr(©\Z\"\r˙+˙vÕ†˝lŸ∑:T\ı≥©N\Îo¨\Ë\Ô5É\ˆ≥\Ì˛V\ı©©V\—\ÀX\—\Àk\Ìg€Ω\ÏW’∑HM\÷?®\‡\⁄;’¶µ®VJ˚\Ô\ÁZ:~~N¿ÑÖ˚\\˙†ÇIˇNµ\ÎI\«€µk\◊\Â[nπ\Â\œ\ÚsjÇÅ$Vfp …áÉ/,¸ˇ!¢L>L£)s˚Ükl>\Óö4(Te\ÿ\Ì”¶o±¢ok\∆\Ó[\ÚÆ\Êù\Õ/œ∑Oí˛∆ä˛Æôz\Ûn\Â\À/œ∑Oõ^∆ä^Æôz/˚\Â\›\À;ò_ûoü∂n∑{sß\”˘®\\\‰:v\ÏX˛\Úx*\“q˙ﬁµ\ˆQ:è¸‹Ä	x\Ù\—G_Mü\⁄ŸÑ\«{\Ï’¢\‡\ﬂ\Ãœ©	íXô±Å§j(®\Z&FJ™nˇ\÷/\œU?4}ã}´º}k˙6i˙+˙[y˚π\ÎØ^∆ä^V\ﬁ~\ÓzŸØx\Õ{™\\\‡J0Pß\Ï\rN\Â\Ál”≥\œ>{wz∑⁄ï+W\Ú˛\’\"\˜∂\€n{gii\Èì˘π\’\Õ@+34ê\Z™ÜäaÜí™\€m5åîùG8˙+˙∂\Èv≠\Í€§\Èo¨\Ë\Ô¶\€\Õe\ı2V\Ùr\”\ÌÊ≤ó•ù;w~¶\\\ÿJ?öπ\›OˇU:^ˇèÑ¶\Û\…\œÿÜáz\Ëï#Gé\‰›´’ìO>y∂(¯j~nu3ê\ƒ å$\√U\√≈†°§\Í˙\◊FJ√úO˙+˙\÷\ÓæMö˛∆ä˛\Ío¢ó±¢ózŸØx≠{§\\\‘Z]]\Õ_\◊\"∑\Ô]kG\Ús\∆t\Â ïz\˜\›w\˜.^ºò\˜ÆV\≈\Òˇ~ii\È\ıx\‡è\Ûs¨ìÅ$Vf` \Â…øj»®\ZJ™Æ7\Ï0R\Z\Âº\Z£o±¢o\Ì\Ó€§\Èo¨\ËØ˛&z+z©ó•\‚u\Ó\':ù\Œ\’rQ´\Ów´ï\“q˚÷Æ¶\Û\ \œ\√\˜øˇ˝˚\˜\Ô\œ;◊à;\Ó∏\„wE¡ˇ<?\«I(\ˆ˚ì\"ˇ<ø<g âï:íaˇlT\ÁIøj\ÿ\ËJ™∂è:åî\∆9øâ\ˆ>’∑X—∑\Ÿ\Ï€§\r˚\Èo¨\Ëoª˚;\Ï}Øó±¢ó\Ì\Óeiò«†ÿæ£≥æ†µ≤≤íøÆU:~y.\Èº\Ús\∆\\»#è¸\Õ\”O?ù\˜≠è?˛¯\ÛEπˇ*?\«I\Ë˚\Àc\‡_|íX©i \Í\œFf;O\ˆUCG˙>Ω[3ø|\‹a§¥ù\Û€∞\˜©æ≈äæ\Õf\ﬂ&m\ÿ\«HcE\€\›\ﬂa\Ô{ΩåΩlw/K\√<\≈Âèî\◊;t\ËP˛2∏V\È¯}\Á¸H~Æ¿8\\Ê\È”ß\Ûæ5\‚\‰…ì/,..\Õ\œq˙˛\Ú¯üÅ$VjH˛\Ÿ\Ë3â\'˘™°\‰•\Ï˚\Ì#•Iú\ÔHÜΩO\ı-V\Ùm6˚6i\√>F˙+˙\€\Ó˛{\ﬂ\Îe¨\Ëeª{Y\Z\Ê1\Ëvª\'\ \Ì\œ=\˜\\˛2∏V\È¯Âπ§\Û\Í?O`L\˜\›w\ﬂ˚\ÁŒù\À˚÷àó^z\ÈwE¡ëü\„$T¸ÖW˘üÅ$V\Z\ZH*ˇl¨õ\‰ì{\’P2\Èa§4\…ÛæÆä˚≤\Ú>’∑X—∑âô\‰y◊Æ‚±©|å\Ù7V\Ùwb&y\ﬁSqüW\ﬁ\˜z+z91ì<Ôâ´∏\Ô7=\≈◊ó\ÀÀõ~Ìùé\ﬂwé/gˇ;¿8\Óæ˚\Óè\ﬂzÎ≠ºoç∏t\È“ªEπ_\…\œq*˛¢À≥\ˆüÅ$V\ZH6¸\ŸXòŒìzz\€|˛/|\È˚i|à\«4ŒøR\≈}òg\Ì>’∑X—∑âö\∆˘◊¢\‚1…≥\ˆ\Èo¨\Ë\ÔDM\„¸∑•\‚æŒ≥v\ﬂ\Îe¨\Ë\ÂDM\„¸\'¢\‚>œìÉˇ[~\ﬂ\Ùk\Ôt¸\Ú\\∫\›\Óï¸ˇ\√m∑\›\÷˚\\√\Ûæ5¢8è+\’\ZI¨\‰èOSπ\Âñ[z7\‹pC\Z\ˆ\Â⁄ÜAˇ“ó.ü\‰ø\Ùï\ˆ\ÂˇoM\'Ã•π\‰èMS—∑\ŸI˛gHöK˛\ÿ4˝m6\Ê\ÿX\…ü¶¢ó±\“\Ùk\Ôt¸æ\Û˘˚¸N\∆p\◊]w}\ÿ\Ù™y\Èç7\ﬁ¯ﬂù˙ﬂ±\ˆìé∑–áM\√ˇ“∑\·\œ\∆\¬dˇ•¨j\…ˇ\≈o\“C\…$\œ†ä˚≤\Ú>’∑X—∑\Ÿ\Ï€§U<6ïèë˛∆ä˛∂ªø\˜y\Â}Øó±¢ó\Ì\Óe©\‚æ\ﬂ\Ù§wÜïó7˝\⁄\€;\÷`\næ˙’Ø^i˙\ÁºKø˛\ıØü\Î\‘\˜;\÷\Ú\'õ5M$üêÆ%\ \ˆ∫\”\–@R˘gc›ß∂ˇ§^5å§\ﬂEQ\ıiJì\ZJ&q\ﬁC\ˆ>’∑\Õ\€˙∑\◊}õÕæM⁄∞èQ\”˝Õ≥P—•î∫∂7˝mwáΩ\Ô\Î\Ó\ÂBE\'Rfe˚¥£ó\Ì\Óeiò«†\„w¨Aª\›ˇ˝\Á£|*\Ëè¸\„\„5|*Ë¶ø\Ë˙\’=ê\‰Y®x≤Ôø¨\È\Ìuß\ÊÅd\‡üç>\€yr\ﬂj)áé™\Ì\€J∂sæc\ˆ>’∑¡\€Îéæ\Õf\ﬂ&m\ÿ«®\È˛\ÊY®\ËNˇe\”\ﬁ\ﬁt\Ù∑\›˝\ˆæØªó\Ëø,˙\ˆiG/\€\›\À\“0èÅOÖñ{\‡Åé=˝\Ù\”y\ﬂ\Z\Ò\‡É)\n˛W˘9N¬†ø\Ë˙\’=ê\‰Y®x≤Ôø¨\È\Ìuß¶Åd®?ôqû‰´Üç™OM™∫ﬁ∏C\…8\Áπm\√ﬁß˙6x{\›—∑\Ÿ\Ï€§\r˚5\›\ﬂ<\›\Èøl\⁄€õé˛∂ªø\√\ﬁ\˜u\˜r°¢˝óE\ﬂ>\Ì\Ëeª{Y\Z\Ê1(∂?\“Y_\Ã:t\ËP˛2∏V\È¯Âπ§\Û\ \œ\√˛˝˚ˇ\≈}\˜\›\˜q^∏|∏¥¥\ÙBQ\Ó?\œœ±Nu$y*û\Ï˚/kz{›©c ŸÜQûÏ´Üå™a§Tu˝QáíQŒØ˙6x{\›—∑v\˜m“ö\ÓoûÖä\Ó\Ù_6\Ì\ÌMG\ı7©ªó\Ëø,˙\ˆiG/\ı≤Tº\∆\›Q.f≠¨¨‰ØÉkµw\Ôﬁè˚\÷v\‰\Á\nå\·Å¯\„;\Ó∏\„\Í≈ã\Û\Œ\’\Í¬Ö?-ä˝Z:ü¸\ÎT\˜@íg°\‚…æˇ≤¶∑◊ù\‡I2Ãì~\’p1h)U\›nÿ°dò\Ûjúæ\r\ﬁ^w\Ùm\”\ÌZ’∑Ik∫øy*∫\”Ÿ¥∑7˝\›tªπ\Ïo›Ω\\®\Ë@ˇe—∑O;zπ\Èvs\Ÿ\Àdii\È\≈k›´\ÂÇ\÷˘\Û\Á\Ûó√µH\«\Ì[Tªö\Œ+?W`L\˜\ﬁ{\Ôè9í\˜ÆV\ﬂ¯\∆7˛∫(\˜j~nu´{ …≥P\Òd\ﬂY\”\€\Î\Œ$…†\'ˇ™°bòa§Tu˚\Î\r%É\Œ\'}ºΩ\Ó\Ë[\Â\Ì[”∑Ik∫øy*∫\”Ÿ¥∑7˝≠º˝\‹\ı∑\Ó^.Tt†ˇ≤\Ë€ßΩ¨º˝\‹\ı≤Tº\÷Mø\ˆhmQkuu59\\ãt‹æÖµ#˘9€∞¥¥\Ù\…={\ˆ¸\· ï+y\˜jq˘\Ú\Âü≈æò\Œ#?∑∫\’=ê\‰Y®x≤Ôø¨\È\ÌugFíd´!\‡\„#•™°\‰\ˆ\r\◊¯[ùGH˙6x{\›—∑5≠\Ì€§5\›\ﬂ<\›\Èøl\⁄€õé˛Æô˚˛\÷\›ÀÖä\Ù_}˚¥£ókÊæó•ù;w~¶\\\‘*^\˜\÷˛Æµtºn∑{\Ì\«@\”˘\‰\Ál\”=\˜\‹\Û\›\'ûx\"\Ô_-äcˇó¢\‹\ﬂ\Ãœ©	u$y6>\È\\Kî\ÌugÜí\‰\”õáÅ˛abúa§4\Ã~™éöæm\ﬁ÷øΩ\Ó\Ë\€5\√\Ïß\Í¯s•\È˛\ÊY®\ËRJ]€õé˛^3\Ã~™é\ﬂ\nu\˜r°¢)≥≤}\⁄\—\ÀkÜ\ŸO\’\Ò[ßx\Õ{™\\\ÿ:x\`˛≤x™\“\Ò˙ﬁ≠v*?7`nπ\Âñ?[^^~\Ô‹πsyß\Íπ\ÁûK?z1??ß&\‘=ê\»\‡\Ã\ÿ@íT\rixHˇ2W5Dåb\–~™éûæ≈äæm0h?U«ù;˙+˙ª¡†˝T∑5\Ù2V\ÙrÉA˚©:n+uª›õã◊æï\\«é\À_OE:Nﬂ¢\⁄G\È<\Ús&d◊Æ]y\◊]wΩ˘\ÚÂºãSq\Ò\‚\≈ˇQ˚\˜E>üüKS$±2ÉIR\˜pP\˜\Ò&F\ﬂbEﬂÜR\˜\Ò\¬\“\ﬂX\—ﬂ°\‘}º\⁄\Èe¨\Ë\ÂP\Í>^\„ø].r•	=s\ÊL˛2y¢\“˛˚4??\'`\¬\ˆ\Ï\Ÿs`ˇ˛˝\Ô•\'Éi˙\‡É~]¸E\Úã¢\‰ˇ:?á&HbeFí§Æ!°Æ\„LÖæ≈äæ]W]«ô	˙+˙{]ußQz+zy]u\'î\Â\Â\Â:ù\Œ\Û\ÂB\◊\Ó›ªß∂∏ñ\ˆ[\Ô\⁄;\‰\“q\”\Ò\Ûs¶\‡\ˆ\€orﬂæ}oO\Îùk/^|&-™\≈N?cäÅ$Vfx I¶=,L{ˇSßo±¢oM{ˇ3GcEö\ˆ˛\√\–\ÀX\—ÀÅ¶Ωˇ–ä\◊¡79\ﬂˇŒµ£Gè\Ê/õ∑%\ÌØˇùj\Î«ª)?`änΩ\ı÷Ø\ÌŸ≥\Á §\Á\⁄˙\ÔT{9\⁄;\’JíXô\ÒÅ$ô\÷\–0≠˝\÷J\ﬂbEﬂ∂4≠˝\Œ4˝ç˝\›“¥\ˆí^∆ä^niZ˚ù)\≈\Î\·O\ı/Æ•§\ÿÓßÖ¶\€gT∞∂®ñéóüPÉ¢Äüﬂµk\◊\Â\«{\Ï\’w\ﬂ}7\Ô\ÏH\ﬁ~˚\Ìg\◊?˝\Ûb\⁄o~¨($±“ÇÅ$ô\Ù\0\È˝5F\ﬂbE\ﬂ*Mz≠°ø±¢øï&Ωø\\Ù2V\Ù≤“§\˜7\”\“;\»:}?öíﬁΩ∂∫∫⁄ªp\·B˛íz†t˝tª\Ï]jk?˛ôéì®QQ\Ã?-ä¯\Õ\€nª\Ìù\Ô|\Á;g\ﬂx\„ç\Û\\·+Øº\Ú\”¨}\Úg\⁄O\⁄_~åH$±“íÅ$ô\‘1©˝Ñ†o±¢oõLj?≠§ø±¢øõLj?3E/cE/7ô\‘~Z%˝Œ≥\ı4\»\ƒz+++Ω√á\˜Nü>\›;{\ˆl\Ô“•Kk/≤\”\◊\Ù}∫<mﬂªw\Ô¶€¶˝•˝˙ùj\»\“\“\“\'ãrÆvª›ã_¸\‚ˇ¯„èü9y\Ú\‰/Ω\Ù\“\Àoæ˘\Ê\ﬂ˝~\˜\‚≈ã\Á^|\Ò\≈\Áä\'ë=¯\‡ÉGä€ºP\‹\Êˇ§€•\€\Á˚å\»@+-\ZHí\Ì€Ω}8˙+˙∂¡vo\ﬂz˙+˙ª¡vo?≥\Ù2V\ÙrÉ\Ìﬁæ\ıä\◊\Ÿ7ØõOU,êçìSi˘1Ä8˛h\ÁŒùˇ¨(\Íø_\\\\<Zî\ˆ\Áù¯\Ÿ\\Ù\ı\Á\È\Ú¥=]/]?\ﬂAdíXi\Ÿ@íå;Tå{ª\–\Ù-V\Ù\Ìöqo7W\Ù7V\Ù\˜öqo\◊\nz+zyÕ∏∑õK\≈\Î\Ë\œØ©èπZ±`6(\È˙G\“\Ì\Û}\‘\ @+-HíQáãQØ?3\Ù-V\ÙmÕ®◊ü[˙+˙ªf\‘Î∑é^∆ä^Æ\ı˙¨[^^æ±\”\È\ÏX\\\\|∏¯zº\»oãº∑æàñæ¶ÔèØoﬂëÆü\Ô†íXi\È@í;d{Ωô§o±¢oC_è˝ç˝˙z≠¶ó±¢óC_Ä61ê\ƒJãí\‰z\√\∆\ı∂\œ<}ã}∏ùå˛∆ä˛\‹>7\Ù2V\Ùr\‡v\0\⁄\ @+-Hí≠Üé≠.o}ã}\€t9\Ëo¨\Ë\Ô¶\À\Áí^∆ä^n∫Äy` âï9Hí|¯»øo-}ã}c˙+˙K¢ó±¢ó\0\Ã%I¨\Ã\…@íîC»æ\ıØs1å\Ë[¨\Ë£\–\ﬂX\—_ΩåΩ`.Hbeéí\‰\”\ÈS~\“\◊|C[\È[¨\Ë£\–\ﬂX\—_ΩåΩ`.Hbe\ŒíÖ\ıÅdn\Ë[¨\Ë£\–\ﬂX\—_ΩåΩ`.Hb\≈@\“n˙+˙\∆(\Ù7V\ÙóD/cE/òKíX1ê¥õæ≈äæ1\n˝ç˝%\—\ÀX\—K\0ÊíÅ$V$\Ì¶o±¢oåBcEI\Ù2V\ÙÄπd âIª\È[¨\Ë£\–\ﬂX\—_ΩåΩ`.Hb\≈@\“n˙+˙\∆(\Ù7V\ÙóD/cE/òKíX1ê¥õæ≈äæ1\n˝ç˝%\—\ÀX\—K\0ÊíÅ$V$\Ì¶o±¢oåBcEI\Ù2V\ÙÄπd âIª\È[¨\Ë£\–\ﬂX\—_ΩåΩ`.Hb\≈@\“n˙+˙\∆(\Ù7V\ÙóD/cE/òKíX1ê¥õæ≈äæ1\n˝ç˝%\—\ÀX\—K\0\Ê\“\Ò\„\«?~ˇ˝\˜7=1J˝)áWãÅ\‰É¸1j≥yH\Ù-N\ÙçQ\Èoú\Ë/%ΩåΩ`nù<y\Ú\’\◊_}”ì£‘ü\ﬂˇ˛\˜ˇπH~û?Fm6oâæ≈âæ1*˝ç˝•§óq¢ó\0Ã≠\'N¸\≈3\œ<\Û\ŒkØΩ\ˆ¶\Òk&\≈˝˛\⁄\Ô~\˜ªø.Üëóã|.å\⁄l\ﬁ}k>˙∆∏\Ù∑˘\Ë/9Ωl>z	\0køü\‚s\È_òä\\-≤\ˆ˚§÷§˚=\›ˇs5å$\Û8ê§\«y˝\Ò÷∑f¢oå-˝πYˇ\Û£ø\ÕD\Ÿ$˝yXˇs°ó\ÕD/\0öb Å˙\Ë\Ã.˝Öx\Ù\0húÅ\Í£o0ª\Ù\‚\—K\0†q®èæ¡\Ï\“_àG/Ä\∆H†>˙≥K!Ω\0\Zg Å˙\Ë\Ã.˝Öx\Ù\0húÅ\Í£o0ª\Ù\‚\—K\0†q®èæ¡\Ï\“_àG/Ä\∆H†>˙≥K!Ω\0\Zg Å˙\Ë\Ã.˝Öx\Ù\0húÅ\Í£o0ª\Ù\‚\—K\0†q®èæ¡\Ï\“_àG/Ä\∆H†>˙≥K!Ω\0\Zg Å˙\Ë\Ã.˝Öx\Ù\0húÅ\Í£o0ª\Ù\‚\—K\0†q®èæ¡\Ï\“_àG/Ä\∆H†>˙≥K!Ω\0\Zg Å˙\Ë\Ã.˝Öx\Ù\0húÅ\Í£o0ª\Ù\‚\—K\0†q®èæ¡\Ï\“_àG/Ä\∆H†>˙≥K!Ω\0\Zg Å˙\Ë\Ã.˝Öx\Ù\0húÅ\Í£o0ª\Ù\‚\—K\0†qU\…\ \√\'zUv;P≠™o¿l®\Ío˛<ò?\Êó\Á€Å\Ì\—K\0†q[\r$É.ª\ﬁv†ZUﬂÄ\ŸP\’ﬂ™\Á>œóPΩ\0\Zg Å˙T\ı\rò\rU˝≠z\Ó\Û|	\ı\—K\0†q®OUﬂÄ\ŸP\’ﬂ™\Á>œóPΩ\0\Zg Å˙T\ı\rò\rU˝≠z\Ó\Û|	\ı\—K\0†q®OUﬂÄ\ŸP\’ﬂ™\Á>œóPΩ\0\Z∑\’@Rïa∑’™˙ÃÜ™˛\ÊœÉ˘\Ûa~yæ\ÿΩ\0\ZW5ê\0”°o0ª\Ù\‚\—K\0†q®èæ¡\Ï\“_àG/Ä\∆H†>˙≥K!Ω\0\Zg Å˙\Ë\Ã.˝Öx\Ù\0húÅ\Í£o0ª\Ù\‚\—K\0†q®èæ¡\Ï\“_àG/Ä\∆H†>˙≥K!Ω\0\Zg Å˙\Ë\Ã.˝Öx\Ù\0húÅ\Í£o0ª\Ù\‚\—K\0†q®èæ¡\Ï\“_àG/Ä\∆H†>m\È\€\ \√\'zUv;Ã¢∂\Ù\⁄D/Ä\∆H†>m\È[\’\"Yæ∞÷øm´\Àf\’\Ú\Ú\Úç\≈cπcqq\Ò\·\‚\Î\Ò\"ø-\Ú^z|◊ø¶ÔèØoﬂëÆü\ÔÉ\Ÿ”ñ˛Bõ\Ë%\0\–8	‘ß-}´Z$õáÖµn∑˚\Ÿ\‚1<R\‰\Í˙\"⁄∞I\◊?ínü\Ôì\Ÿ—ñ˛Bõ\Ë%\0\–8	‘ß-}´Z$k\Û\¬Z∑€Ωπx\ÏNU,òçìSi˘1à/=~˘e@≥\Ù\0húÅ\Í”ñæU-íµqamyy˘Ü\≈\≈\≈oè\€\«˘\Ÿ\ \ J\Ô\\·√Ω”ßO\˜Œû=€ªt\ÈR/I_\”\˜\È\Ú¥=]/øm\⁄_\⁄o\⁄~L\‚jK°M\Ù\0húÅ\Í”ñæU-íµma≠x¨n\Ívªø\Ï_[ZZÍ≠ÆÆ\ˆ.\\∏∞∂à6¨t˝tªt˚lÅ\Ì˘tú¸\ÿ\ƒ‘ñ˛Bõ\Ë%\0\–8	‘ß-}KãdUv{t\›n\˜SE^\È_;x\`\Ô¸˘\Û˘ö\ŸH\“\Ì\”~≤≈µ\Û\Èx˘9O[˙m¢ó\0@\„$P}ã/ΩÉ¨Q-Ω\À\Ï\Ë—£˘\ZŸ∂§˝e\Ô^;üéõü±\Ë/ƒ£ó\0@\„$P}ã-˝Œ≥˛ˇ‹Ω{w\ÔÃô3˘∫\ÿD§˝¶˝\˜-Æ=\ÔwÆ≈¶øè^\0ç3ê@}\Ù-∂\ı*∏\ˆNµi-™ï\“˛˚ﬂπñéüüq\Ë/ƒ£ó\0@\„$P}ã´\€\Ì\ﬁ\\<>ïã\\«é\À\◊¡¶\"ß<f:~:è¸‹àA!Ω\0\Zg Å˙\Ë[\\\≈cs™\\\‡J0Pß\Ï\rN\Â\ÁF˙\Ò\Ë%\0\–8	\‘G\ﬂb⁄πs\Ág Ö≠\Ù£ô\€˝\Ù\œQ•\„\ıˇHh:ü¸iû˛B<z	\04\Œ@\ı—∑òä\«\ÂHπ®µ∫∫öØ{\’\"∑<át>˘9\“<˝Öx\Ù\0húÅ\Í£o\Ò,--}¢x\\ÆñãZuø[≠îé€∑∞v5ùW~Æ4K!Ω\0\Zg Å˙\Ë[Ω∫\›\Ó\Â\"+˘\Â˝ä\«dGπ†µ≤≤íØw\’*øoqmG~Æ•\Ùˇî˛\ﬂ\ÚÀô.˝Öx\Ù\0húÅ\Í£o\ı*©-∞\€)Øw\Ë–°|≠´V\È¯}kè\‰\ÁZ.®ï\◊…∑3]\ÓsàG/Ä\∆H†>˙VØæE™-ÿä\ÔOî€ü{\Óπ|≠´V\È¯}\Áz¢\Ô7,®YXkÜ˚\‚\—K\0†q®èæ\’+_à\Í[¥∫∂¿V|ˇry˘πs\Á\ÚµÆZ•\„\˜ù\Á\À[-®ï\…ˇô.\˜9ƒ£ó\0@\„$P}´Wæïg}\—\ÍÉ\Ú˚∑\ﬁz+_\Î™U:~\ﬂ˘}úüoû¸ˇó\ÈrüC<z	\04.°&\"2Ø˘\\√\ÛµÆZ•\„\Á\Á$\"\"Éìœ∂\0\0\0L@˛\‚´LˇèÇ_ØîóGz\«Z:/?\n\n\0\0\0@#\ÚÖ®˛µæ\ÎÑ˝k\Â9nµ¿\÷ˇˇ\0\0\0\03hA≠‘ùÅO\Ì;\◊\rl˘v\0\0\0\0òàAj•Nß\ÛHπPu\Ë–°|≠´V\È¯}\ÔH{$?\◊Rπ¿ñ_\0\0\0\0µ\Èt:;\ ≈¨ïïï|≠´V{\˜\Ó\Ìˇ$\–˘π\0\0\0@KKKü\Ët:W\À≠\Û\Á\œ\Á\Î]µH\«\Ì[Tªö\Œ+?W\0\0\0\0•\”\È)µVWW\Û5ØZ§\„\ˆ-¨\…\œ\0\0\0\0\¬Ÿπs\Ág\ E≠•••\⁄ﬂµñé\◊\ÌvØ˝h:ü¸\0\0\0 §Nßs™\\\ÿ:x\`æ\ˆ5U\Èx}\ÔV;ïü\0\0\0\0Ñ\’\Ìvo\Ót:ï\\«é\À◊ø¶\"ßoQ\Ì£t˘π\0\0\0@hããã\ﬂ\Óˇë\–3g\Œ\‰\Î`ï\ˆ\ﬂˇ#†\È¯˘9\0\0\0@x\À\À\À7t:ù\ÁÀÖÆ›ªwOmq-\Ì∑8ﬁµw»•\„¶\„\Á\Á\0\0\0\03°\”\È\‹T\‰|ˇ;◊é=öØãmK\⁄_ˇ;\’÷èwS~.\0\0\0\00S∫\›\Óß˙\◊R\“l\˜\”B\”\Ì≥*X[TK\«\À\œ\0\0\0\0f\“˙;◊Æ˝XhJz\˜\⁄\Í\Íj\Ô¬Ö˘ö\Ÿ@\È˙\ÈvŸª\‘\÷~¸3\'?6\0\0\0\0Ã¥\Ù;\œ\÷?\– _Î≠¨¨\Ù>\‹;}˙t\Ô\ÏŸ≥ΩKó.≠-¢•Ø\È˚ty⁄æw\Ô\ﬁM∑M˚K˚\ı;\’\0\0\0\0hµn∑{sß\”9U±@6NN•˝\Â\«\0\0\0\0Ä\÷\Ívªü\Ìt:Gä\\≠X0ît˝#\È\ˆ˘>\0\0\0`n,//\ﬂ\ÿ\Ètv,..>\\|=^\‰∑E\ﬁ[_DK_\”\˜\«◊∑\ÔH\◊\œ\˜\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\00K˛\ŸC\≈u\'8Ç\0\0\0\0IENDÆB`Ç',1),('62562',1,'ClassGuidePartySealApprovalProcess.bpmn20.xml','62561',_binary '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" xmlns:flowable=\"http://flowable.org/bpmn\" targetNamespace=\"http://www.flowable.org/processdef\">\n  <process id=\"ClassGuidePartySealApprovalProcess\" name=\"ÂÖöÁ´†ÂÆ°ÊâπÔºàÁè≠‰∏ª‰ªªÔºâ\" isExecutable=\"true\">\n    <startEvent id=\"StartEvent_1\" name=\"ÂºÄÂßã\" />\n    <userTask id=\"MentorApproval\" name=\"ËæÖÂØºÂëòÂÆ°Êâπ\" flowable:candidateGroups=\"2013952827238473729\" flowable:assignee=\"2013951264663101441\" />\n    <sequenceFlow id=\"Flow_1\" sourceRef=\"StartEvent_1\" targetRef=\"MentorApproval\" />\n    <userTask id=\"PartySecretaryApproval\" name=\"‰π¶ËÆ∞ÂÆ°Êâπ\" flowable:candidateGroups=\"2013952940048474113\" flowable:assignee=\"2013951382959251457\">\n      <incoming>Flow_02zd53y</incoming>\n    </userTask>\n    <sequenceFlow id=\"Flow_2\" sourceRef=\"MentorApproval\" targetRef=\"Gateway_Mentor\" />\n    <endEvent id=\"EndEvent_1\" name=\"ÂêåÊÑè\">\n      <incoming>Flow_00gdfib</incoming>\n    </endEvent>\n    <sequenceFlow id=\"Flow_3\" sourceRef=\"PartySecretaryApproval\" targetRef=\"Gateway_Ps\" />\n    <userTask id=\"DeanApproval\" name=\"Èô¢ÈïøÂÆ°Êâπ\" flowable:candidateGroups=\"2013952886889865217\" flowable:assignee=\"2013951338067615746\">\n      <incoming>Flow_0sczlhw</incoming>\n      <outgoing>Flow_06ao9c0</outgoing>\n    </userTask>\n    <sequenceFlow id=\"Flow_06ao9c0\" sourceRef=\"DeanApproval\" targetRef=\"Gateway_Dean\" />\n    <exclusiveGateway id=\"Gateway_Mentor\" name=\"ËæÖÂØºÂëòÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_2</incoming>\n      <outgoing>Flow_0sczlhw</outgoing>\n      <outgoing>Flow_1esxqux</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_0sczlhw\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_Mentor\" targetRef=\"DeanApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <exclusiveGateway id=\"Gateway_Dean\" name=\"Èô¢ÈïøÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_06ao9c0</incoming>\n      <outgoing>Flow_02zd53y</outgoing>\n      <outgoing>Flow_0uytuzh</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_02zd53y\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_Dean\" targetRef=\"PartySecretaryApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <exclusiveGateway id=\"Gateway_Ps\" name=\"‰π¶ËÆ∞ÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_3</incoming>\n      <outgoing>Flow_00gdfib</outgoing>\n      <outgoing>Flow_01y7cmd</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_00gdfib\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_Ps\" targetRef=\"EndEvent_1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <endEvent id=\"Event_11k28kr\" name=\"ÊãíÁªù\">\n      <incoming>Flow_1esxqux</incoming>\n      <incoming>Flow_0uytuzh</incoming>\n      <incoming>Flow_01y7cmd</incoming>\n    </endEvent>\n    <sequenceFlow id=\"Flow_1esxqux\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_Mentor\" targetRef=\"Event_11k28kr\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_0uytuzh\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_Dean\" targetRef=\"Event_11k28kr\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_01y7cmd\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_Ps\" targetRef=\"Event_11k28kr\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_1\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_1\" bpmnElement=\"ClassGuidePartySealApprovalProcess\">\n      <bpmndi:BPMNEdge id=\"Flow_01y7cmd_di\" bpmnElement=\"Flow_01y7cmd\">\n        <omgdi:waypoint x=\"880\" y=\"203\" />\n        <omgdi:waypoint x=\"880\" y=\"290\" />\n        <omgdi:waypoint x=\"658\" y=\"290\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"884\" y=\"244\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0uytuzh_di\" bpmnElement=\"Flow_0uytuzh\">\n        <omgdi:waypoint x=\"640\" y=\"203\" />\n        <omgdi:waypoint x=\"640\" y=\"272\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"644\" y=\"235\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1esxqux_di\" bpmnElement=\"Flow_1esxqux\">\n        <omgdi:waypoint x=\"410\" y=\"203\" />\n        <omgdi:waypoint x=\"410\" y=\"290\" />\n        <omgdi:waypoint x=\"622\" y=\"290\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"414\" y=\"244\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_00gdfib_di\" bpmnElement=\"Flow_00gdfib\">\n        <omgdi:waypoint x=\"905\" y=\"178\" />\n        <omgdi:waypoint x=\"962\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"923\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_02zd53y_di\" bpmnElement=\"Flow_02zd53y\">\n        <omgdi:waypoint x=\"665\" y=\"178\" />\n        <omgdi:waypoint x=\"730\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"687\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0sczlhw_di\" bpmnElement=\"Flow_0sczlhw\">\n        <omgdi:waypoint x=\"435\" y=\"178\" />\n        <omgdi:waypoint x=\"490\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"452\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_06ao9c0_di\" bpmnElement=\"Flow_06ao9c0\">\n        <omgdi:waypoint x=\"590\" y=\"178\" />\n        <omgdi:waypoint x=\"615\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_Flow_3\" bpmnElement=\"Flow_3\">\n        <omgdi:waypoint x=\"830\" y=\"178\" />\n        <omgdi:waypoint x=\"855\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_Flow_2\" bpmnElement=\"Flow_2\">\n        <omgdi:waypoint x=\"360\" y=\"178\" />\n        <omgdi:waypoint x=\"385\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_Flow_1\" bpmnElement=\"Flow_1\">\n        <omgdi:waypoint x=\"216\" y=\"178\" />\n        <omgdi:waypoint x=\"260\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNShape id=\"_BPMNShape_StartEvent_2\" bpmnElement=\"StartEvent_1\">\n        <omgdc:Bounds x=\"180\" y=\"160\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"189\" y=\"203\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_1\" bpmnElement=\"MentorApproval\">\n        <omgdc:Bounds x=\"260\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_2\" bpmnElement=\"PartySecretaryApproval\">\n        <omgdc:Bounds x=\"730\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_EndEvent_1\" bpmnElement=\"EndEvent_1\">\n        <omgdc:Bounds x=\"962\" y=\"160\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"971\" y=\"203\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_0to05uw_di\" bpmnElement=\"DeanApproval\">\n        <omgdc:Bounds x=\"490\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1773svk_di\" bpmnElement=\"Gateway_Mentor\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"385\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"372\" y=\"123\" width=\"77\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_08j8dl0_di\" bpmnElement=\"Gateway_Dean\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"615\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"607\" y=\"123\" width=\"66\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1yug5i5_di\" bpmnElement=\"Gateway_Ps\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"855\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"848\" y=\"123\" width=\"66\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Event_11k28kr_di\" bpmnElement=\"Event_11k28kr\">\n        <omgdc:Bounds x=\"622\" y=\"272\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"629\" y=\"315\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>\n',0),('62563',1,'ClassGuidePartySealApprovalProcess.ClassGuidePartySealApprovalProcess.png','62561',_binary 'âPNG\r\n\Z\n\0\0\0\rIHDR\0\0\\0\0>\0\0\0*\"˚\„\0\0!IDATx^\Ì\›œè\Áô\\Ÿ] ríì›£.>˘_\\Ê`l$à\Ô(gD\…CPñh\ÿ\0G0%\"ëeY\ﬁd…∂D A¨\\$<\“1\‚»§é)õe≠\Â@\Îê˙ARZQ¢(ëª\"iZ\Í\‘;\È\Ê\ﬂyg¶´ª´Î≠ö\œx0ö™\Óz_≤¯ùz^UO\˜\Ã\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0#\Í\ızˇ\Ï‘©S?¸\≈/~\Ò˚Cá\ıû˛y5\Â*˛\ﬁ?=r\‰\»€á˛ã¯¸∞1\…e\Û%óåJ~õ/˘†≥ä&\„π\‚\"\◊{\˜\›w{ó/_\Ó]ΩzUMπ\¬\ﬂ{¯˚\Ò\≈?*\Zè/\«ÁàçG.õ/πdT\Ú\€|\…/\0ù\ÓÑã\\|\ÒS”Øw\ﬁy\Á˝¢\—¯e|é\ÿx\‰2üíK™í\ﬂ|J~\Ëú\\Ú>w\Ú®päF\„J|é\ÿx\‰2üíK™í\ﬂ|J~\Ëú\ªb\ÒO5W\·|\ƒÁàçG.\Û*π§\n˘Õ´\‰ÄN∂\—¯á\ﬂ\Èù˙\’\ÈΩ˙≥áó+¸w\ÿ?NçW\Z\rπÃ´\‰í*\‰7Øí_\0:eòF\„“Ö≥Ω\ﬂ¸\ÙØzø˛\Ô\˜\›Pa[\ÿ?^ç^\Z\rπÃ´\‰í*\‰7Øí_\0:eòF\„\Ù´V4É:\Û\Í¡èW£óFÉ@.\Û*π§\n˘Õ´\‰ÄN¶\—¯?/\Ï]\—`*\ÏãØF/çÅ\\\ÊUrI\ÚõW\…/\0ù2L£\Òõ\ÁZ\—`*\ÏãØF/çÅ\\\ÊUrI\ÚõW\…/\0ù¢\—»´4\ZrôW\…%U\»o^%ø\0t\ 0çFxw‹∏¡T\ÿ?^ç^\Z\rπÃ´\‰í*\‰7Øí_\0:eòF\„w?ˇ\ÓäcPa_¸x5zi4\‰2ØíK™êﬂºJ~\Ëîa\Zç\Ûg_\È˝\Ê˛áMF\ÿ\ˆ≈èW£óFÉ@.\Û*π§\n˘Õ´\‰ÄN¶\—\ı˙±ßW4\Za[¸85^u®\—¯\Á\ÒÜ\'óyï\\RÖ¸\ÊU\Ú@ß\’h\\π\“˚\›ˇ~bE£∂Ö}+ØFÆé4\Z_(\Í\›˛WF óyï\\RÖ¸\ÊU\Ú@ß¨\◊h\\∫p∂\˜w?|Eì1®∞/<&~û\Z≠:\–höå]˝Øöç\»e^%óT!øyï¸\–)´6\ZWÆ\Ù\ﬁ˘\›\·\ﬁ\ﬂ˛èø¢πà+<&<\÷]É\Ò´\ÂçF|á ˛û!\…e^%óT!øyï¸\–)©FcΩª´ïª\„Wãç’öä’∂≥πÃ´\‰í*\‰7Øí_\0:%\’hsw`µ\nœçèßÜØñ6\Z\Î5\Î\Ì\'\"óyï\\RÖ¸\ÊU\Ú@ß§\Zç∏y®Z\Ò\Ò\‘\\’\¬Fc\ÿ&b\ÿ\«1#óπï\\RÖ¸\ÊU\Ú@ß§\Z\r\’\\µ¨—®\⁄<T}¸Ü%óyï\\RÖ¸\ÊU\Ú\À8nﬁ≤eÀ¶\Ÿ\Ÿ\Ÿ«äØáäzΩ®èã\Í\ıøÜ\Ô\ı\˜o\nèèèåÈ£è>˙x¯ª\ﬂ˝\ÓØ\˜\Ï\Ÿ\Û˛\Ó›ª/˝\Î_ˇ4q«é\◊v\Ì\⁄u\ÒÅx\Î\·á>x\ﬂ}\˜˝õ\‚)£K4\ZyUã\ZçQõÜQü∑°\»e^%óT!øyï¸2äπππ/kÉ•¢Æ\ˆ\Î\√Vx¸Rx~|L†¢ó^zi«£è>z\ˆû{\Ó\Èã\ˆ\ﬁs\œ=\◊;~¸x\Ô\‰…ìΩ\Û\Á\œ\˜Ç\5|∂á˝\˜\ﬂˇß€∑oøZ,\‰:??ˇ\Ÿ¯ò]†\—»´Z\“hå\€,å˚¸ŒìÀºJ.©B~\Û*˘•äb\·˝˘b~4±0•éÜ\„\≈c\0\Îx\ÂïW˛\Ì\˜øˇ˝∑\Ôæ˚\Óﬁè~\Ù£\ﬁ{ÔΩ∑ºXVx|x^±êˇ˝Ω\˜\ﬁ˚\√\"à\Zè\—f\Zçº™ç∆§öÑIglãè\Ó•j\ÿ˝uêÀºJ.\Ûg0\Œbº=\ﬁ?-\ÚõW\…o3\‚\∆yå∑\«˚ßmaa\·¶\Ÿ\Ÿ\Ÿ\Ôã\Ó\ÂW\Âñkqq±∑ˇ˛5o¸Ö˝\·q\Òs\√\Ò\¬q\√\Ò\„1ÅHë´?˘\…O~r ,‹üz\Í©ﬁ•Kón\\ôWûéS\\„≠[∑˛e<^[i4\Ú™\ÃçI7ì>\ﬁHR\rC\‹dî\˜≠∂mí\‰2Øí\À<§r\◊tVS\‰7Øí\ﬂf§≤óc^Ébë}\À\‹\‹‹Ø\À\Ô˘˘˘ﬁæ}˚zgŒúâók\nè\œœè\Ú/áq‚±Åæ\"?7?\Û\Ã3\˜ço|£w\Í‘©8[c	«ª˚\Óª/oﬂæ}O<ni4\Ú™åç∫öÇ∫é;¥T\√\–tì!óyï\\\Ê!ïª¶≥ö\"øyï¸6#ïΩ\ÛZ,\‹?W\‘\Ÿ\Úb{\ÔﬁΩΩ”ßO\«KÄJ\¬\Û\√q¢E¸\È0^<\ÿ\ä\Ã\‹¸\ÿcè]x\¡{.\\à\Û4·∏ªw\Ô˛¯\Œ;\Ô|:øm4\ZyU¶çF\›\Õ@\›\«_S™ah∫…êÀºJ.\Ûê\ ]\”YMëﬂºJ~õë\ ^ny\Ì\ﬂyøæxw\Õ8∑˝c	«ã\Ó∆üv\'Jäú¸\…3\œ<\Ûª∞x?¥\Îéøk◊Æoø˝\ˆ\‚y¥âF#Ø ∞\—(7\·æ\⁄ˇ:é\‘q\Zk6R\rC\”MÜ\\\ÊUr9˝\\¶§r\◊tVS\‰7Øí\ﬂf\Úõ\ ^Ny\røì^~\Ÿ¸∂m\€z\'Núà\€˝â\«\r\«/-\‚_\ˆ;\Ò\–~\Á˝õ\ﬂ¸fmw\ﬁcaúª\Ó∫\ÎbƒØ\ƒsiçF^ïY£7ˇπ®0ø\u\‘fc≠\„4\“l§\ZÜ¶õπÃ´\‰r˙πLI\ÂÆÈ¨¶\»o^%ø\Õ\‰7ïΩú\Ú\⁄√∫\Îw\ﬁ\ÎZºÑ\„ó\Ôƒá\Ò\„9¡ÜS\„\À\·\r\Î&˝;\Ô\Î	\„m›∫\ı\¬m∑\›\ˆg\Òú\⁄@£ëWe\‘h\ƒ˝Ø\Œ¸ˇ\Ê`Pqì0årì1®;ox\ƒ\ qk\ZÜT\rªørôW\…\Âäqg0\Œbº=\ﬁ?-\ÚõW\…\Ôäqß\"\Œaú\«x{ºøN˝èä˚d∞ò>x\`\‹\ﬁ\◊\"åS∫ˇâèòc\√\ﬁ%æ	O<\Ò\ƒ\€Eøœ©\r4\ZyU&çF\Íbüj™4©\Áˇß˛\ˆXj¸\rE.\Û*π\\ñ\Zü˘Õ´\‰wYj¸\rkK\Ès\ﬁ\√\ÕMS\Ù\∆vG\„π¡Ü\Ò\“K/\Ìw\ﬂ/^º\Ád*¬∏w\‹q\«G\Û\Û\Ûüç\Áñ;çF^ïA£±\÷E>\’,\”l§û∑Zì1∞\÷<:O.\Û*πºn≠y\–\'øyï¸^∑\÷<6åÕõ7q∞Ä/i\˜\›\Ê´\n\„ï_J\Ê\œ6ÑG}\Ù\Ï\“\“Rúë©z˙\ÈßOA\‹\œ-w\Zçº™\·Fcòã{™iX´\ŸH=~Ω&c`ò˘tí\\\ÊUryÉaÊ≥°\…o^%ø7f>ùV\Ù\ÍKÉ\≈s¯º\ˆ&ÑqKw\·ó\‚9B\Á]ºx\Ò_\Óÿ±£w\Ó‹π8SUåˇá˘˘˘wz\Ë°?é\Áò3çF^\’`£QÂ¢ûjR\ÕF\Íq\√6U\Ê\’rôW\…\Â\nU\Êµ\·\»o^%ø+TôWß}˙gä\Û\’¡\‚y\⁄w\ﬂ¬∏•¸\’0ØxÆ\–i?˛\Òè\˜\ÏﬁΩ;\ŒF#\Ó∫\ÎÆ7ä ˛y<\«&\Ûx°®[\„\Ì1çF^5N£1\Ï9O\Âbûj\"\ \ÕFj\’&c`î˘ei\ÿs$óyï\\&ç2øV\ˆ\\\ o^%øI£\Ã/k√ú´bˇ¶-˝Ö\Û\‚\‚b\‹\∆OU0ó0ØxÆ\–iè?˛¯\ﬂ>\˜\‹sq.\Z\Ò\‰ìOæ\\Ñ\Ø\„96°\ÙCa\Õh\Zçºj\ÃFc®s\Á\"ûj&\¬\˜\·U(\Ò\ˆQõåÅqÊôçaœë\\\ÊUrπ™q\Ê\Ÿ:√ûK˘Õ´\‰wU\„\Ã3;√ú´b˚\„É\«=˚\Ï≥q?Ua¸“úè\Á\nù∂gœû\˜è?\Á¢Géyevv\ˆ@<\«&î~(¨˘M£ëWM®\—X\ÛúóL\‚\‚ùj6^ãæ∑\…ò\ƒ|5\Ï9íÀºJ.\◊4â˘∂¬∞\ÁR~\Û*˘]\”$ÊõÖa\Œ\’\‹\‹\‹\·¡˛c«é\≈m¸TÖ\Òs	\Û*\œ:\Ô˛˚\Ôø<\Ì\œ~_\ÕkØΩ\ˆF\ƒ_\≈slB\‚Y\ÚöF#Øöp£ë<\Á}ìºhßöçI7ìú\˜\‘%\ŒM\Ú\…e^%ó\Îö‰º≥ï8á\…s)øyï¸Ækí\ÛnL\‚≠8W\≈◊∑€õ^;Ñ\ÒKs|+˙\„@∑\Ìÿ±\„\”>¯ \ŒE#Œü?©\·\ŸxéMH¸\0ãk˘öF#Ø™©—∏\·ú\œ\‘s±/\Ôã\ÔÑ\Ô\ÎxS\«:\Ê?âs\◊\Ú9íÀºJ.áR\«¸≥í8wq-üK˘Õ´\‰w(u\Ã™\Á&ÆpÆ˛q\}\”ká0˛`.sss\„?t\⁄w\‹—ªv\ÌZúãF\Û∏ò¯Åëui4\Ú™¯¸L∫nª\Ì∂\ﬁM7\›öÄ]qñ∆∞÷ùÇ∞}íw\nv\≈∂ÆU¸oC5W\Òπôt\…e\˜*˛7§ö´¯\‹L∫‰∑ù\’\Ù\⁄!å_ö\œ\‚ìùv\œ=\˜\\k˙ˇ¢\rº\˜\ﬁ{ˇwK˛w\‡_\ÿ\‚•~\ŸVMw\nn8\Á3ì˝?\Ì©&#æc0\Èfcí\Ûü™ƒπIû#πÃ´\‰r(ìúñ\Á0y.\Â7Øíﬂ°Lr˛çHú£\Á*\‹\Èloz\Ì\‡<⁄∑æ\ı≠ãMˇ\À¿o˚\€c[\Ú˝¯¯b≥¨\ÈFc\Ê\∆\“\ı\ eˇ¥k¬çF\Úú\˜}af¸ãu™\…øõóz∑\‹I5ìòwcÜ=GM\Á2ÆôDFBMk\”%ó\Îöƒº≥7Ïπî\ﬂ\˜7]\ÚªÆIÃªq√ú´-~\Ú\\‡Éû\Œ\Â]\Ë\ˆ≥ü\ \]\ËW¸\0+k∫—òI\\\‰\À€ö\ﬁ?\ÌöP£±\Ê9/Á¢ΩZì1h&R˚\«m6∆ôoÜ=GM\Á2ÆôD&\ \€\Í\ﬁ\ﬂt\…\Âö∆ôo´{.\Â7Ω≠©í\ﬂ5ç3ﬂ¨sÆº=d‚°á:ò\À\Á¿?\Ú\»#K[\Ú˘¯UÄï5\›h\Ã$.\Ú\ÂmM\Ôüvç\Ÿhu\Œ#£\\ºSMD\Í]qSèµ\Ÿeû\Ÿ\ˆ5ùÀ∏fô(o´{\”%ó´\Zeû≠5Ïπî\ﬂ\Ù∂¶J~W5\ <≥5Ãπ\⁄\‚s\‡!ªw\Ô˛\◊\˜\ﬂˇßq0\Zpm~~˛ï\"Ñ\œ1gM7\Z3âã|y[\”˚ß]\„4\Zc®rO5©&c \ı¯™\ÕFï˘uB”πåk&ëâ\Ú∂∫\˜7]rôTe~ä¸¶∑5U\ÚõTe~ùQ\Ù\Ëõã\Ê\≈\≈≈∏èü™ù;w~ZZ¿oä\Á\nù\ˆ\–C˝\Ò]w\›u\ı‹πsq6¶\ÍÃô3?/¯NòO<«ú5\›h\Ã$.\Ú\ÂmM\Ôüv5\‘h\√\\\ÃSM\√ZM\∆@\Íy\√6\√Ã´sö\Œe\\3âLî∑’Ωø\Èí\ÀÜô◊Ü%ø\ÈmMï¸Æ0Ãº:i~~˛3EØ~u∞p>}˙t\‹\ŒOE∑¥xø\Z\Ê\œ:\Ôæ˚\Ó˚\È\“\“Rúè©˙\ˆ∑ø˝7E\˜\≈s\À]”ç\∆L\‚\"_\ﬁ\÷\Ù˛iWÉçF∞\÷E=\’,\”d§ûø^≥±\÷|:≠\È\\\∆5ì\»Dy[\›˚õ.πº¡Z\ÛaF~W\€\÷T\…\Ô\r÷öœÜP\Ù\Í\·\◊]ó\œ˚\ˆ\Ìã\€˘©\„ñ\K\ÒaCòüüˇ\Ï\ˆ\Ì\€\Ò\‚\≈8#Sq\·¬Ö_<\Ê\œ-wM7\Z3âã|y[\”˚ß]\r7\Z¡j\˜ØŒå\ﬁd§öç;ox\ƒ?YmB”πåk&ëâ\Ú∂∫\˜7]ry\›j\Û†D~\”€ö*˘Ωnµyl(õ7o˛\‚`\Ò\\\Ù\ÌSø∆õõõª˛\Ú˘0üxé∞a\‹{\ÔΩ?|Í©ß\‚úLE1\ˆ+B¯ùxNm\–t£1s\„E\Áz\Â≤⁄ïA£|af\ÂEæ\‹$å\“dsú\‘¯J”πåk&ëëP\”\⁄\ﬂt\…\Â≤\‘¯$\»\Ôç˚õ.˘]ñ\Z\√*z\ˆ£É\ÙﬁΩ{„∂æVaº\“\›\˜£\Ò\‹`Cπ\Ì∂\€˛laa\·\„iÆ\„±c\«\¬K\ÁœÖ\Ò\„9µAnç\∆FØL\Zç u±MA¯?˚©Ê†äµéì\Zw√ëÀºJ.ì\„≤\n˘Õ´\‰79\ÓÜ677\˜˘¢wˇd∞ê>x\`\‹\ﬁ\◊\"åSZº\Ê\œ\r6ú≠[∑˛\Â=\˜\‹s˘¬Öqfjq\Ó‹πˇU\Õ¢æœ•-4\ZyUFçF0\Ìã˛¥\«Àñ\\\ÊUr9\’\ÒZO~\Û*˘ù\Íx≠1;;˚Ω¡b:ºî˛ƒâqõ?Q\·¯\ÂóŒá\Ò\„9¡Üµ}˚\ˆ=ªw\Ô˛8¸–Æ”ï+W~[˛WEˇ]<á6\—h\‰Uô5\Z¡¥.˛\”\Zß\‰2Øí\À\⁄\«\È˘Õ´\‰∑\ˆqZiaa\·¶b!˝\Ú`AΩm€∂\⁄\Ò\·∏\≈x\◊\Ô¯áq\√¯\Òú`Cª\Û\Œ;üﬁµk◊áu›â?w\Ó‹ãa\Ò^0¸ÆQ´i4\Ú™ç†\Ó&†\Ó„∑é\\\ÊUrI\ÚõW\…/´)˙¯[ä:]æ\‡¿Å∏\ÌK8^˘\Œ{º[\‚π\0Ö\€oø˝Å\Ì€∑_ú\Ù\Ô\ƒ\˜\Á˝≠∂\ﬂy\–h\‰Uô6\ZA]\Õ@]\«m5πÃ´\‰í*\‰7Øí_\÷R\Ù\Ûü+/\‚CÖ7ö\˜\›\È\√\Û£7¨[^ºá\Ò\‚9\0%EPæ≤u\Î\÷O<\Ò\ƒ€ó.]ä≥U…á~¯Rˇ\›\ÊœÖ\„\∆cµïF#Ø ∏\—&\›L˙xù!óyï\\RÖ¸\ÊU\Ú\Àz\¬\Ò-•ó”á\nw\„\√Áµü9s&^¨)<></∫\Îæ¸≤˘0N<6êP\ËOã¿|\Áé;\Ó¯\Ë?¯¡\…\˜\ﬁ{\ÔZ∂5\\;{\ˆ\Ï\œ\˜\ÏŸ≥¸N\Û\·8\·x\Òm¶\—»´2o4ÇI5ì:N\'\…e^%óT!øyï¸2å\;\È˝7∂ãﬁΩ\≈\≈\≈\ﬁ˛˝˚{«è\Ôù<y≤w˛¸˘\ÂEB¯\Zæ\€\√˛ù;wÆxn8^8Æ\ﬂyá\Ã\œ\œ∂—æb~\Ók_˚⁄õO>˘\‰â#Géº\Ú\⁄kØΩ\ı˛˚\ÔˇCë\√K\ÁŒù;\ıÍ´Ø+~\ÿ?ˇ\»#è,\œy•x\Œﬂá\ÁÖ\Á\«\«\ÏçF^’ÇF#∑I\˜˘ù\'óyï\\RÖ¸\ÊU\ÚK˝èòª˛9\Òc\÷Qì\ÒGõ7o˛WE†˛\„\Ï\Ï\ÏÅ\"\\ø\‹\ÚOø˚æ˛2l˚\√\„\¬\„\„tâF#ØjI£å\⁄,å˙º\rE.\Û*π§\n˘Õ´\‰óQ\ÎÄ/kÇ•¢Æ&\ÊkUx¸Rx~|LÄâ\–h\‰U-j4Ç™MC\’\«oXrôW\…%U\»o^%øåcaa\·\ÊbAæivv\ˆ±\‚Î°¢^/\Í\„˛b=|\r\ﬂ\Í\Ô\ﬂ`¢4\ZyU\À\Zç`\ÿ\Êa\ÿ\«1#óπï\\RÖ¸\ÊU\Ú@ßh4\Ú™6\Z¡zM\ƒz˚â\»e^%óT!øyï¸\–)\Zçº™•çF∞Z3±\⁄v\÷ óyï\\RÖ¸\ÊU\Ú@ßh4\Ú™7\ZA\‹T\ƒ\ﬂ3$πÃ´\‰í*\‰7Øí_\0:E£ëWµº\—\Õ≈Æ˛WM\∆\‰2ØíK™êﬂºJ~\ËçF^’ÅF#¯Bxw\÷\5\ﬁ¡p\‰2ØíK™êﬂºJ~\ËçF^’ëFc¶\ﬂh0\"πÃ´\‰í*\‰7Øí_\0:E£ëWi4\‰2ØíK™êﬂºJ~\ËçF^•\— êÀºJ.©B~\Û*˘†S4\ZyïFÉ@.\Û*π§\n˘Õ´\‰ÄN\—h\‰U\Z\rπÃ´\‰í*\‰7Øí_\0:E£ëWi4\‰2ØíK™êﬂºJ~\ËçF^•\— êÀºJ.©B~\Û*˘†S4\ZyïFÉ@.\Û*π§\n˘Õ´\‰ÄN\—h\‰U\Z\rπÃ´\‰í*\‰7Øí_\0:E£ëWi4\‰2ØíK™êﬂºJ~\ËçF^•\— êÀºJ.©B~\Û*˘†S:\Ù\È\ÂÀóW\\\\‘\Ù´8oç∆ï¯µëFc<rôO\…%U\…o>%ø\0tŒë#G\ﬁ~\˜\›wW\\\Ù\‘\Ù\Î\Õ7\ﬂ¸ØE£\Ò\À¯µëFc<rôO\…%U\…o>%ø\0t\Œ\·√áˇ\‚\≈_¸\Ëùw\ﬁy\ﬂÉf™¯{\Áç7\ﬁ¯õ¢\…x´®/\«Á®ç4\Z\„ë\À\ÊK.ï¸6_\Ú@ßÖã[¯?\‘E]\rø+¶¶^\·\Ô=¸˝w¢\…4\Z\„ˇ˙ˇ.‰≤ôíKF˛\›\Ùˇ˝\»o3%ø\0\0\√\“h@~\‰\⁄K~Ä\⁄h4 ?r	\Ì%ø\0@m4\ZêπÑ\ˆí_\0†6\Z\r»è\\B{\…/\0Pç\‰G.°Ω\‰\0®çF\Ú#ó\–^\Ú\0\‘F£˘ëKh/˘\0j£—Ä¸\»%¥ó¸\0µ\—h@~\‰\⁄K~Ä\⁄h4 ?r	\Ì%ø\0@m4\ZêπÑ\ˆí_\0†6\Z\r»è\\B{\…/\0Pç\‰G.°Ω\‰\0®çF\Ú#ó\–^\Ú\0\‘F£˘ëKh/˘\0j£—Ä¸\»%¥ó¸\0µ\—h@~\‰\⁄K~Ä\⁄h4 ?r	\Ì%ø\0@m4\ZêüT.;\‹K’∞˚Å\ÈH\Â\0`\"4\ZêüT.Sã\Òx_ﬁ∑\⁄6†^©¸\0LÑF\Úì\ ej1n˘I\Â\0`\"4\ZêüT.Sãqx\»O*ø\0\0°—Ä¸§rôZå[¿C~R˘\0òç\‰\'ï\À\‘b\‹\Úì\ /\0¿Dh4 ?©\\Ü\≈x™Ü\›LG*ø\0\0°—Ä¸\»%¥ó¸\0µ\—h@~\‰\⁄K~Ä⁄§\Zç¯%∏\ÒKq\„\Ì\Ò~`<©\\\Ìê\ o|ΩåØõ\Ò\ˆx?\0¿≤\’\Zçµ∂≠∑O*ó@;§\Úõ∫F∫Æ\0ïi4 ?©\\\Ìê\ o\Í\Z\È∫\n\0T¶—Ä¸§r	¥C*ø©k§\Î*\0PôF\Úì\ %\–©¸¶ÆëÆ´\0@e\Z\r\»O*ó@;§\Úõ∫F∫Æ\0ï≠\÷h§j\ÿ˝¿xRπ\⁄!ï\ﬂ¯z_7\„\Ì\Ò~\0Äe©Fhñ\\B{\…/\0Pç\‰G.°Ω\‰\0®çF\Ú#ó\–^\Ú\0\‘F£˘ëKh/˘\0j£—Ä¸\»%¥ó¸\0µ\—h@~\‰\⁄K~Ä\⁄h4 ?r	\Ì%ø\0@m4\ZêπÑ\ˆí_\0†6\Z\r»è\\B{\…/\0Pç4´\»\‡!á\Î\‘\Ò\ÛÄ<πÆ\0µ\—h@≥äﬁöX∞\«uk¸< OÆ´\0@m4\Z–ºpá=±hw\˜Z\»u\0®çFö\Ó∞\'\Ó\ÓæCπÆ\0µ\—h@¬ù\ˆ\ƒ\‚\›\›wh\◊U\0†6\Z\r\»C∏”ûX¿\ﬂ\Z?»õ\Î*\0Pç\‰#∫\Ô\Ó;¥ê\Î*\0Pç\‰#∫kº»ü\Î*\0Pç\‰ep>\ﬁ¥É¸\0µ\—h@sn.2∏ivv\ˆ±\‚Î°¢^/\ÍJˇ¸\«˝\Ô\ı\˜o\nèèè\‰\≈u\0®çF¶onn\ÓKE\ˆñä∫\⁄_¨[\·\ÒK\·˘\Ò1Å<∏Æ\0µ\—h¿\Ù\Ô\œô;öXòèRG\√\Ò\‚1ÄfÖ|\∆\€\0\0&B£\ı[XX∏ivv\ˆ{E\ﬁ>ç‚ãããΩ˝˚\˜\˜é?\ﬁ;y\Úd\Ô¸˘\ÛΩ |\rﬂá\Ìax\\¸\‹pºp\‹p¸xL†Æ´\0@m4\ZPØ\"c∑\Ã\Õ\Õ˝∫ºûüü\Ô\Ì€∑Øw\ÊÃô\Â\≈˙∞\¬\„\√\Û\¬\Û£Ö¸\Àaúxl`˙\\WÄ\⁄h4†>\≈\¬˝sEù-/∂\˜\Ó\›\€;}˙tº6Ø$<?\'Zƒü\„\≈s\0¶\Àu\0®çF\ÍÓàó\Ô\·Æ˘Å\‚µ¯X\¬\Ò¢ª\Òß√∏\Ò\\Ä\Èq]\0j£—Ä\…øì^~\Ÿ¸∂m\€z\'Núà\◊\ﬂéé_Zƒø\Ïw\‚°9Æ´\0@m4\Z0y˝7¨ª~ÁΩÆ\≈˚@8~˘N|?û0Æ´\0@m4\Z0Y˝èä˚d∞ò>x\`ºﬁÆEßt˛1\Õp]\0j£—Ä\…\⁄R˙ú\˜\Fs\”Ω±\›\—xn@˝\\WÄ\⁄h4`r6o\ﬁ¸\≈¡:º§}\‹wõØ*åW~)}òO<G†^Æ´\0@m4\Z09Eûñã\Á\y\ÌM\„ñ\Ó\¬/\≈s\Í\Â∫\n\0\‘F£ì1??ˇô\"OWã\Ái\ﬂ}\„ñ\W√º\‚π\ıq]\0j£—Ä\ı9y°®[\„\Ìe\≈˛MÉÖ\Û\‚\‚bºÆû™0~iø)û\Î@¯3Ö?[ºù\Î*\0Pç¨Ø¥^u!_l|\∏gü}6^SOUø4\Á\«s]^∏\ÔF\'S\0@m4\Z∞æ\“bx’Ö¸\‹\‹\‹\·¡˛c«é\≈k\Í©\n\„\Ê\Ê5òcºpT˘\œåG¶\0Ä\⁄h4`}\ÒÇ∑T\◊\Ú\≈◊∑\€Où:Ø©ß*å_öcòWr\·>®\ËèåA¶\0Ä\⁄h4`}\ÒÇ7Qaq¸èÉ\Ô?¯\‡ÉxM=Ua¸\“\‹˛êò\Ô\rˇyÅ\—\…\0Põ∏ëWJç_◊Æ]ã\◊\‘S∆èÁ§îö^\≈\◊Z\0\0`J\‚\ÊºT/lÈøÑ~nn\Ó\‚`{Nw\‡˚\Û\Úz\0\0\0∫/^\\ˆ√∑Fè\…\ˆw\‡KsL.\‰\À\0\0\0h≠µ\Ómx˙Åx!\Ô\0\0ÄVZk\·>∞•Eü?0X\»\«\€\0\0†≥äÖ\¶¡¢yqq1^SO\’Œù;?--\‡7\≈s\0\0Ä\rk~~˛3\≈b˘\Í`\·|˙\Ù\Èx]=a\‹\“\‚˝jòW<W\0\0\0\ÿ–ä\Û\“`\Òºoﬂæxm=a\‹\“~)û#\0\0\0lxõ7o˛\‚`\Ò<???\ıª\aºπππ\Î/ü\Ûâ\Á\0\0\0\Ã,ﬂÖ?:X@\Ô›ª7^c\◊*åW∫˚~4û\0\0\0\–777\˜˘b\Ò¸\…`!}\\‡¡xù]ã0Ni\Ò˛IòG<7\0\0\0†dvv\ˆ{\Âó“ü8q\"^oOT8~˘•\Ûa¸xN\0\0\0@daa\·¶b!˝\Ú`AΩm€∂\⁄\Ò\·∏\≈x\◊\Ô¯áq\√¯\Òú\0\0\0ÄÑb!}KQß\Àw\‚8Øø\«éWæ\Û\ﬁ\Ôñx.\0\0\0¿\Zä\≈\ı\Á ã¯P\·ç\Ê\∆}w˙\¸\Ë\r\Îñ\Ôaºx\0\0\0¿˙w‚Øøú>T∏>Ø˝Ãô3\Ò\⁄|M\·\Ò\·y\—]\˜\ÂóÕáq\‚±\0\0Ä\n\¬\Ô§\˜\ﬂ\ÿ.^x\˜{˚\˜\Ô\Ô?~ºw\Ú\‰\…\ﬁ˘\Û\Áó\Î\·k¯>l˚w\Ó‹π\‚π\·x\·∏~\Á\0\0\0&®ˇs\◊?\'~\Ã:\Í£\‚\0\0\0†F\≈\¬˚K\≈|©®´âÖ˘Zøû\0\0\0®\…\¬\¬\¬\Õ≈Ç|\”\Ï\Ï\Ïc\≈\◊CEΩ^\‘\«˝\≈z¯\Zæ?\‘ﬂø)<>>\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\‰\Íˇ˛neö;\0\0\0\0IENDÆB`Ç',1),('62566',1,'ClassGuideOrgSealApprovalProcess.bpmn20.xml','62565',_binary '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" xmlns:flowable=\"http://flowable.org/bpmn\" targetNamespace=\"http://www.flowable.org/processdef\">\n  <process id=\"ClassGuideOrgSealApprovalProcess\" name=\"Èô¢Á´†ÂÆ°ÊâπÔºàÁè≠‰∏ª‰ªªÔºâ\" isExecutable=\"true\">\n    <startEvent id=\"StartEvent_1\" name=\"ÂºÄÂßã\" />\n    <userTask id=\"MentorApproval\" name=\"ËæÖÂØºÂëòÂÆ°Êâπ\" flowable:candidateGroups=\"2013952827238473729\" flowable:assignee=\"2013951264663101441\" />\n    <sequenceFlow id=\"Flow_1\" sourceRef=\"StartEvent_1\" targetRef=\"MentorApproval\" />\n    <userTask id=\"DeanApproval\" name=\"Èô¢ÈïøÂÆ°Êâπ\" flowable:candidateGroups=\"2013952886889865217\" flowable:assignee=\"2013951338067615746\">\n      <incoming>Flow_16w6q12</incoming>\n    </userTask>\n    <sequenceFlow id=\"Flow_2\" sourceRef=\"MentorApproval\" targetRef=\"Gateway_Mentor\" />\n    <endEvent id=\"EndEvent_1\" name=\"ÈÄöËøá\">\n      <incoming>Flow_1sl0y8q</incoming>\n    </endEvent>\n    <sequenceFlow id=\"Flow_3\" sourceRef=\"DeanApproval\" targetRef=\"Gateway_Dean\" />\n    <exclusiveGateway id=\"Gateway_Mentor\" name=\"ËæÖÂØºÂëòÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_2</incoming>\n      <outgoing>Flow_16w6q12</outgoing>\n      <outgoing>Flow_1ymr9po</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_16w6q12\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_Mentor\" targetRef=\"DeanApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <exclusiveGateway id=\"Gateway_Dean\" name=\"Èô¢ÈïøÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_3</incoming>\n      <outgoing>Flow_1sl0y8q</outgoing>\n      <outgoing>Flow_0n9myw1</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_1sl0y8q\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_Dean\" targetRef=\"EndEvent_1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <endEvent id=\"Event_0t3anyf\" name=\"ÊãíÁªù\">\n      <incoming>Flow_1ymr9po</incoming>\n      <incoming>Flow_0n9myw1</incoming>\n    </endEvent>\n    <sequenceFlow id=\"Flow_1ymr9po\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_Mentor\" targetRef=\"Event_0t3anyf\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_0n9myw1\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_Dean\" targetRef=\"Event_0t3anyf\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_1\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_1\" bpmnElement=\"ClassGuideOrgSealApprovalProcess\">\n      <bpmndi:BPMNEdge id=\"Flow_0n9myw1_di\" bpmnElement=\"Flow_0n9myw1\">\n        <omgdi:waypoint x=\"700\" y=\"203\" />\n        <omgdi:waypoint x=\"700\" y=\"280\" />\n        <omgdi:waypoint x=\"588\" y=\"280\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"704\" y=\"239\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1ymr9po_di\" bpmnElement=\"Flow_1ymr9po\">\n        <omgdi:waypoint x=\"450\" y=\"203\" />\n        <omgdi:waypoint x=\"450\" y=\"280\" />\n        <omgdi:waypoint x=\"552\" y=\"280\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"454\" y=\"239\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1sl0y8q_di\" bpmnElement=\"Flow_1sl0y8q\">\n        <omgdi:waypoint x=\"725\" y=\"178\" />\n        <omgdi:waypoint x=\"782\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"743\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_16w6q12_di\" bpmnElement=\"Flow_16w6q12\">\n        <omgdi:waypoint x=\"475\" y=\"178\" />\n        <omgdi:waypoint x=\"520\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"487\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_Flow_3\" bpmnElement=\"Flow_3\">\n        <omgdi:waypoint x=\"620\" y=\"178\" />\n        <omgdi:waypoint x=\"675\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_Flow_2\" bpmnElement=\"Flow_2\">\n        <omgdi:waypoint x=\"380\" y=\"178\" />\n        <omgdi:waypoint x=\"425\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_Flow_1\" bpmnElement=\"Flow_1\">\n        <omgdi:waypoint x=\"216\" y=\"178\" />\n        <omgdi:waypoint x=\"280\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNShape id=\"_BPMNShape_StartEvent_2\" bpmnElement=\"StartEvent_1\">\n        <omgdc:Bounds x=\"180\" y=\"160\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"189\" y=\"203\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_1\" bpmnElement=\"MentorApproval\">\n        <omgdc:Bounds x=\"280\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_2\" bpmnElement=\"DeanApproval\">\n        <omgdc:Bounds x=\"520\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_EndEvent_1\" bpmnElement=\"EndEvent_1\">\n        <omgdc:Bounds x=\"782\" y=\"160\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"791\" y=\"203\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1n6azvq_di\" bpmnElement=\"Gateway_Mentor\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"425\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"411\" y=\"133\" width=\"77\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1mb28fn_di\" bpmnElement=\"Gateway_Dean\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"675\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"667\" y=\"133\" width=\"66\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Event_0t3anyf_di\" bpmnElement=\"Event_0t3anyf\">\n        <omgdc:Bounds x=\"552\" y=\"262\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"559\" y=\"305\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>\n',0),('62567',1,'ClassGuideOrgSealApprovalProcess.ClassGuideOrgSealApprovalProcess.png','62565',_binary 'âPNG\r\n\Z\n\0\0\0\rIHDR\0\0<\0\04\0\0\0\È:6™\0\0êIDATx^\Ì\››èT\Áù\'\ûidÌï≥3sÈõπ øê\Ÿ\Á\"—Æ6Rf.Ä¶\€\ÿi	DâD[¡†]{µ\‡X\⁄\ÂŒ±ì\ÿHªö¯Ö\—l¨\ÙEìç6ÎÄΩH\ŸÑ„â≥\Úd¡/\rf\›6∆Ü!¶\ˆ<ù:\‰¯\ÈS›ß\ﬁN=}\Œ\Á#˝\‘tù™s]\ıÖ\Ô\”U]=5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0PõNß\Ûß\ÁŒù˚˛\œ~\ˆ≥\ﬂ;v¨\Û¸\Ûœõö\'˚∫\ﬂ:q\‚\ƒ\€«èˇ\Î¯˛Åµ\»\Ô\‰G~ qYYz.˚œ∫\Û\Œ;\ÔtÆ]ª÷πq„Ü©y\¬\◊=|˝_|\Ò\≈≥\ıÖ¯>Ç^\‰w\Ú#ø\0ê∏\ù\·\üu¸ü∏©.^º¯^Vò^ä\Ô#\ËE~\”˘ÄDÖó¡¯\Œp\ZÓá¨0]è\Ô#\ËE~\”˘ÄDÖ◊†\«ˇqõ\…M∏?\‚˚zëﬂ¥F~ AU\”?}p±s\Ó\€y\ı\'ØL¯s∏,æûn&˙!øiç¸@Ç™¶´ó/t~\ı\„ˇ\–˘\Â\‡.\€\‚\Îõ¡Ga¢\Úõ\÷\»/\0$®JaZzuqUY\ \Á¸´GW]\ﬂ>\n˝êﬂ¥F~ AU\n\”ˇy\·–™¢îO\ÿ_\ﬂ>\n˝êﬂ¥F~ AU\n”Øû?∞™(\Â∂\≈\◊7Éè\¬D?\‰7≠ë_\0Hê¬î\÷(L\ÙC~\”\Z˘ÄU)L\·]ù‚¢îO\ÿ_\ﬂ>\n˝êﬂ¥F~ AU\n\”o~˙\ÌUE)ü∞-ææ|&˙!øiç¸@Ç™¶K^\È¸\Í˛\«Ue)\\∂\≈\◊7Éè\¬D?\‰7≠ë_\0HPï\¬\Ê\ıSOØ*L\·≤¯zf∏Qòz˙\Ò\»oj#øCìs\0FØRa∫~Ω\Ûõˇ˝ƒ™\¬.\€V]\ﬂ<\nS©ª≥yß˚ë˘Mk\‰w(r¿x¨Wò\¬obˇ«ü>æ™,\Â∂˘m\Ì£Öiïº\Ì\Ì~TÜ\n\‰7≠ëﬂÅ\…9\0\„”≥0]øﬁπ¯õ\„ù¯ˇ~UIä\'\\\'\\\◊wãáÖ\È\‚\Ô¯∆ü∑û¸¶5\Ú;ê8\◊\Ò\Á\00ú≤¬¥\ﬁwÖ{ç\Ô?\n\”mΩJOØ\À[I~\”\Z˘\Ì[Ø<\˜∫\0˙WVò™|W∏◊Ñ\€\∆˚3\’GaZ±^\ŸYo{k\»oZ#ø}Y/\«\ÎmÄj\ \nS\\Ç˙ùx¶˙(LïKN\’\Î5ö¸¶5\Ú[Y\’¸VΩ\0\ÙVVò\Ã\‰¶ÂÖ©\ﬂr\”\Ô\ıG~”öñÁ∑™~s\€\Ô\ı\È\”\‹\‹‹ù[∑n\›4==˝X\ˆ\ÒX6Øg\ÛQ6ù\Ó\«\˘±\Ó\ˆM\·˙\Ò>Ä!}¯\·áˇrqq\Ò\·o˚€ø<x\\‡{˚\˜\Ôø\ˆ’Ø~\ıV\‚\Ó›ªo\Ó›ª\˜ É>¯\÷\√?|\ÙÅ¯7\ŸM˛(\ﬁΩ)LiMã”†•f\–\€5Ç¸¶5-\ŒoUÉ\Êu\–€±Üôôô\œg]j!õ\›\≈M\’	\◊_∑è\˜	\Ù\È\Á?ˇ˘\ÓG}\Ù¬Æ]ª:\Ÿ\"ß\Û\‹s\œuNü>\›9{\ˆl\Á“•Kù |üá\À\√\ˆ}˚\ˆ\›⁄±c«çl\·\Û\„\Ÿ\ŸŸøå\˜\…j\nSZ\”\“\¬4lô\ˆ\ˆñ¸¶5-\ÕoU\√\Êt\ÿ\€”ï-T>ì-XNñ,dôìa\Ò1Äuº\Ú\ +ˇ\ˆª\ﬂ˝\Ó\€_˘\ W:?¯¡:\Ôæ˚\Ó\ ‚¶™p˝pªl\·\Û\€˚\Ôøˇ˚Yˇ<>†0•5-,L£*1£\⁄O_\Ê;\ﬁ)õ™€á%øiM\Û[’®\Ú9™˝åDú\Î8\ﬂ\Ò\Â\Ò\ˆ∫\Õ\Õ\Õ\›1==˝ùlë≤\Ú*ô\‚\Ã\œ\œwé9≤\Ê7ñ\√\ˆpΩ¯∂aaøaˇ\Ò1ÅHñ´?˘—è~¥:O=\ıT\Á\Í’´ü\\\…\Ù)\‹>\Ï\'\‡G€∂m˚õ¯x¸û¬î÷¥¨0ç∫ºåz\Î*+/q\·)n\ÎuŸ†\‰7≠iY~´\Zu.GΩøÅïeπ\Œ¸\˜#[î\‹533\Û\À\‚Bevv∂s¯\\·\Œ˘\Û\Á\„\nµ¶p˝pªp˚h\·\Ûr8N|l†+\Àœù\œ<\Û\Ã?~\Ìk_\Îú;w.\Œ\÷P\¬˛≤E‘µ;våèã¬î⁄¥®0ç´¥åkø•\ \ KùÖG~”öÂ∑™q\Âq\\˚\ÌKYñ\Î\ÃU\ŸB\Á\”\Ÿ\\(.N:\‘YZZä+S_\¬\Ì\√~¢E\œR8^|\–zYf\Ó|\Ï±\«.?\Ù\–CùÀó/\«y\Zâ∞\ﬂ˝˚\˜t\ﬂ}\˜=ø\Ì¶¥¶%Öi\‹ee\‹˚ø≠¨º\‘Yx\‰7≠iI~´\Zw«Ωˇuïeπ\Œ¸W\—}f\Á\ˆb\'<+≥∏∏◊§°Ñ˝E\œ\ˆ,y¶\n≤ú¸\…3\œ<\Ûõ∞\ÿ	ˇYåS\ÿˇﬁΩ{?∏\Áû{åœ£\Õ¶¥¶Ö©XR\¬;*~©˚qe˚©•ïïó:è¸¶5-\»oUç\ y/eYÆ3ˇ\Î	?SS|\€\ˆ\Ì\€;gŒúâ\Î\—HÑ˝Ü˝=/˚ô\Ë\n?≥\Û\ıØ}l\œ\Ï\ƒ\¬qv\Ó\‹y%\‚\„si+Ö)≠ixaäK\–\Õ&¸}\√\«A\À\–Z˚{*+/u˘Mk\Zûﬂ™\Zó\Û^ ≤\\g˛\◊\”}ÉÇ\€\œ\Ïåk±ì˚/>\”éü¥Nå/Ñ7(\ı\œ\Ï¨\'o€∂mó7o\ﬁ¸\Ò9µë¬î\÷4∏0≈•\‰KSø//˘\ƒ%¶äb	\ \ÁæO\\c\ıqG*îó≤©∫}X\Úõ\÷48øU\≈ykD\Œ{âs\Á;æ<\ﬁ>N›∑û˛8_|=z4ÆCcéSxñ\ÁcoYMÎÖ∑û\Ô¢6	O<\Ò\ƒ\€YøüS)LiMCSY)+1˝î°≤\€ˇó\ÓÂ±≤\„7Ç¸¶5\r\ÕoUe9+À©ú\◊`k\·\˜\ÏÑ7®S\ÙF\'\„sÉ\÷øT4<ªs\Â ï8\'µ«Ω\˜\ﬁ{?\Ù\ÀI¶‘¶ÅÖi≠RVf™î°≤\€\ı*Aπµ\Œc√íﬂ¥¶Å˘≠j≠|ï\ÂU\Œ\«hÀñ-ü\À\·%f√æ[ø\¬\Òä/m\Áü#¥¬£è>zaaa!\ŒH≠û~˙\È≥Y\«\Á\÷6\nSZ”∞\¬T•|îïöµ\ P\Ÿ\ı\◊+Aπ*Á≥°\»oZ”∞¸VU%Weπï\Û1…∫\ÕBæ\ÿø/g\¬q\œ\Ú,\ƒ\Áçw\Â ï?€Ω{wgyy9\ŒG≠≤\„ˇnvv\ˆù¸q|ém¢0•5\r*L˝îé≤rSVÜ ÆWµ\Â˙9Ø\‰\…oZ”†¸V\’Oû\ \Ú+\Á#ñ\ıöOeå˘b£\Ógwr·∏Öœçp^\ÒπB£˝\á?<∏ˇ˛8±s\Á\Œ7≤ ˛U|éMê˝Ω^\»\Ê≥\Ò\Â1Ö)≠I©0U}ï§lîïúb*\€\ﬁo	\ \rr~µ™˙µóﬂ¥&•¸VU\ı±VbêïÂ∏µ9\ÔWï˚*€æ)_h\Ã\œ\œ«µßV\·¯˘πÑ\Ûä\œ\Z\Ì\Ò\«ˇá\Áû{.\Œ\≈D<˘\‰ì/g!¸\œ\Ò96A\·ô5ˇÅTò“öî\nS\’\«PdòíQVv\¬\Á\·Y\ÿ¯\ÚAKPnò\Ûª™_{˘MkR\ oUUkëa\Ú#\Á™r_eó?û_\Ô\ŸgüçkO≠\¬\Ò\Á¸x|Æ\–h|\Ô\Ù\È\”q.&\‚ƒâØLOO/\∆\Á\ÿÖd\÷¸RaJkR*LUC£(ee\Ëµ\Ë\ÛaKPn\Á;Uø\ˆ\Úõ÷§îﬂ™™>\÷\nFë9@ï˚jff\Êxæ˝‘©Sq\Ì©U8~~.·ºä\Á	ç∑oﬂækuˇ\Óù^^{\Ìµ7≤ ˛\">\«&(˘á±\ÙHÖ)≠I©0ï<vJC]£,eeh\‘%(7\ \ÛôíØy\È\◊^~”öî\Ú[U\…c¨\Ù±\÷5 º¥>\Á˝*πèV\›W\Ÿ«∑\Ú\À\'›µ\¬\Ò\Á¯V\Ù◊Åf€Ω{\˜≠\˜\ﬂ?\Œ\≈D\\∫t\Èj\¬\Ò96A\…?à\Ò¨¸©0•5)¶í\«L<+è°©\Òîâ\\Úñ¯;æ\·\Ûqº\…\»8\Œ(%_\ÎxVæ\ˆ\Úõ÷§îﬂ™J[\Ò¨<÷¶∆ììV\Áº_%\˜M<\·æ˙\Á¸\ÛIw≠p¸¸\\fffÆ\ƒh¥{ÔΩ∑s\Û\Ê\Õ8ëù«ïí0Z5\nSZ\ﬂ?©\œ\ÊÕõ;w\‹qG(){\„¨a≠\Ô¸¿yî\ˆ\∆∑ç2\Òc\»Ln\‚˚¶)#\Ás&›µ\¬\Ò\Á\Ûª¯ŒÄF€µk\◊\ÕI\◊!\˜\Óª\Ô˛ﬂ≠\Ì{ÜÁÖ≠^ì\Ï§\Ù\‚í\«N\Èchj¥\ﬂ9-+A\ÒwÄG]ÜFy˛#Q\Ú5/˝\⁄\ÀoZìR~´*yåï>÷¶Fõ9@\…}¥\Íæ\nœ§\‰óO∫kyÜáV˚\∆7æqe“Ø+\Õ˝˙◊ø>µµ=?\√ˇ\Áµb“Öij\ıw\ˆV&ï\ÌuOJÖ©\Íc®\Î\Ó©\·\ÀDY	\nØ\Â/{\˜¶Qï°Qú\˜\»U˝\⁄O:ø\ÒLïd)L]\€\'=)Â∑™™èµÆªßÜœãú®\ }µ\’\œ\@\ZzË°•Tﬁ•\Ì\'?˘…±ºK€™ã&]ò¶J\ J\Ò≤IoØ{R*LUC√îä^%(/;e€á-C√ú\ÔXU˝\⁄O:ø\ÒLïdßxŸ∏∑OzR\ oUUk\√\‰¶,«≠\Õyø™\‹Wﬁ•\rq\‡¿Å£©¸ûGydaksO\œã&]ò¶J\ J\Ò≤IoØ{R*LUCëA\ EY\…){ó¶≤\Î\rZÜ9\œ\⁄T˝\⁄O:ø\ÒLïdßxŸ∏∑OzR\ oUUkëA\ÚSñ\ﬂV\Áº_UÓ´≠~§aˇ˛˝ˇzﬂæ}∑\‚`L¿\Õ\Ÿ\Ÿ\ŸW≤˛U|ém2\È\¬4URVäóMz{›≥Sâ~JFYπ)+Aπ≤\Î\˜[Ü˙9ø§M:ø\ÒLïdßxŸ∏∑Oz\Zíﬂ™˙\…QYn\Â|≤N≥)_d\Ã\œ\œ«ΩßV{\ˆ\ÏπUX\lä\œ\Z\Ì¿Åºs\Á\Œ\À\À\Àq6ju˛¸˘üfº\Œ\'>\«6ôtaö*)+\≈\À&ΩΩ\ÓiPa™R6\ J\ÕZ%(Wvª™e®\ ymì\Œo<S%\Ÿ)^6\ÓÌìûÂ∑™*y*À´úè\…\Ï\ÏÏß≤ns#_h,--\≈\ıß·∏Ö\≈Œçp^\ÒπB\„=\¿?^XXà\ÛQ´o~\ÛõóÖ\p|nm3\È\¬4URVäóMz{\›”∞¬¥V\È(+3UJPÆ\Ï\ˆÎï°µ\ŒgCöt~\„ô*\…N\Ò≤qoü\Ù4,øU≠ï´≤ú\ ˘òe\›&º\\e±q¯\\·∏˛\‘\"∑∞\‡Yà\œZ![\Èˇ\Âé;~{\Â ï8#µ∏|˘\ÚKY\0ó\√y\ƒ\Á\÷6ì.LS%e•xŸ§∑\◊=\r,LΩ\ «ó¶/Aπ≤2t\ﬂ\'Æ\ÒΩ\ŒcCõt~\„ô*\…N\Ò≤qoü\Ù40øU\ı\ ◊ó¶\‰ºv[∂l˘\\æ\ÿ\»zN\Ì\œ\ÚÑ\„\Õ\Ã\Ã\‹~9[8ü¯°5\Óøˇ˛\Ô?\ı\‘SqNjë˚øe!¸V|Nm4\È\¬4\ı\…ˇ\ƒnO*\€ÎûÜ¶ªßVóêbâ§\Â™\Ïß\Ï¯ç0\È¸\∆3Uí•0umü\Ù44øU\›=µ:gU\ÚYEï˝îøµ≤és2_p:t(ÆAcéWxv\Ád|n\–*õ7o˛ãπππè\Í~ü¯SßNÖó≤-á\„\«\Á\‘F©¶∂OÉSY	•%|ß∂¨º\Ùc≠˝î∑1\‰7≠ip~´*\À\€Z˘\Ï\«Z˚);n´\Õ\Ã\Ã|&\Î:\Áè£Gè\∆uh,\¬q\nãùè\√y\ƒ\Á≠≥m€∂øŸµk◊µÀó/«ôã\Â\Â\Âˇï\\ÕlæüK[)LiM\√S›•§\Ó\„\’N~”öÜÁ∑™∫sW\˜\Ò6å\È\È\È\Ô‰ãè\“∂3g\Œƒµh§\¬˛ã/e«è\œ	Zk«é\˜\Ô\ﬂˇQ¯\œbúÆ_ø˛\Î,\ø\»\¬¯\Ô\‚sh3Ö)≠iAa™´ú\‘uúâíﬂ¥¶˘≠™Æ¸\’uú\rinn\Óél\·\Òræ\0Ÿæ}˚\ÿ=aø\Ÿ\Òn?£ééü¥\⁄}\˜\›\˜\ÙﬁΩ{?\◊3=\À\À\À/Ü\≈N¿\\⁄_\n¶¥¶%Öi\‹%e\‹˚OÜ¸¶5-\…oU\„\Œ\·∏\˜\ﬂY\Ôπ+õ•\‚3=ãããqM\ZJ\ÿ_\Òôù\Ó\Ò\Óä\œ\»\‹s\œ=\Óÿ±\„ ®¶ß˚3;oyfßú¬î÷¥®0ç´¨åkøIíﬂ¥¶E˘≠j\\y\◊~)\Î?ü..z¬Ñ7\ˆ\›\€\¬\Ì£7(XY\ÏÑ\„\≈\Á\0dA˘\‚∂m\€.?\Ò\ƒo_Ωz5\ŒV_>¯\‡Éüwﬂçm9\Ï7>øß0•5-+L£.-£\ﬁ_\Ú\‰7≠iY~´\Zu.GΩøVœ∏l-ºº-Lx∂\'¸æú\Û\Á\œ\«jM\·˙\·v—≥:+/c«âè\rî\»\Ù\ÁY`æu\ÔΩ\˜~¯Ω\Ô}\Ô\Ïª\Ôæ{3\€\Zn^∏p\·ß\\y\'∂∞ü∞ø¯¸Å¬î÷¥∞0ç™ºåj?ä¸¶5-\ÃoU£\ \Á®\ˆ\”J\·gj∫od/T:\Û\Û\Ûù#GétNü>\›9{\ˆl\Á“•K+•*|üá\À\√\ˆ={\ˆ¨∫m\ÿ_ÿØüŸÅÑ_\nöÖ\Ëp∂`Y˛\Úóø¸\ÊìO>y\ÊƒâØº\ˆ\⁄koΩ\˜\ﬁ{ˇî\Â\\Í\Ú\Ú\ÚπW_}\ıT\ˆü\Ã\Ûè<\Ú\»BvõW≤\€¸øp;øT¥\ZÖ)≠iia\Z∂\ƒ{˚\rK~”öñÊ∑™as:\Ï\Ì\È\Íæe\ı\Ì\ﬂ\”3\‰ú\Ù\÷\”0\Z¥eÀñï\Í?MOO/f\·zi\Î^ã\Z>æ.\€\√\ı\¬\ı\„–õ¬î÷¥∏0\rZfΩ]#\»oZ\”\‚¸V5h^Ωk\»z\”\Á≥µêÕçíÖ\ÃZÆøn\Ô I\nSZ\”\Ú\¬\‘o©\È\˜˙ç#øiM\À\Û[Uøπ\Ì\˜˙\Ùinn\Ó\Œl≥izz˙±\Ï\„±l^\œ\Ê£\Ó\‚&|ü\În\ﬂÆ\Ô i\nSZ£0U.7UØ\◊h\Úõ\÷\»oeU\Û[\ız\0–õ¬î\÷(L+\÷+9\Îmo\r˘Mk\‰∑/\Î\ÂxΩ\Ì\0Pç¬î\÷(L∑\ı*;Ω.o%˘Mk\‰∑oΩ\Ú\‹\Îr\0\Ëü¬î\÷(Lüóû¯\Û÷ìﬂ¥F~\Á:˛\0Ü£0•5\n\”*y˘\Ÿ\€˝®\»oZ#øìs\0\∆GaJk¶Rwáw\n\„\rm\'øiç¸E\ŒÖ)≠Qò\ uã˘Mk\‰w8r¿X(Liç\¬TN*\'øiç¸G\ŒÖ)≠Qò\ )B\Â\‰7≠ë\ﬂ\·\»9\0c°0•5\nS9E®ú¸¶5\Ú;9`,¶¥Fa*ßïìﬂ¥F~á#\Á\0åÖ¬î\÷(L\Â°r\Úõ\÷\»\Ôp\‰Ä±Pò\“\ZÖ©ú\"TN~\”\Z˘éú0\nSZ£0ïSÑ\ \…oZ#ø√ës\0\∆BaJk¶räP9˘Mk\‰w8r¿X(Liç\¬TN*\'øiç¸G\ŒÖ)≠Qò\ )B\Â\‰7≠ë\ﬂ\·\»9\0cq\Ïÿ±[◊Æ][\ı∑©≤˚\·\Ì¨0]è\Ô#°^\‰7ùë\ﬂ\·\…9\0cq\‚ƒâ∑\ﬂy\ÁùUˇyõ˙\Á\Õ7\ﬂ¸˚¨0Ω\ﬂG(BΩ\»o:#ø√ìs\0\∆\‚¯\Ò\„˝\‚ã/~x\Ò\‚\≈\˜|ßx2ì}\›/æ\Ò\∆óï•∑≤˘B|°\ı\"øì˘9`l\¬\“\·;ì\Ÿ\‹ØA7µO¯∫áØø≤‘É\"\‘[x\‹t?\Ú;ôë\ﬂës\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ ä\–¸c\«;eSu;ê9\0Z´WZ\Î≤\ı∂iës\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µz°≤©∫Hãú\0≠UVÑÄfës\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ!h>9\0ZKÇ\Êìs\0†µ°fòõõª3ª/7MOO?ñ}<ñ\Õ\Î\Ÿ|\Ó\ﬂ\Ó\«\˘±\Ó\ˆM\·˙\Ò>h.9\0ZK\⁄\ÿfff>ü›á\Ÿ\‹\Ë.n™N∏˛B∏}ºOöG\ŒÄ\÷RÑ6¶l°\Úô\Ïæ;Y≤êdNÜ˝\≈«†9\¬˝_\0\–\nä\–\∆277w\«\Ù\Ù\Ùw≤˚\ÌVºpôüü\Ô9r§s˙\Ù\È\ŒŸ≥g;ó.]\Í\·c¯<\\∂á\Î≈∑\r˚˚\r˚èè\…\∆\'\Á\0@k)BGv_\›533\Û\À\‚Bevv∂s¯\\·\Œ˘\Û\ÁW7UÖ\Îá€Ö\€Güó\√q\‚c≥±\…9\0\–Zä\–∆ê-t>ùÕÖ\‚\‚\‰–°Cù•••x-”óp˚∞üh—≥éüóú\0≠••/<\„R\\\ÏÑge\„µ\ÀP\¬˛¢g{ñ\¬q\„sacís\0†µ°¥Öü©)æåm˚\ˆ\Ìù3g\Œ\ƒÎïë˚\r˚/,z^\ˆ3=\Õ \Á\0@k)Bi\ÎæA¡\Ìgv∆µ\ÿ…Ö˝ü\È	«èœâçG\ŒÄ\÷RÑ\“\’}\Î\Èè\Û\≈\«—£G\„\ı\…XÑ\„û\Â˘\ÿ[Vo|r\0¥ñ\"îÆ≠Öﬂ≥\ﬁX†N\—úåœççE\ŒÄ\÷RÑ“¥eÀñ\œ\Âé\≥aﬂç≠_\·x≈ó∂Ö\ÛâœëçC\ŒÄ\÷RÑ“î\›/˘b#¸æúI\«-<À≥ü#áú\0≠••gvv\ˆS\Ÿ˝r#_l\‘˝\ÏN.∑∞\‡π\Œ+>W69\0ZK™W\ˆ\ı~!õ\œ∆óe\€7\Âç˘˘˘xR´p¸¬¢gS|Æπ\w\n∑¯r\“ \Á\0@k)B\ı*,z.|≤\ÀœØ\˜\Ï≥\œ\∆kêZÖ\„\Œ˘\Òís]Y\Ë\‰◊â∑ì\˜\r\0\–ZäPΩ\nãáûüôôô\„˘\ˆSßN\≈kêZÖ\„\Á\Á\Œ+?\«x°ìO\Ò\ÔA:\‹7\0@k)B\ıäÖπΩ\\…>æï_~\Ó‹πx\rR´p¸\¬9Ü\Û*]\Ë\‰˝uIÑ˚\0h-E®^\Ò°d\¬b\‚ü\Û\œ\ﬂˇ˝x\rR´p¸¬π˝Æ\‰|?1\Òﬂó4∏o\0Ä÷ä´IknﬁºØAjéüìŸòg\0\0F..°Öyak\˜%m333W\Ú\ÀSzÜß{^^\“\0\0îã\›\≈\√g£\Î$˚3<Ös,]¯ˇ\0\0@À¨µ\–\…mÑwi\À\≈üx;\0\0\–\"k-tr[7\–\Ô\·\…\Âü¯r\0\0ÄO\»õ\ÚE\∆¸¸|º©’û={n<õ\‚s\0\0\Ë\À\Ï\ÏÏß≤\≈≈ç|°±¥¥ØCjé[X\Ï\‹\Áü+\0\0@ﬂ≤\∆Bæ\ÿ8|¯pº©E8na¡≥ü#\0\0¿@∂l\Ÿ\Úπ|±1;;[˚≥<\·x333∑_\Œ\Œ\'>G\0\0ÄÅeçì˘Ç\„–°C\Òöd¨\¬\Ò\n\œÓúå\œ\r\0\0`(333ü\…\Áè£Gè\∆Îí±\«),v>\Áü\0\0¿–¶ßßøS|i€ô3g\‚\ı\…HÖ˝_\ éü\0\0¿H\Ã\Õ\Õ›ë-<^\Œ €∑o€¢\'\Ï7;\ﬁ\Ìgî\¬q\√\Ò\„s\0\0ôl\·qW6K\≈gz\„\ı\ P\¬˛ä\œ\ÏtèwW|.\0\0\0#ó-F>]\\\ÙÑ	o,0Ïª∑Ö\€GoP∞≤\ÿ	«ã\œ\0\0`l∫\œ\Ù\‹~y[ò\lO¯}9\Áœüè\◊2k\n\◊∑ãû\’Yy[8N|l\0\0Ä±?S\”}#Éx°“ôüü\Ô9r§s˙\Ù\È\ŒŸ≥g;ó.]ZY‹Ñè\·\ÛpyÿægœûU∑\r˚˚\ı3;\0\0¿\ƒuﬂ≤˙\ˆ\Ô\ÈrNz\Îi\0\0 9\ŸB\Â\ÛŸÇe!õ%ôµ&\\!\‹>\ﬁ\'\0\0@R\Ê\Ê\Ê\Ó\Ã0õ¶ßß\À>\À\Ê\ıl>\Í.n\¬\«\˘±\Ó\ˆM\·˙\Ò>\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 5ˇc\Á¬Å\Õ\ÍT.\0\0\0\0IENDÆB`Ç',1);
/*!40000 ALTER TABLE `act_ge_bytearray` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ge_property`
--

DROP TABLE IF EXISTS `act_ge_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `REV_` int DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ge_property`
--

LOCK TABLES `act_ge_property` WRITE;
/*!40000 ALTER TABLE `act_ge_property` DISABLE KEYS */;
INSERT INTO `act_ge_property` VALUES ('batch.schema.version','6.8.0.0',1),('cfg.execution-related-entities-count','true',1),('cfg.task-related-entities-count','true',1),('common.schema.version','6.8.0.0',1),('entitylink.schema.version','6.8.0.0',1),('eventsubscription.schema.version','6.8.0.0',1),('identitylink.schema.version','6.8.0.0',1),('job.schema.version','6.8.0.0',1),('next.dbid','67501',28),('schema.history','create(6.8.0.0)',1),('schema.version','6.8.0.0',1),('task.schema.version','6.8.0.0',1),('variable.schema.version','6.8.0.0',1);
/*!40000 ALTER TABLE `act_ge_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_actinst`
--

DROP TABLE IF EXISTS `act_hi_actinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT '1',
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `TRANSACTION_ORDER_` int DEFAULT NULL,
  `DURATION_` bigint DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_actinst`
--

LOCK TABLES `act_hi_actinst` WRITE;
/*!40000 ALTER TABLE `act_hi_actinst` DISABLE KEYS */;
INSERT INTO `act_hi_actinst` VALUES ('60008',1,'StudentOrgSealApprovalProcess:1:57504','60001','60007','StartEvent_1',NULL,NULL,'ÂºÄÂßã','startEvent',NULL,'2026-02-24 14:09:05.019','2026-02-24 14:09:05.022',1,3,NULL,''),('60009',1,'StudentOrgSealApprovalProcess:1:57504','60001','60007','Flow_1gtutt3',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 14:09:05.023','2026-02-24 14:09:05.023',2,0,NULL,''),('60010',2,'StudentOrgSealApprovalProcess:1:57504','60001','60007','headTeacherApproval','60011',NULL,'Áè≠‰∏ª‰ªªÂÆ°Êâπ','userTask','2013951215732350978','2026-02-24 14:09:05.023','2026-02-24 14:13:05.906',3,240883,NULL,''),('60017',1,'StudentOrgSealApprovalProcess:1:57504','60001','60007','Flow_1ln9kdp',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 14:13:05.908','2026-02-24 14:13:05.908',1,0,NULL,''),('60018',1,'StudentOrgSealApprovalProcess:1:57504','60001','60007','Gateway_headTeacher',NULL,NULL,'Áè≠‰∏ª‰ªªÂÆ°ÊâπÁªìÊûú','exclusiveGateway',NULL,'2026-02-24 14:13:05.910','2026-02-24 14:13:05.926',2,16,NULL,''),('60019',1,'StudentOrgSealApprovalProcess:1:57504','60001','60007','Flow_1f887dt',NULL,NULL,'ÂêåÊÑè','sequenceFlow',NULL,'2026-02-24 14:13:05.926','2026-02-24 14:13:05.926',3,0,NULL,''),('60020',1,'StudentOrgSealApprovalProcess:1:57504','60001','60007','counselorApproval','60021',NULL,'ËæÖÂØºÂëòÂÆ°Êâπ','userTask','2013951264663101441','2026-02-24 14:13:05.928',NULL,4,NULL,NULL,''),('62508',1,'StudentOrgSealApprovalProcess:1:57504','62501','62507','StartEvent_1',NULL,NULL,'ÂºÄÂßã','startEvent',NULL,'2026-02-24 14:17:53.234','2026-02-24 14:17:53.237',1,3,NULL,''),('62509',1,'StudentOrgSealApprovalProcess:1:57504','62501','62507','Flow_1gtutt3',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 14:17:53.238','2026-02-24 14:17:53.238',2,0,NULL,''),('62510',2,'StudentOrgSealApprovalProcess:1:57504','62501','62507','headTeacherApproval','62511',NULL,'Áè≠‰∏ª‰ªªÂÆ°Êâπ','userTask','2013951215732350978','2026-02-24 14:17:53.238','2026-02-24 14:18:16.127',3,22889,NULL,''),('62517',1,'StudentOrgSealApprovalProcess:1:57504','62501','62507','Flow_1ln9kdp',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 14:18:16.130','2026-02-24 14:18:16.130',1,0,NULL,''),('62518',1,'StudentOrgSealApprovalProcess:1:57504','62501','62507','Gateway_headTeacher',NULL,NULL,'Áè≠‰∏ª‰ªªÂÆ°ÊâπÁªìÊûú','exclusiveGateway',NULL,'2026-02-24 14:18:16.131','2026-02-24 14:18:16.144',2,13,NULL,''),('62519',1,'StudentOrgSealApprovalProcess:1:57504','62501','62507','Flow_1f887dt',NULL,NULL,'ÂêåÊÑè','sequenceFlow',NULL,'2026-02-24 14:18:16.145','2026-02-24 14:18:16.145',3,0,NULL,''),('62520',2,'StudentOrgSealApprovalProcess:1:57504','62501','62507','counselorApproval','62521',NULL,'ËæÖÂØºÂëòÂÆ°Êâπ','userTask','2013951264663101441','2026-02-24 14:18:16.147','2026-05-20 10:34:46.569',4,7330590422,NULL,''),('62532',1,'StudentOrgSealApprovalProcess:1:57504','62525','62531','StartEvent_1',NULL,NULL,'ÂºÄÂßã','startEvent',NULL,'2026-02-24 14:19:09.487','2026-02-24 14:19:09.487',1,0,NULL,''),('62533',1,'StudentOrgSealApprovalProcess:1:57504','62525','62531','Flow_1gtutt3',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 14:19:09.487','2026-02-24 14:19:09.487',2,0,NULL,''),('62534',2,'StudentOrgSealApprovalProcess:1:57504','62525','62531','headTeacherApproval','62535',NULL,'Áè≠‰∏ª‰ªªÂÆ°Êâπ','userTask','2013951215732350978','2026-02-24 14:19:09.487','2026-02-24 14:19:43.587',3,34100,NULL,''),('62541',1,'StudentOrgSealApprovalProcess:1:57504','62525','62531','Flow_1ln9kdp',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 14:19:43.589','2026-02-24 14:19:43.589',1,0,NULL,''),('62542',1,'StudentOrgSealApprovalProcess:1:57504','62525','62531','Gateway_headTeacher',NULL,NULL,'Áè≠‰∏ª‰ªªÂÆ°ÊâπÁªìÊûú','exclusiveGateway',NULL,'2026-02-24 14:19:43.589','2026-02-24 14:19:43.589',2,0,NULL,''),('62543',1,'StudentOrgSealApprovalProcess:1:57504','62525','62531','Flow_1f887dt',NULL,NULL,'ÂêåÊÑè','sequenceFlow',NULL,'2026-02-24 14:19:43.589','2026-02-24 14:19:43.589',3,0,NULL,''),('62544',2,'StudentOrgSealApprovalProcess:1:57504','62525','62531','counselorApproval','62545',NULL,'ËæÖÂØºÂëòÂÆ°Êâπ','userTask','2013951264663101441','2026-02-24 14:19:43.590','2026-02-24 14:20:07.098',4,23508,NULL,''),('62549',1,'StudentOrgSealApprovalProcess:1:57504','62525','62531','Flow_096picz',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 14:20:07.100','2026-02-24 14:20:07.100',1,0,NULL,''),('62550',1,'StudentOrgSealApprovalProcess:1:57504','62525','62531','Gateway_counselor',NULL,NULL,'ËæÖÂØºÂëòÂÆ°ÊâπÁªìÊûú','exclusiveGateway',NULL,'2026-02-24 14:20:07.101','2026-02-24 14:20:07.101',2,0,NULL,''),('62551',1,'StudentOrgSealApprovalProcess:1:57504','62525','62531','Flow_1bf6tjw',NULL,NULL,'ÂêåÊÑè','sequenceFlow',NULL,'2026-02-24 14:20:07.101','2026-02-24 14:20:07.101',3,0,NULL,''),('62552',2,'StudentOrgSealApprovalProcess:1:57504','62525','62531','deanApproval','62553',NULL,'Èô¢ÈïøÂÆ°Êâπ','userTask','2013951338067615746','2026-02-24 14:20:07.102','2026-02-24 14:20:21.403',4,14301,NULL,''),('62557',1,'StudentOrgSealApprovalProcess:1:57504','62525','62531','Flow_179uijp',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 14:20:21.404','2026-02-24 14:20:21.404',1,0,NULL,''),('62558',1,'StudentOrgSealApprovalProcess:1:57504','62525','62531','Gateway_dean',NULL,NULL,'Èô¢ÈïøÂÆ°ÊâπÁªìÊûú','exclusiveGateway',NULL,'2026-02-24 14:20:21.405','2026-02-24 14:20:21.405',2,0,NULL,''),('62559',1,'StudentOrgSealApprovalProcess:1:57504','62525','62531','Flow_0piie6u',NULL,NULL,'ÂêåÊÑè','sequenceFlow',NULL,'2026-02-24 14:20:21.406','2026-02-24 14:20:21.406',3,0,NULL,''),('62560',1,'StudentOrgSealApprovalProcess:1:57504','62525','62531','EndEvent_1',NULL,NULL,'ÂêåÊÑè','endEvent',NULL,'2026-02-24 14:20:21.407','2026-02-24 14:20:21.411',4,4,NULL,''),('62576',1,'ClassGuidePartySealApprovalProcess:1:62564','62569','62575','StartEvent_1',NULL,NULL,'ÂºÄÂßã','startEvent',NULL,'2026-02-24 15:12:13.774','2026-02-24 15:12:13.774',1,0,NULL,''),('62577',1,'ClassGuidePartySealApprovalProcess:1:62564','62569','62575','Flow_1',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 15:12:13.775','2026-02-24 15:12:13.775',2,0,NULL,''),('62578',2,'ClassGuidePartySealApprovalProcess:1:62564','62569','62575','MentorApproval','62579',NULL,'ËæÖÂØºÂëòÂÆ°Êâπ','userTask','2013951264663101441','2026-02-24 15:12:13.775','2026-02-24 15:12:34.109',3,20334,NULL,''),('62585',1,'ClassGuidePartySealApprovalProcess:1:62564','62569','62575','Flow_2',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 15:12:34.110','2026-02-24 15:12:34.110',1,0,NULL,''),('62586',1,'ClassGuidePartySealApprovalProcess:1:62564','62569','62575','Gateway_Mentor',NULL,NULL,'ËæÖÂØºÂëòÂÆ°ÊâπÁªìÊûú','exclusiveGateway',NULL,'2026-02-24 15:12:34.110','2026-02-24 15:12:34.110',2,0,NULL,''),('62587',1,'ClassGuidePartySealApprovalProcess:1:62564','62569','62575','Flow_1esxqux',NULL,NULL,'ÊãíÁªù','sequenceFlow',NULL,'2026-02-24 15:12:34.110','2026-02-24 15:12:34.110',3,0,NULL,''),('62588',1,'ClassGuidePartySealApprovalProcess:1:62564','62569','62575','Event_11k28kr',NULL,NULL,'ÊãíÁªù','endEvent',NULL,'2026-02-24 15:12:34.111','2026-02-24 15:12:34.111',4,0,NULL,''),('62596',1,'ClassGuideOrgSealApprovalProcess:1:62568','62589','62595','StartEvent_1',NULL,NULL,'ÂºÄÂßã','startEvent',NULL,'2026-02-24 15:13:27.107','2026-02-24 15:13:27.107',1,0,NULL,''),('62597',1,'ClassGuideOrgSealApprovalProcess:1:62568','62589','62595','Flow_1',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 15:13:27.107','2026-02-24 15:13:27.107',2,0,NULL,''),('62598',2,'ClassGuideOrgSealApprovalProcess:1:62568','62589','62595','MentorApproval','62599',NULL,'ËæÖÂØºÂëòÂÆ°Êâπ','userTask','2013951264663101441','2026-02-24 15:13:27.107','2026-02-24 15:14:08.877',3,41770,NULL,''),('62605',1,'ClassGuideOrgSealApprovalProcess:1:62568','62589','62595','Flow_2',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 15:14:08.878','2026-02-24 15:14:08.878',1,0,NULL,''),('62606',1,'ClassGuideOrgSealApprovalProcess:1:62568','62589','62595','Gateway_Mentor',NULL,NULL,'ËæÖÂØºÂëòÂÆ°ÊâπÁªìÊûú','exclusiveGateway',NULL,'2026-02-24 15:14:08.878','2026-02-24 15:14:08.878',2,0,NULL,''),('62607',1,'ClassGuideOrgSealApprovalProcess:1:62568','62589','62595','Flow_1ymr9po',NULL,NULL,'ÊãíÁªù','sequenceFlow',NULL,'2026-02-24 15:14:08.878','2026-02-24 15:14:08.878',3,0,NULL,''),('62608',1,'ClassGuideOrgSealApprovalProcess:1:62568','62589','62595','Event_0t3anyf',NULL,NULL,'ÊãíÁªù','endEvent',NULL,'2026-02-24 15:14:08.880','2026-02-24 15:14:08.880',4,0,NULL,''),('65001',1,'StudentOrgSealApprovalProcess:1:57504','62501','62507','Flow_096picz',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-05-20 10:34:46.621','2026-05-20 10:34:46.621',1,0,NULL,''),('65002',1,'StudentOrgSealApprovalProcess:1:57504','62501','62507','Gateway_counselor',NULL,NULL,'ËæÖÂØºÂëòÂÆ°ÊâπÁªìÊûú','exclusiveGateway',NULL,'2026-05-20 10:34:46.623','2026-05-20 10:34:46.663',2,40,NULL,''),('65003',1,'StudentOrgSealApprovalProcess:1:57504','62501','62507','Flow_1bf6tjw',NULL,NULL,'ÂêåÊÑè','sequenceFlow',NULL,'2026-05-20 10:34:46.664','2026-05-20 10:34:46.664',3,0,NULL,''),('65004',2,'StudentOrgSealApprovalProcess:1:57504','62501','62507','deanApproval','65005',NULL,'Èô¢ÈïøÂÆ°Êâπ','userTask','2013951338067615746','2026-05-20 10:34:46.664','2026-05-20 10:35:43.292',4,56628,NULL,''),('65009',1,'StudentOrgSealApprovalProcess:1:57504','62501','62507','Flow_179uijp',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-05-20 10:35:43.293','2026-05-20 10:35:43.293',1,0,NULL,''),('65010',1,'StudentOrgSealApprovalProcess:1:57504','62501','62507','Gateway_dean',NULL,NULL,'Èô¢ÈïøÂÆ°ÊâπÁªìÊûú','exclusiveGateway',NULL,'2026-05-20 10:35:43.295','2026-05-20 10:35:43.295',2,0,NULL,''),('65011',1,'StudentOrgSealApprovalProcess:1:57504','62501','62507','Flow_0piie6u',NULL,NULL,'ÂêåÊÑè','sequenceFlow',NULL,'2026-05-20 10:35:43.295','2026-05-20 10:35:43.295',3,0,NULL,''),('65012',1,'StudentOrgSealApprovalProcess:1:57504','62501','62507','EndEvent_1',NULL,NULL,'ÂêåÊÑè','endEvent',NULL,'2026-05-20 10:35:43.296','2026-05-20 10:35:43.299',4,3,NULL,'');
/*!40000 ALTER TABLE `act_hi_actinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_attachment`
--

DROP TABLE IF EXISTS `act_hi_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_attachment`
--

LOCK TABLES `act_hi_attachment` WRITE;
/*!40000 ALTER TABLE `act_hi_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_comment`
--

DROP TABLE IF EXISTS `act_hi_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_comment`
--

LOCK TABLES `act_hi_comment` WRITE;
/*!40000 ALTER TABLE `act_hi_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_detail`
--

DROP TABLE IF EXISTS `act_hi_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `REV_` int DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint DEFAULT NULL,
  `TEXT_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_detail`
--

LOCK TABLES `act_hi_detail` WRITE;
/*!40000 ALTER TABLE `act_hi_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_entitylink`
--

DROP TABLE IF EXISTS `act_hi_entitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_entitylink` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `LINK_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ROOT_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ROOT_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HIERARCHY_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`),
  KEY `ACT_IDX_HI_ENT_LNK_REF_SCOPE` (`REF_SCOPE_ID_`,`REF_SCOPE_TYPE_`,`LINK_TYPE_`),
  KEY `ACT_IDX_HI_ENT_LNK_ROOT_SCOPE` (`ROOT_SCOPE_ID_`,`ROOT_SCOPE_TYPE_`,`LINK_TYPE_`),
  KEY `ACT_IDX_HI_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_entitylink`
--

LOCK TABLES `act_hi_entitylink` WRITE;
/*!40000 ALTER TABLE `act_hi_entitylink` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_entitylink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_identitylink`
--

DROP TABLE IF EXISTS `act_hi_identitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_IDENT_LNK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_identitylink`
--

LOCK TABLES `act_hi_identitylink` WRITE;
/*!40000 ALTER TABLE `act_hi_identitylink` DISABLE KEYS */;
INSERT INTO `act_hi_identitylink` VALUES ('60012',NULL,'assignee','2013951215732350978','60011','2026-02-24 14:09:05.041',NULL,NULL,NULL,NULL,NULL),('60013',NULL,'participant','2013951215732350978',NULL,'2026-02-24 14:09:05.042','60001',NULL,NULL,NULL,NULL),('60014','2013952715229585409','candidate',NULL,'60011','2026-02-24 14:09:05.042',NULL,NULL,NULL,NULL,NULL),('60022',NULL,'assignee','2013951264663101441','60021','2026-02-24 14:13:05.929',NULL,NULL,NULL,NULL,NULL),('60023',NULL,'participant','2013951264663101441',NULL,'2026-02-24 14:13:05.931','60001',NULL,NULL,NULL,NULL),('60024','2013952827238473729','candidate',NULL,'60021','2026-02-24 14:13:05.931',NULL,NULL,NULL,NULL,NULL),('62512',NULL,'assignee','2013951215732350978','62511','2026-02-24 14:17:53.255',NULL,NULL,NULL,NULL,NULL),('62513',NULL,'participant','2013951215732350978',NULL,'2026-02-24 14:17:53.255','62501',NULL,NULL,NULL,NULL),('62514','2013952715229585409','candidate',NULL,'62511','2026-02-24 14:17:53.255',NULL,NULL,NULL,NULL,NULL),('62522',NULL,'assignee','2013951264663101441','62521','2026-02-24 14:18:16.147',NULL,NULL,NULL,NULL,NULL),('62523',NULL,'participant','2013951264663101441',NULL,'2026-02-24 14:18:16.148','62501',NULL,NULL,NULL,NULL),('62524','2013952827238473729','candidate',NULL,'62521','2026-02-24 14:18:16.149',NULL,NULL,NULL,NULL,NULL),('62536',NULL,'assignee','2013951215732350978','62535','2026-02-24 14:19:09.487',NULL,NULL,NULL,NULL,NULL),('62537',NULL,'participant','2013951215732350978',NULL,'2026-02-24 14:19:09.487','62525',NULL,NULL,NULL,NULL),('62538','2013952715229585409','candidate',NULL,'62535','2026-02-24 14:19:09.487',NULL,NULL,NULL,NULL,NULL),('62546',NULL,'assignee','2013951264663101441','62545','2026-02-24 14:19:43.590',NULL,NULL,NULL,NULL,NULL),('62547',NULL,'participant','2013951264663101441',NULL,'2026-02-24 14:19:43.591','62525',NULL,NULL,NULL,NULL),('62548','2013952827238473729','candidate',NULL,'62545','2026-02-24 14:19:43.591',NULL,NULL,NULL,NULL,NULL),('62554',NULL,'assignee','2013951338067615746','62553','2026-02-24 14:20:07.103',NULL,NULL,NULL,NULL,NULL),('62555',NULL,'participant','2013951338067615746',NULL,'2026-02-24 14:20:07.104','62525',NULL,NULL,NULL,NULL),('62556','2013952886889865217','candidate',NULL,'62553','2026-02-24 14:20:07.104',NULL,NULL,NULL,NULL,NULL),('62580',NULL,'assignee','2013951264663101441','62579','2026-02-24 15:12:13.777',NULL,NULL,NULL,NULL,NULL),('62581',NULL,'participant','2013951264663101441',NULL,'2026-02-24 15:12:13.777','62569',NULL,NULL,NULL,NULL),('62582','2013952827238473729','candidate',NULL,'62579','2026-02-24 15:12:13.777',NULL,NULL,NULL,NULL,NULL),('62600',NULL,'assignee','2013951264663101441','62599','2026-02-24 15:13:27.109',NULL,NULL,NULL,NULL,NULL),('62601',NULL,'participant','2013951264663101441',NULL,'2026-02-24 15:13:27.109','62589',NULL,NULL,NULL,NULL),('62602','2013952827238473729','candidate',NULL,'62599','2026-02-24 15:13:27.109',NULL,NULL,NULL,NULL,NULL),('65006',NULL,'assignee','2013951338067615746','65005','2026-05-20 10:34:46.667',NULL,NULL,NULL,NULL,NULL),('65007',NULL,'participant','2013951338067615746',NULL,'2026-05-20 10:34:46.671','62501',NULL,NULL,NULL,NULL),('65008','2013952886889865217','candidate',NULL,'65005','2026-05-20 10:34:46.671',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `act_hi_identitylink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_procinst`
--

DROP TABLE IF EXISTS `act_hi_procinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT '1',
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_STATUS_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_IDX_HI_PRO_SUPER_PROCINST` (`SUPER_PROCESS_INSTANCE_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_procinst`
--

LOCK TABLES `act_hi_procinst` WRITE;
/*!40000 ALTER TABLE `act_hi_procinst` DISABLE KEYS */;
INSERT INTO `act_hi_procinst` VALUES ('60001',1,'60001','SA2026177540137779200','StudentOrgSealApprovalProcess:1:57504','2026-02-24 14:09:05.002',NULL,NULL,NULL,'StartEvent_1',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('62501',2,'62501','SA2026179755829157888','StudentOrgSealApprovalProcess:1:57504','2026-02-24 14:17:53.220','2026-05-20 10:35:43.388',7330670168,NULL,'StartEvent_1','EndEvent_1',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('62525',2,'62525','SA2026180076328509440','StudentOrgSealApprovalProcess:1:57504','2026-02-24 14:19:09.487','2026-02-24 14:20:21.505',72018,NULL,'StartEvent_1','EndEvent_1',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('62569',2,'62569','SA2026193432162656256','ClassGuidePartySealApprovalProcess:1:62564','2026-02-24 15:12:13.772','2026-02-24 15:12:34.122',20350,NULL,'StartEvent_1','Event_11k28kr',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('62589',2,'62589','SA2026193739764523008','ClassGuideOrgSealApprovalProcess:1:62568','2026-02-24 15:13:27.107','2026-02-24 15:14:08.889',41782,NULL,'StartEvent_1','Event_0t3anyf',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `act_hi_procinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_taskinst`
--

DROP TABLE IF EXISTS `act_hi_taskinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT '1',
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_taskinst`
--

LOCK TABLES `act_hi_taskinst` WRITE;
/*!40000 ALTER TABLE `act_hi_taskinst` DISABLE KEYS */;
INSERT INTO `act_hi_taskinst` VALUES ('60011',2,'StudentOrgSealApprovalProcess:1:57504',NULL,'headTeacherApproval','60001','60007',NULL,NULL,NULL,NULL,NULL,'Áè≠‰∏ª‰ªªÂÆ°Êâπ',NULL,NULL,NULL,'2013951215732350978','2026-02-24 14:09:05.023',NULL,'2026-02-24 14:13:05.898',240875,NULL,50,NULL,NULL,NULL,'','2026-02-24 14:13:05.898'),('60021',1,'StudentOrgSealApprovalProcess:1:57504',NULL,'counselorApproval','60001','60007',NULL,NULL,NULL,NULL,NULL,'ËæÖÂØºÂëòÂÆ°Êâπ',NULL,NULL,NULL,'2013951264663101441','2026-02-24 14:13:05.928',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,'','2026-02-24 14:13:05.929'),('62511',2,'StudentOrgSealApprovalProcess:1:57504',NULL,'headTeacherApproval','62501','62507',NULL,NULL,NULL,NULL,NULL,'Áè≠‰∏ª‰ªªÂÆ°Êâπ',NULL,NULL,NULL,'2013951215732350978','2026-02-24 14:17:53.238',NULL,'2026-02-24 14:18:16.118',22880,NULL,50,NULL,NULL,NULL,'','2026-02-24 14:18:16.118'),('62521',2,'StudentOrgSealApprovalProcess:1:57504',NULL,'counselorApproval','62501','62507',NULL,NULL,NULL,NULL,NULL,'ËæÖÂØºÂëòÂÆ°Êâπ',NULL,NULL,NULL,'2013951264663101441','2026-02-24 14:18:16.147',NULL,'2026-05-20 10:34:46.529',7330590382,NULL,50,NULL,NULL,NULL,'','2026-05-20 10:34:46.529'),('62535',2,'StudentOrgSealApprovalProcess:1:57504',NULL,'headTeacherApproval','62525','62531',NULL,NULL,NULL,NULL,NULL,'Áè≠‰∏ª‰ªªÂÆ°Êâπ',NULL,NULL,NULL,'2013951215732350978','2026-02-24 14:19:09.487',NULL,'2026-02-24 14:19:43.583',34096,NULL,50,NULL,NULL,NULL,'','2026-02-24 14:19:43.583'),('62545',2,'StudentOrgSealApprovalProcess:1:57504',NULL,'counselorApproval','62525','62531',NULL,NULL,NULL,NULL,NULL,'ËæÖÂØºÂëòÂÆ°Êâπ',NULL,NULL,NULL,'2013951264663101441','2026-02-24 14:19:43.590',NULL,'2026-02-24 14:20:07.094',23504,NULL,50,NULL,NULL,NULL,'','2026-02-24 14:20:07.094'),('62553',2,'StudentOrgSealApprovalProcess:1:57504',NULL,'deanApproval','62525','62531',NULL,NULL,NULL,NULL,NULL,'Èô¢ÈïøÂÆ°Êâπ',NULL,NULL,NULL,'2013951338067615746','2026-02-24 14:20:07.103',NULL,'2026-02-24 14:20:21.397',14294,NULL,50,NULL,NULL,NULL,'','2026-02-24 14:20:21.397'),('62579',2,'ClassGuidePartySealApprovalProcess:1:62564',NULL,'MentorApproval','62569','62575',NULL,NULL,NULL,NULL,NULL,'ËæÖÂØºÂëòÂÆ°Êâπ',NULL,NULL,NULL,'2013951264663101441','2026-02-24 15:12:13.775',NULL,'2026-02-24 15:12:34.105',20330,NULL,50,NULL,NULL,NULL,'','2026-02-24 15:12:34.105'),('62599',2,'ClassGuideOrgSealApprovalProcess:1:62568',NULL,'MentorApproval','62589','62595',NULL,NULL,NULL,NULL,NULL,'ËæÖÂØºÂëòÂÆ°Êâπ',NULL,NULL,NULL,'2013951264663101441','2026-02-24 15:13:27.107',NULL,'2026-02-24 15:14:08.875',41768,NULL,50,NULL,NULL,NULL,'','2026-02-24 15:14:08.875'),('65005',2,'StudentOrgSealApprovalProcess:1:57504',NULL,'deanApproval','62501','62507',NULL,NULL,NULL,NULL,NULL,'Èô¢ÈïøÂÆ°Êâπ',NULL,NULL,NULL,'2013951338067615746','2026-05-20 10:34:46.666',NULL,'2026-05-20 10:35:43.288',56622,NULL,50,NULL,NULL,NULL,'','2026-05-20 10:35:43.288');
/*!40000 ALTER TABLE `act_hi_taskinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_tsk_log`
--

DROP TABLE IF EXISTS `act_hi_tsk_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_tsk_log` (
  `ID_` bigint NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DATA_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_tsk_log`
--

LOCK TABLES `act_hi_tsk_log` WRITE;
/*!40000 ALTER TABLE `act_hi_tsk_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_tsk_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_varinst`
--

DROP TABLE IF EXISTS `act_hi_varinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT '1',
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint DEFAULT NULL,
  `TEXT_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_EXE` (`EXECUTION_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_varinst`
--

LOCK TABLES `act_hi_varinst` WRITE;
/*!40000 ALTER TABLE `act_hi_varinst` DISABLE KEYS */;
INSERT INTO `act_hi_varinst` VALUES ('60002',0,'60001','60001',NULL,'applyId','long',NULL,NULL,NULL,NULL,NULL,2026177540231938049,'2026177540231938049',NULL,'2026-02-24 14:09:05.018','2026-02-24 14:09:05.018'),('60003',0,'60001','60001',NULL,'applicantName','string',NULL,NULL,NULL,NULL,NULL,NULL,'xuesheng',NULL,'2026-02-24 14:09:05.018','2026-02-24 14:09:05.018'),('60004',0,'60001','60001',NULL,'sealType','integer',NULL,NULL,NULL,NULL,NULL,2,'2',NULL,'2026-02-24 14:09:05.018','2026-02-24 14:09:05.018'),('60005',0,'60001','60001',NULL,'applicantId','long',NULL,NULL,NULL,NULL,NULL,2013950942494416897,'2013950942494416897',NULL,'2026-02-24 14:09:05.018','2026-02-24 14:09:05.018'),('60006',0,'60001','60001',NULL,'sealCategory','integer',NULL,NULL,NULL,NULL,NULL,1,'1',NULL,'2026-02-24 14:09:05.018','2026-02-24 14:09:05.018'),('60015',0,'60001','60001',NULL,'approved','boolean',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2026-02-24 14:13:05.894','2026-02-24 14:13:05.894'),('60016',0,'60001','60001',NULL,'rejectReason','string',NULL,NULL,NULL,NULL,NULL,NULL,'123',NULL,'2026-02-24 14:13:05.894','2026-02-24 14:13:05.894'),('62502',0,'62501','62501',NULL,'applyId','long',NULL,NULL,NULL,NULL,NULL,2026179755906572290,'2026179755906572290',NULL,'2026-02-24 14:17:53.233','2026-02-24 14:17:53.233'),('62503',0,'62501','62501',NULL,'applicantName','string',NULL,NULL,NULL,NULL,NULL,NULL,'xuesheng',NULL,'2026-02-24 14:17:53.233','2026-02-24 14:17:53.233'),('62504',0,'62501','62501',NULL,'sealType','integer',NULL,NULL,NULL,NULL,NULL,1,'1',NULL,'2026-02-24 14:17:53.233','2026-02-24 14:17:53.233'),('62505',0,'62501','62501',NULL,'applicantId','long',NULL,NULL,NULL,NULL,NULL,2013950942494416897,'2013950942494416897',NULL,'2026-02-24 14:17:53.233','2026-02-24 14:17:53.233'),('62506',0,'62501','62501',NULL,'sealCategory','integer',NULL,NULL,NULL,NULL,NULL,1,'1',NULL,'2026-02-24 14:17:53.233','2026-02-24 14:17:53.233'),('62515',2,'62501','62501',NULL,'approved','boolean',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2026-02-24 14:18:16.114','2026-05-20 10:35:43.285'),('62516',2,'62501','62501',NULL,'rejectReason','string',NULL,NULL,NULL,NULL,NULL,NULL,'ÂêåÊÑè',NULL,'2026-02-24 14:18:16.114','2026-05-20 10:35:43.286'),('62526',0,'62525','62525',NULL,'applyId','long',NULL,NULL,NULL,NULL,NULL,2026180076292677634,'2026180076292677634',NULL,'2026-02-24 14:19:09.487','2026-02-24 14:19:09.487'),('62527',0,'62525','62525',NULL,'applicantName','string',NULL,NULL,NULL,NULL,NULL,NULL,'xuesheng',NULL,'2026-02-24 14:19:09.487','2026-02-24 14:19:09.487'),('62528',0,'62525','62525',NULL,'sealType','integer',NULL,NULL,NULL,NULL,NULL,2,'2',NULL,'2026-02-24 14:19:09.487','2026-02-24 14:19:09.487'),('62529',0,'62525','62525',NULL,'applicantId','long',NULL,NULL,NULL,NULL,NULL,2013950942494416897,'2013950942494416897',NULL,'2026-02-24 14:19:09.487','2026-02-24 14:19:09.487'),('62530',0,'62525','62525',NULL,'sealCategory','integer',NULL,NULL,NULL,NULL,NULL,1,'1',NULL,'2026-02-24 14:19:09.487','2026-02-24 14:19:09.487'),('62539',2,'62525','62525',NULL,'approved','boolean',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2026-02-24 14:19:43.583','2026-02-24 14:20:21.393'),('62540',2,'62525','62525',NULL,'rejectReason','string',NULL,NULL,NULL,NULL,NULL,NULL,'ÂêåÊÑè',NULL,'2026-02-24 14:19:43.583','2026-02-24 14:20:21.395'),('62570',0,'62569','62569',NULL,'applyId','long',NULL,NULL,NULL,NULL,NULL,2026193432206516225,'2026193432206516225',NULL,'2026-02-24 15:12:13.773','2026-02-24 15:12:13.773'),('62571',0,'62569','62569',NULL,'applicantName','string',NULL,NULL,NULL,NULL,NULL,NULL,'banzhuren',NULL,'2026-02-24 15:12:13.773','2026-02-24 15:12:13.773'),('62572',0,'62569','62569',NULL,'sealType','integer',NULL,NULL,NULL,NULL,NULL,1,'1',NULL,'2026-02-24 15:12:13.773','2026-02-24 15:12:13.773'),('62573',0,'62569','62569',NULL,'applicantId','long',NULL,NULL,NULL,NULL,NULL,2013951215732350978,'2013951215732350978',NULL,'2026-02-24 15:12:13.773','2026-02-24 15:12:13.773'),('62574',0,'62569','62569',NULL,'sealCategory','integer',NULL,NULL,NULL,NULL,NULL,2,'2',NULL,'2026-02-24 15:12:13.774','2026-02-24 15:12:13.774'),('62583',0,'62569','62569',NULL,'approved','boolean',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-02-24 15:12:34.104','2026-02-24 15:12:34.104'),('62584',0,'62569','62569',NULL,'rejectReason','string',NULL,NULL,NULL,NULL,NULL,NULL,'ÊãíÁªù',NULL,'2026-02-24 15:12:34.104','2026-02-24 15:12:34.104'),('62590',0,'62589','62589',NULL,'applyId','long',NULL,NULL,NULL,NULL,NULL,2026193739770634242,'2026193739770634242',NULL,'2026-02-24 15:13:27.107','2026-02-24 15:13:27.107'),('62591',0,'62589','62589',NULL,'applicantName','string',NULL,NULL,NULL,NULL,NULL,NULL,'banzhuren',NULL,'2026-02-24 15:13:27.107','2026-02-24 15:13:27.107'),('62592',0,'62589','62589',NULL,'sealType','integer',NULL,NULL,NULL,NULL,NULL,1,'1',NULL,'2026-02-24 15:13:27.107','2026-02-24 15:13:27.107'),('62593',0,'62589','62589',NULL,'applicantId','long',NULL,NULL,NULL,NULL,NULL,2013951215732350978,'2013951215732350978',NULL,'2026-02-24 15:13:27.107','2026-02-24 15:13:27.107'),('62594',0,'62589','62589',NULL,'sealCategory','integer',NULL,NULL,NULL,NULL,NULL,1,'1',NULL,'2026-02-24 15:13:27.107','2026-02-24 15:13:27.107'),('62603',0,'62589','62589',NULL,'approved','boolean',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,'2026-02-24 15:14:08.874','2026-02-24 15:14:08.874'),('62604',0,'62589','62589',NULL,'rejectReason','string',NULL,NULL,NULL,NULL,NULL,NULL,'ÊãíÁªù',NULL,'2026-02-24 15:14:08.874','2026-02-24 15:14:08.874');
/*!40000 ALTER TABLE `act_hi_varinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_bytearray`
--

DROP TABLE IF EXISTS `act_id_bytearray`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_bytearray` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_bytearray`
--

LOCK TABLES `act_id_bytearray` WRITE;
/*!40000 ALTER TABLE `act_id_bytearray` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_bytearray` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_group`
--

DROP TABLE IF EXISTS `act_id_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_group` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_group`
--

LOCK TABLES `act_id_group` WRITE;
/*!40000 ALTER TABLE `act_id_group` DISABLE KEYS */;
INSERT INTO `act_id_group` VALUES ('123',6,'123','assignment'),('ADMIN',162,'ÁÆ°ÁêÜÂëò','assignment'),('CLASSGUIDE',164,'Áè≠‰∏ª‰ªª','assignment'),('DEAN',161,'Â≠¶Èô¢Èô¢Èïø','assignment'),('MENTOR',161,'ËæÖÂØºÂëò','assignment'),('PARTYSECRETARY',161,'ÂÖöÂßî‰π¶ËÆ∞','assignment'),('STUDENT',164,'Â≠¶Áîü','assignment');
/*!40000 ALTER TABLE `act_id_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_info`
--

DROP TABLE IF EXISTS `act_id_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_info` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `USER_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_info`
--

LOCK TABLES `act_id_info` WRITE;
/*!40000 ALTER TABLE `act_id_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_membership`
--

DROP TABLE IF EXISTS `act_id_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_membership`
--

LOCK TABLES `act_id_membership` WRITE;
/*!40000 ALTER TABLE `act_id_membership` DISABLE KEYS */;
INSERT INTO `act_id_membership` VALUES ('2019749762771800066','ADMIN'),('2021178921381359618','ADMIN'),('2014227995089248257','CLASSGUIDE'),('2014227995089248257','STUDENT'),('2019749762771800066','STUDENT'),('2021582059099684865','STUDENT'),('2021582673644937218','STUDENT');
/*!40000 ALTER TABLE `act_id_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_priv`
--

DROP TABLE IF EXISTS `act_id_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_priv` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PRIV_NAME` (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_priv`
--

LOCK TABLES `act_id_priv` WRITE;
/*!40000 ALTER TABLE `act_id_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_priv_mapping`
--

DROP TABLE IF EXISTS `act_id_priv_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_priv_mapping` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `PRIV_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `GROUP_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_PRIV_MAPPING` (`PRIV_ID_`),
  KEY `ACT_IDX_PRIV_USER` (`USER_ID_`),
  KEY `ACT_IDX_PRIV_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_PRIV_MAPPING` FOREIGN KEY (`PRIV_ID_`) REFERENCES `act_id_priv` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_priv_mapping`
--

LOCK TABLES `act_id_priv_mapping` WRITE;
/*!40000 ALTER TABLE `act_id_priv_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_priv_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_property`
--

DROP TABLE IF EXISTS `act_id_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_property` (
  `NAME_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `REV_` int DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_property`
--

LOCK TABLES `act_id_property` WRITE;
/*!40000 ALTER TABLE `act_id_property` DISABLE KEYS */;
INSERT INTO `act_id_property` VALUES ('schema.version','6.8.0.0',1);
/*!40000 ALTER TABLE `act_id_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_token`
--

DROP TABLE IF EXISTS `act_id_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_token` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `TOKEN_VALUE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TOKEN_DATE_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `IP_ADDRESS_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `USER_AGENT_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TOKEN_DATA_` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_token`
--

LOCK TABLES `act_id_token` WRITE;
/*!40000 ALTER TABLE `act_id_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_user`
--

DROP TABLE IF EXISTS `act_id_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_user` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `FIRST_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DISPLAY_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_user`
--

LOCK TABLES `act_id_user` WRITE;
/*!40000 ALTER TABLE `act_id_user` DISABLE KEYS */;
INSERT INTO `act_id_user` VALUES ('2013950942494416897',157,'xuesheng','',NULL,'xuesheng@demo.edu.cn',NULL,NULL,NULL),('2013951215732350978',157,'banzhuren','',NULL,'banzhuren@demo.edu.cn',NULL,NULL,NULL),('2013951264663101441',157,'fudaoyuan','',NULL,'fudaoyuan@demo.edu.cn',NULL,NULL,NULL),('2013951338067615746',157,'yuanzhang','',NULL,'yuanzhang@demo.edu.cn',NULL,NULL,NULL),('2013951382959251457',157,'shuji','',NULL,'shuji@demo.edu.cn',NULL,NULL,NULL),('2013951423174238210',157,'admin','',NULL,'admin@demo.edu.cn',NULL,NULL,NULL),('2014227995089248257',159,'123','',NULL,'123@test.com',NULL,NULL,NULL),('2014228067868811265',157,'122313','',NULL,'123@test.com',NULL,NULL,NULL),('2014228155601068033',157,'13213','',NULL,'123@test.com',NULL,NULL,NULL),('2014228234974076929',77,'123','',NULL,'123@test.com',NULL,NULL,NULL),('2014228288002662401',157,'12312','',NULL,'123@test.com',NULL,NULL,NULL),('2019749762771800066',4,'3213','',NULL,'123321@qq.com',NULL,NULL,NULL),('2021178921381359618',2,'1232312','',NULL,'1323@qq.com',NULL,NULL,NULL),('2021567837326360577',1,'123132','',NULL,'3166335486@qq.com',NULL,NULL,NULL),('2021571132107284482',1,'qqwe','',NULL,'3166335486@qq.com',NULL,NULL,NULL),('2021580547732631553',1,'qwe','',NULL,'3166335486@qq.com',NULL,NULL,NULL),('2021582059099684865',2,'qwe','',NULL,'3166335486@qq.com',NULL,NULL,NULL),('2021582673644937218',3,'qwe','',NULL,'3166335486@qq.com',NULL,NULL,NULL);
/*!40000 ALTER TABLE `act_id_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_procdef_info`
--

DROP TABLE IF EXISTS `act_procdef_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_procdef_info` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_procdef_info`
--

LOCK TABLES `act_procdef_info` WRITE;
/*!40000 ALTER TABLE `act_procdef_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_procdef_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_deployment`
--

DROP TABLE IF EXISTS `act_re_deployment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DERIVED_FROM_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DERIVED_FROM_ROOT_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ENGINE_VERSION_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_deployment`
--

LOCK TABLES `act_re_deployment` WRITE;
/*!40000 ALTER TABLE `act_re_deployment` DISABLE KEYS */;
INSERT INTO `act_re_deployment` VALUES ('57501','Èô¢Á´†ÂÆ°ÊâπÔºàÂ≠¶ÁîüÔºâ',NULL,NULL,'','2026-02-12 11:08:59.407',NULL,NULL,'57501',NULL),('57505','ÂÖöÁ´†ÂÆ°ÊâπÔºàÂ≠¶ÁîüÔºâ',NULL,NULL,'','2026-02-12 11:09:03.121',NULL,NULL,'57505',NULL),('62561','ÂÖöÁ´†ÂÆ°ÊâπÔºàÁè≠‰∏ª‰ªªÔºâ',NULL,NULL,'','2026-02-24 07:11:42.776',NULL,NULL,'62561',NULL),('62565','Èô¢Á´†ÂÆ°ÊâπÔºàÁè≠‰∏ª‰ªªÔºâ',NULL,NULL,'','2026-02-24 07:11:47.494',NULL,NULL,'62565',NULL);
/*!40000 ALTER TABLE `act_re_deployment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_model`
--

DROP TABLE IF EXISTS `act_re_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_re_model` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int DEFAULT NULL,
  `META_INFO_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_model`
--

LOCK TABLES `act_re_model` WRITE;
/*!40000 ALTER TABLE `act_re_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_procdef`
--

DROP TABLE IF EXISTS `act_re_procdef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `VERSION_` int NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint DEFAULT NULL,
  `SUSPENSION_STATE_` int DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  `ENGINE_VERSION_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DERIVED_FROM_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DERIVED_FROM_ROOT_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DERIVED_VERSION_` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`DERIVED_VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_procdef`
--

LOCK TABLES `act_re_procdef` WRITE;
/*!40000 ALTER TABLE `act_re_procdef` DISABLE KEYS */;
INSERT INTO `act_re_procdef` VALUES ('ClassGuideOrgSealApprovalProcess:1:62568',1,'http://www.flowable.org/processdef','Èô¢Á´†ÂÆ°ÊâπÔºàÁè≠‰∏ª‰ªªÔºâ','ClassGuideOrgSealApprovalProcess',1,'62565','ClassGuideOrgSealApprovalProcess.bpmn20.xml','ClassGuideOrgSealApprovalProcess.ClassGuideOrgSealApprovalProcess.png',NULL,0,1,1,'',NULL,NULL,NULL,0),('ClassGuidePartySealApprovalProcess:1:62564',1,'http://www.flowable.org/processdef','ÂÖöÁ´†ÂÆ°ÊâπÔºàÁè≠‰∏ª‰ªªÔºâ','ClassGuidePartySealApprovalProcess',1,'62561','ClassGuidePartySealApprovalProcess.bpmn20.xml','ClassGuidePartySealApprovalProcess.ClassGuidePartySealApprovalProcess.png',NULL,0,1,1,'',NULL,NULL,NULL,0),('StudentOrgSealApprovalProcess:1:57504',1,'http://www.flowable.org/processdef','Èô¢Á´†ÂÆ°ÊâπÔºàÂ≠¶ÁîüÔºâ','StudentOrgSealApprovalProcess',1,'57501','StudentOrgSealApprovalProcess.bpmn20.xml','StudentOrgSealApprovalProcess.StudentOrgSealApprovalProcess.png',NULL,0,1,1,'',NULL,NULL,NULL,0),('StudentPartySealApprovalProcess:1:57508',1,'http://www.flowable.org/processdef','ÂÖöÁ´†ÂÆ°ÊâπÔºàÂ≠¶ÁîüÔºâ','StudentPartySealApprovalProcess',1,'57505','StudentPartySealApprovalProcess.bpmn20.xml','StudentPartySealApprovalProcess.StudentPartySealApprovalProcess.png',NULL,0,1,1,'',NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `act_re_procdef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_actinst`
--

DROP TABLE IF EXISTS `act_ru_actinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_actinst` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT '1',
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint DEFAULT NULL,
  `TRANSACTION_ORDER_` int DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_RU_ACTI_START` (`START_TIME_`),
  KEY `ACT_IDX_RU_ACTI_END` (`END_TIME_`),
  KEY `ACT_IDX_RU_ACTI_PROC` (`PROC_INST_ID_`),
  KEY `ACT_IDX_RU_ACTI_PROC_ACT` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_RU_ACTI_EXEC` (`EXECUTION_ID_`),
  KEY `ACT_IDX_RU_ACTI_EXEC_ACT` (`EXECUTION_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_RU_ACTI_TASK` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_actinst`
--

LOCK TABLES `act_ru_actinst` WRITE;
/*!40000 ALTER TABLE `act_ru_actinst` DISABLE KEYS */;
INSERT INTO `act_ru_actinst` VALUES ('60008',1,'StudentOrgSealApprovalProcess:1:57504','60001','60007','StartEvent_1',NULL,NULL,'ÂºÄÂßã','startEvent',NULL,'2026-02-24 14:09:05.019','2026-02-24 14:09:05.022',3,1,NULL,''),('60009',1,'StudentOrgSealApprovalProcess:1:57504','60001','60007','Flow_1gtutt3',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 14:09:05.023','2026-02-24 14:09:05.023',0,2,NULL,''),('60010',2,'StudentOrgSealApprovalProcess:1:57504','60001','60007','headTeacherApproval','60011',NULL,'Áè≠‰∏ª‰ªªÂÆ°Êâπ','userTask','2013951215732350978','2026-02-24 14:09:05.023','2026-02-24 14:13:05.906',240883,3,NULL,''),('60017',1,'StudentOrgSealApprovalProcess:1:57504','60001','60007','Flow_1ln9kdp',NULL,NULL,NULL,'sequenceFlow',NULL,'2026-02-24 14:13:05.908','2026-02-24 14:13:05.908',0,1,NULL,''),('60018',1,'StudentOrgSealApprovalProcess:1:57504','60001','60007','Gateway_headTeacher',NULL,NULL,'Áè≠‰∏ª‰ªªÂÆ°ÊâπÁªìÊûú','exclusiveGateway',NULL,'2026-02-24 14:13:05.910','2026-02-24 14:13:05.926',16,2,NULL,''),('60019',1,'StudentOrgSealApprovalProcess:1:57504','60001','60007','Flow_1f887dt',NULL,NULL,'ÂêåÊÑè','sequenceFlow',NULL,'2026-02-24 14:13:05.926','2026-02-24 14:13:05.926',0,3,NULL,''),('60020',1,'StudentOrgSealApprovalProcess:1:57504','60001','60007','counselorApproval','60021',NULL,'ËæÖÂØºÂëòÂÆ°Êâπ','userTask','2013951264663101441','2026-02-24 14:13:05.928',NULL,NULL,4,NULL,'');
/*!40000 ALTER TABLE `act_ru_actinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_deadletter_job`
--

DROP TABLE IF EXISTS `act_ru_deadletter_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_deadletter_job` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_DEADLETTER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_DEADLETTER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
  KEY `ACT_IDX_DEADLETTER_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
  KEY `ACT_IDX_DJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_DJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_DJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_DEADLETTER_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_deadletter_job`
--

LOCK TABLES `act_ru_deadletter_job` WRITE;
/*!40000 ALTER TABLE `act_ru_deadletter_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_deadletter_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_entitylink`
--

DROP TABLE IF EXISTS `act_ru_entitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_entitylink` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LINK_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ROOT_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ROOT_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HIERARCHY_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`),
  KEY `ACT_IDX_ENT_LNK_REF_SCOPE` (`REF_SCOPE_ID_`,`REF_SCOPE_TYPE_`,`LINK_TYPE_`),
  KEY `ACT_IDX_ENT_LNK_ROOT_SCOPE` (`ROOT_SCOPE_ID_`,`ROOT_SCOPE_TYPE_`,`LINK_TYPE_`),
  KEY `ACT_IDX_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_entitylink`
--

LOCK TABLES `act_ru_entitylink` WRITE;
/*!40000 ALTER TABLE `act_ru_entitylink` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_entitylink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_event_subscr`
--

DROP TABLE IF EXISTS `act_ru_event_subscr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_IDX_EVENT_SUBSCR_SCOPEREF_` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_event_subscr`
--

LOCK TABLES `act_ru_event_subscr` WRITE;
/*!40000 ALTER TABLE `act_ru_event_subscr` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_event_subscr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_execution`
--

DROP TABLE IF EXISTS `act_ru_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint DEFAULT NULL,
  `IS_CONCURRENT_` tinyint DEFAULT NULL,
  `IS_SCOPE_` tinyint DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint DEFAULT NULL,
  `IS_MI_ROOT_` tinyint DEFAULT NULL,
  `SUSPENSION_STATE_` int DEFAULT NULL,
  `CACHED_ENT_STATE_` int DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint DEFAULT NULL,
  `EVT_SUBSCR_COUNT_` int DEFAULT NULL,
  `TASK_COUNT_` int DEFAULT NULL,
  `JOB_COUNT_` int DEFAULT NULL,
  `TIMER_JOB_COUNT_` int DEFAULT NULL,
  `SUSP_JOB_COUNT_` int DEFAULT NULL,
  `DEADLETTER_JOB_COUNT_` int DEFAULT NULL,
  `EXTERNAL_WORKER_JOB_COUNT_` int DEFAULT NULL,
  `VAR_COUNT_` int DEFAULT NULL,
  `ID_LINK_COUNT_` int DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_STATUS_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_IDC_EXEC_ROOT` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_EXEC_REF_ID_` (`REFERENCE_ID_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE,
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_execution`
--

LOCK TABLES `act_ru_execution` WRITE;
/*!40000 ALTER TABLE `act_ru_execution` DISABLE KEYS */;
INSERT INTO `act_ru_execution` VALUES ('60001',1,'60001','SA2026177540137779200',NULL,'StudentOrgSealApprovalProcess:1:57504',NULL,'60001',NULL,1,0,1,0,0,1,NULL,'',NULL,'StartEvent_1','2026-02-24 14:09:05.002',NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL),('60007',2,'60001',NULL,'60001','StudentOrgSealApprovalProcess:1:57504',NULL,'60001','counselorApproval',1,0,0,0,0,1,NULL,'',NULL,NULL,'2026-02-24 14:09:05.019',NULL,NULL,NULL,1,0,1,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `act_ru_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_external_job`
--

DROP TABLE IF EXISTS `act_ru_external_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_external_job` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXTERNAL_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_EXTERNAL_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
  KEY `ACT_IDX_EXTERNAL_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
  KEY `ACT_IDX_EJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_EJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_EJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  CONSTRAINT `ACT_FK_EXTERNAL_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_EXTERNAL_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_external_job`
--

LOCK TABLES `act_ru_external_job` WRITE;
/*!40000 ALTER TABLE `act_ru_external_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_external_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_history_job`
--

DROP TABLE IF EXISTS `act_ru_history_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_history_job` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ADV_HANDLER_CFG_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_history_job`
--

LOCK TABLES `act_ru_history_job` WRITE;
/*!40000 ALTER TABLE `act_ru_history_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_history_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_identitylink`
--

DROP TABLE IF EXISTS `act_ru_identitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `GROUP_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_IDENT_LNK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_identitylink`
--

LOCK TABLES `act_ru_identitylink` WRITE;
/*!40000 ALTER TABLE `act_ru_identitylink` DISABLE KEYS */;
INSERT INTO `act_ru_identitylink` VALUES ('60013',1,NULL,'participant','2013951215732350978',NULL,'60001',NULL,NULL,NULL,NULL,NULL),('60023',1,NULL,'participant','2013951264663101441',NULL,'60001',NULL,NULL,NULL,NULL,NULL),('60024',1,'2013952827238473729','candidate',NULL,'60021',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `act_ru_identitylink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_job`
--

DROP TABLE IF EXISTS `act_ru_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
  KEY `ACT_IDX_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
  KEY `ACT_IDX_JOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_JOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_JOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_job`
--

LOCK TABLES `act_ru_job` WRITE;
/*!40000 ALTER TABLE `act_ru_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_suspended_job`
--

DROP TABLE IF EXISTS `act_ru_suspended_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_suspended_job` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_SUSPENDED_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_SUSPENDED_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
  KEY `ACT_IDX_SUSPENDED_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
  KEY `ACT_IDX_SJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_SJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_SJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_SUSPENDED_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_suspended_job`
--

LOCK TABLES `act_ru_suspended_job` WRITE;
/*!40000 ALTER TABLE `act_ru_suspended_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_suspended_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_task`
--

DROP TABLE IF EXISTS `act_ru_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint DEFAULT NULL,
  `VAR_COUNT_` int DEFAULT NULL,
  `ID_LINK_COUNT_` int DEFAULT NULL,
  `SUB_TASK_COUNT_` int DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_IDX_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_task`
--

LOCK TABLES `act_ru_task` WRITE;
/*!40000 ALTER TABLE `act_ru_task` DISABLE KEYS */;
INSERT INTO `act_ru_task` VALUES ('60021',1,'60007','60001','StudentOrgSealApprovalProcess:1:57504',NULL,NULL,NULL,NULL,NULL,NULL,'ËæÖÂØºÂëòÂÆ°Êâπ',NULL,NULL,'counselorApproval',NULL,'2013951264663101441',NULL,50,'2026-02-24 06:13:05.928',NULL,NULL,1,'',NULL,NULL,1,0,1,0);
/*!40000 ALTER TABLE `act_ru_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_timer_job`
--

DROP TABLE IF EXISTS `act_ru_timer_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_timer_job` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TIMER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_TIMER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
  KEY `ACT_IDX_TIMER_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
  KEY `ACT_IDX_TIMER_JOB_DUEDATE` (`DUEDATE_`),
  KEY `ACT_IDX_TJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_TIMER_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_TIMER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_timer_job`
--

LOCK TABLES `act_ru_timer_job` WRITE;
/*!40000 ALTER TABLE `act_ru_timer_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_timer_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_variable`
--

DROP TABLE IF EXISTS `act_ru_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint DEFAULT NULL,
  `TEXT_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_RU_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_RU_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_variable`
--

LOCK TABLES `act_ru_variable` WRITE;
/*!40000 ALTER TABLE `act_ru_variable` DISABLE KEYS */;
INSERT INTO `act_ru_variable` VALUES ('60002',1,'long','applyId','60001','60001',NULL,NULL,NULL,NULL,NULL,NULL,2026177540231938049,'2026177540231938049',NULL),('60003',1,'string','applicantName','60001','60001',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'xuesheng',NULL),('60004',1,'integer','sealType','60001','60001',NULL,NULL,NULL,NULL,NULL,NULL,2,'2',NULL),('60005',1,'long','applicantId','60001','60001',NULL,NULL,NULL,NULL,NULL,NULL,2013950942494416897,'2013950942494416897',NULL),('60006',1,'integer','sealCategory','60001','60001',NULL,NULL,NULL,NULL,NULL,NULL,1,'1',NULL),('60015',1,'boolean','approved','60001','60001',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL),('60016',1,'string','rejectReason','60001','60001',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'123',NULL);
/*!40000 ALTER TABLE `act_ru_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blockchain_evidence`
--

DROP TABLE IF EXISTS `blockchain_evidence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blockchain_evidence` (
  `id` bigint NOT NULL COMMENT '‰∏ªÈîÆID',
  `evidence_no` varchar(64) NOT NULL COMMENT 'Â≠òËØÅÁºñÂè∑',
  `business_type` varchar(32) NOT NULL COMMENT '‰∏öÂä°Á±ªÂûãÔºàAPPLY-Áî≥ËØ∑ÔºåAPPROVE-ÂÆ°ÊâπÔºåSTAMP-ÁõñÁ´†Ôºâ',
  `business_id` bigint NOT NULL COMMENT '‰∏öÂä°IDÔºàÁî≥ËØ∑ID„ÄÅÂÆ°ÊâπËÆ∞ÂΩïIDÁ≠âÔºâ',
  `business_data` text COMMENT '‰∏öÂä°Êï∞ÊçÆJSON',
  `data_hash` varchar(128) NOT NULL COMMENT 'Êï∞ÊçÆÂìàÂ∏åÂÄºÔºàSHA-256Ôºâ',
  `block_height` bigint NOT NULL COMMENT 'Âå∫ÂùóÈ´òÂ∫¶',
  `block_hash` varchar(128) NOT NULL COMMENT 'Âå∫ÂùóÂìàÂ∏åÂÄº',
  `transaction_hash` varchar(128) NOT NULL COMMENT '‰∫§ÊòìÂìàÂ∏åÂÄº',
  `previous_hash` varchar(128) NOT NULL COMMENT '‰∏ä‰∏ÄÂå∫ÂùóÂìàÂ∏åÂÄº',
  `timestamp` datetime NOT NULL COMMENT 'Â≠òËØÅÊó∂Èó¥Êà≥',
  `operator_id` bigint DEFAULT NULL COMMENT 'Êìç‰Ωú‰∫∫ID',
  `operator_name` varchar(64) DEFAULT NULL COMMENT 'Êìç‰Ωú‰∫∫ÂßìÂêç',
  `status` tinyint DEFAULT '1' COMMENT 'Áä∂ÊÄÅÔºà0-Â§±ÊïàÔºå1-ÊúâÊïàÔºâ',
  `verify_status` tinyint DEFAULT '0' COMMENT 'È™åËØÅÁä∂ÊÄÅÔºà0-Êú™È™åËØÅÔºå1-È™åËØÅÈÄöËøáÔºå2-È™åËØÅÂ§±Ë¥•Ôºâ',
  `verify_time` datetime DEFAULT NULL COMMENT 'È™åËØÅÊó∂Èó¥',
  `create_by` bigint DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0' COMMENT 'ÈÄªËæëÂà†Èô§Ôºà0Êú™Âà†Èô§Ôºå1Â∑≤Âà†Èô§Ôºâ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `evidence_no` (`evidence_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Âå∫ÂùóÈìæÂ≠òËØÅË°®';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blockchain_evidence`
--

LOCK TABLES `blockchain_evidence` WRITE;
/*!40000 ALTER TABLE `blockchain_evidence` DISABLE KEYS */;
INSERT INTO `blockchain_evidence` VALUES (2026177541645418497,'EV17719133451524F99A036','APPLY',2026177540231938049,'{\"applyNo\":\"SA2026177540137779200\",\"applicantId\":\"2013950942494416897\",\"applicantName\":\"xuesheng\",\"sealId\":\"2014588288638234625\",\"sealName\":\"Èô¢Á´†ÔºàÁîµÂ≠êÔºâ\",\"applyReason\":\"12345\",\"applyTime\":\"2026-02-24 14:09:04\"}','de76924dbf15495b8a99646d277a88dcdd86f967b9c202e2c90fe0d871bf3c27',1,'baadb99c908b83f02f209ce3e209cdf69acc4a7fdd75e99da81d4bc197c9cd9c','4b65962bfffcaa42864fc55b4cf955b1ed5529939a10e1ee0808602dc02e6841','0','2026-02-24 14:09:05',2013950942494416897,'xuesheng',1,2,'2026-02-24 14:16:37',2013950942494416897,'2026-02-24 14:09:05',2013950942494416897,'2026-02-24 14:09:05',0),(2026178551310860289,'EV1771913585867CE8471E0','APPROVE',2026178551180836865,'{\"recordId\":\"2026178551180836865\",\"applyId\":\"2026177540231938049\",\"approverId\":\"2013951215732350978\",\"approverName\":\"banzhuren\",\"approveResult\":1,\"comment\":\"123\",\"approveTime\":\"2026-02-24T14:13:05\"}','51d36d3a781cb63036feaf083a50153b20022d22b548a779767e18919b9592f5',2,'274eaae6bcc2e9842817d1da91cb3cd0dff2306a08b29150e5d4afab98f4de41','501df49e10d61095ea070649e4e559705d4d03505e5d06a0b6e00275ea49e229','baadb99c908b83f02f209ce3e209cdf69acc4a7fdd75e99da81d4bc197c9cd9c','2026-02-24 14:13:06',2013951215732350978,'banzhuren',1,0,NULL,2013951215732350978,'2026-02-24 14:13:06',2013951215732350978,'2026-02-24 14:13:06',0),(2026179757106143234,'EV1771913873354EBC0B78F','APPLY',2026179755906572290,'{\"applyNo\":\"SA2026179755829157888\",\"applicantId\":\"2013950942494416897\",\"applicantName\":\"xuesheng\",\"sealId\":\"2014588235735478273\",\"sealName\":\"Èô¢Á´†ÔºàÁâ©ÁêÜÔºâ\",\"applyReason\":\"123123\",\"applyTime\":\"2026-02-24 14:17:53\"}','b377c6f8082cc0da02d63eede0774910846acefa6e29d4ee1f33fbba3bc41ecd',3,'511ed00f0450331334a093c091c7f7e2c7317aac712e7b3670d4e0a88532e4bb','a90002d8c21ff98b31f5a06ce5e9114c23e6310699215d4aeddb514d9eb0cf7c','274eaae6bcc2e9842817d1da91cb3cd0dff2306a08b29150e5d4afab98f4de41','2026-02-24 14:17:53',2013950942494416897,'xuesheng',1,1,'2026-05-20 10:36:08',2013950942494416897,'2026-02-24 14:17:53',2013950942494416897,'2026-02-24 14:17:53',0),(2026179852463644674,'EV177191389608666ADA916','APPROVE',2026179852400730114,'{\"recordId\":\"2026179852400730114\",\"applyId\":\"2026179755906572290\",\"approverId\":\"2013951215732350978\",\"approverName\":\"banzhuren\",\"approveResult\":1,\"comment\":\"ÂêåÊÑè\",\"approveTime\":\"2026-02-24T14:18:16\"}','fc824cec3057dc05ed9f5f0d6c46ec34d8e8be52ef532b3a08506dabbaeb5022',4,'36f56c4dfaa48bbc6fd610220648639a0a9bbc5e491e0e7656cfc5706d96bbf6','57eb5951f8810efe912a9285017f7c5170134e8b4f6f77aef5be967d34b7c36d','511ed00f0450331334a093c091c7f7e2c7317aac712e7b3670d4e0a88532e4bb','2026-02-24 14:18:16',2013951215732350978,'banzhuren',1,1,'2026-05-20 10:36:05',2013951215732350978,'2026-02-24 14:18:16',2013951215732350978,'2026-02-24 14:18:16',0),(2026180076494004225,'EV17719139495121445B77F','APPLY',2026180076292677634,'{\"applyNo\":\"SA2026180076328509440\",\"applicantId\":\"2013950942494416897\",\"applicantName\":\"xuesheng\",\"sealId\":\"2014588288638234625\",\"sealName\":\"Èô¢Á´†ÔºàÁîµÂ≠êÔºâ\",\"applyReason\":\"123123\",\"applyTime\":\"2026-02-24 14:19:09\"}','9ae28ec2f80de1e54f26b4a33b8040514c150b2152e9f78128ae58e8f50f3626',5,'aca94b1587fc8766cd2f657dd8913147d672ffd1dc7f152ac327d6c16ce9726a','5c367b1f89af05c202b13af8e2cbcfce107bdec92d5db6e1818d0cf22704abe5','36f56c4dfaa48bbc6fd610220648639a0a9bbc5e491e0e7656cfc5706d96bbf6','2026-02-24 14:19:10',2013950942494416897,'xuesheng',1,1,'2026-02-24 14:19:35',2013950942494416897,'2026-02-24 14:19:10',2013950942494416897,'2026-02-24 14:19:10',0),(2026180219377164290,'EV1771913983573CAAF76AF','APPROVE',2026180219377164289,'{\"recordId\":\"2026180219377164289\",\"applyId\":\"2026180076292677634\",\"approverId\":\"2013951215732350978\",\"approverName\":\"banzhuren\",\"approveResult\":1,\"comment\":\"ÂêåÊÑè\",\"approveTime\":\"2026-02-24T14:19:43\"}','62c1bb44cd47838e79c3ab81839c6d9650b51a52146f4285c7159df93e103b1d',6,'6bc58c7314448846e6ad935d078bdd418e0847c64df80d44f073ef9623505705','7e60c98d2d8a6ec5a342ce9c8894b6b0d43d4369f4f398883610a646cc72353d','aca94b1587fc8766cd2f657dd8913147d672ffd1dc7f152ac327d6c16ce9726a','2026-02-24 14:19:44',2013951215732350978,'banzhuren',1,0,NULL,2013951215732350978,'2026-02-24 14:19:44',2013951215732350978,'2026-02-24 14:19:44',0),(2026180317993639937,'EV1771914007079A6E84395','APPROVE',2026180317926531074,'{\"recordId\":\"2026180317926531074\",\"applyId\":\"2026180076292677634\",\"approverId\":\"2013951264663101441\",\"approverName\":\"fudaoyuan\",\"approveResult\":1,\"comment\":\"ÂêåÊÑè\",\"approveTime\":\"2026-02-24T14:20:07\"}','dec66d918cf3a302a44601888a9d7e3cdc8783643e3e2082039474b025518eca',7,'3ea44f59466dc1d94bf4f83adc6491f1cda79b944ad32983a54d4def39e51135','d3cb91603358ff551babca60a46f3f0af7af0caf58bf3cec49984bf77c1cde99','6bc58c7314448846e6ad935d078bdd418e0847c64df80d44f073ef9623505705','2026-02-24 14:20:07',2013951264663101441,'fudaoyuan',1,1,'2026-02-24 14:20:30',2013951264663101441,'2026-02-24 14:20:07',2013951264663101441,'2026-02-24 14:20:07',0),(2026180377947021314,'EV1771914021380A1A0E067','APPROVE',2026180377947021313,'{\"recordId\":\"2026180377947021313\",\"applyId\":\"2026180076292677634\",\"approverId\":\"2013951338067615746\",\"approverName\":\"yuanzhang\",\"approveResult\":1,\"comment\":\"ÂêåÊÑè\",\"approveTime\":\"2026-02-24T14:20:21\"}','39bca4c9a5a75fc08c1e691cc52b2d571f7d4c4b9c45a0fb289de276d1aed425',8,'0e51917d95740433e4966c08f0c4a22401cc00a0f5448b3cfa57c8295bb77ada','f2e372810bdb7deb8a462355e8522875d4f625b8f87fad06b4508c50dee35b8b','3ea44f59466dc1d94bf4f83adc6491f1cda79b944ad32983a54d4def39e51135','2026-02-24 14:20:21',2013951338067615746,'yuanzhang',1,1,'2026-02-24 14:20:31',2013951338067615746,'2026-02-24 14:20:21',2013951338067615746,'2026-02-24 14:20:21',0),(2026180667353997314,'EV177191409038157D62651','STAMP',2026180667286888449,'{\"applyId\":\"2026180076292677634\",\"pdfUrl\":\"/api/uploads/pdf/2026/02/24/2c936392-9776-4ea2-8b2a-a551dffefc3d.pdf\",\"sealImageUrl\":\"/api/uploads/2026/01/25/1b0c2962-cfbf-4015-afec-802cf6f8a4fa.png\",\"stamps\":[{\"pageIndex\":7,\"x\":23.019432,\"y\":60.62599,\"width\":9.394619,\"height\":9.394619},{\"pageIndex\":7,\"x\":50.149475,\"y\":59.693607,\"width\":15.0,\"height\":15.0}]}','b33e5346692c6bff587947b82126586510d85500f1d931323ab141735d67e417',9,'202cfaff634d31bcb785d2562e3808d45fb697ffaec64b736ebc4e059b70ade1','724a962c7f8fc774e6ae794bbf21ec87130c8e0d109337265e83e75fb00f7c2a','0e51917d95740433e4966c08f0c4a22401cc00a0f5448b3cfa57c8295bb77ada','2026-02-24 14:21:30',2013950942494416897,'xuesheng',1,1,'2026-02-24 14:21:46',2013950942494416897,'2026-02-24 14:21:30',2013950942494416897,'2026-02-24 14:21:30',0),(2026193432663695362,'EV1771917133860D32D6E19','APPLY',2026193432206516225,'{\"applyNo\":\"SA2026193432162656256\",\"applicantId\":\"2013951215732350978\",\"applicantName\":\"banzhuren\",\"sealId\":\"2014588144287068162\",\"sealName\":\"ÂÖöÁ´†ÔºàÁâ©ÁêÜÔºâ\",\"applyReason\":\"123213\",\"applyTime\":\"2026-02-24 15:12:13\"}','0cbab661581ffe1fbe528229fc1f66a7644f05a094d625cf38d4bbf4a6b51622',10,'0bb26f01d08713905ac1c35d924fbdb2521df6b7d7f82165a8e88f6c1627d649','3cd67a7509733ae9194655cccccb2f39616a2bb596ebbd38d14d86f64d8f2a2c','202cfaff634d31bcb785d2562e3808d45fb697ffaec64b736ebc4e059b70ade1','2026-02-24 15:12:14',2013951215732350978,'banzhuren',1,2,'2026-02-24 15:13:01',2013951215732350978,'2026-02-24 15:12:14',2013951215732350978,'2026-02-24 15:12:14',0),(2026193517543825410,'EV1771917154096E0EDAEE4','APPROVE',2026193517476716546,'{\"recordId\":\"2026193517476716546\",\"applyId\":\"2026193432206516225\",\"approverId\":\"2013951264663101441\",\"approverName\":\"fudaoyuan\",\"approveResult\":0,\"comment\":\"ÊãíÁªù\",\"approveTime\":\"2026-02-24T15:12:34\"}','19d2935d10b2db8995244566e4247e34d39eb0f7eeff65ad01ea556d1da9b851',11,'67482dd90490796159e3791c47926525241f705d8160c32e2a3873f82e4fd5a6','479327c00efd505ab2753cffa9a1638871f100bf1d8ad089f51410f335a3f772','0bb26f01d08713905ac1c35d924fbdb2521df6b7d7f82165a8e88f6c1627d649','2026-02-24 15:12:34',2013951264663101441,'fudaoyuan',1,1,'2026-02-24 15:12:48',2013951264663101441,'2026-02-24 15:12:34',2013951264663101441,'2026-02-24 15:12:34',0),(2026193740030681089,'EV177191720715075B372E3','APPLY',2026193739770634242,'{\"applyNo\":\"SA2026193739764523008\",\"applicantId\":\"2013951215732350978\",\"applicantName\":\"banzhuren\",\"sealId\":\"2014588235735478273\",\"sealName\":\"Èô¢Á´†ÔºàÁâ©ÁêÜÔºâ\",\"applyReason\":\"12323\",\"applyTime\":\"2026-02-24 15:13:27\"}','f0eafab2dcd44c7675a00f28cea8725e0f673d9d8755a05e6ff36e2db647fc3a',12,'6873ba15bc0c98252a89ce12790b2bbaafb620e64bfd3ba7ed2940cc1c5f5f5a','8ad5fc506f5570ab0a8977d631f448dd2850eddb004418967611a4e45e5d5e3d','67482dd90490796159e3791c47926525241f705d8160c32e2a3873f82e4fd5a6','2026-02-24 15:13:27',2013951215732350978,'banzhuren',1,1,'2026-02-24 15:15:22',2013951215732350978,'2026-02-24 15:13:27',2013951215732350978,'2026-02-24 15:13:27',0),(2026193915050598401,'EV17719172488698B98FA11','APPROVE',2026193914983489537,'{\"recordId\":\"2026193914983489537\",\"applyId\":\"2026193739770634242\",\"approverId\":\"2013951264663101441\",\"approverName\":\"fudaoyuan\",\"approveResult\":0,\"comment\":\"ÊãíÁªù\",\"approveTime\":\"2026-02-24T15:14:08\"}','65b43357c1d56d0a5484427fa5721631d3c181dc22f208893c12ce6c0d738347',13,'1a175e35414b2b5bb393c21f711b2fd8b7c43920c7cd5d9e08e8747844377ff2','c5a7c9124dee515b8c97640a27b701c7f87e2f859f9a6919d4e312b9727d8b1b','6873ba15bc0c98252a89ce12790b2bbaafb620e64bfd3ba7ed2940cc1c5f5f5a','2026-02-24 15:14:09',2013951264663101441,'fudaoyuan',1,1,'2026-02-24 15:15:23',2013951264663101441,'2026-02-24 15:14:09',2013951264663101441,'2026-02-24 15:14:09',0),(2056926576879562753,'EV1779244486441BC14347B','APPROVE',2056926576791482369,'{\"recordId\":\"2056926576791482369\",\"applyId\":\"2026179755906572290\",\"approverId\":\"2013951264663101441\",\"approverName\":\"fudaoyuan\",\"approveResult\":1,\"comment\":\"ÂêåÊÑè\",\"approveTime\":\"2026-05-20T10:34:46\"}','dfe6bee06f9ffc57c4ed1e44e83e8d30ea027038f715e846e2a4296e92e50474',14,'4d9a916b077e7e148eb2d11a0d82e4466a494d0d8cdafb63550e9fde653a3660','6c41b4ebb03555d0e72000d5921e1d14b3f417002912be1ae432c0dba6bd33f4','1a175e35414b2b5bb393c21f711b2fd8b7c43920c7cd5d9e08e8747844377ff2','2026-05-20 10:34:46',2013951264663101441,'fudaoyuan',1,1,'2026-05-20 10:36:04',2013951264663101441,'2026-05-20 10:34:46',2013951264663101441,'2026-05-20 10:34:46',0),(2056926815275413505,'EV17792445432725D40B8D1','APPROVE',2056926815208304642,'{\"recordId\":\"2056926815208304642\",\"applyId\":\"2026179755906572290\",\"approverId\":\"2013951338067615746\",\"approverName\":\"yuanzhang\",\"approveResult\":1,\"comment\":\"ÂêåÊÑè\",\"approveTime\":\"2026-05-20T10:35:43\"}','c2d3a30335cc85ec3189e94d6a35f1421c8ea31e5a55ddc9d042147ce9336d6e',15,'33c67fba2fbd8224dc824dea63bb6855cddd0f99fd6de416aac2a2a16d60935b','4352da1d4d8f418bf4b3ea35201fc44db4a2d80fdad9df437635bf4f1d81df6b','4d9a916b077e7e148eb2d11a0d82e4466a494d0d8cdafb63550e9fde653a3660','2026-05-20 10:35:43',2013951338067615746,'yuanzhang',1,1,'2026-05-20 10:36:03',2013951338067615746,'2026-05-20 10:35:43',2013951338067615746,'2026-05-20 10:35:43',0);
/*!40000 ALTER TABLE `blockchain_evidence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flw_channel_definition`
--

DROP TABLE IF EXISTS `flw_channel_definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flw_channel_definition` (
  `ID_` varchar(255) NOT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  `VERSION_` int DEFAULT NULL,
  `KEY_` varchar(255) DEFAULT NULL,
  `CATEGORY_` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `TENANT_ID_` varchar(255) DEFAULT NULL,
  `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
  `DESCRIPTION_` varchar(255) DEFAULT NULL,
  `TYPE_` varchar(255) DEFAULT NULL,
  `IMPLEMENTATION_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_IDX_CHANNEL_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flw_channel_definition`
--

LOCK TABLES `flw_channel_definition` WRITE;
/*!40000 ALTER TABLE `flw_channel_definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `flw_channel_definition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flw_ev_databasechangelog`
--

DROP TABLE IF EXISTS `flw_ev_databasechangelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flw_ev_databasechangelog` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flw_ev_databasechangelog`
--

LOCK TABLES `flw_ev_databasechangelog` WRITE;
/*!40000 ALTER TABLE `flw_ev_databasechangelog` DISABLE KEYS */;
INSERT INTO `flw_ev_databasechangelog` VALUES ('1','flowable','org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml','2026-01-25 11:55:23',1,'EXECUTED','9:63268f536c469325acef35970312551b','createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...','',NULL,'4.31.1',NULL,NULL,'9313322063'),('2','flowable','org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml','2026-01-25 11:55:23',2,'EXECUTED','9:dcb58b7dfd6dbda66939123a96985536','addColumn tableName=FLW_CHANNEL_DEFINITION; addColumn tableName=FLW_CHANNEL_DEFINITION','',NULL,'4.31.1',NULL,NULL,'9313322063'),('3','flowable','org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml','2026-01-25 11:55:23',3,'EXECUTED','9:d0c05678d57af23ad93699991e3bf4f6','customChange','',NULL,'4.31.1',NULL,NULL,'9313322063');
/*!40000 ALTER TABLE `flw_ev_databasechangelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flw_ev_databasechangeloglock`
--

DROP TABLE IF EXISTS `flw_ev_databasechangeloglock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flw_ev_databasechangeloglock` (
  `ID` int NOT NULL,
  `LOCKED` tinyint NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flw_ev_databasechangeloglock`
--

LOCK TABLES `flw_ev_databasechangeloglock` WRITE;
/*!40000 ALTER TABLE `flw_ev_databasechangeloglock` DISABLE KEYS */;
INSERT INTO `flw_ev_databasechangeloglock` VALUES (1,0,NULL,NULL);
/*!40000 ALTER TABLE `flw_ev_databasechangeloglock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flw_event_definition`
--

DROP TABLE IF EXISTS `flw_event_definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flw_event_definition` (
  `ID_` varchar(255) NOT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  `VERSION_` int DEFAULT NULL,
  `KEY_` varchar(255) DEFAULT NULL,
  `CATEGORY_` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
  `TENANT_ID_` varchar(255) DEFAULT NULL,
  `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
  `DESCRIPTION_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_IDX_EVENT_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flw_event_definition`
--

LOCK TABLES `flw_event_definition` WRITE;
/*!40000 ALTER TABLE `flw_event_definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `flw_event_definition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flw_event_deployment`
--

DROP TABLE IF EXISTS `flw_event_deployment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flw_event_deployment` (
  `ID_` varchar(255) NOT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  `CATEGORY_` varchar(255) DEFAULT NULL,
  `DEPLOY_TIME_` datetime(3) DEFAULT NULL,
  `TENANT_ID_` varchar(255) DEFAULT NULL,
  `PARENT_DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flw_event_deployment`
--

LOCK TABLES `flw_event_deployment` WRITE;
/*!40000 ALTER TABLE `flw_event_deployment` DISABLE KEYS */;
/*!40000 ALTER TABLE `flw_event_deployment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flw_event_resource`
--

DROP TABLE IF EXISTS `flw_event_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flw_event_resource` (
  `ID_` varchar(255) NOT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
  `RESOURCE_BYTES_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flw_event_resource`
--

LOCK TABLES `flw_event_resource` WRITE;
/*!40000 ALTER TABLE `flw_event_resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `flw_event_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flw_ru_batch`
--

DROP TABLE IF EXISTS `flw_ru_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flw_ru_batch` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `SEARCH_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SEARCH_KEY2_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NOT NULL,
  `COMPLETE_TIME_` datetime(3) DEFAULT NULL,
  `STATUS_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `BATCH_DOC_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flw_ru_batch`
--

LOCK TABLES `flw_ru_batch` WRITE;
/*!40000 ALTER TABLE `flw_ru_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `flw_ru_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flw_ru_batch_part`
--

DROP TABLE IF EXISTS `flw_ru_batch_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flw_ru_batch_part` (
  `ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `BATCH_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `SCOPE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SEARCH_KEY_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SEARCH_KEY2_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NOT NULL,
  `COMPLETE_TIME_` datetime(3) DEFAULT NULL,
  `STATUS_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `RESULT_DOC_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `FLW_IDX_BATCH_PART` (`BATCH_ID_`),
  CONSTRAINT `FLW_FK_BATCH_PART_PARENT` FOREIGN KEY (`BATCH_ID_`) REFERENCES `flw_ru_batch` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flw_ru_batch_part`
--

LOCK TABLES `flw_ru_batch_part` WRITE;
/*!40000 ALTER TABLE `flw_ru_batch_part` DISABLE KEYS */;
/*!40000 ALTER TABLE `flw_ru_batch_part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seal_apply`
--

DROP TABLE IF EXISTS `seal_apply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seal_apply` (
  `id` bigint NOT NULL COMMENT '‰∏ªÈîÆID',
  `apply_no` varchar(64) NOT NULL COMMENT 'Áî≥ËØ∑ÂçïÂè∑',
  `applicant_id` bigint NOT NULL COMMENT 'Áî≥ËØ∑‰∫∫ID',
  `applicant_name` varchar(64) DEFAULT NULL COMMENT 'Áî≥ËØ∑‰∫∫ÂßìÂêç',
  `applicant_no` varchar(64) DEFAULT NULL COMMENT 'Áî≥ËØ∑‰∫∫Â≠¶Âè∑',
  `seal_id` bigint NOT NULL COMMENT 'Áî≥ËØ∑Âç∞Á´†ID',
  `seal_name` varchar(100) DEFAULT NULL COMMENT 'Âç∞Á´†ÂêçÁß∞ÔºàÂÜó‰ΩôÔºâ',
  `seal_category` tinyint DEFAULT NULL COMMENT 'Âç∞Á´†ÂàÜÁ±ªÔºà1-Èô¢Á´†Ôºå2-ÂÖöÁ´†Ôºâ',
  `seal_type` tinyint DEFAULT NULL COMMENT 'Âç∞Á´†Á±ªÂûãÔºà1-Áâ©ÁêÜÁ´†Ôºå2-ÁîµÂ≠êÁ´†Ôºâ',
  `apply_reason` text NOT NULL COMMENT 'Áî≥ËØ∑‰∫ãÁî±',
  `usage_details` text COMMENT 'ÂÖ∑‰ΩìÁî®ÈÄîËØ¥Êòé',
  `apply_date` date NOT NULL COMMENT 'Áî≥ËØ∑Êó•Êúü',
  `expected_use_date` datetime DEFAULT NULL COMMENT 'È¢ÑËÆ°‰ΩøÁî®Êó∂Èó¥',
  `urgency_level` tinyint DEFAULT '1' COMMENT 'Á¥ßÊÄ•Á®ãÂ∫¶Ôºà1-ÊôÆÈÄöÔºå2-Á¥ßÊÄ•Ôºå3-ÁâπÊÄ•Ôºâ',
  `template_id` bigint DEFAULT NULL COMMENT 'ÊµÅÁ®ãÊ®°ÊùøID',
  `process_instance_id` varchar(64) DEFAULT NULL COMMENT 'ÊµÅÁ®ãÂÆû‰æãID',
  `process_definition_key` varchar(64) DEFAULT NULL COMMENT 'ÊµÅÁ®ãÂÆö‰πâKey',
  `process_name` varchar(128) DEFAULT NULL COMMENT 'ÊµÅÁ®ãÂêçÁß∞',
  `current_node_name` varchar(128) DEFAULT NULL COMMENT 'ÂΩìÂâçËäÇÁÇπÂêçÁß∞',
  `current_node_key` varchar(64) DEFAULT NULL COMMENT 'ÂΩìÂâçËäÇÁÇπKey',
  `current_approver_id` bigint DEFAULT NULL COMMENT 'ÂΩìÂâçÂÆ°Êâπ‰∫∫ID',
  `current_approver_name` varchar(64) DEFAULT NULL COMMENT 'ÂΩìÂâçÂÆ°Êâπ‰∫∫ÂßìÂêç',
  `status` tinyint DEFAULT '0' COMMENT 'Áä∂ÊÄÅÔºà0-ÂæÖÂÆ°ÊâπÔºå1-ÂÆ°Êâπ‰∏≠Ôºå2-Â∑≤ÈÄöËøáÔºå3-Â∑≤ÊãíÁªùÔºå4-Â∑≤Êí§ÈîÄÔºâ',
  `reject_reason` text COMMENT 'ÊãíÁªùÂéüÂõ†',
  `apply_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Áî≥ËØ∑Êó∂Èó¥',
  `finish_time` datetime DEFAULT NULL COMMENT 'ÂÆåÊàêÊó∂Èó¥',
  `pdf_url` varchar(500) DEFAULT NULL COMMENT 'PDFÊñá‰ª∂URL',
  `create_by` bigint DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0' COMMENT 'ÈÄªËæëÂà†Èô§Ôºà0Êú™Âà†Èô§Ôºå1Â∑≤Âà†Èô§Ôºâ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `apply_no` (`apply_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Âç∞Á´†‰ΩøÁî®Áî≥ËØ∑Ë°®';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seal_apply`
--

LOCK TABLES `seal_apply` WRITE;
/*!40000 ALTER TABLE `seal_apply` DISABLE KEYS */;
INSERT INTO `seal_apply` VALUES (2026179755906572290,'SA2026179755829157888',2013950942494416897,'xuesheng','xuesheng',2014588235735478273,'Èô¢Á´†ÔºàÁâ©ÁêÜÔºâ',1,1,'123123','123123','2026-02-24','2026-02-24 14:17:51',1,2015277809583300610,'62501','StudentOrgSealApprovalProcess','Èô¢Á´†ÂÆ°ÊâπÔºàÂ≠¶ÁîüÔºâ','Èô¢ÈïøÂÆ°Êâπ','deanApproval',2013951338067615746,'yuanzhang',2,NULL,'2026-02-24 14:17:53','2026-05-20 10:35:43','',2013950942494416897,'2026-02-24 14:17:53',2013950942494416897,'2026-02-24 14:17:53',0),(2026180076292677634,'SA2026180076328509440',2013950942494416897,'xuesheng','xuesheng',2014588288638234625,'Èô¢Á´†ÔºàÁîµÂ≠êÔºâ',1,2,'123123','123213','2026-02-24','2026-02-24 14:19:00',1,2015277809583300610,'62525','StudentOrgSealApprovalProcess','Èô¢Á´†ÂÆ°ÊâπÔºàÂ≠¶ÁîüÔºâ','Èô¢ÈïøÂÆ°Êâπ','deanApproval',2013951338067615746,'yuanzhang',2,NULL,'2026-02-24 14:19:09','2026-02-24 14:20:22','/api/uploads/pdf/2026/02/24/2c936392-9776-4ea2-8b2a-a551dffefc3d.pdf',2013950942494416897,'2026-02-24 14:19:09',2013950942494416897,'2026-02-24 14:19:09',0),(2026193739770634242,'SA2026193739764523008',2013951215732350978,'banzhuren','banzhuren',2014588235735478273,'Èô¢Á´†ÔºàÁâ©ÁêÜÔºâ',1,1,'12323','1233','2026-02-24','2026-02-24 15:13:26',1,2026181870742532098,'62589','ClassGuideOrgSealApprovalProcess','Èô¢Á´†ÂÆ°ÊâπÔºàÁè≠‰∏ª‰ªªÔºâ','ËæÖÂØºÂëòÂÆ°Êâπ','MentorApproval',2013951264663101441,'fudaoyuan',3,'ÊãíÁªù','2026-02-24 15:13:27','2026-02-24 15:14:09','',2013951215732350978,'2026-02-24 15:13:27',2013951215732350978,'2026-02-24 15:13:27',0);
/*!40000 ALTER TABLE `seal_apply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seal_apply_record`
--

DROP TABLE IF EXISTS `seal_apply_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seal_apply_record` (
  `id` bigint NOT NULL COMMENT '‰∏ªÈîÆID',
  `apply_id` bigint NOT NULL COMMENT 'Áî≥ËØ∑ÂçïID',
  `process_instance_id` varchar(64) NOT NULL COMMENT 'ÊµÅÁ®ãÂÆû‰æãID',
  `task_id` varchar(64) NOT NULL COMMENT '‰ªªÂä°ID',
  `task_name` varchar(128) NOT NULL COMMENT '‰ªªÂä°ÂêçÁß∞',
  `task_key` varchar(64) NOT NULL COMMENT '‰ªªÂä°Key',
  `approval_stage` int NOT NULL COMMENT 'ÂÆ°ÊâπÈò∂ÊÆµÔºà1-Áè≠‰∏ª‰ªªÔºå2-ËæÖÂØºÂëòÔºå3-Â≠¶Èô¢Èô¢ÈïøÔºå4-ÂÖöÂßî‰π¶ËÆ∞Á≠âÔºâ',
  `approver_id` bigint NOT NULL COMMENT 'ÂÆ°Êâπ‰∫∫ID',
  `approver_name` varchar(64) DEFAULT NULL COMMENT 'ÂÆ°Êâπ‰∫∫ÂßìÂêç',
  `approver_role_code` varchar(64) DEFAULT NULL COMMENT 'ÂÆ°Êâπ‰∫∫ËßíËâ≤ÁºñÁ†Å',
  `approver_role_name` varchar(64) DEFAULT NULL COMMENT 'ÂÆ°Êâπ‰∫∫ËßíËâ≤ÂêçÁß∞',
  `approve_result` tinyint DEFAULT NULL COMMENT 'ÂÆ°ÊâπÁªìÊûúÔºà1-ÂêåÊÑèÔºå2-ÊãíÁªùÔºâ',
  `approve_comment` text COMMENT 'ÂÆ°ÊâπÊÑèËßÅ',
  `approve_time` datetime DEFAULT NULL COMMENT 'ÂÆ°ÊâπÊó∂Èó¥',
  `task_start_time` datetime DEFAULT NULL COMMENT '‰ªªÂä°ÂºÄÂßãÊó∂Èó¥',
  `task_end_time` datetime DEFAULT NULL COMMENT '‰ªªÂä°ÁªìÊùüÊó∂Èó¥',
  `create_by` bigint DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0' COMMENT 'ÈÄªËæëÂà†Èô§Ôºà0Êú™Âà†Èô§Ôºå1Â∑≤Âà†Èô§Ôºâ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Âç∞Á´†ÂÆ°ÊâπËÆ∞ÂΩïË°®';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seal_apply_record`
--

LOCK TABLES `seal_apply_record` WRITE;
/*!40000 ALTER TABLE `seal_apply_record` DISABLE KEYS */;
INSERT INTO `seal_apply_record` VALUES (2026179852400730114,2026179755906572290,'62501','62511','Áè≠‰∏ª‰ªªÂÆ°Êâπ','headTeacherApproval',1,2013951215732350978,'banzhuren','headTeacherApproval','',1,'ÂêåÊÑè','2026-02-24 14:18:16','2026-02-24 14:17:53','2026-02-24 14:18:16',2013951215732350978,'2026-02-24 14:18:16',2013951215732350978,'2026-02-24 14:18:16',0),(2026180219377164289,2026180076292677634,'62525','62535','Áè≠‰∏ª‰ªªÂÆ°Êâπ','headTeacherApproval',1,2013951215732350978,'banzhuren','headTeacherApproval','',1,'ÂêåÊÑè','2026-02-24 14:19:44','2026-02-24 14:19:09','2026-02-24 14:19:44',2013951215732350978,'2026-02-24 14:19:44',2013951215732350978,'2026-02-24 14:19:44',0),(2026180317926531074,2026180076292677634,'62525','62545','ËæÖÂØºÂëòÂÆ°Êâπ','counselorApproval',1,2013951264663101441,'fudaoyuan','counselorApproval','',1,'ÂêåÊÑè','2026-02-24 14:20:07','2026-02-24 14:19:44','2026-02-24 14:20:07',2013951264663101441,'2026-02-24 14:20:07',2013951264663101441,'2026-02-24 14:20:07',0),(2026180377947021313,2026180076292677634,'62525','62553','Èô¢ÈïøÂÆ°Êâπ','deanApproval',1,2013951338067615746,'yuanzhang','deanApproval','',1,'ÂêåÊÑè','2026-02-24 14:20:21','2026-02-24 14:20:07','2026-02-24 14:20:21',2013951338067615746,'2026-02-24 14:20:21',2013951338067615746,'2026-02-24 14:20:21',0),(2026193914983489537,2026193739770634242,'62589','62599','ËæÖÂØºÂëòÂÆ°Êâπ','MentorApproval',1,2013951264663101441,'fudaoyuan','MentorApproval','',0,'ÊãíÁªù','2026-02-24 15:14:09','2026-02-24 15:13:27','2026-02-24 15:14:09',2013951264663101441,'2026-02-24 15:14:09',2013951264663101441,'2026-02-24 15:14:09',0),(2056926576791482369,2026179755906572290,'62501','62521','ËæÖÂØºÂëòÂÆ°Êâπ','counselorApproval',1,2013951264663101441,'fudaoyuan','counselorApproval','',1,'ÂêåÊÑè','2026-05-20 10:34:46','2026-02-24 14:18:16','2026-05-20 10:34:46',2013951264663101441,'2026-05-20 10:34:46',2013951264663101441,'2026-05-20 10:34:46',0),(2056926815208304642,2026179755906572290,'62501','65005','Èô¢ÈïøÂÆ°Êâπ','deanApproval',1,2013951338067615746,'yuanzhang','deanApproval','',1,'ÂêåÊÑè','2026-05-20 10:35:43','2026-05-20 10:34:47','2026-05-20 10:35:43',2013951338067615746,'2026-05-20 10:35:43',2013951338067615746,'2026-05-20 10:35:43',0);
/*!40000 ALTER TABLE `seal_apply_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seal_info`
--

DROP TABLE IF EXISTS `seal_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seal_info` (
  `id` bigint NOT NULL COMMENT '‰∏ªÈîÆID',
  `code` varchar(64) NOT NULL COMMENT 'Âç∞Á´†ÁºñÁ†Å',
  `name` varchar(100) NOT NULL COMMENT 'Âç∞Á´†ÂêçÁß∞',
  `category` tinyint DEFAULT '1' COMMENT 'Âç∞Á´†ÂàÜÁ±ªÔºà1-Èô¢Á´†Ôºå2-ÂÖöÁ´†Ôºâ',
  `description` text COMMENT 'Âç∞Á´†ÊèèËø∞',
  `image_url` varchar(500) DEFAULT NULL COMMENT 'Âç∞Á´†ÂõæÁâáURL',
  `seal_type` tinyint DEFAULT '1' COMMENT 'Âç∞Á´†Á±ªÂûãÔºà1-Áâ©ÁêÜÁ´†Ôºå2-ÁîµÂ≠êÁ´†Ôºâ',
  `status` tinyint DEFAULT '1' COMMENT 'Áä∂ÊÄÅÔºà0-ÂÅúÁî®Ôºå1-ÂêØÁî®Ôºâ',
  `create_by` bigint DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0' COMMENT 'ÈÄªËæëÂà†Èô§Ôºà0Êú™Âà†Èô§Ôºå1Â∑≤Âà†Èô§Ôºâ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Âç∞Á´†‰ø°ÊÅØË°®';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seal_info`
--

LOCK TABLES `seal_info` WRITE;
/*!40000 ALTER TABLE `seal_info` DISABLE KEYS */;
INSERT INTO `seal_info` VALUES (2014556241253109762,'1101010010001','ÂÖöÁ´†ÔºàÁîµÂ≠êÔºâ',2,'','/api/uploads/2026/01/25/2991619e-1aa9-47b0-b176-4213c198ab14.png',2,1,2013951423174238210,'2026-02-10 20:31:14',2013951423174238210,'2026-02-10 20:31:23',0),(2014588144287068162,'1101010010002','ÂÖöÁ´†ÔºàÁâ©ÁêÜÔºâ',2,'','/api/uploads/2026/01/25/ebb064cb-53b8-4a72-9f20-f350ef4eac24.png',1,1,2013951423174238210,'2026-02-10 20:31:14',2013951423174238210,'2026-02-10 20:31:23',0),(2014588235735478273,'1101010010003','Èô¢Á´†ÔºàÁâ©ÁêÜÔºâ',1,'','/api/uploads/2026/01/25/6d86a147-de3d-431a-b18b-a3f74b92bf97.png',1,1,2013951423174238210,'2026-02-10 20:31:14',2013951423174238210,'2026-02-10 20:31:23',0),(2014588288638234625,'1101010010004','Èô¢Á´†ÔºàÁîµÂ≠êÔºâ',1,'','/api/uploads/2026/01/25/1b0c2962-cfbf-4015-afec-802cf6f8a4fa.png',2,1,2013951423174238210,'2026-02-10 20:31:14',2013951423174238210,'2026-02-10 20:31:23',0);
/*!40000 ALTER TABLE `seal_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seal_stamp_record`
--

DROP TABLE IF EXISTS `seal_stamp_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seal_stamp_record` (
  `id` bigint NOT NULL COMMENT '‰∏ªÈîÆID',
  `stamp_no` varchar(64) NOT NULL COMMENT 'ÁõñÁ´†ËÆ∞ÂΩïÁºñÂè∑',
  `apply_id` bigint NOT NULL COMMENT 'Áî≥ËØ∑ID',
  `seal_id` bigint NOT NULL COMMENT 'Âç∞Á´†ID',
  `seal_name` varchar(128) NOT NULL COMMENT 'Âç∞Á´†ÂêçÁß∞',
  `stamper_id` bigint NOT NULL COMMENT 'ÁõñÁ´†‰∫∫ID',
  `stamper_name` varchar(64) NOT NULL COMMENT 'ÁõñÁ´†‰∫∫ÂßìÂêç',
  `pdf_url` varchar(512) NOT NULL COMMENT 'PDFÊñá‰ª∂URL',
  `seal_image_url` varchar(512) NOT NULL COMMENT 'Âç∞Á´†ÂõæÁâáURL',
  `stamp_time` datetime NOT NULL COMMENT 'ÁõñÁ´†Êó∂Èó¥',
  `status` tinyint NOT NULL COMMENT 'ÁõñÁ´†Áä∂ÊÄÅÔºà1-ÊàêÂäüÔºå2-Â§±Ë¥•Ôºâ',
  `remark` varchar(255) DEFAULT NULL COMMENT 'Â§áÊ≥®',
  `create_by` bigint DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0' COMMENT 'ÈÄªËæëÂà†Èô§Ôºà0Êú™Âà†Èô§Ôºå1Â∑≤Âà†Èô§Ôºâ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `stamp_no` (`stamp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ÁõñÁ´†ËÆ∞ÂΩïË°®';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seal_stamp_record`
--

LOCK TABLES `seal_stamp_record` WRITE;
/*!40000 ALTER TABLE `seal_stamp_record` DISABLE KEYS */;
INSERT INTO `seal_stamp_record` VALUES (2026180667286888449,'ST17719140903609A2FDC48',2026180076292677634,2014588288638234625,'Èô¢Á´†ÔºàÁîµÂ≠êÔºâ',2013950942494416897,'xuesheng','/api/uploads/pdf/2026/02/24/2c936392-9776-4ea2-8b2a-a551dffefc3d.pdf','/api/uploads/2026/01/25/1b0c2962-cfbf-4015-afec-802cf6f8a4fa.png','2026-02-24 14:21:30',1,'PDFÊñá‰ª∂ÁõñÁ´†',2013950942494416897,'2026-02-24 14:21:30',2013950942494416897,'2026-02-24 14:21:30',0);
/*!40000 ALTER TABLE `seal_stamp_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_permission`
--

DROP TABLE IF EXISTS `sys_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_permission` (
  `id` bigint NOT NULL COMMENT '‰∏ªÈîÆID',
  `code` varchar(64) NOT NULL COMMENT 'ÊùÉÈôêÁºñÁ†Å',
  `name` varchar(64) NOT NULL COMMENT 'ÊùÉÈôêÂêçÁß∞',
  `resource` varchar(255) DEFAULT NULL COMMENT 'ËµÑÊ∫êÊ†áËØÜ',
  `action` varchar(32) DEFAULT NULL COMMENT 'Êìç‰Ωú',
  `type` varchar(32) DEFAULT NULL COMMENT 'Á±ªÂûãÔºàAPI/MENU/BUTTONÔºâ',
  `remark` varchar(255) DEFAULT NULL COMMENT 'Â§áÊ≥®',
  `status` int DEFAULT '1' COMMENT 'Áä∂ÊÄÅÔºà0Á¶ÅÁî®Ôºå1ÂêØÁî®Ôºâ',
  `create_by` bigint DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0' COMMENT 'ÈÄªËæëÂà†Èô§Ôºà0Êú™Âà†Èô§Ôºå1Â∑≤Âà†Èô§Ôºâ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ÊùÉÈôêË°®';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_permission`
--

LOCK TABLES `sys_permission` WRITE;
/*!40000 ALTER TABLE `sys_permission` DISABLE KEYS */;
INSERT INTO `sys_permission` VALUES (2013955349588041730,'system:add','Ê∑ªÂä†(Á≥ªÁªü)','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2013955436607266818,'system:update','Êõ¥Êñ∞(Á≥ªÁªü)','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2013955535781584897,'system:get','Êü•Áúã(Á≥ªÁªü)','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2013955573022810114,'system:delete','Âà†Èô§(Á≥ªÁªü)','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2013955618874941440,'system:list','ÂàóË°®(Á≥ªÁªü)','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2013955618874941442,'system:page','ÂàÜÈ°µ(Á≥ªÁªü)','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2013956054889619457,'normal:page','ÂàÜÈ°µ','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2013956095909912578,'normal:delete','Âà†Èô§','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2013956175916261378,'normal:get','Êü•Áúã','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2013956214394806274,'normal:update','Êõ¥Êñ∞','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2013956270762057730,'normal:add','Ê∑ªÂä†','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2019713674699149313,'normal:list','ÂàóË°®','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2019715289741111297,'system:upload','‰∏ä‰º†(Á≥ªÁªü)','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2019789331751854082,'workflow:deploy','ÈÉ®ÁΩ≤Ê®°Êùø','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2019789603072991233,'workflow:undeploy','ÂèñÊ∂àÈÉ®ÁΩ≤Ê®°Êùø','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2019789703589486594,'workflow:suspend','ÊåÇËµ∑Â∑•‰ΩúÊµÅ','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2019789754797744130,'workflow:activate','ÊøÄÊ¥ªÂ∑•‰ΩúÊµÅ','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2020795773766139905,'system:stamp','Âä†ÁõñÁîµÂ≠êÁ´†','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2021168337944326146,'system:approve','ÂÆ°Êâπ‰ªªÂä°ÔºàÂêåÊÑèÔºâ','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0),(2021168433654149121,'system:reject','ÂÆ°Êâπ‰ªªÂä°ÔºàÊãíÁªùÔºâ','','','API','',1,2013951423174238210,'2026-02-10 20:30:23',2013951423174238210,'2026-02-10 20:30:33',0);
/*!40000 ALTER TABLE `sys_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `id` bigint NOT NULL COMMENT '‰∏ªÈîÆID',
  `code` varchar(64) NOT NULL COMMENT 'ËßíËâ≤ÁºñÁ†Å',
  `name` varchar(64) NOT NULL COMMENT 'ËßíËâ≤ÂêçÁß∞',
  `sort` int DEFAULT '0' COMMENT 'ÊòæÁ§∫È°∫Â∫è',
  `remark` varchar(255) DEFAULT NULL COMMENT 'Â§áÊ≥®',
  `status` int DEFAULT '1' COMMENT 'Áä∂ÊÄÅÔºà0Á¶ÅÁî®Ôºå1ÂêØÁî®Ôºâ',
  `create_by` bigint DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0' COMMENT 'ÈÄªËæëÂà†Èô§Ôºà0Êú™Âà†Èô§Ôºå1Â∑≤Âà†Èô§Ôºâ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ËßíËâ≤Ë°®';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (2013952659101409282,'STUDENT','Â≠¶Áîü',1,'',1,2013951423174238210,'2026-01-21 20:32:09',2013951423174238210,'2026-01-21 20:32:09',0),(2013952715229585409,'CLASSGUIDE','Áè≠‰∏ª‰ªª',2,'',1,2013951423174238210,'2026-01-21 20:32:09',2013951423174238210,'2026-01-21 20:32:09',0),(2013952827238473729,'MENTOR','ËæÖÂØºÂëò',3,'',1,2013951423174238210,'2026-01-21 20:32:09',2013951423174238210,'2026-01-21 20:32:09',0),(2013952886889865217,'DEAN','Â≠¶Èô¢Èô¢Èïø',4,'',1,2013951423174238210,'2026-01-21 20:32:09',2013951423174238210,'2026-01-21 20:32:09',0),(2013952940048474113,'PARTYSECRETARY','ÂÖöÂßî‰π¶ËÆ∞',5,'',1,2013951423174238210,'2026-01-21 20:32:09',2013951423174238210,'2026-01-21 20:32:09',0),(2014219081111072769,'ADMIN','ÁÆ°ÁêÜÂëò',6,'',1,2013951423174238210,'2026-01-21 20:32:09',2013951423174238210,'2026-01-21 20:32:09',0);
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_permission`
--

DROP TABLE IF EXISTS `sys_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_permission` (
  `id` bigint NOT NULL COMMENT '‰∏ªÈîÆID',
  `role_id` bigint NOT NULL COMMENT 'ËßíËâ≤ID',
  `permission_id` bigint NOT NULL COMMENT 'ÊùÉÈôêID',
  `create_by` bigint DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0' COMMENT 'ÈÄªËæëÂà†Èô§Ôºà0Êú™Âà†Èô§Ôºå1Â∑≤Âà†Èô§Ôºâ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ËßíËâ≤ÊùÉÈôêÂÖ≥ËÅîË°®';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_permission`
--

LOCK TABLES `sys_role_permission` WRITE;
/*!40000 ALTER TABLE `sys_role_permission` DISABLE KEYS */;
INSERT INTO `sys_role_permission` VALUES (2020515552752054274,2014219081111072769,2013955349588041730,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020515552752054275,2014219081111072769,2013955436607266818,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020515552752054276,2014219081111072769,2013955535781584897,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020515552752054277,2014219081111072769,2013955573022810114,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020515552752054278,2014219081111072769,2013955618874941440,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020515552752054279,2014219081111072769,2013955618874941442,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020515552810774529,2014219081111072769,2019715289741111297,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020515552810774530,2014219081111072769,2019789331751854082,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020515552810774531,2014219081111072769,2019789603072991233,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020515552810774532,2014219081111072769,2019789703589486594,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020515552810774533,2014219081111072769,2019789754797744130,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020796289636171778,2013952659101409282,2013956054889619457,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020796289636171779,2013952659101409282,2013956095909912578,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020796289703280641,2013952659101409282,2013956175916261378,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020796289703280642,2013952659101409282,2013956214394806274,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020796289703280643,2013952659101409282,2013956270762057730,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020796289703280644,2013952659101409282,2019713674699149313,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020796289703280645,2013952659101409282,2019715289741111297,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2020796289703280646,2013952659101409282,2020795773766139905,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168544341831681,2013952886889865217,2013956054889619457,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168544341831682,2013952886889865217,2013956095909912578,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168544341831683,2013952886889865217,2013956175916261378,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168544341831684,2013952886889865217,2013956214394806274,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168544341831685,2013952886889865217,2013956270762057730,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168544341831686,2013952886889865217,2019713674699149313,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168544341831687,2013952886889865217,2021168337944326146,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168544341831688,2013952886889865217,2021168433654149121,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168590307209218,2013952715229585409,2013956054889619457,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168590307209219,2013952715229585409,2013956095909912578,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168590307209220,2013952715229585409,2013956175916261378,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168590374318082,2013952715229585409,2013956214394806274,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168590374318083,2013952715229585409,2013956270762057730,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168590374318084,2013952715229585409,2019713674699149313,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168590374318085,2013952715229585409,2019715289741111297,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168590374318086,2013952715229585409,2020795773766139905,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168590374318087,2013952715229585409,2021168337944326146,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168590374318088,2013952715229585409,2021168433654149121,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168627489714177,2013952827238473729,2013956054889619457,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168627489714178,2013952827238473729,2013956095909912578,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168627489714179,2013952827238473729,2013956175916261378,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168627489714180,2013952827238473729,2013956214394806274,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168627556823041,2013952827238473729,2013956270762057730,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168627556823042,2013952827238473729,2019713674699149313,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168627556823043,2013952827238473729,2021168337944326146,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168627556823044,2013952827238473729,2021168433654149121,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168675506106369,2013952940048474113,2013956054889619457,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168675506106370,2013952940048474113,2013956095909912578,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168675506106371,2013952940048474113,2013956175916261378,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168675506106372,2013952940048474113,2013956214394806274,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168675573215234,2013952940048474113,2013956270762057730,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168675573215235,2013952940048474113,2019713674699149313,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168675573215236,2013952940048474113,2021168337944326146,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0),(2021168675573215237,2013952940048474113,2021168433654149121,2013951423174238210,'2026-02-10 20:29:41',2013951423174238210,'2026-02-10 20:29:57',0);
/*!40000 ALTER TABLE `sys_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `id` bigint NOT NULL COMMENT '‰∏ªÈîÆID',
  `username` varchar(64) NOT NULL COMMENT 'Â≠¶Âè∑',
  `password` varchar(255) NOT NULL COMMENT 'ÂØÜÁ†ÅÂìàÂ∏å',
  `real_name` varchar(64) DEFAULT NULL COMMENT 'ÁúüÂÆûÂßìÂêç',
  `email` varchar(128) DEFAULT NULL COMMENT 'ÈÇÆÁÆ±',
  `phone` varchar(32) DEFAULT NULL COMMENT 'ÊâãÊú∫Âè∑',
  `avatar` varchar(255) DEFAULT NULL COMMENT 'Â§¥ÂÉèURL',
  `gender` tinyint DEFAULT '0' COMMENT 'ÊÄßÂà´Ôºà0-Êú™Áü•Ôºå1-Áî∑Ôºå2-Â•≥Ôºâ',
  `birthday` date DEFAULT NULL COMMENT 'ÁîüÊó•',
  `introduction` text COMMENT '‰∏™‰∫∫ÁÆÄ‰ªã',
  `status` tinyint DEFAULT '1' COMMENT 'Áä∂ÊÄÅÔºà0Á¶ÅÁî®Ôºå1ÂêØÁî®Ôºâ',
  `create_by` bigint DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0' COMMENT 'ÈÄªËæëÂà†Èô§Ôºà0Êú™Âà†Èô§Ôºå1Â∑≤Âà†Èô§Ôºâ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Á≥ªÁªüÁî®Êà∑Ë°®';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (2013950942494416897,'xuesheng','$2a$10$MPGLocbjfB/ybaMhq16jKOIcsTgJbo7v44aOkd3SXTmxKS7Zv61OG','xuesheng','xuesheng@demo.edu.cn','15984562154','',1,NULL,'',1,NULL,NULL,NULL,NULL,0),(2013951215732350978,'banzhuren','$2a$10$X66B6LuE.0CoASxdsb9UjeI/jwT8nwQBRKNukkFKG71.a1kavjdXS','banzhuren','banzhuren@demo.edu.cn','18545846253','',2,NULL,'',1,NULL,NULL,NULL,NULL,0),(2013951264663101441,'fudaoyuan','$2a$10$fa6ILEQuYyOXXDFFm9N5LOt.FSeijSOmYOiRpuSiCtf1rDbxQUDtW','fudaoyuan','fudaoyuan@demo.edu.cn','18596532562','',1,NULL,'',1,NULL,NULL,NULL,NULL,0),(2013951338067615746,'yuanzhang','$2a$10$mKZ5wk5ozrPe/Gr60JXzlOBHTE0B4Lal.xu2X7ac2wTn1RjJ4ye6q','yuanzhang','yuanzhang@demo.edu.cn','15748653256','',1,NULL,'',1,NULL,NULL,NULL,NULL,0),(2013951382959251457,'shuji','$2a$10$NvB2dB9hFHV0FauPmj5LhuDqN5081lDnmrQuR14kW2Uqb6qIfVhXe','shuji','shuji@demo.edu.cn','15845243652','',1,NULL,'',1,NULL,NULL,NULL,NULL,0),(2013951423174238210,'admin','$2a$10$.yyBzUQnKU5/4f8s/074L./80Jq6Dq4GrzJ075c2luXKg685blNc.','admin','admin@demo.edu.cn','15854251453','',1,NULL,'',1,NULL,NULL,NULL,NULL,0),(2014227995089248257,'123','$2a$10$syL6NKSMSqWNLT14vri9Y./3sKgxm6.CGiPJ4Q7bDHs/cdIwq9y3q','123','123@test.com','15845243652',NULL,1,NULL,NULL,1,NULL,NULL,NULL,NULL,0),(2014228067868811265,'12312','$2a$10$kfElY4Cjd1DLrLB9dav/.uA1lTcPL0D7wyQ/V71thzzT5iOM5lCFa','122313','123@test.com','15845243652',NULL,1,NULL,NULL,1,NULL,NULL,NULL,NULL,0),(2014228155601068033,'321','$2a$10$2DRRQlFf1G7raAxYiHLJH.Dl9LyAhIhDFtsF8ly6xnmpGgXjVQTnO','13213','123@test.com','15845243652',NULL,1,NULL,NULL,1,NULL,NULL,NULL,NULL,0),(2014228288002662401,'32112','$2a$10$8g2IwFQbudlEDWoyvYVO2etYG4KbeuP6Mr7jHXe3dnBFa/8lC/7Vy','12312','123@test.com','15845243652',NULL,1,NULL,NULL,1,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `id` bigint NOT NULL COMMENT '‰∏ªÈîÆID',
  `user_id` bigint NOT NULL COMMENT 'Áî®Êà∑ID',
  `role_id` bigint NOT NULL COMMENT 'ËßíËâ≤ID',
  `create_by` bigint DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0' COMMENT 'ÈÄªËæëÂà†Èô§Ôºà0Êú™Âà†Èô§Ôºå1Â∑≤Âà†Èô§Ôºâ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Áî®Êà∑ËßíËâ≤ÂÖ≥ËÅîË°®';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (2014218668211204098,2013951382959251457,2013952940048474113,2013951423174238210,'2026-02-10 20:28:34',2013951423174238210,'2026-02-10 20:28:48',0),(2014219275143770113,2013951423174238210,2014219081111072769,2013951423174238210,'2026-02-10 20:28:34',2013951423174238210,'2026-02-10 20:28:48',0),(2014219387840524290,2013951215732350978,2013952715229585409,2013951423174238210,'2026-02-10 20:28:34',2013951423174238210,'2026-02-10 20:28:48',0),(2014219505419448322,2013951338067615746,2013952886889865217,2013951423174238210,'2026-02-10 20:28:34',2013951423174238210,'2026-02-10 20:28:48',0),(2014219821082767361,2013951264663101441,2013952827238473729,2013951423174238210,'2026-02-10 20:28:34',2013951423174238210,'2026-02-10 20:28:48',0),(2014240391090479105,2014228234974076929,2013952659101409282,2013951423174238210,'2026-02-10 20:28:34',2013951423174238210,'2026-02-10 20:28:48',0),(2014240401341358081,2014228155601068033,2013952659101409282,2013951423174238210,'2026-02-10 20:28:34',2013951423174238210,'2026-02-10 20:28:48',0),(2014240411969724417,2014228067868811265,2013952659101409282,2013951423174238210,'2026-02-10 20:28:34',2013951423174238210,'2026-02-10 20:28:48',0),(2014240432140132353,2014228288002662401,2013952659101409282,2013951423174238210,'2026-02-10 20:28:34',2013951423174238210,'2026-02-10 20:28:48',0),(2014363096700702721,2013950942494416897,2013952659101409282,2013951423174238210,'2026-02-10 20:28:34',2013951423174238210,'2026-02-10 20:28:48',0),(2015717059143405570,2014227995089248257,2013952659101409282,2013951423174238210,'2026-02-10 20:28:34',2013951423174238210,'2026-02-10 20:28:48',0),(2019749943974121474,2019749762771800066,2014219081111072769,2013951423174238210,'2026-02-10 20:28:34',2013951423174238210,'2026-02-10 20:28:48',0),(2021178921448468482,2021178921381359618,2014219081111072769,2013951423174238210,'2026-02-10 20:28:34',2013951423174238210,'2026-02-10 20:28:48',0),(2021582673733017601,2021582673644937218,2013952659101409282,NULL,'2026-02-11 21:50:43',NULL,'2026-02-11 21:50:43',0);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow_template`
--

DROP TABLE IF EXISTS `workflow_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workflow_template` (
  `id` bigint NOT NULL COMMENT '‰∏ªÈîÆID',
  `name` varchar(128) NOT NULL COMMENT 'Ê®°ÊùøÂêçÁß∞',
  `description` text COMMENT 'Ê®°ÊùøÊèèËø∞',
  `process_key` varchar(64) NOT NULL COMMENT 'FlowableÊµÅÁ®ãÂÆö‰πâKey',
  `bpmn_xml` longtext NOT NULL COMMENT 'BPMN XMLÂÜÖÂÆπ',
  `deployed` tinyint DEFAULT '0' COMMENT 'ÊòØÂê¶Â∑≤ÈÉ®ÁΩ≤Ôºà0-Âê¶Ôºå1-ÊòØÔºâ',
  `process_definition_id` varchar(64) DEFAULT NULL COMMENT 'FlowableÊµÅÁ®ãÂÆö‰πâID',
  `allowed_roles` text COMMENT 'ÂÖÅËÆ∏ÂèëËµ∑ÁöÑËßíËâ≤IDÂàóË°®ÔºàJSONÊï∞ÁªÑÔºâ',
  `seal_category` tinyint DEFAULT NULL COMMENT 'Âç∞Á´†ÂàÜÁ±ªÔºà1-Èô¢Á´†Ôºå2-ÂÖöÁ´†Ôºâ',
  `status` tinyint DEFAULT '1' COMMENT 'Áä∂ÊÄÅÔºà0-Á¶ÅÁî®Ôºå1-ÂêØÁî®Ôºâ',
  `create_by` bigint DEFAULT '0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0' COMMENT 'ÈÄªËæëÂà†Èô§Ôºà0Êú™Âà†Èô§Ôºå1Â∑≤Âà†Èô§Ôºâ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `process_key` (`process_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Â∑•‰ΩúÊµÅÊ®°ÊùøË°®';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_template`
--

LOCK TABLES `workflow_template` WRITE;
/*!40000 ALTER TABLE `workflow_template` DISABLE KEYS */;
INSERT INTO `workflow_template` VALUES (2015277809583300610,'Èô¢Á´†ÂÆ°ÊâπÔºàÂ≠¶ÁîüÔºâ','Â≠¶Áîü‰ΩøÁî®Èô¢Á´†ÁöÑÂÆ°ÊâπÊµÅ','StudentOrgSealApprovalProcess','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" xmlns:flowable=\"http://flowable.org/bpmn\" targetNamespace=\"http://www.flowable.org/processdef\">\n  <process id=\"StudentOrgSealApprovalProcess\" name=\"Èô¢Á´†ÂÆ°ÊâπÔºàÂ≠¶ÁîüÔºâ\" isExecutable=\"true\">\n    <startEvent id=\"StartEvent_1\" name=\"ÂºÄÂßã\">\n      <outgoing>Flow_1gtutt3</outgoing>\n    </startEvent>\n    <userTask id=\"headTeacherApproval\" name=\"Áè≠‰∏ª‰ªªÂÆ°Êâπ\" flowable:candidateGroups=\"2013952715229585409\" flowable:assignee=\"2013951215732350978\">\n      <incoming>Flow_1gtutt3</incoming>\n      <outgoing>Flow_1ln9kdp</outgoing>\n    </userTask>\n    <userTask id=\"counselorApproval\" name=\"ËæÖÂØºÂëòÂÆ°Êâπ\" flowable:candidateGroups=\"2013952827238473729\" flowable:assignee=\"2013951264663101441\">\n      <incoming>Flow_1f887dt</incoming>\n      <outgoing>Flow_096picz</outgoing>\n    </userTask>\n    <endEvent id=\"EndEvent_1\" name=\"ÂêåÊÑè\">\n      <incoming>Flow_0piie6u</incoming>\n    </endEvent>\n    <userTask id=\"deanApproval\" name=\"Èô¢ÈïøÂÆ°Êâπ\" flowable:candidateGroups=\"2013952886889865217\" flowable:assignee=\"2013951338067615746\">\n      <incoming>Flow_1bf6tjw</incoming>\n      <outgoing>Flow_179uijp</outgoing>\n    </userTask>\n    <sequenceFlow id=\"Flow_179uijp\" sourceRef=\"deanApproval\" targetRef=\"Gateway_dean\" />\n    <exclusiveGateway id=\"Gateway_headTeacher\" name=\"Áè≠‰∏ª‰ªªÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_1ln9kdp</incoming>\n      <outgoing>Flow_1qajers</outgoing>\n      <outgoing>Flow_1f887dt</outgoing>\n    </exclusiveGateway>\n    <exclusiveGateway id=\"Gateway_counselor\" name=\"ËæÖÂØºÂëòÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_096picz</incoming>\n      <outgoing>Flow_1bf6tjw</outgoing>\n      <outgoing>Flow_06phn3v</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_1bf6tjw\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_counselor\" targetRef=\"deanApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <exclusiveGateway id=\"Gateway_dean\" name=\"Èô¢ÈïøÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_179uijp</incoming>\n      <outgoing>Flow_0piie6u</outgoing>\n      <outgoing>Flow_0hf6ise</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_0piie6u\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_dean\" targetRef=\"EndEvent_1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <endEvent id=\"Event_00f37w1\" name=\"ÊãíÁªù\">\n      <incoming>Flow_1qajers</incoming>\n      <incoming>Flow_06phn3v</incoming>\n      <incoming>Flow_0hf6ise</incoming>\n    </endEvent>\n    <sequenceFlow id=\"Flow_1qajers\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_headTeacher\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_06phn3v\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_counselor\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_0hf6ise\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_dean\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_1gtutt3\" sourceRef=\"StartEvent_1\" targetRef=\"headTeacherApproval\" />\n    <sequenceFlow id=\"Flow_1ln9kdp\" sourceRef=\"headTeacherApproval\" targetRef=\"Gateway_headTeacher\" />\n    <sequenceFlow id=\"Flow_1f887dt\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_headTeacher\" targetRef=\"counselorApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_096picz\" sourceRef=\"counselorApproval\" targetRef=\"Gateway_counselor\" />\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_1\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_1\" bpmnElement=\"StudentOrgSealApprovalProcess\">\n      <bpmndi:BPMNEdge id=\"Flow_096picz_di\" bpmnElement=\"Flow_096picz\">\n        <omgdi:waypoint x=\"530\" y=\"178\" />\n        <omgdi:waypoint x=\"575\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1f887dt_di\" bpmnElement=\"Flow_1f887dt\">\n        <omgdi:waypoint x=\"395\" y=\"178\" />\n        <omgdi:waypoint x=\"430\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"402\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1ln9kdp_di\" bpmnElement=\"Flow_1ln9kdp\">\n        <omgdi:waypoint x=\"310\" y=\"178\" />\n        <omgdi:waypoint x=\"345\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1gtutt3_di\" bpmnElement=\"Flow_1gtutt3\">\n        <omgdi:waypoint x=\"168\" y=\"178\" />\n        <omgdi:waypoint x=\"210\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0hf6ise_di\" bpmnElement=\"Flow_0hf6ise\">\n        <omgdi:waypoint x=\"840\" y=\"203\" />\n        <omgdi:waypoint x=\"840\" y=\"270\" />\n        <omgdi:waypoint x=\"618\" y=\"270\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"844\" y=\"234\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_06phn3v_di\" bpmnElement=\"Flow_06phn3v\">\n        <omgdi:waypoint x=\"600\" y=\"203\" />\n        <omgdi:waypoint x=\"600\" y=\"252\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"604\" y=\"225\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1qajers_di\" bpmnElement=\"Flow_1qajers\">\n        <omgdi:waypoint x=\"370\" y=\"203\" />\n        <omgdi:waypoint x=\"370\" y=\"270\" />\n        <omgdi:waypoint x=\"582\" y=\"270\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"374\" y=\"234\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0piie6u_di\" bpmnElement=\"Flow_0piie6u\">\n        <omgdi:waypoint x=\"865\" y=\"178\" />\n        <omgdi:waypoint x=\"912\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"878\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1bf6tjw_di\" bpmnElement=\"Flow_1bf6tjw\">\n        <omgdi:waypoint x=\"625\" y=\"178\" />\n        <omgdi:waypoint x=\"670\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"637\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_179uijp_di\" bpmnElement=\"Flow_179uijp\">\n        <omgdi:waypoint x=\"770\" y=\"178\" />\n        <omgdi:waypoint x=\"815\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNShape id=\"_BPMNShape_StartEvent_2\" bpmnElement=\"StartEvent_1\">\n        <omgdc:Bounds x=\"132\" y=\"160\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"141\" y=\"203\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_1\" bpmnElement=\"headTeacherApproval\">\n        <omgdc:Bounds x=\"210\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_2\" bpmnElement=\"counselorApproval\">\n        <omgdc:Bounds x=\"430\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_EndEvent_1\" bpmnElement=\"EndEvent_1\">\n        <omgdc:Bounds x=\"912\" y=\"160\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"921\" y=\"203\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_1gx0z7o_di\" bpmnElement=\"deanApproval\">\n        <omgdc:Bounds x=\"670\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1078bu6_di\" bpmnElement=\"Gateway_headTeacher\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"345\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"332\" y=\"123\" width=\"77\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1mawix4_di\" bpmnElement=\"Gateway_counselor\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"575\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"562\" y=\"123\" width=\"77\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_0orv4am_di\" bpmnElement=\"Gateway_dean\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"815\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"807\" y=\"123\" width=\"66\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Event_00f37w1_di\" bpmnElement=\"Event_00f37w1\">\n        <omgdc:Bounds x=\"582\" y=\"252\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"589\" y=\"295\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>\n',1,'StudentOrgSealApprovalProcess:1:77508','[2013952659101409282]',1,1,2013951423174238210,'2026-02-10 20:37:38',2013951423174238210,'2026-02-24 14:36:35',0),(2015277809583300611,'ÂÖöÁ´†ÂÆ°ÊâπÔºàÂ≠¶ÁîüÔºâ','Â≠¶Áîü‰ΩøÁî®ÂÖöÁ´†ÁöÑÂÆ°ÊâπÊµÅ','StudentPartySealApprovalProcess','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" xmlns:flowable=\"http://flowable.org/bpmn\" targetNamespace=\"http://www.flowable.org/processdef\">\n  <process id=\"StudentPartySealApprovalProcess\" name=\"ÂÖöÁ´†ÂÆ°ÊâπÔºàÂ≠¶ÁîüÔºâ\" isExecutable=\"true\">\n    <startEvent id=\"StartEvent_1\" name=\"ÂºÄÂßã\">\n      <outgoing>Flow_1gtutt3</outgoing>\n    </startEvent>\n    <userTask id=\"headTeacherApproval\" name=\"Áè≠‰∏ª‰ªªÂÆ°Êâπ\" flowable:candidateGroups=\"2013952715229585409\" flowable:assignee=\"2013951215732350978\">\n      <incoming>Flow_1gtutt3</incoming>\n      <outgoing>Flow_1ln9kdp</outgoing>\n    </userTask>\n    <userTask id=\"counselorApproval\" name=\"ËæÖÂØºÂëòÂÆ°Êâπ\" flowable:candidateGroups=\"2013952827238473729\" flowable:assignee=\"2013951264663101441\">\n      <incoming>Flow_1f887dt</incoming>\n      <outgoing>Flow_096picz</outgoing>\n    </userTask>\n    <endEvent id=\"EndEvent_1\" name=\"ÂêåÊÑè\">\n      <incoming>Flow_1ggs0xd</incoming>\n    </endEvent>\n    <userTask id=\"deanApproval\" name=\"Èô¢ÈïøÂÆ°Êâπ\" flowable:candidateGroups=\"2013952886889865217\" flowable:assignee=\"2013951338067615746\">\n      <incoming>Flow_1bf6tjw</incoming>\n      <outgoing>Flow_179uijp</outgoing>\n    </userTask>\n    <sequenceFlow id=\"Flow_179uijp\" sourceRef=\"deanApproval\" targetRef=\"Gateway_dean\" />\n    <exclusiveGateway id=\"Gateway_headTeacher\" name=\"Áè≠‰∏ª‰ªªÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_1ln9kdp</incoming>\n      <outgoing>Flow_1qajers</outgoing>\n      <outgoing>Flow_1f887dt</outgoing>\n    </exclusiveGateway>\n    <exclusiveGateway id=\"Gateway_counselor\" name=\"ËæÖÂØºÂëòÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_096picz</incoming>\n      <outgoing>Flow_1bf6tjw</outgoing>\n      <outgoing>Flow_06phn3v</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_1bf6tjw\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_counselor\" targetRef=\"deanApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <exclusiveGateway id=\"Gateway_dean\" name=\"Èô¢ÈïøÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_179uijp</incoming>\n      <outgoing>Flow_0piie6u</outgoing>\n      <outgoing>Flow_0hf6ise</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_0piie6u\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_dean\" targetRef=\"partySecretaryApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <endEvent id=\"Event_00f37w1\" name=\"ÊãíÁªù\">\n      <incoming>Flow_1qajers</incoming>\n      <incoming>Flow_06phn3v</incoming>\n      <incoming>Flow_0hf6ise</incoming>\n      <incoming>Flow_0vv7g2n</incoming>\n    </endEvent>\n    <sequenceFlow id=\"Flow_1qajers\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_headTeacher\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_06phn3v\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_counselor\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_0hf6ise\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_dean\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_1gtutt3\" sourceRef=\"StartEvent_1\" targetRef=\"headTeacherApproval\" />\n    <sequenceFlow id=\"Flow_1ln9kdp\" sourceRef=\"headTeacherApproval\" targetRef=\"Gateway_headTeacher\" />\n    <sequenceFlow id=\"Flow_1f887dt\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_headTeacher\" targetRef=\"counselorApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_096picz\" sourceRef=\"counselorApproval\" targetRef=\"Gateway_counselor\" />\n    <userTask id=\"partySecretaryApproval\" name=\"ÂÖöÂßî‰π¶ËÆ∞ÂÆ°Êâπ\" flowable:candidateGroups=\"2013952940048474113\" flowable:assignee=\"2013951382959251457\">\n      <incoming>Flow_0piie6u</incoming>\n      <outgoing>Flow_1prc4yx</outgoing>\n    </userTask>\n    <sequenceFlow id=\"Flow_1prc4yx\" sourceRef=\"partySecretaryApproval\" targetRef=\"Gateway_partySecretary\" />\n    <exclusiveGateway id=\"Gateway_partySecretary\" name=\"ÂÖöÂßî‰π¶ËÆ∞ÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_1prc4yx</incoming>\n      <outgoing>Flow_1ggs0xd</outgoing>\n      <outgoing>Flow_0vv7g2n</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_1ggs0xd\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_partySecretary\" targetRef=\"EndEvent_1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_0vv7g2n\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_partySecretary\" targetRef=\"Event_00f37w1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_1\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_1\" bpmnElement=\"StudentPartySealApprovalProcess\">\n      <bpmndi:BPMNEdge id=\"Flow_0vv7g2n_di\" bpmnElement=\"Flow_0vv7g2n\">\n        <omgdi:waypoint x=\"1120\" y=\"445\" />\n        <omgdi:waypoint x=\"1120\" y=\"520\" />\n        <omgdi:waypoint x=\"788\" y=\"520\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"1124\" y=\"481\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1ggs0xd_di\" bpmnElement=\"Flow_1ggs0xd\">\n        <omgdi:waypoint x=\"1145\" y=\"420\" />\n        <omgdi:waypoint x=\"1192\" y=\"420\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"1152\" y=\"402\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1prc4yx_di\" bpmnElement=\"Flow_1prc4yx\">\n        <omgdi:waypoint x=\"1060\" y=\"420\" />\n        <omgdi:waypoint x=\"1095\" y=\"420\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_096picz_di\" bpmnElement=\"Flow_096picz\">\n        <omgdi:waypoint x=\"590\" y=\"420\" />\n        <omgdi:waypoint x=\"625\" y=\"420\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1f887dt_di\" bpmnElement=\"Flow_1f887dt\">\n        <omgdi:waypoint x=\"455\" y=\"420\" />\n        <omgdi:waypoint x=\"490\" y=\"420\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"449\" y=\"402\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1ln9kdp_di\" bpmnElement=\"Flow_1ln9kdp\">\n        <omgdi:waypoint x=\"370\" y=\"420\" />\n        <omgdi:waypoint x=\"405\" y=\"420\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1gtutt3_di\" bpmnElement=\"Flow_1gtutt3\">\n        <omgdi:waypoint x=\"238\" y=\"420\" />\n        <omgdi:waypoint x=\"270\" y=\"420\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0hf6ise_di\" bpmnElement=\"Flow_0hf6ise\">\n        <omgdi:waypoint x=\"890\" y=\"445\" />\n        <omgdi:waypoint x=\"890\" y=\"520\" />\n        <omgdi:waypoint x=\"788\" y=\"520\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"894\" y=\"481\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_06phn3v_di\" bpmnElement=\"Flow_06phn3v\">\n        <omgdi:waypoint x=\"650\" y=\"445\" />\n        <omgdi:waypoint x=\"650\" y=\"520\" />\n        <omgdi:waypoint x=\"752\" y=\"520\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"699\" y=\"498\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1qajers_di\" bpmnElement=\"Flow_1qajers\">\n        <omgdi:waypoint x=\"430\" y=\"445\" />\n        <omgdi:waypoint x=\"430\" y=\"520\" />\n        <omgdi:waypoint x=\"752\" y=\"520\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"434\" y=\"481\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0piie6u_di\" bpmnElement=\"Flow_0piie6u\">\n        <omgdi:waypoint x=\"915\" y=\"420\" />\n        <omgdi:waypoint x=\"960\" y=\"420\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"919\" y=\"402\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1bf6tjw_di\" bpmnElement=\"Flow_1bf6tjw\">\n        <omgdi:waypoint x=\"675\" y=\"420\" />\n        <omgdi:waypoint x=\"730\" y=\"420\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"694\" y=\"402\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_179uijp_di\" bpmnElement=\"Flow_179uijp\">\n        <omgdi:waypoint x=\"830\" y=\"420\" />\n        <omgdi:waypoint x=\"865\" y=\"420\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNShape id=\"_BPMNShape_StartEvent_2\" bpmnElement=\"StartEvent_1\">\n        <omgdc:Bounds x=\"202\" y=\"402\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"211\" y=\"445\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_1\" bpmnElement=\"headTeacherApproval\">\n        <omgdc:Bounds x=\"270\" y=\"380\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_2\" bpmnElement=\"counselorApproval\">\n        <omgdc:Bounds x=\"490\" y=\"380\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_EndEvent_1\" bpmnElement=\"EndEvent_1\">\n        <omgdc:Bounds x=\"1192\" y=\"402\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"1201\" y=\"445\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_1gx0z7o_di\" bpmnElement=\"deanApproval\">\n        <omgdc:Bounds x=\"730\" y=\"380\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1078bu6_di\" bpmnElement=\"Gateway_headTeacher\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"405\" y=\"395\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"391.5\" y=\"371\" width=\"77\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1mawix4_di\" bpmnElement=\"Gateway_counselor\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"625\" y=\"395\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"612\" y=\"365\" width=\"77\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_0orv4am_di\" bpmnElement=\"Gateway_dean\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"865\" y=\"395\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"857\" y=\"371\" width=\"66\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Event_00f37w1_di\" bpmnElement=\"Event_00f37w1\">\n        <omgdc:Bounds x=\"752\" y=\"502\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"759\" y=\"545\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_0m324d5_di\" bpmnElement=\"partySecretaryApproval\">\n        <omgdc:Bounds x=\"960\" y=\"380\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_0m4br8x_di\" bpmnElement=\"Gateway_partySecretary\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"1095\" y=\"395\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"1076\" y=\"365\" width=\"88\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>\n',1,'StudentPartySealApprovalProcess:1:57508','[2013952659101409282]',2,1,2013951423174238210,'2026-02-10 20:37:38',2013951423174238210,'2026-02-10 20:37:42',0),(2026181870742532098,'Èô¢Á´†ÂÆ°ÊâπÔºàÁè≠‰∏ª‰ªªÔºâ','Áè≠‰∏ª‰ªª‰ΩøÁî®Èô¢Á´†ÁöÑÂÆ°ÊâπÊµÅ','ClassGuideOrgSealApprovalProcess','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" xmlns:flowable=\"http://flowable.org/bpmn\" targetNamespace=\"http://www.flowable.org/processdef\">\n  <process id=\"ClassGuideOrgSealApprovalProcess\" name=\"Èô¢Á´†ÂÆ°ÊâπÔºàÁè≠‰∏ª‰ªªÔºâ\" isExecutable=\"true\">\n    <startEvent id=\"StartEvent_1\" name=\"ÂºÄÂßã\" />\n    <userTask id=\"MentorApproval\" name=\"ËæÖÂØºÂëòÂÆ°Êâπ\" flowable:candidateGroups=\"2013952827238473729\" flowable:assignee=\"2013951264663101441\" />\n    <sequenceFlow id=\"Flow_1\" sourceRef=\"StartEvent_1\" targetRef=\"MentorApproval\" />\n    <userTask id=\"DeanApproval\" name=\"Èô¢ÈïøÂÆ°Êâπ\" flowable:candidateGroups=\"2013952886889865217\" flowable:assignee=\"2013951338067615746\">\n      <incoming>Flow_16w6q12</incoming>\n    </userTask>\n    <sequenceFlow id=\"Flow_2\" sourceRef=\"MentorApproval\" targetRef=\"Gateway_Mentor\" />\n    <endEvent id=\"EndEvent_1\" name=\"ÈÄöËøá\">\n      <incoming>Flow_1sl0y8q</incoming>\n    </endEvent>\n    <sequenceFlow id=\"Flow_3\" sourceRef=\"DeanApproval\" targetRef=\"Gateway_Dean\" />\n    <exclusiveGateway id=\"Gateway_Mentor\" name=\"ËæÖÂØºÂëòÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_2</incoming>\n      <outgoing>Flow_16w6q12</outgoing>\n      <outgoing>Flow_1ymr9po</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_16w6q12\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_Mentor\" targetRef=\"DeanApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <exclusiveGateway id=\"Gateway_Dean\" name=\"Èô¢ÈïøÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_3</incoming>\n      <outgoing>Flow_1sl0y8q</outgoing>\n      <outgoing>Flow_0n9myw1</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_1sl0y8q\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_Dean\" targetRef=\"EndEvent_1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <endEvent id=\"Event_0t3anyf\" name=\"ÊãíÁªù\">\n      <incoming>Flow_1ymr9po</incoming>\n      <incoming>Flow_0n9myw1</incoming>\n    </endEvent>\n    <sequenceFlow id=\"Flow_1ymr9po\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_Mentor\" targetRef=\"Event_0t3anyf\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_0n9myw1\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_Dean\" targetRef=\"Event_0t3anyf\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_1\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_1\" bpmnElement=\"ClassGuideOrgSealApprovalProcess\">\n      <bpmndi:BPMNEdge id=\"Flow_0n9myw1_di\" bpmnElement=\"Flow_0n9myw1\">\n        <omgdi:waypoint x=\"700\" y=\"203\" />\n        <omgdi:waypoint x=\"700\" y=\"280\" />\n        <omgdi:waypoint x=\"588\" y=\"280\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"704\" y=\"239\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1ymr9po_di\" bpmnElement=\"Flow_1ymr9po\">\n        <omgdi:waypoint x=\"450\" y=\"203\" />\n        <omgdi:waypoint x=\"450\" y=\"280\" />\n        <omgdi:waypoint x=\"552\" y=\"280\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"454\" y=\"239\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1sl0y8q_di\" bpmnElement=\"Flow_1sl0y8q\">\n        <omgdi:waypoint x=\"725\" y=\"178\" />\n        <omgdi:waypoint x=\"782\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"743\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_16w6q12_di\" bpmnElement=\"Flow_16w6q12\">\n        <omgdi:waypoint x=\"475\" y=\"178\" />\n        <omgdi:waypoint x=\"520\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"487\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_Flow_3\" bpmnElement=\"Flow_3\">\n        <omgdi:waypoint x=\"620\" y=\"178\" />\n        <omgdi:waypoint x=\"675\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_Flow_2\" bpmnElement=\"Flow_2\">\n        <omgdi:waypoint x=\"380\" y=\"178\" />\n        <omgdi:waypoint x=\"425\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_Flow_1\" bpmnElement=\"Flow_1\">\n        <omgdi:waypoint x=\"216\" y=\"178\" />\n        <omgdi:waypoint x=\"280\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNShape id=\"_BPMNShape_StartEvent_2\" bpmnElement=\"StartEvent_1\">\n        <omgdc:Bounds x=\"180\" y=\"160\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"189\" y=\"203\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_1\" bpmnElement=\"MentorApproval\">\n        <omgdc:Bounds x=\"280\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_2\" bpmnElement=\"DeanApproval\">\n        <omgdc:Bounds x=\"520\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_EndEvent_1\" bpmnElement=\"EndEvent_1\">\n        <omgdc:Bounds x=\"782\" y=\"160\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"791\" y=\"203\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1n6azvq_di\" bpmnElement=\"Gateway_Mentor\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"425\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"411\" y=\"133\" width=\"77\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1mb28fn_di\" bpmnElement=\"Gateway_Dean\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"675\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"667\" y=\"133\" width=\"66\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Event_0t3anyf_di\" bpmnElement=\"Event_0t3anyf\">\n        <omgdc:Bounds x=\"552\" y=\"262\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"559\" y=\"305\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>\n',1,'ClassGuideOrgSealApprovalProcess:1:62568','[2013952715229585409]',1,1,2013951423174238210,'2026-02-24 14:26:17',2013951423174238210,'2026-02-24 14:58:57',0),(2026187291062484993,'ÂÖöÁ´†ÂÆ°ÊâπÔºàÁè≠‰∏ª‰ªªÔºâ','Áè≠‰∏ª‰ªª‰ΩøÁî®ÂÖöÁ´†ÁöÑÂÆ°ÊâπÊµÅ','ClassGuidePartySealApprovalProcess','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" xmlns:flowable=\"http://flowable.org/bpmn\" targetNamespace=\"http://www.flowable.org/processdef\">\n  <process id=\"ClassGuidePartySealApprovalProcess\" name=\"ÂÖöÁ´†ÂÆ°ÊâπÔºàÁè≠‰∏ª‰ªªÔºâ\" isExecutable=\"true\">\n    <startEvent id=\"StartEvent_1\" name=\"ÂºÄÂßã\" />\n    <userTask id=\"MentorApproval\" name=\"ËæÖÂØºÂëòÂÆ°Êâπ\" flowable:candidateGroups=\"2013952827238473729\" flowable:assignee=\"2013951264663101441\" />\n    <sequenceFlow id=\"Flow_1\" sourceRef=\"StartEvent_1\" targetRef=\"MentorApproval\" />\n    <userTask id=\"PartySecretaryApproval\" name=\"‰π¶ËÆ∞ÂÆ°Êâπ\" flowable:candidateGroups=\"2013952940048474113\" flowable:assignee=\"2013951382959251457\">\n      <incoming>Flow_02zd53y</incoming>\n    </userTask>\n    <sequenceFlow id=\"Flow_2\" sourceRef=\"MentorApproval\" targetRef=\"Gateway_Mentor\" />\n    <endEvent id=\"EndEvent_1\" name=\"ÂêåÊÑè\">\n      <incoming>Flow_00gdfib</incoming>\n    </endEvent>\n    <sequenceFlow id=\"Flow_3\" sourceRef=\"PartySecretaryApproval\" targetRef=\"Gateway_Ps\" />\n    <userTask id=\"DeanApproval\" name=\"Èô¢ÈïøÂÆ°Êâπ\" flowable:candidateGroups=\"2013952886889865217\" flowable:assignee=\"2013951338067615746\">\n      <incoming>Flow_0sczlhw</incoming>\n      <outgoing>Flow_06ao9c0</outgoing>\n    </userTask>\n    <sequenceFlow id=\"Flow_06ao9c0\" sourceRef=\"DeanApproval\" targetRef=\"Gateway_Dean\" />\n    <exclusiveGateway id=\"Gateway_Mentor\" name=\"ËæÖÂØºÂëòÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_2</incoming>\n      <outgoing>Flow_0sczlhw</outgoing>\n      <outgoing>Flow_1esxqux</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_0sczlhw\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_Mentor\" targetRef=\"DeanApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <exclusiveGateway id=\"Gateway_Dean\" name=\"Èô¢ÈïøÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_06ao9c0</incoming>\n      <outgoing>Flow_02zd53y</outgoing>\n      <outgoing>Flow_0uytuzh</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_02zd53y\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_Dean\" targetRef=\"PartySecretaryApproval\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <exclusiveGateway id=\"Gateway_Ps\" name=\"‰π¶ËÆ∞ÂÆ°ÊâπÁªìÊûú\">\n      <incoming>Flow_3</incoming>\n      <outgoing>Flow_00gdfib</outgoing>\n      <outgoing>Flow_01y7cmd</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_00gdfib\" name=\"ÂêåÊÑè\" sourceRef=\"Gateway_Ps\" targetRef=\"EndEvent_1\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == true}</conditionExpression>\n    </sequenceFlow>\n    <endEvent id=\"Event_11k28kr\" name=\"ÊãíÁªù\">\n      <incoming>Flow_1esxqux</incoming>\n      <incoming>Flow_0uytuzh</incoming>\n      <incoming>Flow_01y7cmd</incoming>\n    </endEvent>\n    <sequenceFlow id=\"Flow_1esxqux\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_Mentor\" targetRef=\"Event_11k28kr\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_0uytuzh\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_Dean\" targetRef=\"Event_11k28kr\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_01y7cmd\" name=\"ÊãíÁªù\" sourceRef=\"Gateway_Ps\" targetRef=\"Event_11k28kr\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${approved == false}</conditionExpression>\n    </sequenceFlow>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_1\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_1\" bpmnElement=\"ClassGuidePartySealApprovalProcess\">\n      <bpmndi:BPMNEdge id=\"Flow_01y7cmd_di\" bpmnElement=\"Flow_01y7cmd\">\n        <omgdi:waypoint x=\"880\" y=\"203\" />\n        <omgdi:waypoint x=\"880\" y=\"290\" />\n        <omgdi:waypoint x=\"658\" y=\"290\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"884\" y=\"244\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0uytuzh_di\" bpmnElement=\"Flow_0uytuzh\">\n        <omgdi:waypoint x=\"640\" y=\"203\" />\n        <omgdi:waypoint x=\"640\" y=\"272\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"644\" y=\"235\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1esxqux_di\" bpmnElement=\"Flow_1esxqux\">\n        <omgdi:waypoint x=\"410\" y=\"203\" />\n        <omgdi:waypoint x=\"410\" y=\"290\" />\n        <omgdi:waypoint x=\"622\" y=\"290\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"414\" y=\"244\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_00gdfib_di\" bpmnElement=\"Flow_00gdfib\">\n        <omgdi:waypoint x=\"905\" y=\"178\" />\n        <omgdi:waypoint x=\"962\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"923\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_02zd53y_di\" bpmnElement=\"Flow_02zd53y\">\n        <omgdi:waypoint x=\"665\" y=\"178\" />\n        <omgdi:waypoint x=\"730\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"687\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0sczlhw_di\" bpmnElement=\"Flow_0sczlhw\">\n        <omgdi:waypoint x=\"435\" y=\"178\" />\n        <omgdi:waypoint x=\"490\" y=\"178\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"452\" y=\"160\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_06ao9c0_di\" bpmnElement=\"Flow_06ao9c0\">\n        <omgdi:waypoint x=\"590\" y=\"178\" />\n        <omgdi:waypoint x=\"615\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_Flow_3\" bpmnElement=\"Flow_3\">\n        <omgdi:waypoint x=\"830\" y=\"178\" />\n        <omgdi:waypoint x=\"855\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_Flow_2\" bpmnElement=\"Flow_2\">\n        <omgdi:waypoint x=\"360\" y=\"178\" />\n        <omgdi:waypoint x=\"385\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_Flow_1\" bpmnElement=\"Flow_1\">\n        <omgdi:waypoint x=\"216\" y=\"178\" />\n        <omgdi:waypoint x=\"260\" y=\"178\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNShape id=\"_BPMNShape_StartEvent_2\" bpmnElement=\"StartEvent_1\">\n        <omgdc:Bounds x=\"180\" y=\"160\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"189\" y=\"203\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_1\" bpmnElement=\"MentorApproval\">\n        <omgdc:Bounds x=\"260\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_UserTask_2\" bpmnElement=\"PartySecretaryApproval\">\n        <omgdc:Bounds x=\"730\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"_BPMNShape_EndEvent_1\" bpmnElement=\"EndEvent_1\">\n        <omgdc:Bounds x=\"962\" y=\"160\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"971\" y=\"203\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_0to05uw_di\" bpmnElement=\"DeanApproval\">\n        <omgdc:Bounds x=\"490\" y=\"138\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1773svk_di\" bpmnElement=\"Gateway_Mentor\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"385\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"372\" y=\"123\" width=\"77\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_08j8dl0_di\" bpmnElement=\"Gateway_Dean\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"615\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"607\" y=\"123\" width=\"66\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_1yug5i5_di\" bpmnElement=\"Gateway_Ps\" isMarkerVisible=\"true\">\n        <omgdc:Bounds x=\"855\" y=\"153\" width=\"50\" height=\"50\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"848\" y=\"123\" width=\"66\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Event_11k28kr_di\" bpmnElement=\"Event_11k28kr\">\n        <omgdc:Bounds x=\"622\" y=\"272\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"629\" y=\"315\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>\n',1,'ClassGuidePartySealApprovalProcess:1:62564','[2013952715229585409]',2,1,2013951423174238210,'2026-02-24 14:47:50',2013951423174238210,'2026-02-24 14:59:52',0);
/*!40000 ALTER TABLE `workflow_template` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-20 11:20:03
