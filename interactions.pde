/** triggers and actions */
void AllActions(){
  //image(myGenome.img, 0, 0, myGenome.ScrImgWid, myGenome.ScrImgHei);
  me.isPressed();
  //showInp();
  AllPresentFileAction();
  AllSetNewFilePos();
  AllUpdateAction();
  if (me.kid[0].kid[0].shown) GeneActions();
  if (me.kid[0].kid[1].shown) PixelActions();
  if (me.kid[0].kid[2].shown) SettingsActions();
  me.drawMe();
  PrepareArrow();
  ptouches=touches.length;
}
void PixelActions(){
  if (me.kid[0].kid[1].objs[3].touched) PixelInsertBeforeAction();
  if (me.kid[0].kid[1].objs[4].touched) PixelSetAction();
  if (me.kid[0].kid[1].objs[5].touched) PixelInsertAfterAction();
  if (me.kid[0].kid[1].objs[6].touched) PixelRemoveAction();
  PixelNowAction();
  PixelNewAction();
  
}
void GeneActions(){
  GeneSliderAction();
  GeneNewAction();
  if(me.kid[0].kid[0].objs[1].touched) GeneSetAction();
  if(me.kid[0].kid[0].kid[1].touched) GeneTabAction();
  GeneTypeAction();
}
void SettingsActions(){
  if(me.kid[0].kid[2].objs[0].touched) SettingsResetAction();
  if(me.kid[0].kid[2].objs[1].touched) SettingsSaveAction();
}
void AllPresentFileAction(){
  if(me.objs[1].touched){
    me.kid[0].kid[2].kid[0].objs[0].name=myGenome.path;
    me.kid[0].kid[1].kid[0].objs[0].name=myGenome.path;
    me.kid[0].kid[0].kid[0].objs[0].name=myGenome.path;
    }
    switch(me.kid[0].value){
      case 1:
        me.kid[0].kid[0].kid[0].objs[0].name=me.kid[0].kid[0].kid[0].objs[0].name;
        me.kid[0].kid[1].kid[0].objs[0].name=me.kid[0].kid[0].kid[0].objs[0].name;
        me.kid[0].kid[2].kid[0].objs[0].name=me.kid[0].kid[0].kid[0].objs[0].name;
      break;
      case 2:
        me.kid[0].kid[0].kid[0].objs[0].name=me.kid[0].kid[1].kid[0].objs[0].name;
        me.kid[0].kid[1].kid[0].objs[0].name=me.kid[0].kid[1].kid[0].objs[0].name;
        me.kid[0].kid[2].kid[0].objs[0].name=me.kid[0].kid[1].kid[0].objs[0].name;
      break;
      case 3:
        me.kid[0].kid[0].kid[0].objs[0].name=me.kid[0].kid[2].kid[0].objs[0].name;
        me.kid[0].kid[1].kid[0].objs[0].name=me.kid[0].kid[2].kid[0].objs[0].name;
        me.kid[0].kid[2].kid[0].objs[0].name=me.kid[0].kid[2].kid[0].objs[0].name;
      break;
      case 4:
        me.kid[0].kid[0].kid[0].objs[0].name="";
        me.kid[0].kid[1].kid[0].objs[0].name="";
      break;
      default:
    }
}
void AllSetNewFilePos(){
  Rect r = new Rect();
  myView.getWindowVisibleDisplayFrame(r);
  int fileBoxY=r.bottom-bottomMargin-rowHei*2-margin*2-textSize-textBoxPadding*2;
  me.objs[0].y=fileBoxY+margin+textSize+textBoxPadding*2;
  me.objs[1].y=fileBoxY+textSize/2+textBoxPadding-rowHei;
  me.objs[2].y=fileBoxY-textSize/2;
  me.kid[0].kid[0].kid[0].objs[0].y=fileBoxY;
  me.kid[0].kid[1].kid[0].objs[0].y=fileBoxY;
  me.kid[0].kid[2].kid[0].objs[0].y=fileBoxY;
}
void AllUpdateAction(){
  if (me.objs[0].touched){
    try{
      String file = myContext.getExternalFilesDir(Environment.DIRECTORY_PICTURES).getAbsolutePath()+"/"+me.kid[0].kid[0].kid[0].objs[0].name+".png";
      if (!new File(file).getParentFile().exists())
        new File(file).getParentFile().mkdir();
      println(file);
      myGenome.img.save(file);
      
      ContentValues values = new ContentValues();
      values.put(MediaStore.Images.Media.TITLE, file.split("/")[file.split("/").length-1]);
      values.put(MediaStore.Images.Media.DATE_TAKEN, System.currentTimeMillis ());
      values.put("_data", file);
  
      ContentResolver cr = myContext.getContentResolver();
      cr.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values);
      
    }catch(Exception e){
      println(e);
    }
    //println(Environment.getExternalStoragePublicDirectory(""));
    //println(myContext.getExternalMediaDirs());
    //println(MediaStore.Images.Media.getContentUri(""));
    
  }
}
void AllAfterImgSizChange(){  //a little bit messy, sorry for that
  for(int i=0;i<3;i++)    //major creature card image
    me.kid[0].kid[i].objs[0] = new Image(-margin, -margin-myGenome.ScrImgHei, myGenome.ScrImgWid, myGenome.ScrImgHei, myGenome.img);
  for(int i = 0; i<me.kid[0].kid.length;i++){
    me.kid[0].kid[i].x=margin-myGenome.ScrImgWid;  //every top GroupBox x cord
    me.kid[0].kid[i].y=margin+myGenome.ScrImgHei;  //every top GroupBox y cord
    me.kid[0].kid[i].kid[0].y=-margin-myGenome.ScrImgHei;  //every File name textbox
  }
  me.kid[0].kid[0].kid[0].objs[1].y=6*margin+6*resizedPSiz+myGenome.ScrImgHei;
  int pTab=me.kid[0].kid[0].kid[1].value;
    me.kid[0].kid[0].kid[1]=new Tabs(-margin, -margin,
      sldBtn*2, (float)(height-myGenome.ScrImgHei)/myGenome.genes.size(),
      false, groupAssign(geneX, sldBtn*2-myGenome.ScrImgHei+textSize, myGenome.genes.toArray(new Place[myGenome.genes.size()])),
      SelectNames());
    me.kid[0].kid[0].kid[1].valueSet(pTab);     //gene tabs
    me.kid[0].kid[0].kid[2].y=sldBtn*2-myGenome.ScrImgHei+2*textSize;   //gene new gene outer
    me.kid[0].kid[0].objs[11].y=sldBtn*2-myGenome.ScrImgHei-margin;     //gene Now label
}
void PrepareArrow(){
  switch (me.kid[0].value){
    case 1:
      if (me.kid[0].kid[0].kid[1].value != 0)
        myGenome.drawArrow(0, 0, myGenome.genes.get(me.kid[0].kid[0].kid[1].value-1).begin);
    break;
    case 2:
      myGenome.drawArrow(0, 0, me.kid[0].kid[1].objs[1].value);
    break;
    case 3:
      
    break;
    default:
  }
}
void PixelInsertBeforeAction(){
    myGenome.points.add(me.kid[0].kid[1].objs[1].value, new Pixel(1, colors[me.kid[0].kid[1].objs[2].value]));
    PixelChangeActions();
    int pSld=me.kid[0].kid[1].objs[1].value;
    me.kid[0].kid[1].objs[1]=new Slider(0, 0, me.kid[0].kid[1].objs[1].wid, 0, 0, myGenome.points.size()-1, me.kid[0].kid[1].objs[1].pressed, me.kid[0].kid[1].objs[1].touchId, "Pixel");
    me.kid[0].kid[1].objs[1].valueSet(constrain(pSld+1, 0, myGenome.points.size()-1));
}
void PixelSetAction(){
  if (me.kid[0].kid[1].objs[1].value<myGenome.points.size()){
    myGenome.points.set(me.kid[0].kid[1].objs[1].value, new Pixel(1, colors[me.kid[0].kid[1].objs[2].value]));
    PixelChangeActions();
    int pSld=me.kid[0].kid[1].objs[1].value;
    me.kid[0].kid[1].objs[1]=new Slider(0, 0, me.kid[0].kid[1].objs[1].wid, 0, 0, myGenome.points.size()-1, me.kid[0].kid[1].objs[1].pressed, me.kid[0].kid[1].objs[1].touchId, "Pixel");
    me.kid[0].kid[1].objs[1].valueSet(pSld);
  }
}
void PixelInsertAfterAction(){
    myGenome.points.add(constrain(me.kid[0].kid[1].objs[1].value+1, 0, myGenome.points.size()-1), new Pixel(1, colors[me.kid[0].kid[1].objs[2].value]));
    PixelChangeActions();
    int pSld=me.kid[0].kid[1].objs[1].value;
    me.kid[0].kid[1].objs[1]=new Slider(0, 0, me.kid[0].kid[1].objs[1].wid, 0, 0, myGenome.points.size()-1, me.kid[0].kid[1].objs[1].pressed, me.kid[0].kid[1].objs[1].touchId, "Pixel");
    me.kid[0].kid[1].objs[1].valueSet(pSld);
}
void PixelRemoveAction(){
  if (myGenome.points.size()-1>me.kid[0].kid[1].objs[1].value){
    myGenome.points.remove(me.kid[0].kid[1].objs[1].value);
    PixelChangeActions();
    int pSld=me.kid[0].kid[1].objs[1].value;
    me.kid[0].kid[1].objs[1]=new Slider(0, 0, me.kid[0].kid[1].objs[1].wid, 0, 0, myGenome.points.size()-1, me.kid[0].kid[1].objs[1].pressed, me.kid[0].kid[1].objs[1].touchId, "Pixel");
    me.kid[0].kid[1].objs[1].valueSet(pSld);
  }
}
void PixelChangeActions(){//protected
  myGenome.updateGenes();
  AllAfterImgSizChange();
}
void PixelNowAction(){
  int val = myGenome.points.get(constrain(me.kid[0].kid[1].objs[1].value, 0, myGenome.points.size()-1)).value;
  me.kid[0].kid[1].objs[8].value=colors[val];
  me.kid[0].kid[1].objs[8].name=val<12||val>15?str(val):"separator";
}
void PixelNewAction(){
  int val = me.kid[0].kid[1].objs[2].value;
  me.kid[0].kid[1].objs[9].value=colors[val];
  me.kid[0].kid[1].objs[9].name=val<12||val>15?str(val):"separator";
}
void GeneSliderAction(){//to update
  if (me.kid[0].kid[0].objs[3].value==1000){
    //println("to many accuracy");
    me.kid[0].kid[0].objs[2].valueSet(me.kid[0].kid[0].objs[2].value+1);
    me.kid[0].kid[0].objs[3].valueSet(0);
    me.kid[0].kid[0].objs[3].valueSet(-1);
  }
  if (me.kid[0].kid[0].objs[2].value>=100){
    me.kid[0].kid[0].objs[3].valueSet(0);
    me.kid[0].kid[0].objs[3].valueSet(-1);
    me.kid[0].kid[0].objs[2].valueSet(100);
  }
  if (me.kid[0].kid[0].objs[2].value==0)
    me.kid[0].kid[0].objs[2].valueSet(0);
}
void GeneNewAction(){
  if(me.kid[0].kid[0].kid[1].value!=0)
  switch(geneNames[compareSpieces(myGenome.genes.size())][compareSpieces(myGenome.genes.size())==5?0:me.kid[0].kid[0].kid[1].value-1].type) {
  case nan:
    text("unknown type",500,500);
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      parseLong(me.kid[0].kid[0].kid[0].objs[1].name), 0);
    return;
  case num:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      me.kid[0].kid[0].objs[2].value*1000+
      me.kid[0].kid[0].objs[3].value, 0);
    return;
  case text:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
    me.kid[0].kid[0].kid[0].objs[1].name, 0);
    return;
  case col:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      (me.kid[0].kid[0].objs[4].value<<16)+
      (me.kid[0].kid[0].objs[5].value<<8)+
      (me.kid[0].kid[0].objs[6].value), 0);
    return;
  case dress_wiggo:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      me.kid[0].kid[0].objs[7].value, 0);
    return;
  case dress_heddo:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      me.kid[0].kid[0].objs[8].value, 0);
    return;
  case dress_boddo:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      me.kid[0].kid[0].objs[9].value, 0);
    return;
  case dress_panto:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      me.kid[0].kid[0].objs[10].value, 0);
    return;
  default:
    text("unknown type",500,500);
    return;
  }
}
void GeneSetAction(){
  if(me.kid[0].kid[0].kid[1].value>0){
    myGenome.genes.set(me.kid[0].kid[0].kid[1].value-1, (Gene)me.kid[0].kid[0].kid[2].kid[0].objs[0]);
    GeneChangeActions();
    int pSld=me.kid[0].kid[1].objs[1].value;
    me.kid[0].kid[1].objs[1]=new Slider(0, 0, me.kid[0].kid[1].objs[1].wid, 0, myGenome.points.size()-1, "Pixel");
    me.kid[0].kid[1].objs[1].valueSet(pSld);
  }
}
void GeneTypeAction(){
  for(int i=2;i<11;i++)
    me.kid[0].kid[0].objs[i].shown=false;
  me.kid[0].kid[0].kid[0].objs[1].shown=false;
  GeneType type;
  if(me.kid[0].kid[0].kid[1].value==0) {
    me.kid[0].kid[0].objs[1].shown=false;
    return;
  } else me.kid[0].kid[0].objs[1].shown=true;
  if(compareSpieces(myGenome.genes.size())==geneNames.length-1)
    type = geneNames[geneNames.length-1][0];
  else
    type = geneNames[compareSpieces(myGenome.genes.size())][me.kid[0].kid[0].kid[1].value-1];
  for(Place elem : type.selectGeneInput())
    elem.shown=true;
  me.kid[0].kid[0].objs[1].y=4*margin+6*resizedPSiz+type.selectGeneInput().length*(margin+sldBtn);
}
void GeneTabAction(){
  me.kid[0].kid[0].kid[2].kid[0].y = resizedPSiz*(
    (me.kid[0].kid[0].kid[1].kid[me.kid[0].kid[0].kid[1].value-1].objs[0].value-1) /((width-geneX)/resizedPSiz)+1);
  me.kid[0].kid[0].objs[12].y = me.kid[0].kid[0].kid[2].kid[0].y+sldBtn*2-myGenome.ScrImgHei+2*margin-textSize;
  }
void GeneChangeActions(){//protected
  myGenome.updatePixel();
  AllAfterImgSizChange();
  me.kid[0].kid[0].kid[2].kid[0].y = resizedPSiz*(
    (me.kid[0].kid[0].kid[1].kid[me.kid[0].kid[0].kid[1].value-1].objs[0].value-1) /((width-geneX)/resizedPSiz)+1);
  me.kid[0].kid[0].objs[12].y = me.kid[0].kid[0].kid[2].kid[0].y+sldBtn*2-myGenome.ScrImgHei+2*margin-textSize;
  //me.x=myGenome.ScrImgWid;
 // me.kid[0].kid[1].x=
}
void SettingsResetAction(){
     /*setable:
  reset default (have to be easy accessible. and with hard position)
layout:
  margin
  row Height (min 10) 
  fileModuleHeight
  textsize (min 5)
  textbox padding
Micellanous:
  slider/colorSwitch in Pixel section
  sliders/text for integer values
  sliders/text for unknown type values
  the size of one pixel in code (only for non-standard creature cards)
  */
  /*
pSiz = 8;
resizedPSiz = 32;
rowHei = 30;
margin = 10;
textSize = 10;
sldBtn = 50;
bottomMargin=200;
*/
  JSONObject json = defaultSettings();
  //String[] jsonTrick = new String[]{json.toString()};
  saveJSONObject(json, sketchPath("")+"config.json");
  loadSettings();
  //pSiz=8;
  createGUI();
}
void SettingsSaveAction(){
  rowHei = me.kid[0].kid[2].kid[1].objs[0].value;
  sldBtn = me.kid[0].kid[2].kid[1].objs[1].value;
  margin = me.kid[0].kid[2].kid[1].objs[2].value;
  bottomMargin = me.kid[0].kid[2].kid[1].objs[3].value;
  textSize = me.kid[0].kid[2].kid[1].objs[4].value;
  textBoxPadding = me.kid[0].kid[2].kid[1].objs[5].value;
  
  pixel_Slider = me.kid[0].kid[2].kid[2].objs[0].pressed;
  number_Textbox = me.kid[0].kid[2].kid[2].objs[1].pressed;
  unknown_Slider = me.kid[0].kid[2].kid[2].objs[2].pressed;
  theme = me.kid[0].kid[2].kid[2].objs[3].value;
  pSiz = me.kid[0].kid[2].kid[2].objs[4].value;
  JSONObject json = saveSettings();
  saveJSONObject(json, sketchPath("")+"config.json");
  createGUI();
}

