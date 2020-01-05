;Handles changes to the menu
class TrayManager {
	static versionNum
	static configFileName
	__New(configManager) {
		this.versionNum := configManager.getVersionNum()
		this.configFileName := configManager.getConfigFileName()
	}
	
	configureTrayTooltip() {
		Menu, Tray, Tip, % "MenuClip " . this.versionNum
	}
	
	configureTrayOptions() {
		Menu, Tray, NoStandard
		showAboutMessageFn := ObjBindMethod(this, "showAboutMessage")
		Menu, Tray, Add, &About, % showAboutMessageFn
		reloadScriptFn := ObjBindMethod(this, "reloadScript")
		Menu, Tray, Add, &Reload This Script, % reloadScriptFn
		editConfigFileFn := ObjBindMethod(this, "editConfigFile")
		Menu, Tray, Add, Edit &Configuration, % editConfigFileFn	
		Menu, Tray, Default, Edit &Configuration
		exitScriptFn := ObjBindMethod(this, "exitScript")
		Menu, Tray, Add, &Exit Script, % exitScriptFn
	}
	
	showAboutMessage() {
		MsgBox, 0, About MenuClip, % this.ABOUT_MENUCLIP
	}
	
	reloadScript() {
		Reload
	}
	
	editConfigFile() {
		configFileName := this.configFileName
		Run Edit %configFileName%
	}
	
	exitScript() {
		ExitApp
	}
	
	
	static ABOUT_MENUCLIP := ""
		. "MenuClip is a free, open-source clipboard manager written by takanuva15.`n"
		. "It watches your clipboard and stores new clips into memory, which you "
		. "can recall later by invoking the 'clip menu' through a hotkey.`n`n"
		. "See the README.md file on the MenuClip GitHub page for more info"
}