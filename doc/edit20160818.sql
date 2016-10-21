ALTER TABLE `jpush_user_register`
ADD COLUMN `cityCode`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' AFTER `groupId`,
ADD COLUMN `cityName`  varchar(20) NULL AFTER `cityCode`;

ALTER TABLE `jpush_user_register`
MODIFY COLUMN `cityName`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' AFTER `cityCode`;

ALTER TABLE `jpush_user_register`
ADD COLUMN `licenseNumber`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' AFTER `cityName`;

ALTER TABLE `jpush_user_register`
ADD COLUMN `tomorrowIsLimit`  int(2) NULL DEFAULT 0 COMMENT '明日是否限行 0不限行  1限行' AFTER `licenseNumber`;

ALTER TABLE `jpush_user_register`
ADD COLUMN `limitEndNumber`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '明日限行尾号' AFTER `tomorrowIsLimit`;