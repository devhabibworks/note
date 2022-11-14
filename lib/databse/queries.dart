String queryNote = '''
     CREATE TABLE if noT EXISTS note(
  
   id INTEGER  PRIMARY KEY  AUTOINCREMENT , 
   title TEXT,
   body TEXT NOT NULL,
   date TEXT NOT NULL
);

                ''';

String queryStudent = '''
     CREATE TABLE if noT EXISTS Student(
  
   id INTEGER  PRIMARY KEY  AUTOINCREMENT , 
   name TEXT NOT NULL,
   class TEXT NOT NULL,
   mark  REAL ,
   date  TEXT NOT NULL
);

                ''';
