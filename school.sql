/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50067
 Source Host           : localhost:3306
 Source Schema         : school

 Target Server Type    : MySQL
 Target Server Version : 50067
 File Encoding         : 65001

 Date: 23/04/2020 17:52:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade`  (
  `gid` int(20) NOT NULL AUTO_INCREMENT,
  `gname` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY USING BTREE (`gid`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade` VALUES (1, '大一');
INSERT INTO `grade` VALUES (2, '大二');
INSERT INTO `grade` VALUES (3, '大三');
INSERT INTO `grade` VALUES (4, '大四');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `sid` int(20) NOT NULL AUTO_INCREMENT,
  `sname` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` int(20) NULL DEFAULT NULL,
  `gid` int(20) NULL DEFAULT NULL,
  PRIMARY KEY USING BTREE (`sid`)
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (4, '路飞', '男', 22, 2);
INSERT INTO `student` VALUES (5, '索隆', '男', 22, 3);
INSERT INTO `student` VALUES (11, 'f9c41', '男', 22, 2);
INSERT INTO `student` VALUES (12, '10323', '女', 21, 3);
INSERT INTO `student` VALUES (13, '6311b', '女', 21, 3);
INSERT INTO `student` VALUES (14, '7541a', '女', 21, 3);
INSERT INTO `student` VALUES (15, 'b6159', '女', 21, 3);
INSERT INTO `student` VALUES (16, '7908b', '女', 21, 3);
INSERT INTO `student` VALUES (17, '2c378', '女', 21, 3);
INSERT INTO `student` VALUES (18, '18681', '女', 21, 3);
INSERT INTO `student` VALUES (19, 'ffa13', '女', 21, 3);
INSERT INTO `student` VALUES (25, '48e02', '男', 20, 1);
INSERT INTO `student` VALUES (26, '398d3', '男', 20, 1);
INSERT INTO `student` VALUES (27, '6252b', '男', 20, 1);
INSERT INTO `student` VALUES (28, '34694', '男', 20, 1);
INSERT INTO `student` VALUES (29, 'd740a', '男', 20, 1);
INSERT INTO `student` VALUES (30, 'c3221', '男', 20, 1);
INSERT INTO `student` VALUES (31, '1daf5', '男', 20, 1);
INSERT INTO `student` VALUES (32, '哼哼哈嘿', '男', 20, 4);
INSERT INTO `student` VALUES (37, '哈哈哈', '男', 22, 2);
INSERT INTO `student` VALUES (38, '1111111', '女', 29, 4);
INSERT INTO `student` VALUES (39, '22222', '男', 18, 1);
INSERT INTO `student` VALUES (40, '3333', '男', 18, 1);
INSERT INTO `student` VALUES (41, '嘿嘿', '女', 22, 4);
INSERT INTO `student` VALUES (43, '你真棒啊', '女', 20, 3);
INSERT INTO `student` VALUES (44, '6555', '男', 19, 1);
INSERT INTO `student` VALUES (45, '1893', '男', 12, 4);

SET FOREIGN_KEY_CHECKS = 1;
