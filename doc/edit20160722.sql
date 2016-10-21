ALTER TABLE `order_car_sop`
ADD COLUMN `newCarLicense`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ;

ALTER TABLE `order_car_sop`
ADD COLUMN `newDrivingLicense`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ;

ALTER TABLE `order_car_sop`
ADD COLUMN `newRegistration`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ;

ALTER TABLE `order_car_sop`
ADD COLUMN `transferInvoice`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ;

ALTER TABLE `order_car_info`
ADD COLUMN `licenseSelectType`  int(2) NULL DEFAULT 1 COMMENT '车牌号选取方式 1电话 2客户自选',
ADD COLUMN `licenseSelectDate`  datetime NULL COMMENT '车牌号选取时间' ;

ALTER TABLE `order_car_info`
ADD COLUMN `finalPayment`  int(10) NULL DEFAULT 0 COMMENT '尾款' ,
ADD COLUMN `finalPaymentDate`  datetime NULL COMMENT '尾款支付时间' ;

ALTER TABLE `order_car_info`
ADD COLUMN `mainTain`  varchar(999) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '保养项目' ;


ALTER TABLE `order_car_info`
CHANGE COLUMN `mainTain` `mainTainProject`  varchar(999) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '保养项目' ,
ADD COLUMN `mainTainPayTotal`  int(10) NULL DEFAULT 0 COMMENT '保养金额总额' ;

ALTER TABLE `order_car_info`
ADD COLUMN `mainTainIsPay`  int(2) NULL DEFAULT 1 COMMENT '保养费用是否支付 1未支付 9已支付' ;


ALTER TABLE `order_car_info`
ADD COLUMN `mainTainIsComplete`  int(2) NULL DEFAULT 1 COMMENT '保养是否完成 1未完成  9已完成' ;

ALTER TABLE `order_car_info`
ADD COLUMN `mainTainPhoto`  varchar(999) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '保养施工照片' ;

ALTER TABLE `order_car_info`
ADD COLUMN `highQualityAddProject`  varchar(999) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '精品加装项目';

ALTER TABLE `order_car_info`
ADD COLUMN `highQualityAddPayTotal`  int(10) NULL DEFAULT 0 COMMENT '精品加装总价' ;

ALTER TABLE `order_car_info`
ADD COLUMN `highQualityAddIsPay`  int(2) NULL DEFAULT 1 COMMENT '精品加装是否支付 1未支付 9已支付' ;


ALTER TABLE `order_car_info`
ADD COLUMN `highQualityAddIsComplete`  int(2) NULL DEFAULT 1 COMMENT '精品加装是否完成 1未完成  9已完成' ;


ALTER TABLE `order_car_info`
ADD COLUMN `highQualityAddPhoto`  varchar(999) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '精品加装照片' ;

ALTER TABLE `order_car_info`
ADD COLUMN `pickCarTime`  datetime NULL COMMENT '预约提车时间' ;

ALTER TABLE `order_car_sop`
ADD COLUMN `pickCarTransferList`  varchar(999) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '客户交接单' ;


ALTER TABLE `order_car_info`
ADD COLUMN `carBeautyProject`  varchar(999) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '车辆美容项目' ;

ALTER TABLE `order_car_info`
ADD COLUMN `carBeautyPayTotal`  int(10) NULL DEFAULT 0 COMMENT '车辆美容总价' ;

ALTER TABLE `order_car_info`
ADD COLUMN `carBeautyIsPay`  int(2) NULL DEFAULT 1 COMMENT '车辆美容是否支付 1未支付  9已支付' ;

ALTER TABLE `order_car_info`
ADD COLUMN `carBeautyIsComplete`  int(2) NULL DEFAULT 1 COMMENT '车辆美容是否完成  1未完成  9已完成' AFTER `carBeautyIsPay`;

ALTER TABLE `order_car_info`
ADD COLUMN `carBeautyPhoto`  varchar(999) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '车辆美容照片' AFTER `carBeautyIsComplete`;

ALTER TABLE `order_car_info`
ADD COLUMN `bankReceiveInformation`  int(2) NULL DEFAULT 1 COMMENT '银行是否收到客户资料 1未收到  9已收到' AFTER `carBeautyPhoto`;

ALTER TABLE `order_car_info`
ADD COLUMN `bankIsApproval`  int(2) NULL DEFAULT 1 COMMENT '银行放款是否审批通过 1未通过 9已通过' AFTER `bankReceiveInformation`;

ALTER TABLE `order_car_info`
ADD COLUMN `bankLoanAmountReady`  int(10) NULL DEFAULT 0 COMMENT '银行预计放款金额' AFTER `bankIsApproval`;

ALTER TABLE `order_car_info`
ADD COLUMN `bankLoanAmountComplete`  int(2) NULL DEFAULT 1 COMMENT '银行是否放款成功  1未成功  9已成功' AFTER `bankLoanAmountReady`;

ALTER TABLE `order_car_info`
ADD COLUMN `bankReceiveInfoTime`  datetime NULL COMMENT '银行收到客户贷款资料时间' AFTER `bankLoanAmountComplete`;

ALTER TABLE `order_car_info`
ADD COLUMN `bankApprovalTime`  datetime NULL COMMENT '银行审批通过时间' AFTER `bankReceiveInfoTime`;

ALTER TABLE `order_car_info`
ADD COLUMN `licenseSelectTime`  datetime NULL COMMENT '选新车牌动作发生时间' AFTER `licenseSelectType`;

ALTER TABLE `order_car_info`
ADD COLUMN `carMortageProcessIsComplete`  int(2) NULL DEFAULT 1 COMMENT '抵押手续是否办理完成' AFTER `bankApprovalTime`;

ALTER TABLE `order_car_info`
ADD COLUMN `pickCarDateTime`  datetime NULL COMMENT '预约提车动作发生时间' AFTER `highQualityAddPhoto`;

ALTER TABLE `order_car_info`
ADD COLUMN `finalPaymentDateTime`  datetime NULL COMMENT '约定支付尾款动作发生时间' AFTER `licenseSelectDate`;

ALTER TABLE `order_car_info`
ADD COLUMN `carMortageProcessDateTime`  datetime NULL COMMENT '车辆抵押手续办理完成时间' AFTER `carMortageProcessIsComplete`;

ALTER TABLE `order_car_info`
ADD COLUMN `mainTainDateTime`  datetime NULL COMMENT '车辆保养完成时间' AFTER `mainTainIsComplete`;

ALTER TABLE `order_car_info`
ADD COLUMN `highQualityAddDateTime`  datetime NULL COMMENT '车辆精品加装完成时间' AFTER `highQualityAddPhoto`;

ALTER TABLE `order_car_info`
ADD COLUMN `carBeautyDateTime`  datetime NULL COMMENT '车辆美容完成时间' AFTER `carBeautyPhoto`;