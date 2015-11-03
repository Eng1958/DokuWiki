' ******************************************************************************
' ProtokollHandler.vbs
'
'
' ******************************************************************************
'
option explicit
Dim param, plen, file2exec, WshShell
Dim objFSO, testFile

' -----------------------------------------------------------------------------'
' get Argument: file to execute'
param = WScript.Arguments.Item(0)
plen = len(param)-5
file2exec = right(param, plen)

' WScript.Echo "Hello World: " & file2exec


Set objFSO = CreateObject("Scripting.FileSystemObject")
'testFile = "c:\boot.ini"
'testFile = "x:\folder\file.exe"

If (objFSO.FileExists(File2Exec)) Then 
	' WScript.Echo "jo file gibts"
Else
	WScript.Echo File2Exec & " doesn't exist!"
    WScript.Quit
End If

File2Exec = """" & File2Exec & """"
' WScript.Echo File2Exec

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.Run (File2exec)
