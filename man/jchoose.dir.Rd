\name{jchoose.dir}
\alias{jchoose.dir}
\title{Choose a directory interactively using rJava...}
\usage{jchoose.dir(default=getwd(), caption="Select Directory",
    modal=canUseJavaModal())}
\description{Choose a directory interactively using rJava}
\details{Provides the same functionality as choose.dir from utils package,
but relies on Java and rJava package and therefore is system independent provided Java 1.5 and higher is installed.}
\note{jchoose.dir() is called internally by rchoose.dir() if it's appropriate for a given platform/graphics combination.
Calling jchoose.dir() directly forces the package to use Java based dialog regardless of system capabilities and therefore may fail.
Use the direct call to jchoose.dir() only if it seems beneficial to bypass the rchoose.dir() decision logic.}
\value{A character vector giving zero or more file paths. If user cancels operation, character(0) is returned.}
\seealso{{\code{\link{rchoose.dir}}, \code{\link{canUseJavaModal}}}}
\author{Alex Lisovich, Roger Day}
\arguments{\item{default}{Which filename or directory to show initially. Default is current work directory.}
\item{caption}{The caption on the file selection dialog}
\item{modal}{Indicates how the modality of the dialog is implemented.
If TRUE, the modal dialog is used and if FALSE, R repeatedly checks for dialog status (active or not).
The latter is used to refresh R Gui window  on Windows. Default is canUseJavaModal().}}
\examples{\dontrun{
jchoose.dir();
}}
