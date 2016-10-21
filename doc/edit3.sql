ALTER TABLE `order_car_info`
ADD COLUMN `isApproval`  int(2) NULL AFTER `carIdentity`;

ALTER TABLE `order_car_info`
MODIFY COLUMN `isApproval`  int(2) NULL DEFAULT 1 AFTER `carIdentity`;

UPDATE order_car_info SET isApproval =1 WHERE ISNULL(isApproval);