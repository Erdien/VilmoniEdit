/** that's just second page of inputs */
class PreGroup extends Tuple {
  PreGroup[] kid;
  void drawMe() {
    if(this.objs!=null)
    for (int i=0; i<this.objs.length; i++) {
      pushMatrix();
      translate(this.x, this.y);
      if (this.objs[i].shown)
        this.objs[i].drawMe();
      popMatrix();
    }
    if(this.kid!=null)
    for (int i=0; i<this.kid.length; i++) {
      pushMatrix();
      translate(this.x, this.y);
      if (this.kid[i].shown)
        this.kid[i].drawMe();
      popMatrix();
    }
  }
  boolean isPressed(int x, int y) {
    boolean toReturn=false;
    if (this.objs!=null)
    for (int i=0; i<this.objs.length; i++) {
      if (this.objs[i].shown && this.objs[i].isPressed(this.x+x, this.y+y)) {
        this.pressed=true;
        this.action();
        toReturn = true;
      }
    }
    if (this.kid!=null)
    for (int i=0; i<this.kid.length; i++) {
      if (this.kid[i].shown && this.kid[i].isPressed(this.x+x, this.y+y)) {
        this.pressed=true;
        this.action();
        toReturn = true;
      }
    }
    if (toReturn) return true;
    this.pressed=false;
    return false;
  }
  boolean isPressed() {
    return isPressed(0, 0);
  }
}
class Group extends PreGroup {
  Group(int x, int y, PreGroup[] objs) {
    this.x=x;
    this.y=y;
    this.kid=objs;
  }
  Group(int x, int y, Place[] objs) {
    this.x=x;
    this.y=y;
    this.objs=objs;
  }
  Group(int x, int y, Place[] objs, PreGroup[] kid) {
    this.x=x;
    this.y=y;
    this.objs=objs;
    this.kid=kid;
  }
}
class Slider extends Tuple {
  final int buttonwid = sldBtn;
  Slider(int x, int y, int scrollwid, int value, int maxValue, String name) {
    this.x=x;
    this.y=y;
    this.value=value;
    this.wid=scrollwid;
    this.objs=new Place[]{
      new Scroll(buttonwid+margin, buttonwid/2, scrollwid, value, maxValue, name), 
      new Button(0, 0, buttonwid, buttonwid, "-"), 
      new Button(buttonwid+margin*2+scrollwid, 0, buttonwid, buttonwid, "+")
    };
  }
  private void updateValue() {
    this.value = objs[0].value;
  }
  void action() {
    if (this.objs[1].touched)
      this.objs[0].value--;
    if (this.objs[2].touched)
      this.objs[0].value++;
    this.objs[0].value=clamp(this.objs[0].value, 0, this.objs[0].barmax);
    updateValue();
  }
  void valueSet(int value){
    value=clamp(value, -1, this.objs[0].barmax);
    if (value<0)
      this.objs[0].pressed = false;
    else{
      this.value = value;
      this.objs[0].value = value;
    }
    
  }
}
/*class NumBox extends Tuple{
 NumBox(int x, int y, int wid, int value, String name){
 this.x=x;
 this.y=y;
 this.value=value;
 this.name=name;
 this.objs=new Place[]{
 new TextBox(0, 0, wid, rowHei, str(value)),
 new Button(wid, 0, rowHei, rowHei/2, "+"),
 new Button(wid, rowHei/2, rowHei, rowHei/2, "-")
 };
 }
 }*/
class ColorTabs extends Tuple{
  PImage mask;
  ColorTabs(int x, int y, int wid, int hei, boolean orientation, int amount, int value) {
    this(x, y, wid, hei, orientation, amount, value, new String[0]);
  }
  ColorTabs(int x, int y, int wid, int hei, boolean orientation, int amount, int value, String[] names) {
    this.x=x;
    this.y=y;
    this.objs=new Place[amount];
    for (int i=0; i<amount; i++)
      if (orientation)
        this.objs[i]=new Switch(floor(i%(wid/hei))*hei, floor(i/(wid/hei))*hei, hei, hei, names.length>i?names[i]:str(i));
      else
        this.objs[i]=new Switch(floor(i/(wid/hei))*hei, floor(i%(wid/hei))*hei, hei, hei, names.length>i?names[i]:str(i));
        //this.objs[i]=new Switch(floor(i/(hei/wid))*wid, floor(i%(hei/wid))*wid, wid, wid, names.length>i?names[i]:str(i));
    this.wid=wid;
    this.hei=hei;
    mask = createImage(hei, hei, ARGB);
    mask.loadPixels();
    for(int bx=4; bx<hei-3; bx++) {
      mask.pixels[4*hei+bx]=color((bx>>2)%2*255);
      mask.pixels[(hei-4)*hei+bx]=color((bx>>2)%2*255);
      mask.pixels[bx*hei+4]=color((bx>>2)%2*255);
      mask.pixels[bx*hei+hei-4]=color((bx>>2)%2*255);
    }
    mask.updatePixels();
    this.objs[value].pressed=true;
    this.value=value;
  }
  void drawMe(){
    for (int i=0; i<this.objs.length; i++) {
      pushMatrix();
      translate(this.x, this.y);
      if (this.objs[i].shown){
        fill(colors[i]);
        rect(this.objs[i].x, this.objs[i].y, this.objs[i].wid, this.objs[i].hei);
        fill(0);
        textAlign(CENTER, CENTER);
        text(this.objs[i].name, this.objs[i].x+this.objs[i].wid/2, this.objs[i].y+this.objs[i].hei/2);
        if (this.objs[i].pressed)
          image(mask, this.objs[i].x, this.objs[i].y);
      }
      popMatrix();
    }
  }
  boolean isPressed(int x, int y) {
    this.touched=false;
    for (int i=0; i<objs.length; i++) {
      boolean beforeValue=false;
      if (this.objs[i].pressed==true)
        beforeValue=true;
      if (this.objs[i].isPressed(this.x+x, this.y+y)) {
        this.pressed=true;
      }
      else if (beforeValue==true)
        objs[i].pressed=true;
      if (this.objs[i].touched)
        this.touched=true;
    }
    this.action();
    return true;
  }
  void action() {
    if (this.touched) {
      boolean onlyOne = false;
      for (int i=0; i<objs.length; i++)
        if (this.objs[i].touched && !onlyOne) {
          this.objs[i].pressed=true;
          this.value=i;
          onlyOne=true;
        } else if (touches.length>ptouches || onlyOne) {
          this.objs[i].pressed=false;
          this.objs[i].touched=false;
        }
      for (int i=0; i<objs.length; i++)
        if (!this.objs[i].touched)
          this.objs[i].pressed=false;
    }
  }
  void valueSet(int value){
    for(int i=0; i<objs.length; i++){
      this.objs[i].pressed = false;
    }
    this.value=clamp(value, 0, objs.length);
    if (this.value>0){
      this.objs[this.value-1].pressed=true;
    }
  }
}
class Tabs extends PreGroup {
  Tabs(int x, int y, int wid, int hei, boolean orientation, Group[] kid, String[] names) {
    this.x=x;
    this.y=y;
    this.objs=new Place[kid.length];
    for (int i=0; i<kid.length; i++)
      if (orientation)
        this.objs[i]=new Switch(i*wid, 0, wid, hei, names.length>i?names[i]:("Tab"+(i+1)));
      else
        this.objs[i]=new Switch(0, i*hei, wid, hei, names.length>i?names[i]:("Tab"+(i+1)));
    this.wid=orientation?wid*kid.length:wid;
    this.hei=orientation?hei:hei*kid.length;
    this.kid=kid;
    for(PreGroup i : this.kid)
      i.shown=false;
  }
  boolean isPressed(int x, int y) {
    boolean toReturn=false;
    this.touched=false;
    for (int i=0; i<objs.length; i++) {
      if (this.objs[i].shown && this.objs[i].isPressed(this.x+x, this.y+y)) {
        if(this.kid[i].shown)
          this.kid[i].isPressed(this.x+x, this.y+y);
        this.pressed=true;
        if (this.objs[i].touched)
          this.touched=true;
        if (!this.objs[i].pressed && this.value==i+1)
          this.value=0;
        this.kid[i].shown = this.objs[i].pressed;
        //this.kid[i].shown = this.kid[i].shown?true:this.objs[i].touched;
        toReturn = true;
      }
    }
    this.action();
    if (toReturn) return true;
    this.pressed=false;
    return false;
  }
  void action() {
    if (this.touched) {
      boolean onlyOne = false;
      for (int i=0; i<objs.length; i++)
        if (this.objs[i].touched && !onlyOne) {
          this.objs[i].pressed=true;
          this.kid[i].shown=true;
          this.value=i+1;
          onlyOne=true;
        } else if (touches.length>ptouches || onlyOne) {
          this.objs[i].pressed=false;
          this.objs[i].touched=false;
          this.kid[i].shown=false;
        }
      for (int i=0; i<objs.length; i++)
        if (!this.objs[i].touched){
          this.objs[i].pressed=false;
          this.kid[i].shown=false;
        }
    }
  }
  void valueSet(int value){
    for(int i=0; i<objs.length; i++){
      this.objs[i].pressed = false;
      this.kid[i].shown = false;
    }
    this.value=clamp(value, 0, objs.length);
    if (this.value>0){
      this.objs[this.value-1].pressed=true;
      this.kid[this.value-1].shown=true;
    }
  }
}
class TextBoxes extends PreGroup{
  TextBoxes(int x, int y, TextBox[] objs) {
    this.x=x;
    this.y=y;
    this.objs=objs;
  }
  boolean isPressed(int x, int y) {
    boolean toReturn=false;
    for (int i=0; i<objs.length; i++) {
      if (this.objs[i].shown && this.objs[i].isPressed(this.x+x, this.y+y)) {
        this.pressed=true;
        if (this.objs[i].touched)
          this.touched=true;
        toReturn = true;
      }
    }
    this.action();
    this.touched=false;
    if (toReturn) return true;
    this.pressed=false;
    return false;
  }
  void action() {
    if (this.touched) {
      boolean onlyOne = false;
      for (int i=0; i<objs.length; i++)
        if (this.objs[i].touched && !onlyOne) {
          if(selectedTextBox==null)
          openKeyboard();
          selectedTextBox=this.objs[i];
          this.objs[i].pressed=true;
          onlyOne=true;
        } else if (touches.length>ptouches || onlyOne) {
          this.objs[i].pressed=false;
          this.objs[i].touched=false;
        }
      for (int i=0; i<objs.length; i++)
        if (!this.objs[i].touched)
          this.objs[i].pressed=false;
      if(!onlyOne){
        selectedTextBox=null;
      }
    }
    if(!this.pressed){
      selectedTextBox=null;
      closeKeyboard();
    }
  }
}