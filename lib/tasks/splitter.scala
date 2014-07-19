import java.lang.String
import scala.io.Source  
import scala.util.matching.Regex
import java.io.FileWriter

def p (s: String){
  println (s)
}

def matchString (s: String): String = {
  val TableMatch = """^.*`(.*)`.*\n$""".r
  val TableMatch (result) = s
  result
}

var file_handler: java.io.FileWriter = null.asInstanceOf[java.io.FileWriter];

def parseFile () {
  for {  
    (line) <- Source.fromFile("db/development_seed.sql").getLines  
  } { 
    if (line.contains("Table structure for table")) { 
      val table_name = matchString(line)
      p ("=> Writing structure to file: " + table_name)
      if (file_handler != null.asInstanceOf[java.io.FileWriter]) {
        file_handler.close 
      }
      file_handler = new java.io.FileWriter("db/seeds/" + table_name + ".sql")
    }
    if (file_handler != null.asInstanceOf[java.io.FileWriter]) {
      file_handler.write(line)
    }
  }
}

parseFile()
