String queryNote = '''
     CREATE TABLE if noT EXISTS note(
  
   id INTEGER  PRIMARY KEY  AUTOINCREMENT , 
   title TEXT,
   body TEXT NOT NULL,
   date TEXT NOT NULL
);

                ''';
