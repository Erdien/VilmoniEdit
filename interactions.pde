/** triggers and actions */
void AllActions(){
  image(myGenome.img, 0, 0, myGenome.ScrImgWid, myGenome.ScrImgHei);
  me.isPressed();
  //showInp();
  AllPresentFileAction();
  AllSetNewFilePos();
  AllUpdateAction();
  PrepareArrow();
  if (me.kid[0].kid[1].shown) PixelActions();
  if (me.kid[0].kid[0].shown) GeneActions();
  me.drawMe();
  ptouches=touches.length;
}
void PixelActions(){
  if (me.kid[0].kid[1].objs[2].touched) PixelInsertBeforeAction();
  if (me.kid[0].kid[1].objs[3].touched) PixelSetAction();
  if (me.kid[0].kid[1].objs[4].touched) PixelInsertAfterAction();
  if (me.kid[0].kid[1].objs[5].touched) PixelRemoveAction();
  PixelNowAction();
  PixelNewAction();
  
}
void GeneActions(){
  GeneSliderAction();
  GeneNewAction();
  if(me.kid[0].kid[0].objs[0].touched) GeneSetAction();
  GeneTypeAction();
}
void AllPresentFileAction(){
  if(me.objs[1].touched){
    me.kid[0].kid[1].kid[0].objs[0].name=myGenome.path;
    me.kid[0].kid[0].kid[0].objs[0].name=myGenome.path;
    }
    switch(me.kid[0].value){
      case 1:
        me.kid[0].kid[1].kid[0].objs[0].name=me.kid[0].kid[1].kid[0].objs[0].name;
      break;
      case 2:
        me.kid[0].kid[0].kid[0].objs[0].name=me.kid[0].kid[0].kid[0].objs[0].name;
      break;
      case 3:
        me.kid[0].kid[0].kid[0].objs[0].name="";
        me.kid[0].kid[1].kid[0].objs[0].name="";
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
  int fileBoxY=r.bottom-sldBtn-2*margin-rowHei;
  me.objs[0].y=fileBoxY+rowHei+margin;
  me.objs[1].y=fileBoxY-margin;
  me.objs[2].y=fileBoxY-margin;
  me.kid[0].kid[0].kid[0].objs[0].y=fileBoxY;
  me.kid[0].kid[1].kid[0].objs[0].y=fileBoxY;
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
  for(int i = 0; i<me.kid[0].kid.length;i++){
    me.kid[0].kid[i].x=margin-myGenome.ScrImgWid;
    me.kid[0].kid[i].y=margin+myGenome.ScrImgHei;
    me.kid[0].kid[i].kid[0].y=-margin-myGenome.ScrImgHei;
  }
  me.kid[0].kid[0].kid[0].objs[1].y=6*margin+6*resizedPSiz+myGenome.ScrImgHei;
  int pTab=me.kid[0].kid[0].kid[1].value;
    me.kid[0].kid[0].kid[1]=new Tabs(-margin, -margin,
      sldBtn*2, (float)(height-myGenome.ScrImgHei)/myGenome.genes.size(),
      false, groupAssign(geneX, sldBtn*2-myGenome.ScrImgHei+textSize, myGenome.genes.toArray(new Place[myGenome.genes.size()])),
      SelectNames());
    me.kid[0].kid[0].kid[1].valueSet(pTab);
    me.kid[0].kid[0].kid[2].y=sldBtn*2-myGenome.ScrImgHei+2*textSize;
}
void PrepareArrow(){
  switch (me.kid[0].value){
    case 1:
    println( myGenome.genes.get(me.kid[0].kid[0].kid[1].value-1).begin );
      if (me.kid[0].kid[0].kid[1].value != 0)
        myGenome.drawArrow(0, 0, myGenome.genes.get(me.kid[0].kid[0].kid[1].value-1).begin);
    break;
    case 2:
      myGenome.drawArrow(0, 0, me.kid[0].kid[1].objs[0].value);
    break;
    case 3:
      
    break;
    default:
  }
}
void PixelInsertBeforeAction(){
    myGenome.points.add(me.kid[0].kid[1].objs[0].value, new Pixel(1, colors[me.kid[0].kid[1].objs[1].value]));
    PixelChangeActions();
    int pSld=me.kid[0].kid[1].objs[0].value;
    me.kid[0].kid[1].objs[0]=new Slider(0, 0, me.kid[0].kid[1].objs[0].wid, 0, 0, myGenome.points.size()-1, me.kid[0].kid[1].objs[0].pressed, me.kid[0].kid[1].objs[0].touchId, "Pixel");
    me.kid[0].kid[1].objs[0].valueSet(constrain(pSld+1, 0, myGenome.points.size()-1));
}
void PixelSetAction(){
  if (me.kid[0].kid[1].objs[0].value<myGenome.points.size()){
    myGenome.points.set(me.kid[0].kid[1].objs[0].value, new Pixel(1, colors[me.kid[0].kid[1].objs[1].value]));
    PixelChangeActions();
    int pSld=me.kid[0].kid[1].objs[0].value;
    me.kid[0].kid[1].objs[0]=new Slider(0, 0, me.kid[0].kid[1].objs[0].wid, 0, 0, myGenome.points.size()-1, me.kid[0].kid[1].objs[0].pressed, me.kid[0].kid[1].objs[0].touchId, "Pixel");
    me.kid[0].kid[1].objs[0].valueSet(pSld);
  }
}
void PixelInsertAfterAction(){
    myGenome.points.add(constrain(me.kid[0].kid[1].objs[0].value+1, 0, myGenome.points.size()-1), new Pixel(1, colors[me.kid[0].kid[1].objs[1].value]));
    PixelChangeActions();
    int pSld=me.kid[0].kid[1].objs[0].value;
    me.kid[0].kid[1].objs[0]=new Slider(0, 0, me.kid[0].kid[1].objs[0].wid, 0, 0, myGenome.points.size()-1, me.kid[0].kid[1].objs[0].pressed, me.kid[0].kid[1].objs[0].touchId, "Pixel");
    me.kid[0].kid[1].objs[0].valueSet(pSld);
}
void PixelRemoveAction(){
  if (myGenome.points.size()-1>me.kid[0].kid[1].objs[0].value){
    myGenome.points.remove(me.kid[0].kid[1].objs[0].value);
    PixelChangeActions();
    int pSld=me.kid[0].kid[1].objs[0].value;
    me.kid[0].kid[1].objs[0]=new Slider(0, 0, me.kid[0].kid[1].objs[0].wid, 0, 0, myGenome.points.size()-1, me.kid[0].kid[1].objs[0].pressed, me.kid[0].kid[1].objs[0].touchId, "Pixel");
    me.kid[0].kid[1].objs[0].valueSet(pSld);
  }
}
void PixelChangeActions(){//protected
  myGenome.updateGenes();
  AllAfterImgSizChange();
}
void PixelNowAction(){
  me.kid[0].kid[1].objs[7].value=colors[myGenome.points.get(constrain(me.kid[0].kid[1].objs[0].value, 0, myGenome.points.size()-1)).value];
  me.kid[0].kid[1].objs[7].name=str(myGenome.points.get(constrain(me.kid[0].kid[1].objs[0].value, 0, myGenome.points.size()-1)).value);
}
void PixelNewAction(){
  me.kid[0].kid[1].objs[8].value=colors[me.kid[0].kid[1].objs[1].value];
  me.kid[0].kid[1].objs[8].name=str(me.kid[0].kid[1].objs[1].value);
}
void GeneSliderAction(){//to fix
  if (me.kid[0].kid[0].objs[1].value==1000){
    me.kid[0].kid[0].objs[0].valueSet(me.kid[0].kid[0].objs[0].value+1);
    me.kid[0].kid[0].objs[1].valueSet(0);
    me.kid[0].kid[0].objs[1].valueSet(-1);
  }
  if (me.kid[0].kid[0].objs[0].value>=100){
    me.kid[0].kid[0].objs[1].valueSet(0);
    me.kid[0].kid[0].objs[1].valueSet(-1);
    me.kid[0].kid[0].objs[0].valueSet(100);
  }
  if (me.kid[0].kid[0].objs[0].value==0)
    me.kid[0].kid[0].objs[0].valueSet(0);
}
void GeneNewAction(){
  if(me.kid[0].kid[0].kid[1].value!=0)
  switch(geneNames[compareSpieces(myGenome.genes.size())][compareSpieces(myGenome.genes.size())==4?0:me.kid[0].kid[0].kid[1].value-1].type) {
  case nan:
    text("unknown type",500,500);
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      parseLong(me.kid[0].kid[0].kid[0].objs[1].name), 0);
    return;
  case num:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      me.kid[0].kid[0].objs[1].value*1000+
      me.kid[0].kid[0].objs[2].value, 0);
    return;
  case text:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
    me.kid[0].kid[0].kid[0].objs[1].name, 0);
    return;
  case col:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      (me.kid[0].kid[0].objs[3].value<<16)+
      (me.kid[0].kid[0].objs[4].value<<8)+
      (me.kid[0].kid[0].objs[5].value), 0);
    return;
  case dress_wiggo:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      me.kid[0].kid[0].objs[6].value, 0);
    return;
  case dress_heddo:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      me.kid[0].kid[0].objs[7].value, 0);
    return;
  case dress_boddo:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      me.kid[0].kid[0].objs[8].value, 0);
    return;
  case dress_panto:
    me.kid[0].kid[0].kid[2].kid[0].objs[0] = new Gene(
      me.kid[0].kid[0].objs[9].value, 0);
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
    int pSld=me.kid[0].kid[1].objs[0].value;
    me.kid[0].kid[1].objs[0]=new Slider(0, 0, me.kid[0].kid[1].objs[0].wid, 0, myGenome.points.size()-1, "Pixel");
    me.kid[0].kid[1].objs[0].valueSet(pSld);
  }
}
void GeneTypeAction(){
  for(int i=1;i<10;i++)
    me.kid[0].kid[0].objs[i].shown=false;
  me.kid[0].kid[0].kid[0].objs[1].shown=false;
  GeneType type;
  if(me.kid[0].kid[0].kid[1].value==0) {
    me.kid[0].kid[0].objs[0].shown=false;
    return;
  } else me.kid[0].kid[0].objs[0].shown=true;
  if(compareSpieces(myGenome.genes.size())==4)
    type = geneNames[4][0];
  else
    type = geneNames[compareSpieces(myGenome.genes.size())][me.kid[0].kid[0].kid[1].value-1];
  for(Place elem : type.selectGeneInput())
    elem.shown=true;
  me.kid[0].kid[0].objs[0].y=4*margin+6*resizedPSiz+type.selectGeneInput().length*(margin+sldBtn);
}
void GeneChangeActions(){//protected
  myGenome.updatePixel();
  AllAfterImgSizChange();
  me.kid[0].kid[0].kid[2].kid[0].y = resizedPSiz*(
    (me.kid[0].kid[0].kid[1].kid[me.kid[0].kid[0].kid[1].value-1].objs[0].value-1) /((width-geneX)/resizedPSiz)+1);
  println("gene_lines:", me.kid[0].kid[0].kid[1].kid[me.kid[0].kid[0].kid[1].value-1].objs[0].value-- ,(width-geneX)/resizedPSiz+1);
  me.kid[0].kid[0].objs[11].y = me.kid[0].kid[0].kid[2].kid[0].y+sldBtn*2-myGenome.ScrImgHei+2*margin-textSize;
  //changes new gene label and field .y pos
  //me.x=myGenome.ScrImgWid;
 // me.kid[0].kid[1].x=
}