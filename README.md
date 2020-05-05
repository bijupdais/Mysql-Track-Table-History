# Mysql-Track-Table-History
Involves creation of triggers to a table and keeping track of the changes(insert/update/delete) by using a new table which is similar to the original one, but with some additional columns.

Steps:
1. Please do the following string replacements in the track_mysql_table_history.sql file before executing in the Mysql database:
    a. Replace the string 'MyDB' with the name of your database.
    b. Replace the string 'data' with the name of the table to be tracked.
2. Run the SQL file in your Mysql database.
3. Thats all.

Explanation:
Basically this system uses a new table(<originaltablename>_history) to track all changes to the table. We use the below triggers for tracking the changes:
  a. AFTER INSERT
  b. AFTER UPDATE
  c. BEFORE DELETE

On each trigger, we have an insert to the history table.
