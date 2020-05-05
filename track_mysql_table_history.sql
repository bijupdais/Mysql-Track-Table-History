/*Change the database/table names per requirements*/

CREATE TABLE MyDB.data_history LIKE MyDB.data;

ALTER TABLE MyDB.data_history MODIFY COLUMN primary_key_column int(11) NOT NULL, 
   DROP PRIMARY KEY, ENGINE = MyISAM, ADD action VARCHAR(8) DEFAULT 'insert' FIRST, 
   ADD revision INT(6) NOT NULL AUTO_INCREMENT AFTER action,
   ADD dt_datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER revision,
   ADD PRIMARY KEY (primary_key_column, revision);
   
   
DROP TRIGGER IF EXISTS MyDB.data__ai;
DROP TRIGGER IF EXISTS MyDB.data__au;
DROP TRIGGER IF EXISTS MyDB.data__bd;

CREATE TRIGGER MyDB.data__ai AFTER INSERT ON MyDB.data FOR EACH ROW
    INSERT INTO MyDB.data_history SELECT 'insert', NULL, NOW(), d.* 
    FROM MyDB.data AS d WHERE d.primary_key_column = NEW.primary_key_column;

CREATE TRIGGER MyDB.data__au AFTER UPDATE ON MyDB.data FOR EACH ROW
    INSERT INTO MyDB.data_history SELECT 'update', NULL, NOW(), d.*
    FROM MyDB.data AS d WHERE d.primary_key_column = NEW.primary_key_column;

CREATE TRIGGER MyDB.data__bd BEFORE DELETE ON MyDB.data FOR EACH ROW
    INSERT INTO MyDB.data_history SELECT 'delete', NULL, NOW(), d.* 
    FROM MyDB.data AS d WHERE d.primary_key_column = OLD.primary_key_column;