package rjavautils;

import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.Frame;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JList;
import javax.swing.JScrollPane;
import org.jdesktop.layout.GroupLayout;

public class rJavaListChooser extends JDialog
{
  String[] m_Selection;
  int[] m_initialSelection;
  boolean m_bMultiple;
  String[] m_sItems;
  DefaultListModel m_listModel;
  private JButton cancelButton;
  private JList itemList;
  private JScrollPane jScrollPane1;
  private JButton okButton;

  public rJavaListChooser(Frame parent, boolean modal)
  {
    super(parent, modal);
    this.m_listModel = new DefaultListModel();
    this.m_sItems = new String[0];
    this.m_initialSelection = new int[0];
  }

  protected void initSelectionValues() {
    this.m_listModel.clear();
    for (int i = 0; i < this.m_sItems.length; i++) {
      this.m_listModel.addElement(this.m_sItems[i]);
    }
    this.itemList.setModel(this.m_listModel);
    this.itemList.setSelectedIndices(this.m_initialSelection);
  }

  protected void initSize() {
    setMinimumSize(getPreferredSize());

    Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();

    Dimension dlgSize = getSize();
    Dimension listSize = this.itemList.getSize();
    Dimension listPreferredSize = this.itemList.getPreferredSize();
    dlgSize.setSize(dlgSize.width + listPreferredSize.width - listSize.width, dlgSize.height + listPreferredSize.height - listSize.height);

    double width = Math.min(0.8D * screenSize.width, dlgSize.width);
    double height = Math.min(0.8D * screenSize.height, dlgSize.height);

    setSize((int)Math.round(width), (int)Math.round(height));
  }

  public void setSelectionValues(String[] sItems)
  {
    this.m_sItems = sItems;
  }

  public void setInitialSelection(int[] initialSelection) {
    this.m_initialSelection = initialSelection;
  }

  public void setMultipleSelection(boolean bMultiple) {
    this.m_bMultiple = bMultiple;
  }

  public String[] getSelection() {
    return this.m_Selection;
  }
  public String[] showDialog() {
    this.m_Selection = new String[0];

    initComponents();
    this.itemList.setSelectionMode(this.m_bMultiple ? 2 : 0);

    initSelectionValues();
    initSize();
    setLocationRelativeTo(null);
    setAlwaysOnTop(true);
    setVisible(true);
    return this.m_Selection;
  }

  public boolean isRunning() {
    return isVisible();
  }

  private void initComponents()
  {
    this.cancelButton = new JButton();
    this.okButton = new JButton();
    this.jScrollPane1 = new JScrollPane();
    this.itemList = new JList();

    setDefaultCloseOperation(2);

    this.cancelButton.setText("Cancel");
    this.cancelButton.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent evt) {
        rJavaListChooser.this.cancelButtonActionPerformed(evt);
      }
    });
    this.okButton.setText("OK");
    this.okButton.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent evt) {
        rJavaListChooser.this.okButtonActionPerformed(evt);
      }
    });
    this.jScrollPane1.setViewportView(this.itemList);

    GroupLayout layout = new GroupLayout(getContentPane());
    getContentPane().setLayout(layout);
    layout.setHorizontalGroup(layout.createParallelGroup(1).add(layout.createSequentialGroup().addContainerGap().add(layout.createParallelGroup(1).add(2, layout.createSequentialGroup().add(this.okButton, -2, 69, -2).addPreferredGap(1).add(this.cancelButton)).add(this.jScrollPane1, -1, 146, 32767)).addContainerGap()));

    layout.setVerticalGroup(layout.createParallelGroup(1).add(2, layout.createSequentialGroup().addContainerGap().add(this.jScrollPane1, -1, 37, 32767).addPreferredGap(1).add(layout.createParallelGroup(3).add(this.cancelButton).add(this.okButton)).addContainerGap()));

    pack();
  }

  private void okButtonActionPerformed(ActionEvent evt) {
    Object[] selection = this.itemList.getSelectedValues();
    this.m_Selection = new String[selection.length];
    for (int i = 0; i < selection.length; i++) {
      this.m_Selection[i] = ((String)selection[i]);
    }
    dispose();
  }

  private void cancelButtonActionPerformed(ActionEvent evt) {
    dispose();
  }

  public static void main(String[] args)
  {
    EventQueue.invokeLater(new Runnable() {
      public void run() {
        rJavaListChooser dialog = new rJavaListChooser(new JFrame(), true);
        dialog.addWindowListener(new WindowAdapter() {
          public void windowClosing(WindowEvent e) {
            System.exit(0);
          }
        });
        dialog.setVisible(true);
      }
    });
  }
}