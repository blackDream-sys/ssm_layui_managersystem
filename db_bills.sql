/*
 Navicat Premium Data Transfer

 Source Server         : b
 Source Server Type    : MySQL
 Source Server Version : 50530
 Source Host           : localhost:3306
 Source Schema         : db_bills

 Target Server Type    : MySQL
 Target Server Version : 50530
 File Encoding         : 65001

 Date: 07/11/2021 03:33:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bills
-- ----------------------------
DROP TABLE IF EXISTS `bills`;
CREATE TABLE `bills`  (
  `id` int(22) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `billtime` datetime NULL DEFAULT NULL,
  `typeid` int(22) NULL DEFAULT NULL,
  `price` double(10, 2) NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bills
-- ----------------------------
INSERT INTO `bills` VALUES (7, '测试', '2021-11-05 13:45:49', 1, 200.00, NULL);
INSERT INTO `bills` VALUES (8, '测试', '2021-11-05 13:45:49', 1, 200.00, NULL);
INSERT INTO `bills` VALUES (9, '测试', '2021-11-05 13:45:49', 1, 200.00, NULL);
INSERT INTO `bills` VALUES (10, '测试', '2021-11-05 13:45:49', 1, 200.00, NULL);
INSERT INTO `bills` VALUES (11, '测试', '2021-11-05 13:45:49', 1, 200.00, NULL);
INSERT INTO `bills` VALUES (12, '测试', '2021-11-05 13:45:49', 1, 200.00, NULL);
INSERT INTO `bills` VALUES (13, '测试', '2021-11-05 13:45:50', 1, 200.00, NULL);
INSERT INTO `bills` VALUES (14, '测试', '2021-11-05 13:45:50', 1, 200.00, NULL);
INSERT INTO `bills` VALUES (15, '测试', '2021-11-05 13:45:50', 1, 200.00, NULL);
INSERT INTO `bills` VALUES (16, '借钱给2bbbbbbbbbbbb', '2021-11-02 08:00:00', 3, 20000.00, '妈的');
INSERT INTO `bills` VALUES (18, '8b', '2021-11-06 01:48:53', 3, 7.00, '7bbbbbbbbbbbbbbbb');
INSERT INTO `bills` VALUES (19, 't', '2021-11-18 19:16:55', 5, 5.00, 'f');
INSERT INTO `bills` VALUES (20, 'r', '2021-11-06 19:17:21', 7, 6.00, '6');
INSERT INTO `bills` VALUES (21, 'f', '2021-11-06 19:17:34', 6, 7.00, '8');
INSERT INTO `bills` VALUES (22, 't', '2021-11-24 19:17:47', 6, 7.00, '9');
INSERT INTO `bills` VALUES (23, '66', '2021-11-06 19:18:12', 9, 9.00, '0');
INSERT INTO `bills` VALUES (24, '6', '2021-11-06 19:18:25', 8, 8.00, '8');
INSERT INTO `bills` VALUES (25, '6', '2021-11-06 19:18:43', 7, 7.00, '7');
INSERT INTO `bills` VALUES (26, '1', '2021-11-06 19:26:23', 3, 2.00, NULL);
INSERT INTO `bills` VALUES (27, '1', '2021-11-05 19:26:24', 3, 255.00, '');

-- ----------------------------
-- Table structure for billtype
-- ----------------------------
DROP TABLE IF EXISTS `billtype`;
CREATE TABLE `billtype`  (
  `id` int(22) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of billtype
-- ----------------------------
INSERT INTO `billtype` VALUES (1, '支出');
INSERT INTO `billtype` VALUES (2, '收入');
INSERT INTO `billtype` VALUES (3, '借出');
INSERT INTO `billtype` VALUES (4, '借入');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(22) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `loginname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '小明', 'xiaoming', '123456', '男');
INSERT INTO `user` VALUES (2, '管理员', 'admin', '856aea89ad509f163284abb75579dcfc', '女');

SET FOREIGN_KEY_CHECKS = 1;
