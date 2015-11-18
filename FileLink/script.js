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
  * Version	1.2		13.11.2015	FileLink: Correction of short names
  * Version	1.3		17.11.2015	FileLink: only for "FILE://" - protocol
  *
  */
  
  
/**
 *
**/
function FileLink() {
	console.log("*** Start FileLink");

	jQuery("a.urlextern").each(function(){
		$this = jQuery(this);
		console.log($this);
		console.log($this.text());
		filename = $this.text();
		/* Shorten only file:// - links	*/
		console.log("protocol:" + filename.substring(0,5));
		if (filename.substring(0,5) == "file:") {
			filename = filename.replace(/^.*[\\\/]/, '');
			console.log(filename);
			console.log(filename.length);
			if (filename.length != 0) {
				$this.html(filename);
			}
			// add class-id
			jQuery("a.urlextern").addClass("filelink");
		}
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
	var res = page.substring(0, 5).toLowerCase(); 
	console.log(page + "/Result:" + res);
	if (res == "start") {
		var platform = navigator.platform;
		console.log(LocalOsSystem());
		console.log(navigator.userAgent);
//    	jQuery("h2").after("Some appended text to show if script is"t running."); 
		var OStext = "Local OS-System: " + LocalOsSystem();
		var txt2 = jQuery("<p></p>").text(OStext);   // Create with jQuery
		jQuery("p").first().append(txt2);         // Append the new elements
		jQuery("p").first().css( "background-color", "lightgray" );
		
		var OStext = "Browser: " + navigator.userAgent;
		var txt2  = jQuery("<p></p>").text(OStext);   // Create with jQuery
		jQuery("p").first().append(txt2);         // Append the new elements

        }
	console.log("*** End SystemInfo()");
}
jQuery(SystemInfo);

function LocalOsSystem() {

	return navigator.platform;
}

