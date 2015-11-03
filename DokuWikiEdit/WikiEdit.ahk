MsgBox, "Hello World"
Loop, %0%  ; For each parameter:
{
	param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
	MsgBox, 4,, Parameter number %A_Index% is %param%.  Continue?
	IfMsgBox, No
		break
}
run, C:\Program Files\UltraEdit\UEdit32.exe %param%
