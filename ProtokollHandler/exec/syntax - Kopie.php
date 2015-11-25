<?php
/**
 * Plugin exec : Execute a protocoll handler
 *
 * Syntax: <exec myStyleClass>content</exec>
 * 
 * @author     Dieter Engemann <dieter.engemann@gmail.com'>
 * @license    GPL 2 (http://www.gnu.org/licenses/gpl.html)
 * 
 * @version 31.01.2013  19:35 Uhr  
 */

// Used from class plugin
 
if(!defined('DOKU_INC')) define('DOKU_INC',realpath(dirname(__FILE__).'/../../').'/');
if(!defined('DOKU_PLUGIN')) define('DOKU_PLUGIN',DOKU_INC.'lib/plugins/');
require_once(DOKU_PLUGIN.'syntax.php');


class syntax_plugin_exec extends DokuWiki_Syntax_Plugin {


   /**
    * Get an associative array with plugin info.
    */
    function getInfo(){
        return array(
            'author' => 'Dieter Engemann',
            'email'  => 'dieter.engemann@gmail.com',
            'date'   => '2013-01-31',
            'name'   => 'exec Plugin',
            'desc'   => 'Plugin to start a protocol handler',
            'url'    => 'http://www.dokuwiki.org/plugin:class',
        );
    }


    function getType(){ return 'formatting'; }
     // function getType(){ return 'container'; }
    function getPType(){ return 'normal'; }
    function getAllowedTypes() { 
        return array('container','substition','protected','disabled','formatting','paragraphs');
    }
 
    // must return a number lower than returned by native 'code' mode (200)
    function getSort(){ return 158; }
 
 
    /**
     * Connect pattern to lexer:
     * This function is inherited from Doku_Parser_Mode. Here is the place 
     * to register the regular expressions needed to match your syntax.
     */
    function connectTo($mode) {       
        $this->Lexer->addEntryPattern('<exec.*?>(?=.*?</exec>)',$mode,'plugin_exec');
    }
    function postConnect() {
        $this->Lexer->addExitPattern('</exec>','plugin_exec');
    }
 
 
    /**
     * Handle the match
     * to prepare the matched syntax for use in the renderer
     */
    function handle($match, $state, $pos, &$handler){
        switch ($state) {
            case DOKU_LEXER_ENTER:
                $data = strtolower(trim(substr($match,6,-1)));
                return array($state, $data);
 
            case DOKU_LEXER_UNMATCHED : 
                return array($state, $match);
 
            case DOKU_LEXER_EXIT :
                return array($state, '');
 
        }       
        return false;
    }
 
 
   /**
     * output
	 * to render the content
     */
    function render($mode, &$renderer, $indata) {

       global $filename;

        if($mode == 'xhtml'){
            list($state, $match) = $indata;
            switch ($state) {
 
            case DOKU_LEXER_ENTER :      
                // $renderer->doc .= '</p><div class="'.htmlspecialchars($match).'"><p>';
                // $renderer->doc .= '<a href=exec:' . 'c:\test.txt' . '>';
                $renderer->doc .= '<a href=exec:';
                break;
 
              case DOKU_LEXER_UNMATCHED : 
                // $renderer->doc .= $renderer->_xmlEntities($match);
                $filename = $match;
                if (file_exists ($filename)) {
                  $renderer->doc .= $match . ' title=' . $match . ' class="exec">' . basename($match);
                }
                else {
                  $renderer->doc .= $match . ' title=' . $match . ' class="notexist">' . basename($match);
                }
                
                break;
 
              case DOKU_LEXER_EXIT :
                // check existing of file
                $renderer->doc .= "</a>";
                break;
            }
            return true;
        }
        return false;
    }
}
 
//Setup VIM: ex: et ts=4 enc=utf-8 :
?>