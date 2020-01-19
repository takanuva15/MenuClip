;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

;Container class for the classes that MenuClip directly uses
class MenuClip {
	class Controller {
		#Include %A_ScriptDir%\src\controller\TrayManager.ahk
		#Include %A_ScriptDir%\src\controller\ConfigManager.ahk
		#Include %A_ScriptDir%\src\controller\ClipManager.ahk
	}
	class Model {
		#Include %A_ScriptDir%\src\model\ClipStore.ahk
		#Include %A_ScriptDir%\src\model\CacheDirManager.ahk
	}
	class View {
		#Include %A_ScriptDir%\src\view\MenuManager.ahk
	}
}
