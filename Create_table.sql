// 공사를 중개하는 담당자와 관련된 데이터를 저장하는 테이블
CREATE TABLE `brokerage` (
	`manager_id` INT NOT NULL AUTO_INCREMENT,
	`manager_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`manager_approval` TINYINT(1) NOT NULL DEFAULT '0',
	`construction_approval` TINYINT(1) NULL DEFAULT '0',
	`change_date` DATE NULL DEFAULT NULL,
	`change_manager` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`create_date` DATE NULL DEFAULT NULL,
	PRIMARY KEY (`manager_id`) USING BTREE
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;

//yn_house에서 진행한 공사와 관련된 데이터를 저장한 테이블
CREATE TABLE `construction` (
	`construction_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`customer_id` INT NOT NULL,
	`manager_id` INT NOT NULL,
	`construction_name` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_0900_ai_ci',
	`construction_address` VARCHAR(150) NOT NULL DEFAULT '' COLLATE 'utf8mb4_0900_ai_ci',
	`construction_type` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_0900_ai_ci',
	`registration_date` DATE NOT NULL ,
	`due_date` DATE NULL DEFAULT NULL ,
	`floors` INT UNSIGNED NOT NULL DEFAULT '0',
	`construction_counts` INT UNSIGNED NOT NULL DEFAULT '1',
	`construction_width` FLOAT UNSIGNED NULL DEFAULT NULL,
	`construction_length` FLOAT UNSIGNED NULL DEFAULT NULL,
	`construction_height` FLOAT UNSIGNED NULL DEFAULT NULL,
	`construction_shoulder_height` FLOAT UNSIGNED NULL DEFAULT NULL,
	`construction_area` FLOAT UNSIGNED NULL DEFAULT NULL,
	`progress` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_0900_ai_ci',
	`government_sup_state` TINYINT(1) NOT NULL DEFAULT '0',
	`payment_state` TINYINT(1) NOT NULL DEFAULT '0',
	`payment_date` DATE NOT NULL,
	`x-coordinate` FLOAT UNSIGNED NULL DEFAULT NULL,
	`y-coordinate` FLOAT UNSIGNED NULL DEFAULT NULL,
	PRIMARY KEY (`construction_id`) USING BTREE,
	INDEX `FK_construction_construction_customer` (`customer_id`) USING BTREE,
	INDEX `FK_construction_brokerage` (`manager_id`) USING BTREE,
	CONSTRAINT `FK_construction_brokerage` FOREIGN KEY (`manager_id`) REFERENCES `brokerage` (`manager_id`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `FK_construction_construction_customer` FOREIGN KEY (`customer_id`) REFERENCES `construction_customer` (`construction_customer_id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COMMENT='공사에 필요한 데이터와 공사 진행 과정에서 발생한 데이터를 저장하는 테이블\r\n'
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;

//yn_house에서 사용하는 자재와 관련된 데이터를 저장한 테이블
CREATE TABLE `material` (
	`material_id` INT NOT NULL AUTO_INCREMENT,
	`material_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`alias` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`material_price` INT UNSIGNED NOT NULL DEFAULT '0',
	`major_category` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`middle_category` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`sub_category` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`material_account` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`standard` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	PRIMARY KEY (`material_id`) USING BTREE
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;

//yn_house와 자재를 거래하는 거래처 데이터를 저장한 테이블
CREATE TABLE `correspondent` (
	`correspondent_id` INT NOT NULL AUTO_INCREMENT,
	`correspondent_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`manager` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`phonenumber` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	PRIMARY KEY (`correspondent_id`) USING BTREE
)

//yn_house를 이용하는 고객과 관련된 데이터를 저장하는 테이블
CREATE TABLE `customer` (
	`construction_customer_id` INT NOT NULL AUTO_INCREMENT,
	`customer_class` VARCHAR(2) NOT NULL COMMENT '개인, 기업, 정부, 기타로 구분' COLLATE 'utf8mb4_0900_ai_ci',
	`customer_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`customer_phonenumber` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`customer_sex` TINYINT(1) NOT NULL,
	`customer_birthday` DATE NOT NULL,
	`customer_address` VARCHAR(150) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`vip` TINYINT(1) NULL DEFAULT NULL,
	`distance` FLOAT NULL DEFAULT NULL COMMENT '고객의 주소와 회사와의 거리',
	`transaction_total` INT NULL DEFAULT '0' COMMENT '지금까지 고객이 지불한 비용',
	`transaction_count` INT NULL DEFAULT '0' COMMENT '지금까지 고객과 거래한 횟수',
	`note` VARCHAR(100) NULL DEFAULT NULL COMMENT '공사할 때 참고해야 할 특이사항' COLLATE 'utf8mb4_0900_ai_ci',
	PRIMARY KEY (`construction_customer_id`) USING BTREE
)
COLLATE='utf8mb4_0900_ai_ci'

//yn_house에서 일하는 직원의 데이터를 저장한 테이블
CREATE TABLE `employee` (
	`employee_id` INT NOT NULL AUTO_INCREMENT,
	`employee_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`employee_phonenumber` VARCHAR(13) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`employee_pay` INT UNSIGNED NULL DEFAULT '0',
	PRIMARY KEY (`employee_id`) USING BTREE
)

//yn_house가 현재 보유하고 있는 자재의 수량과 자재의 임계치를 저장한 테이블
CREATE TABLE `inventory` (
	`material_id` INT NOT NULL,
	`correspondent_id` INT NOT NULL,
	`material_name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`material_ count` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`expected_supply` INT NULL DEFAULT NULL,
	`expected_date` DATE NULL DEFAULT NULL,
	`threshold` INT NULL DEFAULT NULL COMMENT '재고 수량이 임계치 이하면 자동 발주를 수행한다',
	PRIMARY KEY (`material_id`) USING BTREE,
	INDEX `FK_inventory_correspondent` (`correspondent_id`) USING BTREE,
	CONSTRAINT `FK_inventory_correspondent` FOREIGN KEY (`correspondent_id`) REFERENCES `correspondent` (`correspondent_id`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `FK__material` FOREIGN KEY (`material_id`) REFERENCES `material` (`material_id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;

//공사에서 사용한 자재의 데이터를 저장한 테이블
CREATE TABLE `construction_material` (
	`construction_id` INT UNSIGNED NOT NULL,
	`material_id` INT NOT NULL,
	`material_total` INT NOT NULL DEFAULT '0',
	`material_price` INT NULL DEFAULT '0',
	`using_count` INT NULL DEFAULT NULL,
	`fianl_total` INT NULL DEFAULT '0',
	`use` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	PRIMARY KEY (`construction_id`, `material_id`) USING BTREE,
	INDEX `FK_construction_material_material` (`material_id`) USING BTREE,
	CONSTRAINT `FK_construction_material_construction` FOREIGN KEY (`construction_id`) REFERENCES `construction` (`construction_id`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `FK_construction_material_material` FOREIGN KEY (`material_id`) REFERENCES `material` (`material_id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;

//공사를 의뢰한 고객의 데이터를 저장한 테이블
CREATE TABLE `construction_customer` (
	`construction_customer_id` INT NOT NULL,
	`customer_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`address` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`phonenumber` VARCHAR(13) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	PRIMARY KEY (`construction_customer_id`) USING BTREE,
	CONSTRAINT `FK__customer` FOREIGN KEY (`construction_customer_id`) REFERENCES `customer` (`construction_customer_id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;

//공사에 참여한 직원의 데이터를 저장한 테이블
CREATE TABLE `construction_employees` (
	`construction_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`employee_id` INT NOT NULL,
	PRIMARY KEY (`construction_id`, `employee_id`) USING BTREE,
	INDEX `employee_id` (`employee_id`) USING BTREE,
	CONSTRAINT `FK_construction_employees_construction` FOREIGN KEY (`construction_id`) REFERENCES `construction` (`construction_id`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `FK_construction_employees_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;

//공사 도면에 관한 데이터를 저장한 테이블
CREATE TABLE `drawing` (
	`drawing_id` INT NOT NULL AUTO_INCREMENT,
	`construction_id` INT UNSIGNED NOT NULL,
	`img_route` VARCHAR(150) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`img_sequence` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	PRIMARY KEY (`drawing_id`) USING BTREE,
	INDEX `FK__construction` (`construction_id`) USING BTREE,
	CONSTRAINT `FK__construction` FOREIGN KEY (`construction_id`) REFERENCES `construction` (`construction_id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;

//공사의 실제 시공비와 예측 시공비를 저장하는 테이블
CREATE TABLE `demand_price_result` (
	`construction_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`actual_price` INT NULL DEFAULT NULL,
	`forecast_price` INT NULL DEFAULT NULL,
	PRIMARY KEY (`construction_id`) USING BTREE,
	CONSTRAINT `FK__construction2` FOREIGN KEY (`construction_id`) REFERENCES `construction` (`construction_id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;

//각 날짜마다 실제 수요와 예측 수요를 저장하는 테이블
CREATE TABLE `demand_forecast_result` (
	`demand_id` INT NOT NULL AUTO_INCREMENT,
	`date` DATE NULL DEFAULT NULL,
	`actual_demand` INT NULL DEFAULT NULL,
	`forecast_demand` INT NULL DEFAULT NULL,
	PRIMARY KEY (`demand_id`) USING BTREE
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;
