ALTER TABLE `car_insurance_info`
ADD COLUMN `type`  tinyint(4) NULL DEFAULT 0 COMMENT '报价类型 0:车险报价 1:续保报价' AFTER `isChoose`;

ALTER TABLE `car_insurance_order`
ADD COLUMN `type`  tinyint(4) NULL DEFAULT 0 COMMENT '报价类型 0:车险报价 1:续保报价' AFTER `totalPrice`;

ALTER TABLE `car_insurance_info`
ADD COLUMN `commercialPrice`  int(8) NULL DEFAULT 0 COMMENT '商业险价格' AFTER `type`,
ADD COLUMN `nonCommercialPrice`  int(8) NULL DEFAULT 0 COMMENT '非商业险价格' AFTER `commercialPrice`;


UPDATE car_insurance_info i,
 (
	SELECT
		id,
		max(CASE type WHEN 1 THEN total ELSE 0 END ) comm,
		max(CASE type WHEN 0 THEN total ELSE 0 END ) noComm
	FROM
		(
			SELECT
				i.id,
				o.type,
				sum(
					IF (d.isConfirm = 1, d.price, 0)
				) + sum(
					IF (
						d.isConfirmDeductible = 1
						AND d.isConfirm = 1,
						d.nonDeductible,
						0
					)
				) total
			FROM
				car_insurance_info i
			LEFT JOIN car_insurance_detail d ON i.id = d.infoId
			LEFT JOIN car_insurance_option o ON o.id = d.optionId
			GROUP BY
				i.id,
				o.type
		) tt
	GROUP BY
		id
) tmp
SET i.commercialPrice = tmp.comm,
 i.nonCommercialPrice = tmp.noComm
WHERE
	i.id = tmp.id