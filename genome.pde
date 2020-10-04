/** Genome and child classes */
class Pixel {
  int begin;
  int value;
  Pixel(int begin, color value) {
    this.begin=begin;
    this.value=setValue(value);
  }
  int setValue(color data) {
    for (int i=0; i<colors.length; i++)
      if (isSimilar(data, colors[i], 15))
        if (i==17 || i==18)//alt colors
          return i-12;     //make alt colors normal colors
        else
          return i;
    return colors.length-1;
  }
}
class Gene extends Place{
  ArrayList<Pixel> points;
  int begin=0;
  Gene(ArrayList<Pixel> points, int begin) {
    this.wid=resizedPSiz;
    this.hei=this.wid;
    for(int i=0;i<points.size();i++)
      this.value += points.get(i).value*pow(12, points.size()-i-1);
    this.name = str(this.value);
    this.points = points;
    this.value = points.size();
    this.begin = begin;
  }
  Gene(long value, int begin) {
    this.wid=resizedPSiz;
    this.hei=this.wid;
    if(value<=Integer.MAX_VALUE)
      this.name=str((int)value);
    else
      this.name=str(value);
    this.points = new ArrayList<Pixel>();
    //println( value, ((int)value%12L+12L)%12);
    for(int i=0;;i++){
      this.points.add(0, new Pixel(i,colors[(int)(value%12L)]));
      //value-=value%12;
      value/=12;
      if(value==0) break;
    }
    this.value=this.points.size();
    this.begin=begin;
  }
  Gene(String value, int begin) {
    this.wid=resizedPSiz;
    this.hei=this.wid;
    this.name=value;
    this.points = new ArrayList<Pixel>();
    int i=0;
    Charset targetCharset=Charset.forName("latin-1");
    if(value.length()>0) {
      boolean ability = targetCharset.newEncoder().canEncode(value.substring(value.length()-1));
    if (!ability)
      value=value.substring(0, value.length()-1);
    }
    //println(value);
    byte[] name=reverse(value.getBytes(targetCharset));
    //println("t1");
    for(int letter : name){
      letter=letter<0?letter+255:letter;
      //println(letter);
      for(;;i++){
        this.points.add(0, new Pixel(i,colors[int(letter)%12]));
        letter=letter/12;
        if(letter==0 && i%2==0) break;
      }
      //println(value, (i<digits(value)-1?"ex":"ne"), i, digits(value));
    }
    this.value = this.points.size();
    this.begin=begin;
  }
  void drawMe(){
    noStroke();
    for(int i=0; i<points.size(); i++){
      fill(colors[this.points.get(i).value]);
      rect(floor(i%((width-geneX)/this.wid))*this.wid,
        this.y+floor(i/((width-geneX)/this.wid))*this.wid, 
        this.hei, this.hei);
    }
    fill(0);
    text(this.name, this.x+100, this.y-textSize);
    stroke(0);
  }
  boolean isPressed(int x, int y) {//untouchable
    return false;
  }
}
class Genome {
  Position beginPixel;
  ArrayList<Pixel> points = new ArrayList<Pixel>();
  ArrayList<Gene> genes = new ArrayList<Gene>();
  PImage img;
  int ScrImgWid;
  int ScrImgHei;
  String path;
  Genome(String path) {
    this.img=loadImage(path);
    this.path=path.split("/")[path.split("/").length-1];
    this.path=this.path.split("\\.")[0];
    quickSetup();
    getBegin();
    int gBeg=0;
    int mayLast=-1;
    for(int i=0;;i++) {
      this.points.add(new Pixel(i, chain(i, this)));
      if (this.points.get(i).value>11 && this.points.get(i).value<16){//is separator
        if (gBeg==i && mayLast==-1) mayLast=i-1;
        else if (gBeg!=i) mayLast=-1;
        if (mayLast==-1 && i!=0)
          this.genes.add(new Gene(new ArrayList<Pixel>(this.points.subList(gBeg, i)), gBeg));
        if (i*pSiz/this.img.width==(this.img.height-beginPixel.y-floor(pSiz/2))/pSiz+1){
          this.points.subList(mayLast==-1?i:mayLast, this.points.size()-1).clear();
          break;
        }
        //if (mayLast==-1 && i!=0)
        //  this.genes.add(new Gene(new ArrayList<Pixel>(this.points.subList(gBeg, i)), gBeg));
        gBeg=i+1;
      }
    }
  }
  void quickSetup(){
    final int spaceX = sldBtn*4;
    final int spaceY = margin*3+rowHei+sldBtn + (sldBtn+margin)*4+sldBtn*4;
      this.ScrImgWid=(this.img.width<width-spaceX)?this.img.width:width-spaceX;
      this.ScrImgHei=this.img.height*this.ScrImgWid/this.img.width;
    if ((this.img.height<height-spaceY?this.img.height:height-spaceY)<this.ScrImgHei) {
      this.ScrImgHei=(this.img.height<height-spaceY)?this.img.height:height-spaceY;
      this.ScrImgWid=this.img.width*this.ScrImgHei/this.img.height;
    }
  }
  private void getBegin() {
    for (int point=this.img.height-ceil(pSiz/2); point>0; point-=pSiz)
      if (isSimilar(this.img.get(floor(pSiz/2), point), colors[16], 8)) {
        this.beginPixel = new Position(floor(pSiz/2), point+pSiz);
        break;
      }
    if (this.beginPixel==null) {
      noLoop();
      exit();
    }
    
  }
  void drawArrow(int startX, int startY, int where){
    pushMatrix();
    noStroke();
    fill(0);
    translate(startX, startY);
    translate(this.beginPixel.x*this.ScrImgWid/this.img.width, this.beginPixel.y*this.ScrImgHei/this.img.height);
    translate(floor(where%(this.img.width/pSiz))*pSiz*this.ScrImgWid/this.img.width,
      floor(where/(this.img.width/pSiz))*pSiz*this.ScrImgHei/this.img.height);
    //translate(where*pSiz%this.img.width*this.ScrImgWid/this.img.width, 
    //  floor(where*pSiz/this.img.width)*pSiz*this.ScrImgHei/this.img.height);
    triangle(10,-20,-10,-20,0,0);
    stroke(0);
    popMatrix();
  }
  void updateGenes(){
    PGraphics newimg = createGraphics(this.img.width,
      this.beginPixel.y+floor(pSiz/2)+pSiz*floor((this.beginPixel.x-floor(pSiz/2)+pSiz*this.points.size())/this.img.width));
    newimg.beginDraw();
    newimg.noStroke();
    newimg.fill(0);
    newimg.rect(0, beginPixel.y-floor(pSiz/2), newimg.width, newimg.height);
    newimg.image(this.img,0,0);
    newimg.image(loadImage("watermark.png"), 0, 0);
    this.genes=new ArrayList<Gene>();
    int gBeg=0;
    int mayLast=-1;
    for(int i=0;;i++){
      if (i>=this.points.size())
        this.points.add(new Pixel(i, chain(i, this)));
      if (this.points.get(i).value>11 && this.points.get(i).value<16){//is separator
        if (gBeg==i && mayLast==-1) mayLast=i-1;
        else if (gBeg!=i) mayLast=-1;
        if (mayLast==-1 && i!=0)
          this.genes.add(new Gene(new ArrayList<Pixel>(this.points.subList(gBeg, i)), gBeg));
        if (i*pSiz/this.img.width==(this.img.height-beginPixel.y-floor(pSiz/2))/pSiz+1){
          this.points.subList(mayLast==-1?i:mayLast, this.points.size()-1).clear();
          newimg.fill(0);
          newimg.rect(floor((this.beginPixel.x/pSiz+i)%(this.img.width/pSiz))*pSiz,
            this.beginPixel.y-floor(pSiz/2)+floor((this.beginPixel.x/pSiz+i)/(this.img.width/pSiz))*pSiz, 
            this.img.width-(this.beginPixel.x-floor(pSiz/2)+pSiz*i)%this.img.width, pSiz);
          break;
        }
        //if (mayLast==-1 && i!=0)
        //  this.genes.add(new Gene(new ArrayList<Pixel>(this.points.subList(gBeg, i)), gBeg));
        gBeg=i+1;
      }
      newimg.fill(colors[points.get(i).value]);
      newimg.rect(floor((this.beginPixel.x/pSiz+i)%(this.img.width/pSiz))*pSiz,
        this.beginPixel.y-floor(pSiz/2)+floor((this.beginPixel.x/pSiz+i)/(this.img.width/pSiz))*pSiz, 
        pSiz, pSiz);
        
        
      //newimg.rect((this.beginPixel.x-floor(pSiz/2)+pSiz*i)%this.img.width,
        //this.beginPixel.y-floor(pSiz/2)+pSiz*floor((this.beginPixel.x-floor(pSiz/2)+pSiz*i)/this.img.width), 
        //pSiz, pSiz);
    }
    newimg.endDraw();
    this.img = newimg.get();
    quickSetup();
  }
  void updatePixel(){
    int pointSize=1;
    for (Gene gene : this.genes)
      pointSize+=gene.value+1;
    println("ggg", pointSize, this.points.size());
    PGraphics newimg = createGraphics(this.img.width,
      this.beginPixel.y+floor(pSiz/2)+pSiz*floor((this.beginPixel.x-floor(pSiz/2)+pSiz*pointSize)/this.img.width));
    newimg.beginDraw();
    newimg.noStroke();
    newimg.fill(0);
    newimg.rect(0, beginPixel.y-floor(pSiz/2), newimg.width, newimg.height);
    newimg.image(this.img,0,0);
    newimg.image(loadImage("watermark.png"), 0, 0);
    this.points=new ArrayList<Pixel>();
    int i=0;
    int igen=0;
    for (Gene gene : this.genes) {
      this.genes.get(igen).begin=i;
      for (Pixel pix : gene.points) {
        this.points.add(new Pixel(i, colors[pix.value]));
        newimg.fill(colors[pix.value]);
        newimg.rect(floor((this.beginPixel.x/pSiz+i)%(this.img.width/pSiz))*pSiz,
        this.beginPixel.y-floor(pSiz/2)+floor((this.beginPixel.x/pSiz+i)/(this.img.width/pSiz))*pSiz, 
        pSiz, pSiz);
        i++;
      }
      this.points.add(new Pixel(i, colors[15/*random(4)*/]));
      newimg.fill(colors[this.points.get(i).value]);
      newimg.rect(floor((this.beginPixel.x/pSiz+i)%(this.img.width/pSiz))*pSiz,
        this.beginPixel.y-floor(pSiz/2)+floor((this.beginPixel.x/pSiz+i)/(this.img.width/pSiz))*pSiz, 
        pSiz, pSiz);
      i++;
      igen++;
    }
    newimg.rect((this.beginPixel.x-floor(pSiz/2)+pSiz*i)%this.img.width,
            this.beginPixel.y-floor(pSiz/2)+pSiz*floor((this.beginPixel.x-floor(pSiz/2)+pSiz*i)/this.img.width), 
            (this.img.width-(this.beginPixel.x-floor(pSiz/2)+pSiz*i)%this.img.width), pSiz);
    newimg.endDraw();
    this.img=newimg.get();
    quickSetup();
  }
}