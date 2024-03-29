/** basic components */
color highlight = 200;
color normal = 160;
color dark = 120;
color background = 192;
color textColor = 0;
class Place {
  int x=0;
  int y=0;
  int wid=0;
  int hei=0;
  int value=0;
  int barmax=1; //have to delete/make scroll only
  int barmin=0; //same as ^
  final int barhei=30; // not sure if same as ^
  final int barwid=15; // same as ^
  final int rowHei = 30;
  int touchId=-1;
  String name="";
  boolean touched=false;
  boolean pressed=false;
  boolean shown=true;
  void drawMe() {
    if (this.pressed)
      fill(highlight);
    else
      fill(normal);
    if (this.touched)
      fill(dark);
    rect(this.x, this.y, this.wid, this.hei);
    fill(textColor);
    textAlign(CENTER, CENTER);
    text(this.name, this.x+this.wid/2, this.y+this.hei/2);
  }
  boolean isPressed(int x, int y) {
    if (touches.length > ptouches) {
      for (int touch=0; touch < touches.length; touch++)
        if (touches[touch].x >= this.x+x &&
          touches[touch].x <= this.x+x+this.wid &&
          touches[touch].y >= this.y+y &&
          touches[touch].y <= this.y+y+this.hei) {
          this.pressed=true;
          return true;
        }
    } else if (touches.length == ptouches) return this.pressed;
    this.pressed=false;
    return false;
  }
  void action(){}
  void valueSet(int Value){}
}
class Button extends Place {
  Button(int x, int y, int wid, int hei, String name) {
    this.x=x;
    this.y=y;
    this.wid=wid;
    this.hei=hei;
    this.name=name;
  }
  void drawMe() {
    if (this.pressed)
      fill(dark);
    else
      fill(normal);
    rect(this.x, this.y, this.wid, this.hei);
    fill(textColor);
    textAlign(CENTER, CENTER);
    text(this.name, this.x+this.wid/2, this.y+this.hei/2);
  }
  boolean isPressed(int x, int y) {
    if (touches.length > ptouches) {
      for (int touch=0; touch < touches.length; touch++)
        if (touches[touch].x >= this.x+x &&
          touches[touch].x <= this.x+x+this.wid &&
          touches[touch].y >= this.y+y &&
          touches[touch].y <= this.y+y+this.hei) {
          this.pressed=true;
          this.touched=true;
          return true;
        }
    } else if (touches.length == ptouches) {
      this.touched=false;
      updateValue();
      return this.pressed;
    }
    this.touched=false;
    this.pressed=false;
    updateValue();
    return false;
  }
  private void updateValue() {
    if (this.pressed) this.value= 1;
    else this.value= 0;
  }
}
class Switch extends Place {
  Switch(int x, int y, int wid, int hei, String name) {
    this.x=x;
    this.y=y;
    this.wid=wid;
    this.hei=hei;
    this.name=name;
  }
  void drawMe() {
    if (this.pressed)
      fill(highlight);
    else
      fill(normal);
    if (this.touched)
      fill(dark);
    rect(this.x, this.y, this.wid, this.hei);
    fill(textColor);
    textAlign(CENTER, CENTER);
    text(this.name, this.x+this.wid/2, this.y+this.hei/2);
  }
  boolean isPressed(int x, int y) {
    if (touches.length > ptouches) {
      for (int touch=0; touch < touches.length; touch++)
        if (touches[touch].x >= this.x+x &&
          touches[touch].x <= this.x+x+this.wid &&
          touches[touch].y >= this.y+y &&
          touches[touch].y <= this.y+y+this.hei) {
          this.pressed=this.touched==false?!this.pressed:this.pressed;
          this.touched=this.pressed;
          updateValue();
          return this.pressed;
        }
    } else if (touches.length == ptouches) {
      updateValue();
      return this.pressed;
    }
    this.touched=false;
    updateValue();
    return true;
  }
  private void updateValue() {
    if (this.pressed) this.value=1;
    else this.value=0;
  }
}
class Scroll extends Place {
  int touchIndex=-1;
  Scroll(int x, int y, int wid, int value, int barmin, int barmax, String name) {
    this(x, y, wid, value, barmin, barmax, -1, name);
  }
  Scroll(int x, int y, int wid, int value, int barmin, int barmax, int touchId, String name) {
    this.x=x;
    this.y=y;
    this.wid=wid;
    this.hei=10;
    this.value=value;
    this.barmin=barmin;
    this.barmax=barmax;
    this.touchId=touchId;
    touchIndex=idToTouch(touchId);
    this.name=name;
  }
  void drawMe() {
    fill(normal);
    if (this.touched)
      fill(highlight);
    rect(this.x, this.y-this.hei/2, this.wid, this.hei);
    fill(highlight);
    rect(this.x+(this.value-this.barmin)*this.wid/(this.barmax-this.barmin)-this.barwid/2, this.y-this.barhei/2, this.barwid, this.barhei);
    fill(textColor);
    textAlign(CENTER, BOTTOM);
    text(this.name + ": " + this.value, this.x+this.wid/2, this.y-this.barhei/2);
  }
  boolean isPressed(int x, int y) {
    if (touches.length > ptouches) {
      for (int touch=0; touch < touches.length; touch++)
        if (touches[touch].x >= this.x+x &&
          touches[touch].x <= this.x+x+this.wid &&
          touches[touch].y >= this.y+y-this.hei &&
          touches[touch].y <= this.y+y+this.hei*2) {
          updateValue(x, y);
          this.touchId=touches[touch].id;
          touchIndex=touch;
          this.pressed=true;
          return true;
        } else if(touchId==touches[touch].id) {
          touchIndex=touch;
          return true;
        }
    } else if (touches.length == ptouches && this.pressed) {
      updateValue(x, y);
      return this.pressed;
    } else if (touches.length < ptouches) {
      touchIndex=idToTouch(this.touchId);
      if(touchIndex!=-1)
        return true;
    }
    touchId=-1;
    this.pressed=false;
    return false;
  } 
  private void updateValue(int x, int y){
    if (touchIndex!=-1)
      this.value=(int)round((touches[touchIndex].x-this.x-x)/this.wid*(this.barmax-this.barmin))+this.barmin;
    this.value=constrain(this.value, this.barmin, this.barmax);
  }
}
class TextBox extends Place {
  TextBox(int x, int y, int wid, int hei, String value) {
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hei = hei;
    this.name = value;
  }
  void drawMe() {
    if (this.pressed)
      fill(255);
    else
      fill(highlight);
    rect(this.x, this.y, this.wid, this.hei);
    fill(textColor);
    textAlign(LEFT,CENTER);
    text(this.name + (this.pressed?"_":""), this.x+2, this.y+this.hei/2);
  }
  boolean isPressed(int x, int y) {
    if (touches.length > ptouches) {
      for (int touch=0; touch < touches.length; touch++)
        if (touches[touch].x >= this.x+x &&
          touches[touch].x <= this.x+x+this.wid &&
          touches[touch].y >= this.y+y &&
          touches[touch].y <= this.y+y+this.hei) {
          this.pressed=this.touched==false?!this.pressed:this.pressed;
          this.touched=true;
          return false;
        } else{
          this.pressed=false;
          this.touched=false;
          return false;
        }
    } else if (touches.length == ptouches) {
      return this.pressed;
    }
    this.touched=false;
    return true;
  }
}
void keyPressed(){
  println(keyCode);
  if(selectedTextBox!=null){
  switch(keyCode){
  case 67:
    selectedTextBox.name = selectedTextBox.name.substring(0, max(0, selectedTextBox.name.length()-1));
    break;
  case 66:
    selectedTextBox.pressed=false;
    selectedTextBox.touched=false;
    closeKeyboard();
    selectedTextBox=null;
    break;
  default:
  if(((keyCode>28 && keyCode<55) || keyCode==62)) //for textBox
    selectedTextBox.name += key;
  else if(keyCode>6 && keyCode<17)              //for numpad //numpad is useles (slider)
    selectedTextBox.name += key;
  else if(keyCode==59 || keyCode==60 || 
    keyCode==24 || keyCode==25 || 
    keyCode==57 || keyCode==58){}
  else                                          //for testing
    selectedTextBox.name += key;
  }}else
  openKeyboard();
}
class Label extends Place {
  Label(int x, int y, int wid, int hei, String name, int... value){
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hei = hei;
    this.name = name;
    this.value = value.length!=0?value[0]:192;
  }
  Label(int x, int y, String name){
    this.x = x;
    this.y = y;
    this.name = name;
    }
  void drawMe(){
    fill(this.value);
    noStroke();
    rect(this.x, this.y, this.wid, this.hei);
    fill(textColor);
    if(this.hei>0)
      textAlign(LEFT, BOTTOM);
    else
      textAlign(LEFT, CENTER);
    text(this.name, this.x, this.y);
    stroke(0);
  }
  boolean isPressed(int x, int y) {//untouchable
    return false;
  }
}
class Image extends Place {
  PImage image;
  Image(int x, int y, PImage image){
    this.x = x;
    this.y = y;
    this.wid = image.width;
    this.hei = image.height;
    this.image = image;
  }
  Image(int x, int y, int wid, int hei, PImage image){
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hei = hei;
    this.image = image;

  }
  void drawMe(){
    image(this.image, this.x, this.y, this.wid, this.hei);
  }
}
class Tuple extends Place {
  Place[] objs;
  void drawMe() {
    for (int i=0; i<this.objs.length; i++) {
      pushMatrix();
      translate(this.x, this.y);
      if (this.objs[i].shown)
        this.objs[i].drawMe();
      popMatrix();
    }
  }
  boolean isPressed(int x, int y) {
    boolean toReturn=false;
    for (int i=0; i<objs.length; i++) {
      if (this.objs[i].shown && this.objs[i].isPressed(this.x+x, this.y+y)) {
        this.pressed=true;
        this.action();
        toReturn = true;
      }
    }
    if (toReturn) return true;
    this.pressed=false;
    return false;
  }
}