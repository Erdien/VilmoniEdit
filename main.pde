Genome myGenome;
//semi constants
int pSiz = 8;
final int resizedPSiz = 32;
int rowHei = 30;
int sldBtn = 50;
int margin = 10;
int bottomMargin=20;
int textSize = 16;
int textBoxPadding = 7;
boolean pixel_Slider = false;
boolean number_Textbox = false;
boolean unknown_Slider = false;
int theme = 1;

int geneX;
int ptouches;
Place selectedTextBox;
Group me;
Group[] mex;
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
void onActivityResult(int requestCode, int resultCode, Intent data) {
  if (requestCode==10)
    if (resultCode==Activity.RESULT_OK)
      myGenome = new Genome(myResolver.getPath(myContext, data.getData()));
}
void checkPermission(boolean granted) {
  if (granted) {
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
    }
    );
  }
}
void setup() {
  try {
    loadSettings();
  }
  catch(Exception e) {
    SettingsResetAction();
  }
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
void exit() {
  System.exit(0);
}
void draw() {
  //if(frameCount==10)
  //showSoftKeyboard();
  if (me!=null) {
    background(192);
    AllActions();
    //line(width/2,0,width/2,height);
  } else if (myGenome!=null) {
    try {
      createGUI();
    }
    catch(Exception e) {
      SettingsResetAction();
      createGUI();
    }
  }
}
public void showSoftKeyboard() {
  Context context = surface.getContext();
  View view = surface.getRootView();
  InputMethodManager imm = (InputMethodManager) context.getSystemService(Context.INPUT_METHOD_SERVICE);
  //myEditText.setInputType(InputType.TYPE_CLASS_NUMBER);
  imm.showSoftInput(view, InputMethodManager.SHOW_IMPLICIT);
}
void createGUI() {
  textSize(textSize);
  //beginPixel=beginPixel(myImg);
  //int restWid = width-myGenome.img.width;
  //println(myGenome.img.width, myGenome.img.height);
  int sldCst=sldBtn*2+margin*2;
  int fileBoxX = sldBtn*2+margin;
  int fileBoxY = height-bottomMargin-rowHei*2-margin*2-textSize-textBoxPadding*2;  //position of the textBox (upper edge) look at interactions
  Place pixel1;
  Place pixel2;
  if (pixel_Slider) {
    pixel1 = new Slider(0, 0, width/2-sldCst-margin*3/2, 0, myGenome.points.size()-1, "Pixel");
    pixel2 = new Slider(width/2+margin-margin*3/2, 0, width/2-sldCst-margin*3/2, 0, 15, "Value");
  } else {
    pixel1 = new Slider(0, 0, width-sldCst-2*margin, 0, myGenome.points.size()-1, "Pixel");
    pixel2 = new ColorTabs(sldBtn*4+margin*2, sldBtn*2+margin*4, width-sldBtn*4-margin*4, sldBtn, true, 16, 0, colors,
      new String[]{"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "X", "E", "", "", "", ""});
  }
  geneX = myGenome.ScrImgWid + margin;
  if(myGenome.ScrImgHei<50)
    myGenome.ScrImgHei=50;
  if (myGenome.ScrImgWid<50)
    myGenome.ScrImgWid=50;
  me = new Group(0, 0,
    new Place[]{
    new Button(fileBoxX, fileBoxY-margin, sldBtn*2, rowHei*2, "Update"),                     //look at interactions
    new Button(fileBoxX+40*10+margin, fileBoxY-margin, sldBtn*2, rowHei*2, "Present File"),  //look at interactions
    new Label(fileBoxX, fileBoxY-textSize-textBoxPadding*2, "File Name:"),                   //look at interactions
    },
    new PreGroup[]{
      new Tabs(myGenome.ScrImgWid, 0, (float)(width-myGenome.ScrImgWid)/4, rowHei*3, true,
      new Group[]{

        new Group(margin-myGenome.ScrImgWid, margin+myGenome.ScrImgHei,
        new Place[]{
          new Image(-margin, -margin-myGenome.ScrImgHei, myGenome.ScrImgWid, myGenome.ScrImgHei, myGenome.img),
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
          new Label(geneX-margin, sldBtn*2-myGenome.ScrImgHei+2*margin+resizedPSiz+textSize, "New")
        }, //end place
        new PreGroup[]{
          new TextBoxes(-margin, -margin-myGenome.ScrImgHei,
          new TextBox[]{
            new TextBox(fileBoxX, fileBoxY, 40*10, textSize+textBoxPadding*2, ""),
            new TextBox(sldBtn*2+margin, 6*margin+6*resizedPSiz+myGenome.ScrImgHei, width-2*margin-sldBtn*2, textSize+textBoxPadding*2, "")
          }
          ),
          new Tabs(-margin, -margin,
          sldBtn*2, (float)(height-myGenome.ScrImgHei-bottomMargin)/myGenome.genes.size(),
          false, groupAssign(geneX, sldBtn*2-myGenome.ScrImgHei+textSize+textBoxPadding*2, myGenome.genes.toArray(new Place[myGenome.genes.size()])),
          SelectNames()),
          new Group(geneX-margin, sldBtn*2-myGenome.ScrImgHei+2*textSize+textBoxPadding*2, new Group[]{
            new Group(0, resizedPSiz, new Place[]{
              new Gene(0, 0)
            })
          })
        }//end pregroup
        ), //end Gene


        new Group(margin-myGenome.ScrImgWid, margin+myGenome.ScrImgHei,
        new Place[]{
          new Image(-margin, -margin-myGenome.ScrImgHei, myGenome.ScrImgWid, myGenome.ScrImgHei, myGenome.img),
          pixel1,
          pixel2,
          new Button(0, sldBtn+margin, sldBtn*2, sldBtn, "Insert before"),
          new Button(0, (sldBtn+margin)*2, sldBtn*2, sldBtn, "Set"), //if pressed set \/ to \\//
          new Button(0, (sldBtn+margin)*3, sldBtn*2, sldBtn, "Insert after"),
          new Button(0, (sldBtn+margin)*4, sldBtn*2, sldBtn, "Remove"),
          new Button(sldBtn*2+margin, sldBtn+margin, sldBtn*2, sldBtn, "Prepare\n(unusavle)"),
          new Label(width/2-sldBtn-margin, sldBtn+margin*3, sldBtn, sldBtn, "0", 0),
          new Label(width/2-margin, sldBtn+margin*3, sldBtn, sldBtn, "0", -1),
          new Label(width/2-sldBtn-margin, sldBtn+margin, "Now"),
          new Label(width/2-margin, sldBtn+margin, "New"),
        }, //end Place
        new PreGroup[]{
          new TextBoxes(-margin, -margin-myGenome.ScrImgHei,
          new TextBox[]{
            new TextBox(fileBoxX, fileBoxY, 40*10, textSize+textBoxPadding*2, "")
          }
          )
        }//end Container
        ), //end Pixel


        new Group(margin-myGenome.ScrImgWid, margin+myGenome.ScrImgHei, 
        new Place[]{
          new Button(-margin, -margin-myGenome.ScrImgHei, myGenome.ScrImgWid+(myGenome.ScrImgWid>70?-30:+30), myGenome.ScrImgHei+(myGenome.ScrImgHei>70?-30:+30), "reset\ndefault"),   //this button have to be on the Top of the scren
          new Button(myGenome.ScrImgWid, rowHei*3-myGenome.ScrImgHei, sldBtn*2, rowHei*2, "save\nconfiguration"), 
        }, //end Place
        new PreGroup[]{
          new TextBoxes(-margin, -margin-myGenome.ScrImgHei, 
          new TextBox[]{
            new TextBox(fileBoxX, fileBoxY, 40*10, textSize+textBoxPadding*2, "")
          }
          ), 
          new Group(0, 0, new Place[]{
            new Slider(0, margin, width/2-sldCst-margin*3/2, rowHei, 10, 300, "small size (rowHei)"),
            new Slider(width/2+margin-margin*3/2, margin, width/2-sldCst-margin*3/2, sldBtn, 10, 300, "big size (sldBtn)"),
            new Slider(0, margin*2+sldBtn, width/2-sldCst-margin*3/2, margin, 100, "margin"),
            new Slider(width/2+margin-margin*3/2, margin*2+sldBtn, width/2-sldCst-margin*3/2, bottomMargin, 200, "bottom margin"),
            new Slider(0, margin*3+sldBtn*2, width/2-sldCst-margin*3/2, textSize, 5, 40, "text size"),
            new Slider(width/2+margin-margin*3/2, margin*3+sldBtn*2, width/2-sldCst-margin*3/2, textBoxPadding, 50, "textbox padding"),
            //new Slider(int x, int y, int scrollWid, int value, int minValue, int maxValue, "Bottom margin"),
            new Label(0, 0, "Layout:"), 
          }), 
          new Group(0, margin*5+sldBtn*3, new Place[]{
            new Switch(0, margin, sldBtn*4, rowHei*2, "Pixel\nSlider or ColorTab"), 
            new Switch(margin+sldBtn*4, margin, sldBtn*4, rowHei*2, "Gene Numbers\nSlider or TextBox"), 
            new Switch(0, margin*2+rowHei*2, sldBtn*4, rowHei*2, "Gene Unknown\nTextBox or Slider"), 
            new ColorTabs(margin+sldBtn*4, margin*2+rowHei*2, width-margin*3-sldBtn*4, rowHei*2, true, 3, 1,
              new color[]{160, 80, color(160,0,0)},
              new String[]{"light", "dark", "red"}
            ),
            //new Switch(margin+sldBtn*4, margin*2+rowHei*2, sldBtn*4, rowHei*2, "Pixel\nSlider or ColorTab"),
            new Slider(0, margin*3+rowHei*4, width/2-sldCst-margin*3/2, pSiz, 1, 30, "source Code Pixel size"), 
            //new Slider(width/2+margin-margin*3/2, margin*3+rowHei*4, width/2-sldCst-margin*3/2, sldBtn, 10, 300, "big size (sldBtn)"),
            new Label(0, 0, "Micelanous:"), 
          })
        }//end Container
        ), //end Settings
      }, 
      new String[]{"Gene", "Pixel", "Settings", "Credits"})
    });

  //me.kid[0].kid[0].kid[1].objs[0].pressed=true;
  me.kid[0].kid[2].kid[2].objs[0].pressed = pixel_Slider;
  me.kid[0].kid[2].kid[2].objs[1].pressed = number_Textbox;
  me.kid[0].kid[2].kid[2].objs[2].pressed = unknown_Slider;
}
