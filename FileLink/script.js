/** ****************************************************************
  * FileLink(): Changes the text of an external url (file://).
  * 
  * @author Dieter Engemann <dieter@engemann.me>
  * 
  * Add this Script into ...\dokuwiki\htdocs\lib\plugins\*
  * 
  * Author:	D. Engemann
  * Date:	02.11.2015
  * Version	1.0
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
	

function SystemInfo() {

	console.log("SystemInfo");
        console.log(navigator.platform);
        console.log(document.title);
jQuery("p").after("Some appended text."); 
	console.log("*** End SystemInfo");
}
jQuery(SystemInfo);
