
CREATE TABLE `car_insurance_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `infoId` int(11) NOT NULL COMMENT '车险信息',
  `optionId` int(11) NOT NULL COMMENT '保险项目',
  `coverage` int(8) DEFAULT '0' COMMENT '保额',
  `price` int(8) DEFAULT '0' COMMENT '价格',
  `nonDeductible` int(8) DEFAULT '0' COMMENT '不计免赔',
  `isImported` tinyint(4) DEFAULT '0' COMMENT '是否进口(0:国产 1:进口)',
  `isConfirm` tinyint(4) DEFAULT '1' COMMENT '是否确认(0:未选择 1:已选择)',
  `isConfirmDeductible` tinyint(4) DEFAULT '1' COMMENT '是否确认不计免赔(0:未选择 1:已选择)',
  `action` tinyint(4) DEFAULT '0',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='保险公司配置表';


CREATE TABLE `car_insurance_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `quoterId` int(11) NOT NULL COMMENT '报价员',
  `carInfoId` int(11) NOT NULL COMMENT '商品车辆',
  `quoteStatus` tinyint(4) DEFAULT '0' COMMENT '报价状态(0:未报价1:报价中2:报价完毕3:已确认保项)',
  `isChoose` tinyint(4) DEFAULT '0' COMMENT '是否选择(0:未选择 1:已选择)',
  `action` tinyint(4) DEFAULT '0',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `orderStatus` tinyint(4) DEFAULT '0' COMMENT '订单状态(0:待处理 1:已购买 2:已取消)',
  `orderPrice` int(8) DEFAULT '0' COMMENT '客户付款额',
  `orderPic` varchar(100) DEFAULT '' COMMENT '保单上传地址',
  `orderMemo` varchar(255) DEFAULT '' COMMENT '订单备注',
  `orderTime` datetime DEFAULT NULL COMMENT '支付时间',
  `orderBeginTime` datetime DEFAULT NULL COMMENT '订单生效时间',
  `totalPrice` int(8) DEFAULT '0' COMMENT '车险总价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='保险公司配置表';


CREATE TABLE `car_insurance_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '保项名称',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '保项类型(0:非商业险 1:商业险)',
  `isNonDeductible` tinyint(4) DEFAULT '0' COMMENT '是否不计免赔(0:否 1:是)',
  `extend` varchar(100) DEFAULT '' COMMENT '扩展项(定额, 国产/进口)',
  `action` tinyint(4) DEFAULT '0',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='保险公司配置表';


CREATE TABLE `car_insurance_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `infoId` int(11) DEFAULT NULL COMMENT '车险信息id',
  `carInfoId` int(11) NOT NULL COMMENT '商品车辆',
  `orderStatus` tinyint(4) DEFAULT '0' COMMENT '订单状态(0:待处理 1:已购买 2:已取消)',
  `orderPrice` int(8) DEFAULT '0' COMMENT '客户付款额',
  `orderPic` varchar(100) DEFAULT '' COMMENT '保单上传地址',
  `orderMemo` varchar(255) DEFAULT '' COMMENT '订单备注',
  `orderTime` datetime DEFAULT NULL COMMENT '支付时间',
  `orderBeginTime` datetime DEFAULT NULL COMMENT '订单生效时间',
  `totalPrice` int(8) DEFAULT '0' COMMENT '车险总价',
  `action` tinyint(4) DEFAULT '0',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='保险公司配置表';


CREATE TABLE `sys_insurance_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(100) DEFAULT '' COMMENT '公司名称',
  `logo` varchar(60) DEFAULT '' COMMENT 'Logo图片',
  `phone` varchar(20) DEFAULT '' COMMENT '公司电话',
  `action` tinyint(4) DEFAULT '0',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='保险公司配置表';


CREATE TABLE `sys_insurance_quoter` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `companyId` int(11) NOT NULL COMMENT '保险公司表主键',
  `name` varchar(100) DEFAULT '' COMMENT '公司名称',
  `phone` varchar(20) DEFAULT '' COMMENT '公司电话',
  `action` tinyint(4) DEFAULT '0',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='保险公司配置表';

INSERT INTO `car_insurance_option` VALUES ('1', '交强险', '0', '0', '', '0', '2016-07-05 15:25:07', '2016-07-05 15:25:12');
INSERT INTO `car_insurance_option` VALUES ('2', '车辆损失险', '1', '1', '', '0', '2016-07-05 15:25:09', '2016-07-05 15:25:15');
INSERT INTO `car_insurance_option` VALUES ('3', '第三者责任险', '1', '1', '50万', '0', null, null);
INSERT INTO `car_insurance_option` VALUES ('4', '车船使用税', '0', '0', '', '0', null, null);
INSERT INTO `car_insurance_option` VALUES ('5', '第三者责任险', '1', '1', '100万', '0', null, null);
INSERT INTO `car_insurance_option` VALUES ('6', '车上人员责任险(司机)', '1', '1', '每座1万', '0', null, null);
INSERT INTO `car_insurance_option` VALUES ('7', '车上人员责任险(乘客)', '1', '1', '每座1万', '0', null, null);
INSERT INTO `car_insurance_option` VALUES ('8', '全车盗抢险', '1', '1', '', '0', null, null);
INSERT INTO `car_insurance_option` VALUES ('9', '车辆涉水险', '1', '1', '无', '0', null, null);
INSERT INTO `car_insurance_option` VALUES ('10', '自燃损失险', '1', '1', '', '0', null, null);
INSERT INTO `car_insurance_option` VALUES ('11', '玻璃单独破碎险', '1', '0', '国产/进口', '0', null, null);
