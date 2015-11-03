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

*[[@E:\Musik\Lehrbuecher\Bass-Improvisation\04-AudioTrack-04.mp3|04-AudioTrack-04.mp3]]  MP3-File
