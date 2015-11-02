/** ****************************************************************
  * FileLink(): Changes the text of an external url (file://).
  * 
  * @author Dieter Engemann <dieter@engemann.me>
  * 
  */
function FileLink() {
	console.log("FileLink");

// 	jQuery("div.dokuwiki div").addClass("blue");
//     $this = jQuery(this);
//     console.log($this);

	jQuery("a.urlextern").each(function(){
    	$this = jQuery(this);
    	console.log($this);
    	console.log($this.text());
		filename = $this.text();
    	filename = filename.replace(/^.*[\\\/]/, '');
    	console.log(filename);
    	$this.html(filename);
		jQuery("a.urlextern").addClass("filelink");
	});

	console.log("*** End FileLink");
}
jQuery(FileLink);