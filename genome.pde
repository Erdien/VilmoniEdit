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
  int begin;
  Gene(ArrayList<Pixel> points, int begin) {
    this.wid=resizedPSiz;
    this.hei=this.wid;
    this.points = points;
    this.begin = begin;
  }
  Gene(int value, int begin) {
    this.wid=resizedPSiz;
    this.hei=this.wid;
    this.points = new ArrayList<Pixel>();
    for(int i=0; i<floor(log(value)/log(12))+5; i++){
      this.points.add(0, new Pixel(i,colors[value%12]));
      value-=value%12;
      value=value/12;
    }
    //this.points = points;
    this.begin = begin;
  }
  void drawMe(){
    //println(floor(log(value)/log(12)));
    noStroke();
    for(int i=0; i<points.size(); i++){
      fill(colors[this.points.get(i).value]);
      rect(floor((this.x/this.wid+i)%
      ((width-geneX)/this.wid))*this.wid,
        this.y+(floor((this.x/this.wid+i)/((width-geneX)/this.wid)))*this.wid, this.hei, this.hei);
    }
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
  String path;
  Genome(String path) {
    this.img=loadImage(path);
    this.path=path.split("/")[path.split("/").length-1];
    this.path=this.path.split("\\.")[0];
    getBegin();
    int gBeg=0;
    int mayLast=-1;
    for(int i=0;;i++) {
      this.points.add(new Pixel(i, chain(i, this)));
      if (this.points.get(i).value>11 && this.points.get(i).value<16){//is separator
        if (gBeg==i && mayLast==-1) mayLast=i-1;
        else if (gBeg!=i) mayLast=-1;
        if (i*pSiz/this.img.width==(this.img.height-beginPixel.y-floor(pSiz/2))/pSiz+1){
          this.points.subList(mayLast==-1?i-1:mayLast, this.points.size()-1).clear();
          break;
        }
        if (mayLast==-1 && i!=0)
          this.genes.add(new Gene(new ArrayList<Pixel>(this.points.subList(gBeg, i)), gBeg));
        gBeg=i+1;
      }
    }
  }
  void drawMe(boolean pixelOrientation, boolean geneOrientation, Position begin) {
    if (pixelOrientation)
      if (geneOrientation)
      {
      }
  }
  private void getBegin() {
    for (int point=this.img.height-ceil(pSiz/2); point>0; point-=pSiz)
      if (isSimilar(this.img.get(floor(pSiz/2), point), colors[16], 8)) {
        this.beginPixel = new Position(floor(pSiz/2), point+pSiz);
        break;
      }
    if (this.beginPixel==null)
      //noLoop();
      exit();
    
  }
  void drawArrow(int startX, int startY, int where){
    pushMatrix();
    noStroke();
    fill(0);
    translate(startX, startY);
    translate(this.beginPixel.x, this.beginPixel.y);
    translate(where*pSiz%this.img.width, floor(where*pSiz/this.img.width)*pSiz);
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
      if (this.points.get(i).value>11 && this.points.get(i).value<16){//is separato
        if (gBeg==i && mayLast==-1) mayLast=i-1;
        else if (gBeg!=i) mayLast=-1;
        if (i*pSiz/this.img.width==(this.img.height-beginPixel.y-floor(pSiz/2))/pSiz+1){
          this.points.subList(mayLast==-1?i-1:mayLast, this.points.size()-1).clear();
          newimg.rect((this.beginPixel.x-floor(pSiz/2)+pSiz*i)%this.img.width,
            this.beginPixel.y-floor(pSiz/2)+pSiz*floor((this.beginPixel.x-floor(pSiz/2)+pSiz*i)/this.img.width), 
            (this.img.width-(this.beginPixel.x-floor(pSiz/2)+pSiz*i)%this.img.width), pSiz);
          break;
        }
        if (mayLast==-1 && i!=0)
          this.genes.add(new Gene(new ArrayList<Pixel>(this.points.subList(gBeg, i)), gBeg));
        gBeg=i+1;
      }
      newimg.fill(colors[points.get(i).value]);
      newimg.rect((this.beginPixel.x-floor(pSiz/2)+pSiz*i)%this.img.width,
        this.beginPixel.y-floor(pSiz/2)+pSiz*floor((this.beginPixel.x-floor(pSiz/2)+pSiz*i)/this.img.width), 
        pSiz, pSiz);
    }
    newimg.endDraw();
    this.img = newimg.get();
  }
  void updatePixel(){
    PGraphics newimg = createGraphics(this.img.width,
      this.beginPixel.y+floor(pSiz/2)+pSiz*floor((this.beginPixel.x-floor(pSiz/2)+pSiz*this.points.size())/this.img.width));
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
        newimg.rect((this.beginPixel.x-floor(pSiz/2)+pSiz*i)%this.img.width,
          this.beginPixel.y-floor(pSiz/2)+pSiz*floor((this.beginPixel.x-floor(pSiz/2)+pSiz*i)/this.img.width), 
          pSiz, pSiz);
        i++;
      }
      this.points.add(new Pixel(i, colors[15/*random(4)*/]));
      newimg.fill(colors[this.points.get(i).value]);
      newimg.rect((this.beginPixel.x-floor(pSiz/2)+pSiz*i)%this.img.width,
        this.beginPixel.y-floor(pSiz/2)+pSiz*floor((this.beginPixel.x-floor(pSiz/2)+pSiz*i)/this.img.width), 
        pSiz, pSiz);
      i++;
      igen++;
    }
    newimg.rect((this.beginPixel.x-floor(pSiz/2)+pSiz*i)%this.img.width,
            this.beginPixel.y-floor(pSiz/2)+pSiz*floor((this.beginPixel.x-floor(pSiz/2)+pSiz*i)/this.img.width), 
            (this.img.width-(this.beginPixel.x-floor(pSiz/2)+pSiz*i)%this.img.width), pSiz);
    newimg.endDraw();
    this.img=newimg.get();
  }
}
