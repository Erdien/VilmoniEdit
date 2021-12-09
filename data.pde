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
  //String getName(){
  //  return name;
  //}
  Place[] selectGeneInput() {
    switch(this.type) {
    case nan:
      if(unknown_Slider){
        return new Place[]{
          me.kid[0].kid[0].objs[2], 
          me.kid[0].kid[0].objs[3]
        };
      }else{
        return new Place[]{
          me.kid[0].kid[0].kid[0].objs[1]
        };
      }
    case num:
      if(number_Textbox){
        return new Place[]{
          me.kid[0].kid[0].kid[0].objs[1]
        };
      }else{
        return new Place[]{
          me.kid[0].kid[0].objs[2], 
          me.kid[0].kid[0].objs[3]
        };
      }
    case text:
      return new Place[]{
        me.kid[0].kid[0].kid[0].objs[1]
      };
    case col:
      return new Place[]{
        me.kid[0].kid[0].objs[4], 
        me.kid[0].kid[0].objs[5], 
        me.kid[0].kid[0].objs[6]
      };
    case dress_wiggo:
      return new Place[]{
        me.kid[0].kid[0].objs[7]
      };
    case dress_heddo:
      return new Place[]{
        me.kid[0].kid[0].objs[8]
      };
    case dress_boddo:
      return new Place[]{
        me.kid[0].kid[0].objs[9]
      };
    case dress_panto:
      return new Place[]{
        me.kid[0].kid[0].objs[10]
      };
    default://same as nan
      return new Place[]{
        me.kid[0].kid[0].kid[0].objs[1]
      };
    }
  }
}
final color[] colors = new color[]{
  color(247, 0, 113), //red        0
  color(244, 91, 255), //pink       1
  color(98, 0, 222), //purple     2
  color(28, 122, 255), //blue       3
  color(20, 217, 246), //cyan       4
  color(0, 189, 177), //teal       5
  color(0, 164, 6), //dgreen     6
  color(71, 222, 21), //green      7
  color(158, 250, 0), //lime       8
  color(255, 252, 30), //yellow     9
  color(255, 188, 0), //orange     10
  color(255, 112, 24), //dorange    11
  //separators 
  color(153, 95, 66), //brown      12
  color(255, 255, 255), //white      13
  color(149, 149, 149), //gray       14
  color(0, 0, 0), //black      15
  //controll
  color(255, 255, 243), //bg         16
  color(20, 194, 183), //alt teal   17-12
  color(20, 171, 9), //alt dgreen 18-12
  color(89, 49, 27)     //none       19
};
final GeneType[][] geneNames = new GeneType[][]{
  {
    new GeneType("Unknown", types.nan), //GMO checker
    new GeneType("Metabo", types.num), //growth speed
    new GeneType("Hydro", types.num), //max hydration
    new GeneType("Distro", types.num), //width
    new GeneType("Name", types.text)
  }, 
  {
    new GeneType("Unknown", types.nan), 
    new GeneType("Wiggo", types.nan), 
    new GeneType("Heddo", types.nan), 
    new GeneType("Boddo", types.nan), 
    new GeneType("Panto", types.nan), 
    new GeneType("Senso", types.nan), 
    new GeneType("Noodo", types.nan), 
    new GeneType("Name", types.text)
  }, 
  {
    new GeneType("Unknown", types.nan), 
    new GeneType("Wiggo", types.dress_wiggo), //12
    new GeneType("Heddo", types.dress_heddo), //24
    new GeneType("Boddo", types.dress_boddo), //26
    new GeneType("Panto", types.dress_panto), //9
    new GeneType("Boddo\ncolor", types.col), 
    new GeneType("Eyo\ncolor", types.col), 
    new GeneType("Torso\ncolor", types.col), 
    new GeneType("Panto\ncolor", types.col), 
    new GeneType("Name", types.text)
  }, 
  {
    new GeneType("Unknown", types.nan), 
    new GeneType("Masso", types.num), 
    new GeneType("Metabo", types.num), 
    new GeneType("Bendo", types.num), 
    new GeneType("Flexo", types.num), 
    new GeneType("Leggo", types.num), 
    new GeneType("Senso", types.num), 
    new GeneType("Maho", types.num), 
    new GeneType("Mostro", types.num), 
    new GeneType("Motho", types.num), 
    new GeneType("Scecho", types.num), 
    new GeneType("Scestro", types.num), 
    new GeneType("Scetho", types.num), 
    new GeneType("Waho", types.num), 
    new GeneType("Wastro", types.num), 
    new GeneType("Watho", types.num), 
    new GeneType("Name", types.text)
  }, 
  {
    new GeneType("Unknown", types.nan), 
    new GeneType("type", types.text), 
    new GeneType("birth", types.col), 
    new GeneType("surrive", types.col)
  }, 
  {
    new GeneType("Tab1", types.nan)
  }
};