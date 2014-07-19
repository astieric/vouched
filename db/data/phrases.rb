columns = [ :id, :name ]
values = [
  [1,"Objective-C"],
  [2,"SEQUEL"],
  [3,"PL/SQL"],
  [4,"T-SQL"],
  [5,"Transact-SQL"],
  [6,"SQL-92"],
  [7,"SQL-1999"],
  [8,"SQL-2003"],
  [9,"VB.NET"],
  [10,"FoxPro"],
  [11,"xBase"],
  [12,"ASE"],
  [13,"Sybase SQL Server"],
  [14,"ADS"],
  [15,"CA Datacom"],
  [16,"Informix Dynamic Server"],
  [17,"Zend"],
  [18,"Rails"]
]

Phrase.import columns, values, :validate => false