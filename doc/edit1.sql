UPDATE order_car_info SET orderStatus=7 WHERE action = 0;
ALTER TABLE `order_car_sop`
MODIFY COLUMN `image`  varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' AFTER `content`,
MODIFY COLUMN `contractImage`  varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '合同照片' AFTER `isContract`;