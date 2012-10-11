\name{jselect.list}
\alias{jselect.list}
\title{Select item(s) from a list.}
\usage{
  jselect.list(choices, preselect = NULL, multiple = FALSE,
    title = NULL, modal = canUseJavaModal())
}
\arguments{
  \item{choices}{A character vector of items.}

  \item{preselect}{A character vector, or NULL. If non-null
  and if the string(s) appear in the list, the item(s) are
  selected initially.}

  \item{multiple}{Logical: can more than one item be
  selected?}

  \item{title}{Optional character string for window title,
  or NULL for no title.}

  \item{modal}{Indicates how the modality of the dialog is
  implemented. return A character vector of selected items.
  If multiple is false and no item was selected (or Cancel
  was used), '' is returned. If multiple is true and no
  item was selected (or Cancel was used) then a character
  vector of length 0 is returned.}
}
\description{
  Provides the same functionality as choose.files from
  utils package, but relies on Java and rJava package and
  therefore is system independent provided Java 1.5 and
  higher is installed. This brings up a modal dialog box
  with a (scrollable) list of items, which can be selected
  by the mouse. If multiple is true, further items can be
  selected or deselected by holding the control key down
  whilst selecting, and shift-clicking can be used to
  select ranges. Normal termination is via the 'OK' button
  or by hitting Enter or double-clicking an item. Selection
  can be aborted via the 'Cancel' button or pressing
  Escape. If no graphical widget is available it displays a
  text list from which the user can choose by number(s).
  The multiple = FALSE case uses menu. Preselection is only
  supported for multiple = TRUE, where it is indicated by a
  '+' preceding the item. It is an error to use select.list
  in a non-interactive session.
}
\note{
  jselect.list() is called internally by rchoose.list() if
  it's appropriate for a given platform/graphics
  combination. Calling jselect.list() directly forces the
  package to use Java based dialog regardless of system
  capabilities and therefore may fail. Use the direct call
  to jselect.list() only if it seems beneficial to bypass
  the rchoose.list() decision logic.
}
\examples{
\dontrun{
jselect.list(c("Peter", "Alex", "Roger", "Leah"),title="Select", multiple=TRUE);
}
}
\author{
  Alex Lisovich, Roger Day
}
\seealso{
  {\code{\link{rselect.list}}, \code{\link{select.list}}}
}

