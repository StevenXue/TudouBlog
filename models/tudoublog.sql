/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50626
Source Host           : localhost:3306
Source Database       : tudoublog

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2017-05-21 18:05:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tb_article
-- ----------------------------
DROP TABLE IF EXISTS `tb_article`;
CREATE TABLE `tb_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `featureID` int(10) unsigned NOT NULL,
  `title` varchar(128) NOT NULL,
  `subtitle` varchar(128) DEFAULT NULL,
  `link` varchar(256) NOT NULL,
  `license` varchar(256) DEFAULT NULL,
  `timeCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `timeRelease` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `timeModify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `author` varchar(256) NOT NULL,
  `introduction` varchar(256) DEFAULT NULL,
  `coverLink` varchar(256) DEFAULT NULL,
  `content` text NOT NULL,
  `countRead` int(10) unsigned NOT NULL DEFAULT '0',
  `countShare` int(10) unsigned NOT NULL DEFAULT '0',
  `countDiscuss` int(10) unsigned NOT NULL DEFAULT '0',
  `labels` varchar(256) DEFAULT NULL,
  `state` varchar(16) NOT NULL DEFAULT 'pass',
  PRIMARY KEY (`id`),
  KEY `fk_article_featuresID` (`featureID`),
  CONSTRAINT `fk_article_featuresID` FOREIGN KEY (`featureID`) REFERENCES `tb_feature` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_article
-- ----------------------------

-- ----------------------------
-- Table structure for tb_discuss
-- ----------------------------
DROP TABLE IF EXISTS `tb_discuss`;
CREATE TABLE `tb_discuss` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author` varchar(32) NOT NULL,
  `contact` varchar(64) DEFAULT NULL,
  `discussID` int(10) unsigned NOT NULL,
  `timeCreate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` varchar(256) NOT NULL,
  `state` varchar(16) NOT NULL DEFAULT 'verify',
  `mask` varchar(16) NOT NULL DEFAULT 'comman',
  `type` varchar(16) NOT NULL DEFAULT 'disc',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_discuss
-- ----------------------------

-- ----------------------------
-- Table structure for tb_feature
-- ----------------------------
DROP TABLE IF EXISTS `tb_feature`;
CREATE TABLE `tb_feature` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  `timeCreate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `author` varchar(128) NOT NULL,
  `coverLink` varchar(256) DEFAULT NULL,
  `introduction` varchar(256) DEFAULT NULL,
  `countArticle` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_feature
-- ----------------------------

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `name` varchar(128) NOT NULL,
  `nickname` varchar(128) NOT NULL,
  `password` varchar(512) NOT NULL,
  `question` varchar(128) NOT NULL,
  `anser` varchar(128) NOT NULL,
  `authority` varchar(16) NOT NULL DEFAULT 'website',
  `timeCreate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` varchar(16) NOT NULL DEFAULT 'pass',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('stone', '石头', '5763317dd725182093ea049d0e9e8bef', '你的名字？', '石头', 'website', '2017-05-21 18:03:35', 'pass');

-- ----------------------------
-- Table structure for tb_visitor
-- ----------------------------
DROP TABLE IF EXISTS `tb_visitor`;
CREATE TABLE `tb_visitor` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(128) NOT NULL,
  `timeVisited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ua` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_visitor
-- ----------------------------
INSERT INTO `tb_visitor` VALUES ('1', '522170fb17b3dafd4d8c57bfe7d2c613', '2017-05-21 18:04:23', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36');
DROP TRIGGER IF EXISTS `tb_article_insert`;
DELIMITER ;;
CREATE TRIGGER `tb_article_insert` AFTER INSERT ON `tb_article` FOR EACH ROW UPDATE tb_feature SET countArticle = countArticle+1 WHERE id = NEW.featureID
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `tb_article_delete`;
DELIMITER ;;
CREATE TRIGGER `tb_article_delete` AFTER DELETE ON `tb_article` FOR EACH ROW UPDATE tb_feature SET countArticle = countArticle-1 WHERE id = OLD.featureID
;;
DELIMITER ;
