ProtokollHandler für DokuWiki
=============================

Description
-----------

The exec Protocol Handler in FF starts the Python program exec.py 
to execute local files (like MP3-files, PDF-files, or directories).

I use this protocoll handler in DokuWiki. I wrote a little PHP-plugin
which converts links to my "own" exec-protocoll


Example
-------

In DokuWiki create a "exec link" with the following syntax 

<exec>$MW\HelloWorld.mp3</exec> 



Installation
------------


Configuration
-------------

Create a configuration file to configure your macros in ~/.exec/macro.cfg


  # Macro-Definition for exec-Protocoll-Handler
  # 
  # Example:
  #   $ML = ~/Musik/Musik-Wiki/Lehrbuecher
  #
  $MW = ~/Musik/Musik-Wiki
  $MWLB = ~/Musik/Musik-Wiki/Lehrbuecher
