/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50709
 Source Host           : localhost
 Source Database       : myblog

 Target Server Type    : MySQL
 Target Server Version : 50709
 File Encoding         : utf-8

 Date: 11/22/2015 11:31:50 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` varchar(19) NOT NULL,
  `name` varchar(25) NOT NULL,
  `leftv` int(11) NOT NULL,
  `rightv` int(11) NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `category`
-- ----------------------------
BEGIN;
INSERT INTO `category` VALUES ('d3Lbk9G0GR3nO938cY0', 'about this blog', '6', '7', '1', '2015-11-15 21:23:55'), ('Mf2DuehP8rWqS8EzyXb', 'Root', '1', '8', '0', '2014-12-18 19:37:58');
COMMIT;

-- ----------------------------
--  Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` varchar(19) NOT NULL,
  `postid` varchar(19) NOT NULL,
  `parent` varchar(19) DEFAULT NULL,
  `creator` varchar(25) NOT NULL,
  `email` varchar(50) NOT NULL,
  `url` varchar(80) NOT NULL,
  `agent` varchar(120) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `content` varchar(200) NOT NULL,
  `status` enum('wait','approve','reject','trash') NOT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_comment_post` (`postid`),
  KEY `index_parent` (`parent`) USING BTREE,
  CONSTRAINT `index_comment` FOREIGN KEY (`parent`) REFERENCES `comment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `index_comment_post` FOREIGN KEY (`postid`) REFERENCES `post` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `link`
-- ----------------------------
DROP TABLE IF EXISTS `link`;
CREATE TABLE `link` (
  `id` varchar(19) NOT NULL,
  `name` varchar(80) NOT NULL,
  `url` varchar(100) NOT NULL,
  `notes` varchar(150) DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `creator` varchar(20) NOT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `link`
-- ----------------------------
BEGIN;
INSERT INTO `link` VALUES ('6ChkuVe0kfLY8ZiDnqZ', 'JavaTalk', 'http://www.zhouhaocheng.cn', null, '1', 'admin', '2015-01-06 17:27:31');
COMMIT;

-- ----------------------------
--  Table structure for `options`
-- ----------------------------
DROP TABLE IF EXISTS `options`;
CREATE TABLE `options` (
  `id` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `options`
-- ----------------------------
BEGIN;
INSERT INTO `options` VALUES ('allowComment', 'allowComment', 'true'), ('description', 'description', 'Spring Mybatis Ehcache Shiro Lucene FreeMarker'), ('keywords', 'keywords', 'test'), ('maxshow', 'maxshow', '10'), ('postid', 'postid', '12'), ('subtitle', 'subtitle', 'from zblog'), ('title', 'title', 'blueHawky');
COMMIT;

-- ----------------------------
--  Table structure for `post`
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` varchar(19) NOT NULL,
  `title` varchar(100) NOT NULL,
  `excerpt` varchar(350) DEFAULT NULL,
  `content` mediumtext NOT NULL,
  `type` enum('post','page') NOT NULL,
  `parent` varchar(19) DEFAULT NULL,
  `categoryid` varchar(19) DEFAULT NULL,
  `pstatus` varchar(10) NOT NULL,
  `cstatus` varchar(10) NOT NULL,
  `ccount` int(11) NOT NULL,
  `rcount` int(11) NOT NULL,
  `creator` varchar(19) NOT NULL,
  `createTime` datetime NOT NULL,
  `lastUpdate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_post_category` (`categoryid`),
  KEY `index_post_user` (`creator`),
  CONSTRAINT `index_post_category` FOREIGN KEY (`categoryid`) REFERENCES `category` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `index_post_user` FOREIGN KEY (`creator`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `post`
-- ----------------------------
BEGIN;
INSERT INTO `post` VALUES ('12', '关于这个博客系统1', '这里是标题标题 这个文章更多是为了测试markdown写的，在github上发现了 https://github.com/dongfangshangren/Zblog 这个项目，挺有意思的，于是fork了一份，然后用java8作为fork项目的jdk进行编写。替换了datasource，将文章分类的sql里面的name列添加了unique属性，修复了类目重复的问题（当你在创建类目的时候点确定过快，可能实际创建了两个），其实unique的方法也不好，应该在请求上添加唯一键，只因为这个博客有个bug，删除类目的时候回去读取类目，但是返回参数却限定为一个，但是可能是有两个同名类目，会导致mybatis抛异常,so,干脆改成不许重名，其实删除应该按照类目id来做，后续改掉吧。 然后另外一个问题呢，就', '<div id=\"epiceditor-preview\">\n <h1 id=\"-\">这里是标题标题</h1> \n <p> 这个文章更多是为了测试markdown写的，在github上发现了 <a href=\"https://github.com/dongfangshangren/Zblog\">https://github.com/dongfangshangren/Zblog</a> 这个项目，挺有意思的，于是fork了一份，然后用java8作为fork项目的jdk进行编写。替换了datasource，将文章分类的sql里面的name列添加了unique属性，修复了类目重复的问题（当你在创建类目的时候点确定过快，可能实际创建了两个），其实unique的方法也不好，应该在请求上添加唯一键，只因为这个博客有个bug，删除类目的时候回去读取类目，但是返回参数却限定为一个，但是可能是有两个同名类目，会导致mybatis抛异常,so,干脆改成不许重名，其实删除应该按照类目id来做，后续改掉吧。 然后另外一个问题呢，就是lucence的版本问题升级到5.2.1了 刚发现搜索那一块还有问题，各种不兼容，看样子只有重写了，顺带学一下lucence 先把搜索那块屏蔽掉了，结果尼玛发现markdown有问题</p> \n <h2 id=\"2015-11-21\">2015-11-21</h2> \n <p> markdown的问题总算解决了，不知道为什么作者在初始化epiceditor的时候这么写的</p> \n <p><code>basePath: window.location.protocol+\"//\"+window.location.port+window.location.host+\"/resource/epiceditor-0.2.3\"</code></p> \n <p> 把多的那个port去掉就好了，改成</p> \n <p><code>basePath: window.location.protocol+\"//\"+window.location.host+\"/resource/epiceditor-0.2.2\"</code></p> \n <p> 对了，顺带我把epiceditor的版本换了一下</p> \n</div>\n<div id=\"xunlei_com_thunder_helper_plugin_d462f475-c18e-46be-bd10-327458d045bd\"></div>', 'post', 'Root', 'd3Lbk9G0GR3nO938cY0', 'publish', 'open', '0', '1', 'uHHi9gvg81UXn4PLlLE', '2015-11-15 23:56:42', '2015-11-22 11:29:59');
COMMIT;

-- ----------------------------
--  Table structure for `tag`
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` varchar(19) NOT NULL,
  `name` varchar(15) NOT NULL,
  `postid` varchar(19) NOT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `postid` (`postid`),
  CONSTRAINT `tag_post_index` FOREIGN KEY (`postid`) REFERENCES `post` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tag`
-- ----------------------------
BEGIN;
INSERT INTO `tag` VALUES ('Yquk6LAWGc5EhCKwHrv', '随笔', '12', '2015-11-22 11:29:59');
COMMIT;

-- ----------------------------
--  Table structure for `upload`
-- ----------------------------
DROP TABLE IF EXISTS `upload`;
CREATE TABLE `upload` (
  `id` varchar(19) NOT NULL,
  `postid` varchar(19) DEFAULT NULL,
  `name` varchar(80) NOT NULL,
  `path` varchar(100) NOT NULL,
  `creator` varchar(25) NOT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_upload_post` (`postid`),
  CONSTRAINT `index_upload_post` FOREIGN KEY (`postid`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(19) NOT NULL,
  `nickName` varchar(25) NOT NULL,
  `realName` varchar(25) NOT NULL,
  `password` varchar(32) NOT NULL,
  `email` varchar(30) NOT NULL,
  `status` varchar(10) NOT NULL,
  `role` enum('admin','editor','contributor') NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `createTime` datetime NOT NULL,
  `creator` varchar(15) DEFAULT NULL,
  `lastUpdate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`nickName`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user`
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('uHHi9gvg81UXn4PLlLE', 'admin', 'bluehawky', 'ec2b6e7ecf5debf13ef78bbee85a9ce9', 'woshipmx1991@sina.com', 'N', 'admin', '', '2014-12-31 18:49:44', null, '2014-12-31 18:49:48');
COMMIT;

-- ----------------------------
--  View structure for `view_category`
-- ----------------------------
DROP VIEW IF EXISTS `view_category`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_category` AS select `n`.`id` AS `id`,`n`.`name` AS `name`,count(`n`.`id`) AS `level`,`n`.`visible` AS `visible` from (`category` `n` join `category` `p`) where (`n`.`leftv` between `p`.`leftv` and `p`.`rightv`) group by `n`.`id` order by `n`.`leftv`;

SET FOREIGN_KEY_CHECKS = 1;
