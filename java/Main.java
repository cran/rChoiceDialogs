package rjavautils;

import javax.swing.SwingUtilities;

public class Main
{
  public static void main(String[] args)
  {
    SwingUtilities.invokeLater(new Runnable() {
      public void run() {
        //rJavaFileChooser fc = new rJavaFileChooser();
        //fc.setMultiSelectionEnabled(true);
        //int res = fc.showOpenDialog(null, true);
          String [] choice={"one","two","three","four"};
          rJavaListChooser lc= new rJavaListChooser(null,true);
          lc.setMultipleSelection(true);
          lc.setTitle("test");

          lc.setSelectionValues(choice);
          String [] res=lc.showDialog();
      }
    });
  }
}