Genome myGenome;
//Position beginPixel;
final int pSiz = 8;
final int resizedPSiz = 32;
final int rowHei = 30;
final int margin = 10;
final int sldBtn = 50;
int geneX;
int ptouches;
Place selectedTextBox;
Group me;
Group[] mex;
final color[] colors = new color[]{
  color(247, 0, 113),   //red        0
  color(244, 91, 255),  //pink       1
  color(98, 0, 222),    //purple     2
  color(28, 122, 255),  //blue       3
  color(20, 217, 246),  //cyan       4
  color(0, 189, 177),   //teal       5
  color(0, 164, 6),     //dgreen     6
  color(71, 222 , 21),  //green      7
  color(158, 250, 0),   //lime       8
  color(255, 252, 30),  //yellow     9
  color(255, 188, 0),   //orange     10
  color(255, 112, 24),  //dorange    11
                        //separators 
  color(153, 95, 66),    //brown      12
  color(255, 255, 255), //white      13
  color(149, 149, 149), //gray       14
  color(0, 0, 0),       //black      15
                        //controll
  color(255, 255, 243), //bg         16
  color(20, 194, 183),  //alt teal   17-12
  color(20, 171, 9),    //alt dgreen 18-12
  color(89, 49, 27)     //none       19
};
final String[][] geneNames = new String[][]{
  {
    "Unknown", //GMO checker
    "Metabo",  //growth speed
    "Hydro",   //max hydration
    "Distro",  //width
    "Name"
  },
  {
    "Unknown",
    "Wiggo",
    "Heddo",
    "Boddo",
    "Panto",
    "Senso",
    "Noodo",
    "Name"
  },
  {
    "Unknown",
    "Wiggo",
    "Heddo",
    "Boddo",
    "Panto",
    "",
    "",
    "",
    "",
    "Name"
  },
  {
    "Unknown",
    "Masso",
    "Metabo",
    "Bendo",
    "Flexo",
    "Leggo",
    "Senso",
    "Maho",
    "Mostro",
    "Motho",
    "Scecho",
    "Scestro",
    "Scetho",
    "Waho",
    "Wastro",
    "Watho",
    "Name"
  },
  {
    "Tab1"
  }
};
import android.content.Intent;
import android.app.Activity;
import android.content.Context;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.os.Environment;
import android.view.View;
import android.graphics.Rect;
Intent myIntent;
Activity myActivity;
Context myContext;
//MediaScannerConnection myMedia;
View myView;
FileUtils myResolver;
 void onActivityResult(int requestCode, int resultCode, Intent data){
  if(requestCode==10)
     if(resultCode==Activity.RESULT_OK)
     myGenome = new Genome(myResolver.getPath(myContext, data.getData()));
}
void checkPermission(boolean granted){
  if(granted){
    myActivity = this.getActivity();
    myIntent = new Intent(Intent.ACTION_GET_CONTENT);
    myContext = this.getContext();
    //myMedia = new MediaScannerConnection(myContext, null);
    //myMedia.connect();
    myView = myActivity.getWindow().getDecorView();
    myResolver = new FileUtils();
    myIntent.setType("image/*");
    myActivity.runOnUiThread(new Runnable() {
      public void run() {
        myActivity.startActivityForResult(myIntent, 10);
      }
    });
  }
}
void setup() {
  if (!hasPermission("android.permission.WRITE_EXTERNAL_STORAGE"))
    requestPermission("android.permission.WRITE_EXTERNAL_STORAGE");
  if (!hasPermission("android.permission.READ_EXTERNAL_STORAGE")) 
    requestPermission("android.permission.READ_EXTERNAL_STORAGE", "checkPermission");
  else checkPermission(true);
  fullScreen(P2D);
  //println(myContext.getFilesDir());
  //  FungBox.png
  //  sketch1587539851816.png
  
}
void exit(){
  //this.exit();
  myActivity.finishAffinity();
}
void draw(){
  if(me!=null){
  background(192);
  AllActions();
  //line(width/2,0,width/2,height);
  }else if(myGenome!=null)
  {
    createGUI();
    //System.exit(0);
    //this.getActivity().finishAffinity();
  }
}
void createGUI(){
  textSize(16);
  //beginPixel=beginPixel(myImg);
  //int restWid = width-myGenome.img.width;
  int sldCst=sldBtn*2+margin*2;
  int fileBoxX = sldBtn*2+margin;
  int fileBoxY = height-200;
  geneX = myGenome.img.width + margin;
  me = new Group(myGenome.img.width, 0,
  new Place[]{
    new Button(fileBoxX-myGenome.img.width, fileBoxY+rowHei+margin, sldBtn*2, sldBtn, "Update"),
    new Button(fileBoxX-myGenome.img.width+40*10+margin, fileBoxY-margin, sldBtn*2, sldBtn, "Present File"),
    new Label(fileBoxX-myGenome.img.width, fileBoxY-margin, "File Name:"),
  },
  new PreGroup[]{
    new Tabs(0, 0, (width-myGenome.img.width)/4, rowHei*3, true, 
    new Group[]{
    
      new Group(margin-myGenome.img.width, margin+myGenome.img.height,
        new Place[]{
          new Slider(0, 0, width-sldCst-2*margin, 0, myGenome.points.size()-1, "Pixel"),
          new ColorTabs(sldBtn*4+margin*2, sldBtn*2+margin*4, width-sldBtn*4-margin*4, sldBtn, true, 16, 0,
            new String[]{"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "", "", "", ""}),
          //new Slider(0, 0, width/2-sldCst-margin*3/2, 0, myGenome.points.size()-1, "Pixel"),
          //new Slider(width/2+margin-margin*3/2, 0, width/2-sldCst-margin*3/2, 0, 15, "Value"),
          new Button(0, sldBtn+margin, sldBtn*2, sldBtn, "Insert before"),
          new Button(0, (sldBtn+margin)*2, sldBtn*2, sldBtn, "Set"),//if pressed set \/ to \\//
          new Button(0, (sldBtn+margin)*3, sldBtn*2, sldBtn, "Insert after"),
          new Button(0, (sldBtn+margin)*4, sldBtn*2, sldBtn, "Remove"),
          new Button(sldBtn*2+margin, sldBtn+margin, sldBtn*2, sldBtn, "Prepare"),
          new Label(width/2-sldBtn-margin, sldBtn+margin*3, sldBtn, sldBtn, "0", 0),
          new Label(width/2-margin, sldBtn+margin*3, sldBtn, sldBtn, "0", -1),
          new Label(width/2-sldBtn-margin, sldBtn+margin, "Now"),
          new Label(width/2-margin, sldBtn+margin, "New"),
        },//end Place
        new PreGroup[]{
          new TextBoxes(-margin, -margin-myGenome.img.height,
            new TextBox[]{
              new TextBox(fileBoxX, fileBoxY, 40*10, rowHei, "")
            }
          )
        }
      ),//end Pixel
      
      new Group(margin-myGenome.img.width, margin+myGenome.img.height,
        new Place[]{
          new Slider(sldBtn*2, 4*margin+6*resizedPSiz, width-sldCst-2*margin-sldBtn*2, 1, 1, 100, "Base"),
          new Slider(sldBtn*2, 5*margin+6*resizedPSiz+sldBtn, width-sldCst-2*margin-sldBtn*2, 0, 1000, "Accurate"),
          new Button(sldBtn*2, 6*margin+6*resizedPSiz+2*sldBtn, 2*sldBtn, sldBtn, "Set"),
          new Label(geneX-margin, -margin, "Now"),
          new Label(geneX-margin, 2*margin+4*resizedPSiz, "New")
        },//end place
        new PreGroup[]{
          new TextBoxes(-margin, -margin-myGenome.img.height,
            new TextBox[]{
              new TextBox(fileBoxX, fileBoxY, 40*10, rowHei, "")
            }
          ),
          new Tabs(-margin, -margin,
            sldBtn*2, (height-myGenome.img.height)/myGenome.genes.size(),
            false, groupAssign(geneX, margin, myGenome.genes.toArray(new Place[myGenome.genes.size()])),
            geneNames[compareSpieces(myGenome.genes.size())]),
          new Group(geneX-margin, 2*margin+4*resizedPSiz+10, new Place[]{new Gene(0,0)})
        }//end pregroup
      ),//end Gene
      
      new Group(200, 350,
        new Place[]{
          new Scroll(0, 0, 200, 60, 50, 100, "Scroll2"), 
          new Switch(0, 30, 60, rowHei, "Switch2"), 
          new Button(70, 30, 60, rowHei, "Button1"),
          new Label(0, 150, "Label1"),
          new ColorTabs(sldBtn*2+margin*2, sldBtn*2+margin*4, width-sldBtn*4-margin*4, sldBtn, false, 16, 0)
        },//end place
        new PreGroup[]{
          new TextBoxes(0, 70,
            new TextBox[]{
              new TextBox(0, 0, 90, rowHei, ""), 
              new TextBox(100, 0, 90, rowHei, ""), 
              new TextBox(0, 40, 90, rowHei, ""), 
              new TextBox(100, 40, 90, rowHei, "")
            }
          )//end textbox
        }//end pregroup
      )//end 2nd group
      
    },
    new String[]{"Pixel", "Gene", "Name", "Credits"})
    });
  
  //me.kid[0].kid[1].kid[1].objs[0].pressed=true;
}