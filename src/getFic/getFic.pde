import org.jsoup.*;
import org.jsoup.nodes.*;
import org.jsoup.internal.*;
import org.jsoup.parser.*;
import org.jsoup.safety.*;
import org.jsoup.select.*;
import org.jsoup.helper.*;
import java.util.*;
import processing.serial.*;
Serial arduino;
int i = 0;
String ficId = "";

public void setup() {
  String portName = Serial.list()[0];
  arduino = new Serial(this, portName, 9600);
}


void draw(){  
  println(i);
  if (arduino.available() > 0){
      println(arduino.readString());
      String para = getFic(ficId,i);
      arduino.write(para);
      i+=1;
  }
}


public static List<String> splitEqually(String text, int size) {
    List<String> ret = new ArrayList<String>((text.length() + size - 1) / size);
    for (int start = 0; start < text.length(); start += size) {
      String sub = text.substring(start, Math.min(text.length(), start + size));
      ret.add(sub);
    }
    return ret;
}


String getFic(String ao3Id, int element) {
  String[] attributesClassName = {"rating tags", "warning tags", "category tags", "fandom tags", "relationship tags", "character tags", "freeform tags", "language", "collections", "dl.stats", "title heading", "byline heading", "summary module", "notes module"};
  List<String> data = new ArrayList<String> ();
  String url = "https://www.archiveofourown.org/works/" + ao3Id;
  Document doc;
  try {
    doc = Jsoup.connect(url)
    .header("Accept-Encoding", "gzip, deflate")
    .userAgent("Mozilla/5.0 (Windows NT 6.1; WOW64; rv:23.0) Gecko/20100101 Firefox/23.0")
    .maxBodySize(0)
    .timeout(600000)
    .get();

  }
  catch (IOException e) {
    e.printStackTrace();
    doc = null;
  }

  if (doc != null) {
    for (String item : attributesClassName) {
      Elements att = doc.getElementsByClass(item);
      data.add(att.text()+"\n");
    }
    Elements body = doc.select("div.userstuff").select("p");
    for (Element item : body) {
      data.add(item.text()+"\n");
    }  
    String merged = String.join("\n", data);
    List<String> equal = splitEqually(merged, 150);
    return equal.get(element);
  }
  return "";
}
