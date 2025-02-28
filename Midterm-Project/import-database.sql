-- MySQL Script generated by MySQL Workbench
-- Fri Feb 28 10:02:32 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bks
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bks` ;

-- -----------------------------------------------------
-- Schema bks
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bks` DEFAULT CHARACTER SET utf8 ;
USE `bks` ;

-- -----------------------------------------------------
-- Table `bks`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bks`.`Customers` ;

CREATE TABLE IF NOT EXISTS `bks`.`Customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(50) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `street_address` VARCHAR(255) NOT NULL,
  `city` VARCHAR(100) NOT NULL,
  `state` VARCHAR(50) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bks`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bks`.`Orders` ;

CREATE TABLE IF NOT EXISTS `bks`.`Orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date` VARCHAR(45) NOT NULL,
  `total_amount` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_Orders_Customers1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `bks`.`Customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bks`.`Vendors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bks`.`Vendors` ;

CREATE TABLE IF NOT EXISTS `bks`.`Vendors` (
  `vendor_id` INT NOT NULL AUTO_INCREMENT,
  `vendor_name` VARCHAR(45) NOT NULL,
  `contact_first_name` VARCHAR(45) NOT NULL,
  `contact_last_name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `street_address` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`vendor_id`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bks`.`Invoices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bks`.`Invoices` ;

CREATE TABLE IF NOT EXISTS `bks`.`Invoices` (
  `invoice_id` INT NOT NULL AUTO_INCREMENT,
  `vendor_id` INT NOT NULL,
  `invoice_number` INT NOT NULL,
  `invoice_date` VARCHAR(45) NOT NULL,
  `invoice_total` VARCHAR(45) NOT NULL,
  `terms` VARCHAR(45) NOT NULL,
  `invoice_due_date` VARCHAR(45) NOT NULL,
  `payment_date` VARCHAR(45),
  PRIMARY KEY (`invoice_id`),
  INDEX `fk_Invoices_Vendors_idx` (`vendor_id` ASC) VISIBLE,
  INDEX `idx_invoice_number` (`invoice_number` ASC) VISIBLE,
  UNIQUE INDEX `invoice_number_UNIQUE` (`invoice_number` ASC) VISIBLE,
  CONSTRAINT `fk_Invoices_Vendors`
    FOREIGN KEY (`vendor_id`)
    REFERENCES `bks`.`Vendors` (`vendor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bks`.`Shipments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bks`.`Shipments` ;

CREATE TABLE IF NOT EXISTS `bks`.`Shipments` (
  `shipment_id` INT NOT NULL AUTO_INCREMENT,
  `invoice_id` INT NOT NULL,
  `tracking_number` VARCHAR(45) NOT NULL,
  `shipment_date` VARCHAR(45) NOT NULL,
  `delivery_date` VARCHAR(45) NULL,
  `carrier_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`shipment_id`),
  UNIQUE INDEX `tracking_number_UNIQUE` (`tracking_number` ASC) VISIBLE,
  INDEX `fk_Shipments_Invoices1_idx` (`invoice_id` ASC) VISIBLE,
  CONSTRAINT `fk_Shipments_Invoices1`
    FOREIGN KEY (`invoice_id`)
    REFERENCES `bks`.`Invoices` (`invoice_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bks`.`Publishers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bks`.`Publishers` ;

CREATE TABLE IF NOT EXISTS `bks`.`Publishers` (
  `publisher_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `street_address` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `contact_email` VARCHAR(45) NOT NULL,
  `contact_phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`publisher_id`),
  UNIQUE INDEX `contact_email_UNIQUE` (`contact_email` ASC) VISIBLE,
  UNIQUE INDEX `contact_phone_UNIQUE` (`contact_phone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bks`.`Authors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bks`.`Authors` ;

CREATE TABLE IF NOT EXISTS `bks`.`Authors` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `bio` VARCHAR(45) NULL,
  `honorific` VARCHAR(45) NULL,
  PRIMARY KEY (`author_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bks`.`Books`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bks`.`Books` ;

CREATE TABLE IF NOT EXISTS `bks`.`Books` (
  `book_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `genre` VARCHAR(45) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `stock` VARCHAR(45) NOT NULL,
  `publisher_id` INT NOT NULL,
  `author_id` INT NOT NULL,
  `isbn` VARCHAR(45) NOT NULL,
  `publication_date` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE INDEX `isbn_UNIQUE` (`isbn` ASC) VISIBLE,
  INDEX `fk_Books_Publishers1_idx` (`publisher_id` ASC) VISIBLE,
  INDEX `fk_Books_Authors1_idx` (`author_id` ASC) VISIBLE,
  CONSTRAINT `fk_Books_Publishers1`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `bks`.`Publishers` (`publisher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Books_Authors1`
    FOREIGN KEY (`author_id`)
    REFERENCES `bks`.`Authors` (`author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bks`.`OrderDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bks`.`OrderDetails` ;

CREATE TABLE IF NOT EXISTS `bks`.`OrderDetails` (
  `order_detail_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `quantity` VARCHAR(45) NOT NULL,
  `unit_price` VARCHAR(45) NOT NULL,
  `subtotal` VARCHAR(45) NOT NULL,
  `update_date` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`order_detail_id`),
  INDEX `fk_OrderDetails_Orders1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_OrderDetails_Books1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_OrderDetails_Orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `bks`.`Orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderDetails_Books1`
    FOREIGN KEY (`book_id`)
    REFERENCES `bks`.`Books` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bks`.`Payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bks`.`Payments` ;

CREATE TABLE IF NOT EXISTS `bks`.`Payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `payment_date` VARCHAR(45) NOT NULL,
  `amount` VARCHAR(45) NOT NULL,
  `payment_method` VARCHAR(45) NOT NULL,
  `transaction_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE INDEX `transaction_id_UNIQUE` (`transaction_id` ASC) VISIBLE,
  INDEX `fk_Payments_Orders1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payments_Orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `bks`.`Orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
