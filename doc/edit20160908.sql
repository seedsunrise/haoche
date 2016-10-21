ALTER TABLE `car_info`
ADD COLUMN `saleOnOffType`  int(4) NULL DEFAULT 0 COMMENT '下架类型 1：内部下架  2：外部交易  3：其它' AFTER `insuranceQuoteStatus`,
ADD COLUMN `saleOnOffContent`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '下架理由' AFTER `saleOnOffType`;