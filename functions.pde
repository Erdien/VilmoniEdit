/** random functions */
class Position {
  int x;
  int y;
  Position(int x, int y) {
    this.x=x;
    this.y=y;
  }
}
boolean isSimilar(color data, color check, int tollerance) { //tollerance is max distance
  int R1 = data >> 16 & 0xFF;
  int G1 = data >> 8 & 0xFF;
  int B1 = data & 0xFF;
  int R2 = check >> 16 & 0xFF;
  int G2 = check >> 8 & 0xFF;
  int B2 = check & 0xFF;
  float distance = sqrt(pow(R1-R2, 2)+pow(G1-G2, 2)+pow(B1-B2, 2));
  return distance<=tollerance;
}
color chain(int place, Genome code) {
  return code.img.get(
    code.beginPixel.x+floor(place%(code.img.width/pSiz))*pSiz, 
    code.beginPixel.y+floor(place/(code.img.width/pSiz))*pSiz
    );
    /*println(
      code.beginPixel.x+floor(place%(code.img.width/pSiz))*pSiz,
      code.beginPixel.y+floor(place/(code.img.width/pSiz))*pSiz,
      test);*/
      //return test;
}
//int digits(int value){
//  for(int i=1;;i++) {
//    if (value<12) return i;
//    value/=12;
//  }
//}
long parseLong(String value){
  try{
    return Long.parseLong(value);
  }catch(Exception e){return 0L;}
}
//String str(double val){
//  return "";
//}
int AlignedX(int shift, int where, int wid, int cellSiz) {
  return floor((shift/cellSiz+where)%(wid/cellSiz))*cellSiz;
}
int AlignedY(int shiftY, int shiftX, int where, int wid, int cellSiz) {
  return shiftY+floor((shiftX/cellSiz+where)/(wid/cellSiz))*cellSiz;
}
int idToTouch(int id) { //not used, can be used to upgrade touch/click event
  for (int i=0; i<touches.length; i++)
    if (touches[i].id==id) return i;
  return -1;
}
Group[] groupAssign(int x, int y, Place[] toAssign){
  Group[] result = new Group[toAssign.length];
  for(int i=0; i<toAssign.length; i++)
    result[i] = new Group(x, y, new Place[]{myGenome.genes.get(i)});
  return result;
}
String[] SelectNames(){
  GeneType[] carry = geneNames[compareSpieces(myGenome.genes.size())];
  String[] toReturn = new String[carry.length];
  for(int i=0; i<toReturn.length; i++)
    toReturn[i]=carry[i].name;
  return toReturn;
}
JSONObject defaultSettings(){
JSONObject json = new JSONObject();
  json.setInt("rowHei", 30);
  json.setInt("sldBtn", 50);
  json.setInt("margin", 10);
  json.setInt("bottomMargin", 0);
  json.setInt("textSize", 16);
  json.setInt("textBoxPadding", 7);
  json.setInt("pSiz", 8);
  json.setBoolean("pixel_Slider", false);
  json.setBoolean("number_Textbox", false);
  json.setBoolean("unknown_Slider", false);
  json.setInt("theme", 0);
  //json.setInt("textSize", 10);
  //json.setInt("resizedPSiz", 32);
  //println(json.toString());
  return(json);
}
import java.io.Reader.*;
void loadSettings(){
  JSONObject json = loadJSONObject(sketchPath("")+"config.json");
  rowHei = json.getInt("rowHei");
  sldBtn = json.getInt("sldBtn");
  margin = json.getInt("margin");
  bottomMargin = json.getInt("bottomMargin");
  textSize = json.getInt("textSize");
  textBoxPadding = json.getInt("textBoxPadding");
  pSiz = json.getInt("pSiz");
  pixel_Slider = json.getBoolean("pixel_Slider");
  number_Textbox = json.getBoolean("number_Textbox");
  unknown_Slider = json.getBoolean("unknown_Slider");
  theme = json.getInt("theme");
  //json.setInt("resizedPSiz", 32);
}
JSONObject saveSettings(){
JSONObject json = new JSONObject();
  json.setInt("rowHei", rowHei);
  json.setInt("sldBtn", sldBtn);
  json.setInt("margin", margin);
  json.setInt("bottomMargin", bottomMargin);
  json.setInt("textSize", textSize);
  json.setInt("textBoxPadding", textBoxPadding);
  json.setInt("pSiz", pSiz);
  json.setBoolean("pixel_Slider", pixel_Slider);
  json.setBoolean("number_Textbox", number_Textbox);
  json.setBoolean("unknown_Slider", unknown_Slider);
  json.setInt("theme", theme);
  //json.setInt("textSize", 10);
  //json.setInt("resizedPSiz", 32);
  return(json);
}
int compareSpieces(int genLen){
  switch(genLen){
    case 5:
      return 0;
    case 8:
      return 1;
    case 10:
      return 2;
    case 17:
      return 3;
    case 4:
      return 4;
    default:
      return 5;
  }
}