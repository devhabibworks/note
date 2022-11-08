String queryNote = '''
       CREATE TABLE if noT EXISTS note(
  
   ID INTEGER  PRIMARY KEY  AUTOINCREMENT , 
   TITLE TEXT,
   BODY TEXT NOT NULL,
   DATE TEXT NOT NULL
);

                ''';
