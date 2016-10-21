CREATE TABLE `jpush_user_register` (
`id`  bigint(11) NULL AUTO_INCREMENT ,
`action`  int(2) NULL ,
`createdAt`  datetime NULL ,
`updatedAt`  datetime NULL ,
`userId`  bigint(11) NULL ,
`registerId`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' ,
`groupId`  bigint(11) NULL ,
PRIMARY KEY (`id`)
);

ALTER TABLE `jpush_user_register`
MODIFY COLUMN `groupId`  bigint(11) NULL DEFAULT 0 AFTER `registerId`;

ALTER TABLE `jpush_user_register`
MODIFY COLUMN `action`  int(2) NULL DEFAULT 1 AFTER `id`;

ALTER TABLE `order_car_info`
ADD COLUMN `loanTerm`  int(3) NULL DEFAULT 0 COMMENT '贷款期限  单位 月' AFTER `carMortageProcessDateTime`;