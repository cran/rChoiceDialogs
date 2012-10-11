\name{cmdchoose.files}
\alias{cmdchoose.files}
\title{Choose a list of files interactively using the command line}
\usage{
  cmdchoose.files(default = getwd(),
    caption = "Select files", multi = TRUE,
    dir.only = FALSE, filters = getDefaultFilters(),
    index = nrow(filters))
}
\arguments{
  \item{default}{Which filename or directory to show
  initially. Default is current work directory.}

  \item{caption}{The caption on the file selection dialog}

  \item{multi}{Whether to allow multiple files to be
  selected}

  \item{dir.only}{If TRUE (default is FALSE) works as
  directory chooser.}

  \item{filters}{A matrix of filename filters. If NULL, all
  files are shown. Default is filters=getDefaultFilters().}

  \item{index}{Which row of filters to use by default.}
}
\value{
  A character vector giving zero or more file paths. If
  user cancels operation, character(0) is returned.
}
\description{
  Allows to choose files or directories using the using the
  command line based interaction providing the same
  functionality as GUI counterparts without using any
  graphical framework.
}
\note{
  cmdchoose.files() is called internally by rchoose.files()
  if neither Java nor TclTk are available Calling
  cmdchoose.files() directly forces the package to use
  command line interaction regardless of system
  capabilities and therefore may fail. Use the direct call
  to cmdchoose.files() only if it seems beneficial to
  bypass the rchoose.files() decision logic.
}
\examples{
\dontrun{
cmdchoose.files();
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

