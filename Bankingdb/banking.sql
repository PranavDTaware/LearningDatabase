
CREATE DATABASE bankingdb;
use bankingdb;

CREATE TABLE accounts(
	account_id INT auto_increment primary key,
    holder varchar(50) not null,
    balance decimal(10,2) not null
);

INSERT INTO accounts (holder, balance) VALUES
('Sameer', 3000),
('Ritesh', 6000),
('Raj', 10000);

create table operations(
	operationid int auto_increment primary key,
    accountid int,
    date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) not null,
    operations_type varchar(50) not null,
    constraint fk_account_id foreign key (accountid) references accounts(account_id) on update cascade
    on delete cascade );
    
INSERT INTO operations (accountid, date_time, amount, operations_type) VALUES
('1', NOW(), 3000, 'D'),
('1', NOW(), 6000, 'W'),
('2', NOW(), 10000, 'D');


-- create store procedures

-- CREATE DEFINER=`root`@`localhost` PROCEDURE `spfundtransfer`(
-- 	IN from_accountid INT,
--     IN to_accountid INT,
--     IN sp_amount DECIMAL(10,2)
-- )
-- BEGIN
-- 	START TRANSACTION;
-- 		UPDATE accounts SET balance = balance + sp_amount
--         WHERE account_id = to_accountid;
--         INSERT INTO operations (accountid, date_time, amount, operations_type) 
--         VALUES(to_accountid, NOW(), sp_amount, 'D');
--         
--         UPDATE accounts SET balance = balance - sp_amount
--         WHERE account_id = from_accountid;
--         INSERT INTO operations (accountid, date_time, amount, operations_type) 
--         VALUES(from_accountid, NOW(), sp_amount, 'W');
--     COMMIT;
-- END


CALL spfundtransfer(2,1,500);



