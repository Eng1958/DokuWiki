/** ****************************************************************
  * FileLink(): Changes the text of an external url (file://).
  * 
  * @author Dieter Engemann <dieter@engemann.me>
  * 
  * Add this Script into ...\dokuwiki\htdocs\lib\plugins\*
  * 
  * @param {function} fn optional callback to run after hiding
  *
  * @Date:	02.11.2015
  * Version	1.0		02.11.2015	Initial Version
  * Version	1.1		05.11.2015	get local OS-System an show it on the page
  *   
  *     
  */
function FileLink() {
	console.log("FileLink");


	jQuery("a.urlextern").each(function(){
		$this = jQuery(this);
		console.log($this);
		console.log($this.text());
		filename = $this.text();
		filename = filename.replace(/^.*[\\\/]/, '');
		console.log(filename);
		$this.html(filename);
		// add class-id
		jQuery("a.urlextern").addClass("filelink");
	});

	console.log("*** End FileLink");
}
jQuery(FileLink);

/**
 *
 **/
function SystemInfo() {

    console.log("*** Start SystemInfo()");
//    jQuery("h1").after("Some appended text to show if script ist running."); 
	
	var page = document.title;
	console.log(page);
	var res = page.substring(0, 5); 
	console.log(page + "/Result:" + res);
	if (res == "Start") {
		var platform = navigator.platform;
		console.log(platform);
		console.log(navigator.userAgent);
//    	jQuery("h2").after("Some appended text to show if script ist running."); 
		var txt2 = jQuery("<p></p>").text("Local OS-System: ");   // Create with jQuery
		jQuery("p").append(txt2);         // Append the new elements 
		jQuery("p").append(platform);         // Append the new elements 
	}
	console.log("*** End SystemInfo()");
}
jQuery(SystemInfo);
