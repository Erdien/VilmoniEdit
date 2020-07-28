/** triggers and actions */
void AllActions(){
  image(myGenome.img, 0 ,0);
  me.isPressed();
  showInp();
  AllPresentFileAction();
  AllSetNewFilePos();
  AllUpdateAction();
  PrepareArrow();
  PixelActions();
  GeneActions();
  me.drawMe();
  ptouches=touches.length;
}
void PixelActions(){
  PixelInsertBeforeAction();
  PixelSetAction();
  PixelInsertAfterAction();
  PixelRemoveAction();
  PixelNowAction();
  PixelNewAction();
}
void GeneActions(){
  GeneSliderAction();
  GeneNewAction();
  GeneSetAction();
}
void AllPresentFileAction(){
  if(me.objs[1].touched){
    me.kid[0].kid[0].kid[0].objs[0].name=myGenome.path;
    me.kid[0].kid[1].kid[0].objs[0].name=myGenome.path;
    }
    switch(me.kid[0].value){
      case 1:
        me.kid[0].kid[1].kid[0].objs[0].name=me.kid[0].kid[0].kid[0].objs[0].name;
      break;
      case 2:
        me.kid[0].kid[0].kid[0].objs[0].name=me.kid[0].kid[1].kid[0].objs[0].name;
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
void PrepareArrow(){
  switch (me.kid[0].value){
    case 1:
      myGenome.drawArrow(0, 0, me.kid[0].kid[0].objs[0].value);
    break;
    case 2:
      if (me.kid[0].kid[1].kid[1].value != 0)
        myGenome.drawArrow(0, 0, myGenome.genes.get(me.kid[0].kid[1].kid[1].value-1).begin);
    break;
    case 3:
      
    break;
    default:
  }
}
void PixelInsertBeforeAction(){
  if (me.kid[0].kid[0].objs[2].touched){
    myGenome.points.add(me.kid[0].kid[0].objs[0].value, new Pixel(1, colors[me.kid[0].kid[0].objs[1].value]));
    PixelChangeActions();
    int pSld=me.kid[0].kid[0].objs[0].value;
    me.kid[0].kid[0].objs[0]=new Slider(0, 0, me.kid[0].kid[0].objs[0].wid, 0, 0, myGenome.points.size()-1, me.kid[0].kid[0].objs[0].pressed, me.kid[0].kid[0].objs[0].touchId, "Pixel");
    me.kid[0].kid[0].objs[0].valueSet(constrain(pSld+1, 0, myGenome.points.size()-1));
  }
}
void PixelSetAction(){
  if (me.kid[0].kid[0].objs[3].touched && me.kid[0].kid[0].objs[0].value<myGenome.points.size()){
    myGenome.points.set(me.kid[0].kid[0].objs[0].value, new Pixel(1, colors[me.kid[0].kid[0].objs[1].value]));
    PixelChangeActions();
    int pSld=me.kid[0].kid[0].objs[0].value;
    me.kid[0].kid[0].objs[0]=new Slider(0, 0, me.kid[0].kid[0].objs[0].wid, 0, 0, myGenome.points.size()-1, me.kid[0].kid[0].objs[0].pressed, me.kid[0].kid[0].objs[0].touchId, "Pixel");
    me.kid[0].kid[0].objs[0].valueSet(pSld);
  }
}
void PixelInsertAfterAction(){
  if (me.kid[0].kid[0].objs[4].touched){
    myGenome.points.add(constrain(me.kid[0].kid[0].objs[0].value+1, 0, myGenome.points.size()-1), new Pixel(1, colors[me.kid[0].kid[0].objs[1].value]));
    PixelChangeActions();
    int pSld=me.kid[0].kid[0].objs[0].value;
    me.kid[0].kid[0].objs[0]=new Slider(0, 0, me.kid[0].kid[0].objs[0].wid, 0, 0, myGenome.points.size()-1, me.kid[0].kid[0].objs[0].pressed, me.kid[0].kid[0].objs[0].touchId, "Pixel");
    me.kid[0].kid[0].objs[0].valueSet(pSld);
  }
}
void PixelRemoveAction(){
  if (me.kid[0].kid[0].objs[5].touched && myGenome.points.size()-1>me.kid[0].kid[0].objs[0].value){
    myGenome.points.remove(me.kid[0].kid[0].objs[0].value);
    PixelChangeActions();
    int pSld=me.kid[0].kid[0].objs[0].value;
    me.kid[0].kid[0].objs[0]=new Slider(0, 0, me.kid[0].kid[0].objs[0].wid, 0, 0, myGenome.points.size()-1, me.kid[0].kid[0].objs[0].pressed, me.kid[0].kid[0].objs[0].touchId, "Pixel");
    me.kid[0].kid[0].objs[0].valueSet(pSld);
  }
}
void PixelChangeActions(){//protected
  myGenome.updateGenes();
    int pTab=me.kid[0].kid[1].kid[1].value;
    me.kid[0].kid[1].kid[1]=new Tabs(-margin, -margin,
      sldBtn*2, (height-myGenome.img.height)/myGenome.genes.size(),
      false, groupAssign(geneX, margin, myGenome.genes.toArray(new Place[myGenome.genes.size()])),
      SelectNames());
    me.kid[0].kid[1].kid[1].valueSet(pTab);
}
void PixelNowAction(){
  me.kid[0].kid[0].objs[7].value=colors[myGenome.points.get(constrain(me.kid[0].kid[0].objs[0].value, 0, myGenome.points.size()-1)).value];
  me.kid[0].kid[0].objs[7].name=str(myGenome.points.get(constrain(me.kid[0].kid[0].objs[0].value, 0, myGenome.points.size()-1)).value);
}
void PixelNewAction(){
  me.kid[0].kid[0].objs[8].value=colors[me.kid[0].kid[0].objs[1].value];
  me.kid[0].kid[0].objs[8].name=str(me.kid[0].kid[0].objs[1].value);
}
void GeneSliderAction(){
  if (me.kid[0].kid[1].objs[1].value==1000){
    me.kid[0].kid[1].objs[0].valueSet(me.kid[0].kid[1].objs[0].value+1);
    me.kid[0].kid[1].objs[1].valueSet(0);
    me.kid[0].kid[1].objs[1].valueSet(-1);
  }
  if (me.kid[0].kid[1].objs[0].value>=100){
    me.kid[0].kid[1].objs[1].valueSet(0);
    me.kid[0].kid[1].objs[1].valueSet(-1);
    me.kid[0].kid[1].objs[0].valueSet(100);
  }
  if (me.kid[0].kid[1].objs[0].value==0)
    me.kid[0].kid[1].objs[0].valueSet(0);
}
void GeneNewAction(){
  me.kid[0].kid[1].kid[2].objs[0] = new Gene(me.kid[0].kid[1].objs[0].value*1000+me.kid[0].kid[1].objs[1].value, 0);
}
void GeneSetAction(){
  if(me.kid[0].kid[1].objs[2].touched){
    if(me.kid[0].kid[1].kid[1].value>0)
      myGenome.genes.set(me.kid[0].kid[1].kid[1].value-1, new Gene(me.kid[0].kid[1].objs[0].value*1000+me.kid[0].kid[1].objs[1].value, 0));
    GeneChangeActions();
    int pSld=me.kid[0].kid[0].objs[0].value;
    me.kid[0].kid[0].objs[0]=new Slider(0, 0, me.kid[0].kid[0].objs[0].wid, 0, myGenome.points.size()-1, "Pixel");
    me.kid[0].kid[0].objs[0].valueSet(pSld);
  }
}
void GeneChangeActions(){//protected
  myGenome.updatePixel();
    int pTab=me.kid[0].kid[1].kid[1].value;
    me.kid[0].kid[1].kid[1]=new Tabs(-margin, -margin,
      sldBtn*2, (height-myGenome.img.height)/myGenome.genes.size(),
      false, groupAssign(geneX, margin, myGenome.genes.toArray(new Place[myGenome.genes.size()])),
      SelectNames());
    me.kid[0].kid[1].kid[1].valueSet(pTab);
}