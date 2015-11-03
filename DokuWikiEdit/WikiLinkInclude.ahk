;----------------------------------------------------------------
; Wiki-Link.ahk überprüft das Clipboard, ob eine URL
; oder ein Filenamen kopiert worden ist. Falls eine 
; URL vorliegt, wird diese im Broweser gestartet
; ansonsten wird das File aufgerufen.
; 23.05.2007  	D. Engemann	Ursprung
; 20.03.2008	D. Engemann	als Include in WikiEditSupport.ahk impementiert.
;----------------------------------------------------------------

; A label named "OnClipboardChange" (if it exists) is launched automatically 
; whenever any application (even the script itself) has changed the contents 
; of the clipboard. The label also runs once when the script first starts.
;
; The built-in variable A_EventInfo contains:
; 0 if the clipboard is now empty;
; 1 if it contains something that can be expressed as text (this includes files 
;   copied from an Explorer window);
; 2 if it contains something entirely non-text such as a picture.
OnClipboardChange:

;; Clipboard nur bearbeiten, wenn Text ( = 1) im Clipboard vorliegt.
if A_EventInfo <> 1
{
    return
}

WinGetClass, class, A
;; MsgBox, The active window's class is "%class%".

;; IEFrame
;; MozillaUIWindowClass
var = IE
IfNotInString, class, %var% 
{
    var = Mozilla
    IfNotInString, class, %var%
    {
        return
    }
}


;; eine kopierte URL die mit "http:" anfängt, wird im Browser aufgerufen
position := InStr(Clipboard, "http:", CaseSensitive = false, StartingPos = 1)
if position = 1 
{
  gosub runClipboard
  return
}

;; eine kopierte URL die mit "www."" anfängt, wird im Browser aufgerufen
position := InStr(Clipboard, "www.", CaseSensitive = false, StartingPos = 1)
if position = 1 
{
  gosub runClipboard
  return
}


;; eine kopierte File-URL wird gestartet
position := InStr(Clipboard, "file:", CaseSensitive = false, StartingPos = 1)
if position = 1 
{
  StringTrimLeft, OutputVar, Clipboard, 8
  Clipboard := OutputVar

  gosub runClipboard
  return
}

;; eine kopierte File-URL wird gestartet
position := InStr(Clipboard, "exec:", CaseSensitive = false, StartingPos = 1)
if position = 1 
{
  StringTrimLeft, OutputVar, Clipboard, 5
  Clipboard := OutputVar

  gosub runClipboard
  return
}

;; ein kopiertes File wird gestartet
IfExist, %Clipboard%
{
  gosub runClipboard
}

return


; ------------------------------------------------------------------------
; 
; ------------------------------------------------------------------------
runClipboard:
;;  ToolTip Clipboard data type: %A_EventInfo% `n%Clipboard%`nCurrent WindowClass %class%
  msgBox  4, WikiLink, Current Browser "%class%"`nRun %Clipboard%, 4
  IfMsgBox Timeout 
    goto ret
  else IfMsgBox No
    goto ret
    
;;  run C:\Programme\Winamp\winamp.exe, %Clipboard%
  run %Clipboard%

ret:  
  Sleep 3000
;;  ToolTip  ; Turn off the tip.

return

