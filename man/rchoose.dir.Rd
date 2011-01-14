\name{rchoose.dir}
\alias{rchoose.dir}
\title{Choose directory interactively...}
\usage{rchoose.dir(default=getwd(), caption="Select Directory")}
\description{Choose directory interactively}
\details{Provides the same functionality as choose.dir from the utils package for Windows,
but is intended to be system independent.}
\value{A character vector giving zero or more file paths. If user cancels operation, character(0) is returned.}
\seealso{{\code{\link{getDefaultFilters}}, \code{\link{jchoose.files}}, 
\code{\link{tkchoose.files}}, \code{\link{canUseJava}}, \code{\link{canUseTclTk}}}}
\author{Alex Lisovich, Roger Day}
\arguments{\item{default}{Which filename or directory to show initially. Default is current work directory.}
\item{caption}{The caption on the file selection dialog}}
\examples{\dontrun{
rchoose.dir();
}}
