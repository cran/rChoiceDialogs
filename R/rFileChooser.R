
#' Get default set of filters
#'
#' @name getDefaultFilters
#' @return Default set of filters for jchoose.files
#' @seealso {\code{\link{jchoose.files}}, \code{\link{tkchoose.files}}, \code{\link{rchoose.files}}}
#' @export getDefaultFilters
#' @author  Alex Lisovich, Roger Day

getDefaultFilters<-function(){
  res<-rbind(
	c("R or S files (*.R,*.q,*.ssc,*.S)", "*.R;*.q;*.ssc;*.S"),
	c("Enhanced metafiles (*.emf)",       "*.emf"),            
	c("Postscript files (*.ps)",          "*.ps"),             
	c("PDF files (*.pdf)",                "*.pdf"),            
	c("Png files (*.png)",                "*.png"),            
	c("Windows bitmap files (*.bmp)",     "*.bmp"),            
	c("Jpeg files (*.jpeg,*.jpg)",        "*.jpeg;*.jpg"),     
	c("Text files (*.txt)",              "*.txt"),            
	c("R images (*.RData,*.rda)",         "*.RData;*.rda"),    
	c("Zip files (*.zip)",                "*.zip"),           
	c("All files (*.*)",                 "*.*")
  );             
  return(as.matrix(res));
}


#' Choose a list of files interactively using tcltk
#'
#' Provides the same functionality as choose.files from utils package for Windows,
#' but relies on tcltk package and therefore is system independent provided tcltk is installed.
#'
#'
#' @note tkchoose.files() is called internally by rchoose.files() if it's appropriate for a given platform/graphics combination.
#' Calling tkchoose.files() directly forces the package to use tcl tk based dialog regardless of system capabilities and therefore may fail.
#' Use the direct call to tkchoose.files() only if it seems beneficial to bypass the rchoose.files() decision logic.
#'
#' @name tkchoose.files
#' @param default Which filename to show initially
#' @param caption The caption on the file selection dialog
#' @param multi Whether to allow multiple files to be selected
#' @param filters A matrix of filename filters. If NULL, all files are shown.
#' Default is filters=getDefaultFilters().
#' @param index Which row of filters to use by default.
#' @return A character vector giving zero or more file paths.  If user cancels operation, character(0) is returned.
#'
#' @seealso {\code{\link{getDefaultFilters}}, \code{\link{rchoose.files}}}
#' @examples
#' \dontrun{
#' tkchoose.files();
#' }
#' @export tkchoose.files
#' @author  Alex Lisovich, Roger Day


tkchoose.files<-function(default = "", caption = "Select files",
             multi = TRUE, filters = getDefaultFilters(),
             index = nrow(filters)){
	if (is.null(filters))
		filters=c("All","*.*");

    	if (inherits(filters, "character")) 
		filters <- matrix(filters, ncol = 2);
    	if (!inherits(filters, "matrix") || mode(filters) != "character" || 
		ncol(filters) != 2) 
		stop("'filters' must be a n*2 matrix of characters!")

	filters[,2]<-gsub(";",",",filters[,2],fixed=TRUE);
	for (i in 1:nrow(filters))		
		filters[i,1]<-gsub(paste("(",filters[i,2],")",sep=""),"",filters[i,1],fixed=TRUE);

    	filters <- paste("{\"", filters[, 1], "\" {\"", gsub(",", 
		"\" \"", filters[, 2]), "\"}}", sep = "", collapse = " ");


	tclres<-tcltk::tclvalue(tcltk::tkgetOpenFile(title=caption,initialdir = default,initialfile = "",
										multiple=multi,filetypes=filters));


	res<-character(0);	
	if(nzchar(tclres)){
		if (multi){
			starts<-gregexpr("{",tclres,fixed=TRUE)[[1]]+1;
			stops<-gregexpr("}",tclres,fixed=TRUE)[[1]]-1;
			if(starts[1]<1)
				return(tclres);
			res<-NULL;
			for (i in 1:length(starts)){
				res<-c(res,as.character(substr(tclres,starts[i],stops[i])));
			}
			
		} else
			 res<-tclres;
	}
	return(res);
}

#' Choose a list of files interactively using rJava
#'
#' Provides the same functionality as choose.files from utils package,
#' but relies on Java and rJava package and therefore is system independent provided Java 1.5 and higher is installed.
#'
#' @note jchoose.files() is called internally by rchoose.files() if it's appropriate for a given platform/graphics combination.
#' Calling jchoose.files() directly forces the package to use Java based dialog regardless of system capabilities and therefore may fail.
#' Use the direct call to jchoose.files() only if it seems beneficial to bypass the rchoose.files() decision logic.
#'
#' @name jchoose.files
#' @param default Which filename or directory to show initially. Default is current work directory.
#' @param caption The caption on the file selection dialog
#' @param multi Whether to allow multiple files to be selected
#' @param filters A matrix of filename filters. If NULL, all files are shown.
#' Default is filters=getDefaultFilters().
#' @param index Which row of filters to use by default.
#' @param modal Indicates how the modality of the dialog is implemented.
#' If TRUE, the modal dialog is used and if FALSE, R repeatedly checks for dialog status (active or not).
#' The latter is used to refresh R Gui window  on Windows. Default is canUseJavaModal().
#' @return A character vector giving zero or more file paths. If user cancels operation, character(0) is returned.
#'
#' @seealso {\code{\link{getDefaultFilters}}, \code{\link{rchoose.files}}, \code{\link{canUseJavaModal}}}
#' @examples
#' \dontrun{
#' jchoose.files();
#' }
#' @export jchoose.files
#' @author  Alex Lisovich, Roger Day

jchoose.files<-function(default = getwd(), caption = "Select files",
             multi = TRUE, filters = getDefaultFilters(),
             index = nrow(filters),modal=canUseJavaModal()){



    if (inherits(filters, "character")) {
        filters <- matrix(filters, ncol = 2)
	  index=nrow(filters);
    }
    if (!inherits(filters, "matrix") || mode(filters) != "character" || 
        ncol(filters) != 2) 
        stop("'filters' must be a n*2 matrix of characters!")

	chooser<-new(J("rjavautils.rJavaFileChooser"));

	chooser$setDialogTitle(caption);
	chooser$setMultiSelectionEnabled(multi);
	chooser$setCurrentDirectory(.jnew("java.io.File",default));

	if(!is.null(filters)){
		active_filter<-NULL;
		chooser$setAcceptAllFileFilterUsed(FALSE);
		for (i in 1:nrow(filters)){
			extensions<-unlist(strsplit(filters[i,2],split=";"));
			extensions<-gsub("*.","",extensions,fixed=TRUE);
			filter<-new(J("rjavautils.ExtensionFileFilter"),filters[i,1],.jarray(extensions));
			chooser$addChoosableFileFilter(filter);
			if(index==i)
				active_filter<-filter;
		}
		if(!is.null(active_filter))
			chooser$setFileFilter(active_filter);
	}



	resVal<-chooser$showOpenDialog(NULL,modal);
	if(!modal){
		while (chooser$isRunning()){};
		chooser$dispose();
	}

	if(chooser$selectionApproved()){
		if(multi) {
			files<-as.list(chooser$getSelectedFiles());
			fnames<-unlist(lapply(files, function(file) {file$getCanonicalPath()}));
		} else {
			fnames<-chooser$getSelectedFile()$getCanonicalPath();
		}
	} else {
		fnames<-character(0);
	}



	return(fnames);
}


#' Choose a directory interactively using rJava
#'
#' Provides the same functionality as choose.dir from utils package,
#' but relies on Java and rJava package and therefore is system independent provided Java 1.5 and higher is installed.
#'
#'
#' @note jchoose.dir() is called internally by rchoose.dir() if it's appropriate for a given platform/graphics combination.
#' Calling jchoose.dir() directly forces the package to use Java based dialog regardless of system capabilities and therefore may fail.
#' Use the direct call to jchoose.dir() only if it seems beneficial to bypass the rchoose.dir() decision logic.
#'
#' @name jchoose.dir
#' @param default Which filename or directory to show initially. Default is current work directory.
#' @param caption The caption on the file selection dialog
#' @param modal Indicates how the modality of the dialog is implemented.
#' If TRUE, the modal dialog is used and if FALSE, R repeatedly checks for dialog status (active or not).
#' The latter is used to refresh R Gui window  on Windows. Default is canUseJavaModal().
#' @return A character vector giving zero or more file paths. If user cancels operation, character(0) is returned.
#'
#' @seealso {\code{\link{rchoose.dir}}, \code{\link{canUseJavaModal}}}
#' @examples
#' \dontrun{
#' jchoose.dir();
#' }
#' @export jchoose.dir
#' @author  Alex Lisovich, Roger Day


jchoose.dir<-function(default = getwd(), caption = "Select Directory",modal=canUseJavaModal()){

	chooser<-new(J("rjavautils.rJavaFileChooser"));

	chooser$setFileSelectionMode(J("javax.swing.JFileChooser")$DIRECTORIES_ONLY);
	chooser$setDialogTitle(caption);
	chooser$setCurrentDirectory(.jnew("java.io.File",default));


	resVal<-chooser$showOpenDialog(NULL,modal);
	if(!modal){
		while (chooser$isRunning()){};
		chooser$dispose();
	}

	if(chooser$selectionApproved()){
		dirname<-chooser$getSelectedFile()$getCanonicalPath();
	} else {
		dirname<-character(0);
	}



	return(dirname);
}


#' Choose a list of files interactively
#'
#' Provides the same functionality as choose.files from the utils package for Windows,
#' but is intended to be system independent.
#'
#' @name rchoose.files
#' @param default Which filename or directory to show initially. Default is current work directory.
#' @param caption The caption on the file selection dialog
#' @param multi Whether to allow multiple files to be selected
#' @param filters A matrix of filename filters. If NULL, all files are shown.
#' Default is filters=getDefaultFilters().
#' @param index Which row of filters to use by default.
#' @return A character vector giving zero or more file paths. If user cancels operation, character(0) is returned.
#'
#' @seealso {\code{\link{getDefaultFilters}}, \code{\link{jchoose.files}}, 
#' \code{\link{tkchoose.files}}, \code{\link{canUseJava}}, \code{\link{canUseTclTk}}}
#' @examples
#' \dontrun{
#' rchoose.files();
#' }
#' @export rchoose.files
#' @author  Alex Lisovich, Roger Day

rchoose.files<-function(default = getwd(), caption = "Select files",
             multi = TRUE, filters = getDefaultFilters(),
             index = nrow(filters)){

	if(canUseJava())
		return(jchoose.files(default,caption,multi,filters,index));
	if(canUseTclTk())
		return(tkchoose.files(default,caption,multi,filters,index));

	warning("rchoose.files: no suitable graphics found");

	return(character(0));
}



#' Choose directory interactively
#'
#' Provides the same functionality as choose.dir from the utils package for Windows,
#' but is intended to be system independent.
#'
#' @name rchoose.dir
#' @param default Which filename or directory to show initially. Default is current work directory.
#' @param caption The caption on the file selection dialog
#' @return A character vector giving zero or more file paths. If user cancels operation, character(0) is returned.
#' @seealso {\code{\link{getDefaultFilters}}, \code{\link{jchoose.files}}, 
#' \code{\link{tkchoose.files}}, \code{\link{canUseJava}}, \code{\link{canUseTclTk}}}
#' @examples
#' \dontrun{
#' rchoose.dir();
#' }
#' @export rchoose.dir
#' @author  Alex Lisovich, Roger Day


rchoose.dir<-function(default=getwd(), caption="Select Directory"){
	if(canUseJava())
		return(jchoose.dir(default,caption));
	if(canUseTclTk())
		return(tcltk::tk_choose.dir(default,caption));

	warning("rchoose.dir: no suitable graphics found");

	return(character(0));

}


