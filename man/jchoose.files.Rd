\name{jchoose.files}
\alias{jchoose.files}
\title{Choose a list of files interactively using rJava}
\usage{
  jchoose.files(default = getwd(),
    caption = "Select files", multi = TRUE,
    filters = getDefaultFilters(), index = nrow(filters),
    modal = canUseJavaModal())
}
\arguments{
  \item{default}{Which filename or directory to show
  initially. Default is current work directory.}

  \item{caption}{The caption on the file selection dialog}

  \item{multi}{Whether to allow multiple files to be
  selected}

  \item{filters}{A matrix of filename filters. If NULL, all
  files are shown. Default is filters=getDefaultFilters().}

  \item{index}{Which row of filters to use by default.}

  \item{modal}{Indicates how the modality of the dialog is
  implemented. If TRUE, the modal dialog is used and if
  FALSE, R repeatedly checks for dialog status (active or
  not). The latter is used to refresh R Gui window on
  Windows. Default is canUseJavaModal().}
}
\value{
  A character vector giving zero or more file paths. If
  user cancels operation, character(0) is returned.
}
\description{
  Provides the same functionality as choose.files from
  utils package, but relies on Java and rJava package and
  therefore is system independent provided Java 1.5 and
  higher is installed.
}
\note{
  jchoose.files() is called internally by rchoose.files()
  if it's appropriate for a given platform/graphics
  combination. Calling jchoose.files() directly forces the
  package to use Java based dialog regardless of system
  capabilities and therefore may fail. Use the direct call
  to jchoose.files() only if it seems beneficial to bypass
  the rchoose.files() decision logic.
}
\examples{
\dontrun{
jchoose.files();
}
}
\author{
  Alex Lisovich, Roger Day
}
\seealso{
  {\code{\link{getDefaultFilters}},
  \code{\link{rchoose.files}},
  \code{\link{canUseJavaModal}}}
}

