package rjavautils;

import java.awt.Container;
import java.awt.EventQueue;
import java.awt.Frame;
import java.awt.HeadlessException;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import javax.swing.JDialog;
import javax.swing.JFileChooser;

public class rJavaFileChooser extends JFileChooser
{
  JDialog parent;
  int retVal;

  protected void closeDialog()
  {
    if (this.parent.isModal()) {
      WindowEvent wev = new WindowEvent(this.parent, 201);
      Toolkit.getDefaultToolkit().getSystemEventQueue().postEvent(wev);
    } else {
      this.parent.setVisible(false);
    }
  }

  public int showOpenDialog(Frame owner, boolean Modal) throws HeadlessException
  {
    this.retVal = 1;

    this.parent = new JDialog(owner, getDialogTitle(), Modal);

    addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        if (e.getActionCommand().equals("ApproveSelection")) {
          rJavaFileChooser.this.retVal = 0;
          rJavaFileChooser.this.closeDialog();
        } else if (e.getActionCommand().equals("CancelSelection")) {
          rJavaFileChooser.this.closeDialog();
        }
      }
    });
    if (this.parent.isModal())
      this.parent.setDefaultCloseOperation(2);
    else {
      this.parent.setDefaultCloseOperation(1);
    }

    this.parent.getContentPane().add(this);

    this.parent.pack();
    this.parent.setLocationRelativeTo(null);
    this.parent.setAlwaysOnTop(true);
    this.parent.setVisible(true);

    return this.retVal;
  }

  public void dispose() {
    this.parent.setDefaultCloseOperation(2);
    WindowEvent wev = new WindowEvent(this.parent, 201);
    Toolkit.getDefaultToolkit().getSystemEventQueue().postEvent(wev);
  }

  public boolean isRunning() {
    return this.parent.isVisible();
  }

  public boolean selectionApproved() {
    return this.retVal == 0;
  }
}