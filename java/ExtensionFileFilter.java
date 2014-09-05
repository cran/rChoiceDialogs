package rjavautils;

import java.io.File;
import javax.swing.filechooser.FileFilter;

class ExtensionFileFilter extends FileFilter
{
  String description;
  String[] extensions;

  public ExtensionFileFilter(String description, String extension)
  {
    this(description, new String[] { extension });
  }

  public ExtensionFileFilter(String description, String[] extensions)
  {
    if (description == null)
      this.description = (extensions[0] + "{ " + extensions.length + "} ");
    else {
      this.description = description;
    }
    this.extensions = ((String[])(String[])extensions.clone());
    toLower(this.extensions);
  }

  private void toLower(String[] array) {
    int i = 0; for (int n = array.length; i < n; i++)
      array[i] = array[i].toLowerCase();
  }

  public String getDescription()
  {
    return this.description;
  }

  public boolean accept(File file) {
    if (file.isDirectory()) {
      return true;
    }
    String path = file.getAbsolutePath().toLowerCase();
    int i = 0; for (int n = this.extensions.length; i < n; i++) {
      String extension = this.extensions[i];
      if (extension.equals("*"))
        return true;
      if ((path.endsWith(extension)) && (path.charAt(path.length() - extension.length() - 1) == '.')) {
        return true;
      }
    }

    return false;
  }
}