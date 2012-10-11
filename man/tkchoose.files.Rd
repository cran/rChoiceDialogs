\name{tkchoose.files}
\alias{tkchoose.files}
\title{Choose a list of files interactively using tcltk}
\usage{
  tkchoose.files(default = "", caption = "Select files",
    multi = TRUE, filters = getDefaultFilters(),
    index = nrow(filters))
}
\arguments{
  \item{default}{Which filename to show initially}

  \item{caption}{The caption on the file selection dialog}

  \item{multi}{Whether to allow multiple files to be
  selected}

  \item{filters}{A matrix of filename filters. If NULL, all
  files are shown. Default is filters=getDefaultFilters().}

  \item{index}{Which row of filters to use by default.}
}
\value{
  A character vector giving zero or more file paths.  If
  user cancels operation, character(0) is returned.
}
\description{
  Provides the same functionality as choose.files from
  utils package for Windows, but relies on tcltk package
  and therefore is system independent provided tcltk is
  installed.
}
\note{
  tkchoose.files() is called internally by rchoose.files()
  if it's appropriate for a given platform/graphics
  combination. Calling tkchoose.files() directly forces the
  package to use tcl tk based dialog regardless of system
  capabilities and therefore may fail. Use the direct call
  to tkchoose.files() only if it seems beneficial to bypass
  the rchoose.files() decision logic.
}
\examples{
\dontrun{
tkchoose.files();
}
}
\author{
  Alex Lisovich, Roger Day
}
\seealso{
  {\code{\link{getDefaultFilters}},
  \code{\link{rchoose.files}}}
}

