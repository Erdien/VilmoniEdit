import android.app.Activity;
import android.content.Context;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.text.InputType;
import android.view.View;
import android.widget.EditText;
import android.view.ViewTreeObserver;
import android.graphics.Rect;

EditText box;
Activity act;
Context mC;
FrameLayout fl;


public void onStart() {
  super.onStart();
  act = this.getActivity();
  mC= act.getApplicationContext();
  //show or hide the keyboard at start
  act.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE);
  if (box==null) {
    box = new EditText(mC);
    box.setLayoutParams(new RelativeLayout.LayoutParams( RelativeLayout.LayoutParams.WRAP_CONTENT, 
      RelativeLayout.LayoutParams.WRAP_CONTENT));
      fl = (FrameLayout)act.getWindow().getDecorView().getRootView();
      fl.addView(box);
    //box.setTextColor(Color.rgb(0,0,0));
    //box.setX(50);
    //box.setY(400);
    
    box.setTextSize(0);
    box.setPadding(0, 0, 0, 0);
    box.setBackgroundColor(0xff0ffff0);
    
    box.setInputType(InputType.TYPE_CLASS_NUMBER);
    box.setText("");
    box.requestFocus();
    
  }
}
boolean isKeyboardShowing = false;
void onKeyboardVisibilityChanged(boolean opened) {
    println("keyboard " + opened);
}
void showInp() {
  // ContentView is the root view of the layout of this activity/fragment    
act.getWindow().getDecorView().getRootView().getViewTreeObserver().addOnGlobalLayoutListener(
    new ViewTreeObserver.OnGlobalLayoutListener() {
    public void onGlobalLayout() {

        Rect r = new Rect();
        act.getWindow().getDecorView().getRootView().getWindowVisibleDisplayFrame(r);
        int screenHeight = act.getWindow().getDecorView().getRootView().getHeight();

        // r.bottom is the position above soft keypad or device button.
        // if keypad is shown, the r.bottom is smaller than that before.
        int keypadHeight = screenHeight - r.bottom;

        //println(TAG, "keypadHeight = " + keypadHeight);

        if (keypadHeight > screenHeight * 0.15) { // 0.15 ratio is perhaps enough to determine keypad height.
            // keyboard is opened
            if (!isKeyboardShowing) {
                isKeyboardShowing = true;
                onKeyboardVisibilityChanged(true);
            }
        }
        else {
            // keyboard is closed
            if (isKeyboardShowing) {
                isKeyboardShowing = false;
                onKeyboardVisibilityChanged(false);
            }
        }
    }
});
//delay(100);
//   if (!isKeyboardShowing){
//     box.setInputType((box.getInputType()+1)%10);
//     closeKeyboard();
//     openKeyboard();
//     println(box.getInputType());
//     delay(250);
//   }
//   box.setX(random(40,44));
    //String txt = box.getText().toString();//i you want to save it or transform it
  //println(txt);
}
public void onResume() {
  super.onResume();
   //show the softinput keyboard at start
    //act.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE);
}