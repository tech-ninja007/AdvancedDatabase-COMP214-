/*
To perform the following activities, refer to the tables in the JustLee Books database.

1. Create a view that lists the name and phone number of the contact person at each publisher. Don’t include the publisher’s ID in the view. Name the view CONTACT.

2. Change the CONTACT view so that no users can accidentally perform DML operations on the view.

3. Create a view called HOMEWORK13 that includes the columns named Col1 and Col2 from the FIRSTATTEMPT table. Make sure the view is created even if the FIRSTATTEMPT table doesn’t exist.

4. Attempt to view the structure of the HOMEWORK13 view.

5. Create a view that lists the ISBN and title for each book in inventory along with the name and phone number of the person to contact if the book needs to be reordered. Name the view REORDERINFO.

6. Try to change the name of a contact person in the REORDERINFO view to your name. Was an error message displayed when performing this step? If so, what was the cause of the error message?

7. Select one of the books in the REORDERINFO view and try to change its ISBN. Was an error message displayed when performing this step? If so, what was the cause of the error message?

8. Delete the record in the REORDERINFO view containing your name. (If you weren’t able to perform #6 successfully, delete one of the contacts already listed in the table.) Was an error message displayed when performing this step? If so, what was the cause of the error message?

9. Issue a rollback command to undo any changes made with the preceding DML operations.

10. Delete the REORDERINFO view.
*/
--1
create or replace view CONTACT
as select contact, phone
from publisher;
--2
create or replace view CONTACT
as select contact, phone
from publisher
with read only;
--3
CREATE FORCE VIEW HOMEWORK13
AS SELECT col1, col2 from firstattempt;

--4
DESC HOMEWORK13;
--5
CREATE OR REPLACE VIEW reorderinfo
as select pubid, isbn, title, contact, phone
from books join publisher using(pubid);
--6
update reorderinfo 
set contact = 'IKRAM'
where title = 'SHORTEST POEMS'; 
/*
SQL Error: ORA-01779: cannot modify a column which maps to a non key-preserved table
01779. 00000 -  "cannot modify a column which maps to a non key-preserved table"
*Cause:    An attempt was made to insert or update columns of a join view which
           map to a non-key-preserved table.
*Action:   Modify the underlying base tables directly. 
*/

--7
UPDATE reorderinfo
set contact='IKRAM' 
where isbn='2147428890';
/*
ORA-02292: integrity constraint (COMP214_W23_ZO_19.ORDERITEMS_ISBN_FK) violated - child record found
*/

--8
delete from reorderinfo where contact='JANE TOMLIN';
/*
Error report -
ORA-02292: integrity constraint (COMP214_W23_ZO_19.ORDERITEMS_ISBN_FK) violated - child record found
*/

--9
rollback;

--10
drop view reorderinfo;

