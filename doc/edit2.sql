ALTER TABLE `order_car_info`
ADD COLUMN `carIdentity`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' AFTER `carMainPhoto`;