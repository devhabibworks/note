-- code used to create table 

CREATE TABLE if noT EXISTS note(
  
   id INTEGER  PRIMARY KEY  AUTOINCREMENT , 
   title TEXT,
   body TEXT NOT NULL,
   date TEXT NOT NULL
);

--code used to insert new values
INSERT into note VALUES( null, "titl1" , "body1" , "date1");

--select all values 
SELECT * from note;

--select with connition
SELECT * from note WHERE id = 1;

--update table
UPDATE note set 
body = "Nawaf is late"
WHERE id = 1;

-- delet value from table
DELETE FROM note
WHERE id = 1;

--delete column from table
ALTER TABLE TABLENAME DROP COLUMN COLUMNNAME