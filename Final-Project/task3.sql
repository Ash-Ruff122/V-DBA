# task 3


DELIMITER //
DROP PROCEDURE ProcessSale;

CREATE PROCEDURE ProcessSale ()
BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE; 
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
		SET sql_error = TRUE; 
        
	START TRANSACTION; 
    INSERT INTO invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,terms,invoice_due_date,payment_date)
    VALUES (101, 42, 99987, '2025-07-14', 5250.32, 'Cash on delivery', '2025-07-28', NULL);
    
    IF sql_error = FALSE THEN 
		COMMIT;
        SELECT 'The transaction was committed.';
	ELSE 
		ROLLBACK; 
        SELECT 'The Transaction was rolled back.'; 
	END IF; 
END //

CALL ProcessSale;

select * 
from invoices

