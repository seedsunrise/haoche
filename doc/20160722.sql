CREATE TABLE `sys_car_extra_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(100) DEFAULT '' COMMENT '公司名称',
  `type` tinyint(4) DEFAULT '0' COMMENT '类别(0:保养 1:精品加装 2:美容)',
  `action` tinyint(4) DEFAULT '0',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='保养、美容、精品加装 配置表';