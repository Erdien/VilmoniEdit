/** random functions */
class Position {
  int x;
  int y;
  Position(int x, int y) {
    this.x=x;
    this.y=y;
  }
}
enum types {
    nan,
    num,
    text,
    col,
    dress_wiggo,//12
    dress_heddo,//24
    dress_boddo,//26
    dress_panto,//9
  };
class GeneType {
  String name;
  types type;
  GeneType(String name, types type) {
    this.name = name;
    this.type = type;
  }
  String getName(){
    return name;
  }
  Place[] selectGeneInput() {
    switch(this.type) {
    case nan :
      return new Place[]{
        me.kid[0].kid[1].kid[0].objs[1]
      };
    case num :
      return new Place[]{
        me.kid[0].kid[1].objs[1], 
        me.kid[0].kid[1].objs[2]
      };
    case text :
      return new Place[]{
        me.kid[0].kid[1].kid[0].objs[1]
      };
    case col:
      return new Place[]{
        me.kid[0].kid[1].objs[3], 
        me.kid[0].kid[1].objs[4], 
        me.kid[0].kid[1].objs[5]
      };
    case dress_wiggo:
      return new Place[]{
        me.kid[0].kid[1].objs[6]
      };
    case dress_heddo:
      return new Place[]{
        me.kid[0].kid[1].objs[7]
      };
    case dress_boddo:
      return new Place[]{
        me.kid[0].kid[1].objs[8]
      };
    case dress_panto:
      return new Place[]{
        me.kid[0].kid[1].objs[9]
      };
    default://same as nan
      return new Place[]{
        me.kid[0].kid[1].kid[0].objs[1]
      };
    }
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
    (code.beginPixel.x+pSiz*place)%code.img.width, 
    code.beginPixel.y+pSiz*floor(pSiz*place/code.img.width)
    );
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
    default:
     return 4;
  }
}