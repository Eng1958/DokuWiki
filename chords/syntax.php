<?php
/**
 * Plugin Color: Sets new colors for text and background.
 *
 * @license    GPL 2 (http://www.gnu.org/licenses/gpl.html)
 * @author     Christopher Smith <chris@jalakai.co.uk>
 */

// must be run within DokuWiki
if(!defined('DOKU_INC')) die();

if(!defined('DOKU_PLUGIN')) define('DOKU_PLUGIN',DOKU_INC.'lib/plugins/');
require_once(DOKU_PLUGIN.'syntax.php');

/**
 * All DokuWiki plugins to extend the parser/rendering mechanism
 * need to inherit from this class
 */
class syntax_plugin_chords extends DokuWiki_Syntax_Plugin {

    /**
     * return some info
     */
    function getInfo(){
        return array(
            'author' => 'Dieter Engemann',
            'email'  => 'dieter.engemann@googlemail.com',
            'date'   => '2009-05-28',
            'name'   => 'Chordname Plugin',
            'desc'   => 'Formatted Output of Chordnames',
            'url'    => 'http://www.dokuwiki.org/plugin:tutorial',
        );
    }

    function getType(){ return 'formatting'; }
    function getAllowedTypes() { return array('formatting', 'substition', 'disabled'); }
    function getSort(){ return 158; }
    function connectTo($mode) { $this->Lexer->addEntryPattern('<chord.*?>(?=.*?</chord>)',$mode,'plugin_chords'); }
    function postConnect() { $this->Lexer->addExitPattern('</chord>','plugin_chords'); }


    /**
     * Handle the match
     */
    function handle($match, $state, $pos, &$handler){
        switch ($state) {
          case DOKU_LEXER_ENTER :
                list($color, $background) = preg_split("/\//u", substr($match, 6, -1), 2);
                if ($color = $this->_isValid($color)) $color = "color:$color;";
                if ($background = $this->_isValid($background)) $background = "background-color:$background;";
                return array($state, array($color, $background));

          case DOKU_LEXER_UNMATCHED :  return array($state, $match);
          case DOKU_LEXER_EXIT :       return array($state, '');
        }
        return array();
    }

    /**
     * Create output
     */
    function render($mode, &$renderer, $data) {
        if($mode == 'xhtml'){
            list($state, $match) = $data;
            switch ($state) {
              case DOKU_LEXER_ENTER :
                list($color, $background) = $match;
//                $renderer->doc .= "<b style='$color $background'>";
//                $renderer->doc .= "<span style='font-weight: bold; color: #000080;'>";
                $renderer->doc .= "<span class=\"chords\">";
                break;

//              case DOKU_LEXER_UNMATCHED :  $renderer->doc .= $renderer->_xmlEntities($match); break;
//              case DOKU_LEXER_UNMATCHED :  $renderer->doc .= $renderer->_xmlEntities($this->_convertChord($match))
              case DOKU_LEXER_UNMATCHED :  $renderer->doc .= $this->_convertChord($match); break;
              case DOKU_LEXER_EXIT :       $renderer->doc .= "</span>"; break;
            }
            return true;
        }
        return false;
    }

    function _convertChord($match){

      $m = '';
      $count = 0;
      $posAlt = 0;
      while (($posNeu = strpos($match, '^', $posAlt)) > 0) {
//        echo $posAlt . ' - ' . $posNeu . '<br>';
//        echo substr($match, $posAlt, $posNeu - $posAlt) . '<br>';
        $m .= substr($match, $posAlt, $posNeu - $posAlt);
        if (bcmod($count,2) == 0){
          $m .= '<sup>';
        }
        else{
          $m .= '</sup>';
        }
        $count++;
        
        $posAlt = $posNeu + 1;
      }
//      echo substr($match, $posAlt, strlen($match) - $posAlt) . '<br>';
      $m .= substr($match, $posAlt, strlen($match) - $posAlt);
      if (bcmod($count,2) != 0){
        $m .= '</sup>';
      }
	$m = str_replace("#", "<span style=\"font-size: larger;\">&#9839;</span>", $m);	// Sharp-Symbol
	$m = str_replace("b", "<span style=\"font-size: medium ;\">&#9837;</span>", $m);	// Flat-Symbol
	$m = str_replace("@", "<span style=\"font-size: medium ;\">&#9838;</span>", $m);	// Natural-Symbol

//      echo $m . '<br>';
//      echo '<hr>';
      return $m;


      $s = '';
      $array = explode ( '^', $match );
      $c = sizeof($array);

      if ($c < 2){

        $s = $match;
        
      }
      else {

        for ( $x = 0; $x < count ( $array ); $x++ )  {
          $s .= $array[$x];
          if (bcmod ( $x, 2 ) == 0){
            $s .= '<sup>';
          }
          else{
            $s .= '</sup>';
          }
        }
        $s .= '</sup>';
      }

      //      $s = $array[0] . '<sup>' . $array[1] . '</sup>' . $array[2];

      return $s;
    }
    // validate color value $c
    // this is cut price validation - only to ensure the basic format is correct and there is nothing harmful
    // three basic formats  "colorname", "#fff[fff]", "rgb(255[%],255[%],255[%])"
    function _isValid($c) {
        $c = trim($c);

        $pattern = "/^\s*(
            ([a-zA-z]+)|                                #colorname - not verified
            (\#([0-9a-fA-F]{3}|[0-9a-fA-F]{6}))|        #colorvalue
            (rgb\(([0-9]{1,3}%?,){2}[0-9]{1,3}%?\))     #rgb triplet
            )\s*$/x";

        if (preg_match($pattern, $c)) return trim($c);

        return "";
    }
}
?>
