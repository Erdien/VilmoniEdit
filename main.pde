Genome myGenome;
final int pSiz = 8;
final int resizedPSiz = 32;
final int rowHei = 30;
final int margin = 10;
final int textSize = 10;
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
final GeneType[][] geneNames = new GeneType[][]{
  {
    new GeneType("Unknown", types.nan), //GMO checker
    new GeneType("Metabo", types.num),  //growth speed
    new GeneType("Hydro", types.num),   //max hydration
    new GeneType("Distro", types.num),  //width
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
    new GeneType("Wiggo", types.dress_wiggo),//12
    new GeneType("Heddo", types.dress_heddo),//24
    new GeneType("Boddo", types.dress_boddo),//26
    new GeneType("Panto", types.dress_panto),//9
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
    new GeneType("Tab1", types.nan)
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

import android.widget.FrameLayout;
import android.widget.RelativeLayout;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;

import java.nio.charset.Charset;
/*
import android.support.v4.content.ContextCompat;
import android.support.v4.app.ActivityCompat;
import android.Manifest;
import android.content.pm.PackageManager;
/*
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.zip.GZIPInputStream;
import android.content.res.AssetManager;
import java.io.FileNotFoundException;
import java.net.MalformedURLException;*/
Intent myIntent;
Activity myActivity;
Context myContext;
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
 /* if (ContextCompat.checkSelfPermission(surface.getContext(), 
  Manifest.permission.READ_EXTERNAL_STORAGE) == PackageManager.PERMISSION_DENIED) {
    println("totot");
  }else{
    println("poss");
  }
if (ContextCompat.checkSelfPermission(surface.getContext(), 
  Manifest.permission.READ_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED) {
    println("t");
} else {
  println("n");
    ActivityCompat.requestPermissions(surface.getActivity(), new String[]{Manifest.permission.READ_EXTERNAL_STORAGE}, 1);
}*/
  //if (!hasPermission("android.permission.WRITE_EXTERNAL_STORAGE"))
  //  requestPermission("android.permission.WRITE_EXTERNAL_STORAGE");
  if (!hasPermission("android.permission.READ_EXTERNAL_STORAGE")) 
    requestPermission("android.permission.READ_EXTERNAL_STORAGE", "checkPermission");
  else checkPermission(true);
  fullScreen(P2D);
  //println(myContext.getFilesDir());
  //  FungBox.png
  //  sketch1587539851816.png
  
}
void exit(){
  System.exit(0);
}
void draw(){
  if(frameCount==10)
    showSoftKeyboard();
  if(me!=null){
  background(192);
  AllActions();
  //line(width/2,0,width/2,height);
  }else if(myGenome!=null) {
    createGUI();
  }
}
public void showSoftKeyboard() {
    Context context = surface.getContext();
    View view = surface.getRootView();
    InputMethodManager imm = (InputMethodManager) context.getSystemService(Context.INPUT_METHOD_SERVICE);
    //myEditText.setInputType(InputType.TYPE_CLASS_NUMBER);
    imm.showSoftInput(view, InputMethodManager.SHOW_IMPLICIT);
}
void createGUI(){
  textSize(16);
  //beginPixel=beginPixel(myImg);
  //int restWid = width-myGenome.img.width;
  //println(myGenome.img.width, myGenome.img.height);
  int sldCst=sldBtn*2+margin*2;
  int fileBoxX = sldBtn*2+margin;
  int fileBoxY = height-rowHei-sldBtn-margin;
  geneX = myGenome.ScrImgWid + margin;
  me = new Group(0, 0,
  new Place[]{
    new Button(fileBoxX, fileBoxY+rowHei+margin, sldBtn*2, sldBtn, "Update"),
    new Button(fileBoxX+40*10+margin, fileBoxY-margin, sldBtn*2, sldBtn, "Present File"),
    new Label(fileBoxX, fileBoxY-margin, "File Name:"),      //margin*3+rowHei+sldBtn
  },
  new PreGroup[]{
    new Tabs(myGenome.ScrImgWid, 0, (float)(width-myGenome.ScrImgWid)/4, rowHei*3, true, 
    new Group[]{
    
    new Group(margin-myGenome.ScrImgWid, margin+myGenome.ScrImgHei,
        new Place[]{
          new Button(sldBtn*2, 4*margin+6*resizedPSiz, 2*sldBtn, sldBtn, "Set"),
          
          new Slider(sldBtn*2, 4*margin+6*resizedPSiz, width-sldCst-2*margin-sldBtn*2, 1, 1, 100, "Base"),
          new Slider(sldBtn*2, 5*margin+6*resizedPSiz+sldBtn, width-sldCst-2*margin-sldBtn*2, 0, 1000, "Accurate"),
         
          new Slider(sldBtn*2, 4*margin+6*resizedPSiz, width-sldCst-2*margin-sldBtn*2, 0, 0, 255, "Red"),
          new Slider(sldBtn*2, 5*margin+6*resizedPSiz+sldBtn, width-sldCst-2*margin-sldBtn*2, 0, 0, 255, "Green"),
          new Slider(sldBtn*2, 6*margin+6*resizedPSiz+2*sldBtn, width-sldCst-2*margin-sldBtn*2, 0, 0, 255, "Blue"),
        
          new Slider(sldBtn*2, 4*margin+6*resizedPSiz, width-sldCst-2*margin-sldBtn*2, 0, 0, 11, "Dress"),
          new Slider(sldBtn*2, 4*margin+6*resizedPSiz, width-sldCst-2*margin-sldBtn*2, 0, 0, 23, "Dress"),
          new Slider(sldBtn*2, 4*margin+6*resizedPSiz, width-sldCst-2*margin-sldBtn*2, 0, 0, 25, "Dress"),
          new Slider(sldBtn*2, 4*margin+6*resizedPSiz, width-sldCst-2*margin-sldBtn*2, 0, 0, 8, "Dress"),
          
          new Label(geneX-margin, sldBtn*2-myGenome.ScrImgHei-margin, "Now"),
          new Label(geneX-margin, sldBtn*2-myGenome.ScrImgHei+2*margin+resizedPSiz-textSize, "New")
        },//end place
        new PreGroup[]{
          new TextBoxes(-margin, -margin-myGenome.ScrImgHei,
            new TextBox[]{
              new TextBox(fileBoxX, fileBoxY, 40*10, rowHei, ""),
              new TextBox(sldBtn*2+margin, 6*margin+6*resizedPSiz+myGenome.ScrImgHei, width-2*margin-sldBtn*2, rowHei, "")
            }
          ),
          new Tabs(-margin, -margin,
            sldBtn*2, (float)(height-myGenome.ScrImgHei)/myGenome.genes.size(),
            false, groupAssign(geneX, sldBtn*2-myGenome.ScrImgHei+textSize, myGenome.genes.toArray(new Place[myGenome.genes.size()])),
            SelectNames()),
          new Group(geneX-margin, sldBtn*2-myGenome.ScrImgHei+2*textSize, new Group[]{
            new Group(0,resizedPSiz,new Place[]{
              new Gene(0,0)
            })
          })
        }//end pregroup
      ),//end Gene
    
    
      new Group(margin-myGenome.ScrImgWid, margin+myGenome.ScrImgHei,
        new Place[]{
          new Slider(0, 0, width-sldCst-2*margin, 0, myGenome.points.size()-1, "Pixel"),
          new ColorTabs(sldBtn*4+margin*2, sldBtn*2+margin*4, width-sldBtn*4-margin*4, sldBtn, true, 16, 0,
            new String[]{"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "X", "E", "", "", "", ""}),
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
          new TextBoxes(-margin, -margin-myGenome.ScrImgHei,
            new TextBox[]{
              new TextBox(fileBoxX, fileBoxY, 40*10, rowHei, "")
            }
          )
        }
      ),//end Pixel
      
      
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
    new String[]{"Gene", "Pixel", "idk\nTab for testing", "Options", "Credits"})
    });
  
  //me.kid[0].kid[0].kid[1].objs[0].pressed=true;
}