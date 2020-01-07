;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

;Container class for the classes that MenuClip directly uses
class MenuClip {
	#Include %A_ScriptDir%\src\TrayManager.ahk
	#Include %A_ScriptDir%\src\ConfigManager.ahk
	#Include %A_ScriptDir%\src\ClipCache.ahk
	#Include %A_ScriptDir%\src\ClipManager.ahk
	#Include %A_ScriptDir%\src\MenuManager.ahk
}
