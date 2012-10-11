\name{rselect.list}
\alias{rselect.list}
\title{Select item(s) from a list.}
\usage{
  rselect.list(choices, preselect = NULL, multiple = FALSE,
    title = NULL, graphics = getOption("menu.graphics"))
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

  \item{graphics}{logical indicating if a graphical widget
  should be used. return A character vector of selected
  items. If multiple is false and no item was selected (or
  Cancel was used), '' is returned. If multiple is true and
  no item was selected (or Cancel was used) then a
  character vector of length 0 is returned.}
}
\description{
  Provides the same functionality as select.list from the
  utils package, but is intended to broaden the range of
  systems where selection can be made through the graphical
  dialog provided Java 1.5 or higher is installed. This
  brings up a modal dialog box with a (scrollable) list of
  items, which can be selected by the mouse. If multiple is
  true, further items can be selected or deselected by
  holding the control key down whilst selecting, and
  shift-clicking can be used to select ranges. Normal
  termination is via the 'OK' button or by hitting Enter or
  double-clicking an item. Selection can be aborted via the
  'Cancel' button or pressing Escape. If no graphical
  widget is available it displays a text list from which
  the user can choose by number(s). The multiple = FALSE
  case uses menu. Preselection is only supported for
  multiple = TRUE, where it is indicated by a '+' preceding
  the item. It is an error to use rselect.list in a
  non-interactive session.
}
\examples{
\dontrun{
rselect.list(c("Peter", "Alex", "Roger", "Leah"),title="Select", multiple=TRUE);
}
}
\author{
  Alex Lisovich, Roger Day
}
\seealso{
  {\code{\link{jselect.list}}, \code{\link{select.list}}}
}

