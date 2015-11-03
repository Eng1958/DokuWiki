; EXAMPLE #2: This is a working script that creates a popup menu that is displayed when the user presses the Win-Z hotkey.
#Persistent  ; Keep the script running until the user exits it.
Tip=Wiki-Edit-Support

;;Menu, tray, Icon, Gesicht.ico
Menu, tray, Icon, %A_ScriptDir%\Witch.ico

TrayTip, Wiki-Edit-Support, %Tip%, 20, 17


; Create the popup menu by adding some items to it.
Menu, MyMenu, Add, Item1, MenuHandler
Menu, MyMenu, Add, Item2, MenuHandler
Menu, MyMenu, Add  ; Add a separator line.
Menu, MyMenu, Color, Silver

;DokuWiki
; Create another menu destined to become a submenu of the above menu.
Menu, Submenu1, Add, Bold, 					      MenuHandler
Menu, Submenu1, Add, <setLink>, 				      MenuHandler
Menu, Submenu1, Add, <Color>, 				    MenuHandler
Menu, Submenu1, Add, <Chord>,            MenuHandler
Menu, Submenu1, Add, Textfluß bei Bilder, MenuHandler
Menu, Submenu1, Add, Seitenumbruch, 		  	MenuHandler
Menu, Submenu1, Add, Farbe, 				    MenuHandler
Menu, Submenu1, Add, Kategorie, 			    MenuHandler
Menu, Submenu1, Add, DokuWikiExternalLink,		MenuHandler
Menu, Submenu1, Add, Image,			      		MenuHandler
Menu, Submenu1, Add, Seitenende,				MenuHandler


Menu, Submenu2, Add, Bold, 			        MenuHandler
Menu, Submenu2, Add, Kursiv, 		        MenuHandler
Menu, Submenu2, Add, <span color>,	      	MenuHandler


Menu, Submenu3, Add, WikiTemplate, MenuHandler
Menu, Submenu3, Add, Escape, MenuHandler
Menu, Submenu3, Add, Enter, MenuHandler

Menu, Submenu4, Add, PsPad, 	        	ToolMenuHandler
Menu, Submenu4, Add, IdoswinPro, 	        ToolMenuHandler
Menu, Submenu4, Add, AutohotkeyHelp, 	    ToolMenuHandler
Menu, Submenu4, Add, Guitar Tuner, 	      ToolMenuHandler
Menu, Submenu4, Add, Magix Midi-Studio 2005 , 	ToolMenuHandler
Menu, Submenu4, Add, Lilypond Help, 	   ToolMenuHandler
Menu, Submenu4, Add, Band-in-a-Box, 	   ToolMenuHandler
Menu, Submenu4, Add, Band-in-a-Box (Help), 	   ToolMenuHandler


; Create a submenu in the first menu (a right-arrow indicator). When the user selects it, the second menu is displayed.
Menu, MyMenu, Add, DokuWiki Extensions, 	:Submenu1
Menu, MyMenu, Add, DokuWiki Commands, 		:Submenu2
Menu, MyMenu, Add  ; Add a separator line below the submenu.
Menu, MyMenu, Add, Tools, 					:Submenu4


Menu, MyMenu, Add  ; Add a separator line below the submenu.
Menu, MyMenu, Add, Item3, MenuHandler  ; Add another menu item beneath the submenu.
Menu, MyMenu, Add, Top Of Page, MenuHandler  ; Add another menu item beneath the submenu.
Menu, MyMenu, Add  ; Add a separator line below the submenu.
Menu, MyMenu, Add, Exit, MenuHandler  ; Add another menu item beneath the submenu.


; Create a submenu in the first menu (a right-arrow indicator). When the user selects it, the second menu is displayed.

; CapsLock immer aus
SetCapsLockState, AlwaysOff

; WikiLink als Include
; #include WikiLinkInclude.ahk
; #include WebNWalk-Pin.ahk

return  ; End of script's auto-execute section.

MenuHandler:


ifEqual A_ThisMenuItem, <setLink>
{
	msgbox Test
	Gosub, SaveClipboard
	;;Control, EditPaste, This text will be inserted at the caret position.,

	send, <script language="javascript" type="text/javascript">`n
   	send, setLink("", "", "");`n
	send, </script>`n
 
	Gosub, RestoreClipboard
}	
else
; ------------------------------------------------------------------------------
; <<LaunchApplicationButton "" "Quick Reference" "PDF\tiddlywikiquickreferencecard.pdf">>
; ------------------------------------------------------------------------------
ifEqual A_ThisMenuItem, DokuWikiExternalLink
{
	FileSelectFile, SelectedFile, 3, , Open a file, Media Files (*.mp3; *.mid; *.ms*)
	if SelectedFile =
	{
	    MsgBox, The user didn't select anything.
	    return
	}
	;	MsgBox, The user selected the following:`n%SelectedFile%

	SplitPath, SelectedFile, name, dir, ext, name_no_ext, drive
	StringUpper, ext, ext
	
	ClipSaved := ClipboardAll   ; Save the entire clipboard to a variable of your choice.
	; ... here make temporary use of the clipboard, such as for pasting Unicode text via Transform Unicode ...
	
	;;InputBox, subroutineName, Subroutine-Name, Prompt, HIDE, Width, Height, X, Y, Font, Timeout, Default
	InputBox, LinkName, LaunchApplicationButton, Bitte Link - Namen eingeben,,400,150,,,,,%name%
	if ErrorLevel
		return
	else
	
	Clipboard =
	ClipWait, .2
	FormatTime, TimeString ,, dd.MM.yyyy
	string = 
	string = %string%%A_Space%%A_Space%*[[@   
	string = %string%%SelectedFile%|
	string = %string%%LinkName%]]  %ext%-File`r`n 
	Clipboard = %string%
	ClipWait, 1, 1
	
	send ^v 
	sleep 1000
	
	Clipboard := ClipSaved   ; Restore the original clipboard. Note the use of Clipboard (not ClipboardAll).
	ClipSaved =   ; Free the memory in case the clipboard was very large.clipboard

	return
}	
else
ifEqual A_ThisMenuItem, Image
{
	Var = 
	(
		<<Image "e:\Musik\P\CharlieParker\CharlieParker.jpg" "'Charlie Parker'" 20>>
	)

	Gosub, SaveClipboard

	Loop, parse, Var,`n,%A_Space%%A_Tab%
	{
	 	Clipboard = %Clipboard%%A_LoopField%`n
		ClipWait, .2
	}
	if ErrorLevel
	{
		MsgBox, The attempt to copy text onto the clipboard failed.
		return
	}
	; Als Ctrl-V einfügen
	send ^v 
	sleep 100
	Gosub, RestoreClipboard
 
}	


else
ifEqual A_ThisMenuItem, Textfluß bei Bilder
{
	Var = 
	(
		<html><br style="clear:both"></html>
	)

	Gosub, SaveClipboard

	Loop, parse, Var,`n,%A_Space%%A_Tab%
	{
	 	Clipboard = %Clipboard%%A_LoopField%`n
		ClipWait, .2
	}
	if ErrorLevel
	{
		MsgBox, The attempt to copy text onto the clipboard failed.
		return
	}
	; Als Ctrl-V einfügen
	send ^v 
	sleep 100
	Gosub, RestoreClipboard
 
}	
else
;*******************************************************************************
; Fett
;*******************************************************************************
ifEqual A_ThisMenuItem, Bold
{
	Gosub, SaveClipboard
   	send, ''%Clipboard%''
	Gosub, RestoreClipboard
}	
else
ifEqual A_ThisMenuItem, Kursiv
{
	Gosub, SaveClipboard
   	send, ''%Clipboard%''
	Gosub, RestoreClipboard
}
else
ifEqual A_ThisMenuItem, <Chord>
{
	Gosub, SaveClipboard
   	send, <chord>%Clipboard%</chord>
	Gosub, RestoreClipboard
}
else
ifEqual A_ThisMenuItem, <Color>
{
	Gosub, SaveClipboard
   	send, <Color>%Clipboard%</Color>
	Gosub, RestoreClipboard
}
else
ifEqual A_ThisMenuItem, <span color>
{
	Gosub, SaveClipboard
   	send, <span style=Color:red>%Clipboard%</span>
	Gosub, RestoreClipboard
}
ifEqual A_ThisMenuItem, Kategorie
{
	; {{tag>Lehrbücher}}
	Gosub, SaveClipboard
   	send,  {{}{{}tag>Lehrbücher{}}{}}
	Gosub, RestoreClipboard
}
; ------------------------------------------
; Seiteende bei DokuWiki
; mit Backlinks und Tags
; ------------------------------------------
ifEqual A_ThisMenuItem, Seitenende
{
	; {{tag>Lehrbücher}}
	InputBox, UserInput, Kategorie, Bitte geben Sie eine Kategorie ein., , 280, 120
	if ErrorLevel 
	{
    	MsgBox, CANCEL was pressed.
    	return
    }
    
	Gosub, SaveClipboard
   	send,  ======  ======`n 
   	send  {{}{{}backlinks>.{}}{}}`n 
   	send,  {{}{{}tag>%UserInput%{}}{}}`n 
	Gosub, RestoreClipboard
}
else
ifEqual A_ThisMenuItem, WikiTemplate
{
Template = 
(
(:title Titel des Dokumentes:)
(:Summary: Template-Text:)
(:Verzeichnis: E/Duke_Ellington:)
(:Lilypond: Work/Lilypond:)
`%rframe`% http://localhost/Musik/{$:Verzeichnis}/Bild.jpg | '''{$Titlespaced}'''
(:toc:)
(:num:)
(:justify:)
[[<<]]
Verzeichnis: (:WikiExec {$:Verzeichnis}:))
!!Kapitel 1
!!!Überschrift 1
*(:WikiExec {$:Verzeichnis}\Song1.mp3:)
*(:WikiExec {$:Lilypond}\Song1.ly:)

!!!Überschrift 2
!!Siehe auch
!!Web-Links

<!-- Abstand -->
[@


@]
>>bgcolor=lightgray border='1px solid black' padding=5px<<'''Used from:'''
->(:pagelist link={$FullName} order=title fmt=#title count=10:)

'''Artikel/Kategorie:'''

->[[!{$Groupspaced}]]
>><<
)

	ClipSaved := ClipboardAll   ; Save the entire clipboard to a variable of your choice.
	Clipboard =
	ClipWait, .2


	Loop, parse, Template,`n,%A_Space%%A_Tab%
	{
		Clipboard = %Clipboard%%A_LoopField%`n
		ClipWait, .2
	}
if ErrorLevel
{
	MsgBox, The attempt to copy text onto the clipboard failed.
	return
}
send ^v 
sleep 1000

Clipboard := ClipSaved   ; Restore the original clipboard. Note the use of Clipboard (not ClipboardAll).
ClipSaved =   ; Free the memory in case the clipboard was very large.clipboard


}else	
ifEqual A_ThisMenuItem, Exit
{
	;;
} else
ifEqual A_ThisMenuItem, Top Of Page 
{
  sleep 500
  send ^{Home}
}
else
ifEqual A_ThisMenuItem, Escape
{
	send {ESC}
}	
else
ifEqual A_ThisMenuItem, Enter
{
	send {ENTER}
}	
else
{
;,	MsgBox You selected %A_ThisMenuItem% from the menu %A_ThisMenu%.
}
return

; -------------------------------------------------------------------------------------
;
; -------------------------------------------------------------------------------------
NaturalMenuHandler:

ifEqual A_ThisMenuItem, WikiTemplate
{
	send * +--------------------------------------------------------------------+
	send {ENTER}
;;	0010 * +--------------------------------------------------------------------+
;;0020 * I                     VAW Grevenbroich, (c) 1996                     I
;;0030 * I--------------------------------------------------------------------I

}
else
{
	MsgBox NATURAL: You selected %A_ThisMenuItem% from the menu %A_ThisMenu%.
}
return

; -------------------------------------------------------------------------------------
; Running Tools an other usefull things
; -------------------------------------------------------------------------------------
ToolMenuHandler:
;;MsgBox You selected [%A_ThisMenuItem%] %edit% from the menu %A_ThisMenu%.
ifEqual A_ThisMenuItem, PsPAd
{
	run, "C:\Programme\PSPad editor\PSPad.exe"
	return
}	

ifEqual A_ThisMenuItem, IdoswinPro
{
	run, "C:\Programme\Idoswin Pro\IdoswinPro.exe"
	return
}	
ifEqual A_ThisMenuItem, AutohotkeyHelp
{
	run, c:\Programme\AutoHotkey\AutoHotkey.chm
}	
ifEqual A_ThisMenuItem, Guitar Tuner 
{
	c="C:\Programme\Audio Phonics, Inc\AP Guitar Tuner 1.02\APGuitarTuner.exe"
	run, %c%
	return
}	
ifEqual A_ThisMenuItem, Magix Midi-Studio 2005  
{
	c="C:\MAGIX\ms2005_deLuxe\midistudiodlx.exe"
	run, %c%
}	
ifEqual A_ThisMenuItem, Lilypond Help
{
;;	c="e:\Musik\Work\Lilypond\lilypond.pdf"
;;  c="E:\UniServer3_2\diskw\www\Musik\Work\Lilypond\lilypond.pdf"
  	c="E:\Musik\Work\Lilypond\lilypond.pdf"
	run, %c%
	return
}	
ifEqual A_ThisMenuItem, Band-in-a-Box
{
 		c="E:\BANDINAB\bbw.exe"
		run, %c%
		return
}	
ifEqual A_ThisMenuItem, Band-in-a-Box (Help)
{
 		c="E:\BANDINAB\bbw.hlp"
		run, %c%
		return
}	
else
{
	MsgBox ToolMenuHandler: You selected %A_ThisMenuItem% from the menu %A_ThisMenu%.
}
return



SaveClipboard:
   	; save clipboard
   	tmp = %ClipboardAll%
   	; simulate Ctrl+C (=selection in clipboard)
   	Clipboard= ;empty clipboard
   	Send, ^c
   	Clipwait,0.5
   	; save the content of the clipboard in the variable word
	sleep 100
return
RestoreClipboard:
   	; restore old content of the clipboard
   	Clipboard = %tmp%	; Restore the original clipboard. Note the use of Clipboard (not ClipboardAll).
   	tmp = 				; Free the memory in case the clipboard was very large.clipboard
   	
return
; ------------------------------------------------------------------------------
; Erzeugt ein Wiki-Template für DokuWiki
; ------------------------------------------------------------------------------
PmWikiTemplate:
    MsgBox Noch nicht als Subroutine implementiert!
return

;************** Hotkeys *********************************
::edit::<edit>,</edit>
sleep 150
send {LEFT 6}  
return

;;::kat::[[Kategorie:]]
;;; sleep 50
;;send {LEFT 4}  
;;return

::bu::(:bu:)
return

::<chord::<chord></chord>
sleep 50
send {LEFT 8}  
return

::<wrap>::<wrap bu></wrap>
return




::*b0::<em>::</em>{left 5}

;;;(:WikiExec {$:Verzeichnis}\Latin-05.mspx:)
:*:WikiExec`n::
send (:WikiExec {{}$:Verzeichnis{}}\song.mp3:)
send {LEFT 10}
return

;-------------------------------------------------------------------------------
; Konto-Nr und Bankleitzahl
;-------------------------------------------------------------------------------
::konr::7004664013 
::blz::37069306

;-------------------------------------------------------------------------------
; Meine Handy-Nr
;-------------------------------------------------------------------------------
::handy::0176 775 280 26 


;;:*:]d::  ; This hotstring replaces "]d" with the current date and time via the commands below.
::dat8::  ; This hotstring replaces "]d" with the current date and time via the commands below.
;;FormatTime, CurrentDateTime,, M/d/yyyy h:mm tt  ; It will look like 9/1/2005 3:53 PM
FormatTime, CurrentDateTime,, dd.MM.yyyy 
SendInput %CurrentDateTime%
return

;-------------------------------------------------------------------------------
; Schaltet den Ton mit der ScrollLock-Taste ein- und aus
;-------------------------------------------------------------------------------
ScrollLock:: ; oder eine andere Taste
SoundSet, +1, , mute
SoundGet, soundmute, , mute
if soundmute = On
{
   SetScrollLockState, On  ;knippst das Licht an
   ToolTip,TON wurde abgeschaltet!,1024,0 ; oben rechts bei 1024*768
}
else
{
   SetScrollLockState, Off  ;löscht das Licht
   ToolTip,TON ist wieder eingeschaltet!,1024,0 ; oben rechts bei 1024*768
}
SetTimer, RemoveToolTip, 5000  ; 5 sek anzeigen
return
RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return 



#w::Menu, MyMenu, Show   ; i.e. press the Win-W hotkey to show the menu.
MButton::Menu, MyMenu, Show   ; i.e. press the Win-W hotkey to show the menu.

^!r::Reload  ; Assign Ctrl-Alt-R as a hotkey to restart the script.
