\name{rchoose.files}
\alias{rchoose.files}
\title{Choose a list of files interactively...}
\usage{rchoose.files(default=getwd(), caption="Select files", multi=TRUE,
    filters=getDefaultFilters(), index=nrow(filters))}
\description{Choose a list of files interactively}
\details{Provides the same functionality as choose.files from the utils package for Windows,
but is intended to be system independent.}
\value{A character vector giving zero or more file paths. If user cancels operation, character(0) is returned.}
\seealso{{\code{\link{getDefaultFilters}}, \code{\link{jchoose.files}}, 
\code{\link{tkchoose.files}}, \code{\link{canUseJava}}, \code{\link{canUseTclTk}}}}
\author{Alex Lisovich, Roger Day}
\arguments{\item{default}{Which filename or directory to show initially. Default is current work directory.}
\item{caption}{The caption on the file selection dialog}
\item{multi}{Whether to allow multiple files to be selected}
\item{filters}{A matrix of filename filters. If NULL, all files are shown.
Default is filters=getDefaultFilters().}
\item{index}{Which row of filters to use by default.}}
\examples{\dontrun{
rchoose.files();
}}
