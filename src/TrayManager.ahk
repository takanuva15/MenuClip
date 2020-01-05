;Handles changes to the menu
class TrayManager {
	__New() {
		
	}
	
	configureTrayTooltip(versionNum) {
		Menu, Tray, Tip, MenuClip %versionNum%
	}
	
	configureTrayOptions() {
		Menu, Tray, NoStandard
		showAboutMessageFn := ObjBindMethod(this, "showAboutMessage")
		Menu, Tray, Add, &About, % showAboutMessageFn
		reloadScriptFn := ObjBindMethod(this, "reloadScript")
		Menu, Tray, Add, &Reload This Script, % reloadScriptFn
	}
	
	showAboutMessage() {
		MsgBox, 0, About MenuClip, % this.ABOUT_MENUCLIP
	}
	
	reloadScript() {
		Reload
	}
	
	
	static ABOUT_MENUCLIP := ""
		. "MenuClip is a free, open-source clipboard manager written by takanuva15.`n"
		. "It watches your clipboard and stores new clips into memory, which you "
		. "can recall later by invoking the 'clip menu' through a hotkey.`n`n"
		. "See the README.md file on the MenuClip GitHub page for more info"
}