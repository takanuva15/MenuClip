;Handles changes to the menu
class TrayManager {
	static configManager
	static clipManager
	static VERSION
	__New(version, clipManager) {
		this.VERSION := version
		this.clipManager := clipManager
		this.configManager := clipManager.configManager
	}
	
	configureTrayTooltip() {
		Menu, Tray, Tip, % "MenuClip " . this.VERSION
	}
	
	configureTrayOptions() {
		Menu, Tray, NoStandard
		showAboutMessageFn := ObjBindMethod(this, "showAboutMessage")
		Menu, Tray, Add, &About, % showAboutMessageFn
		Menu, Tray, Add
		editConfigFileFn := ObjBindMethod(this, "editConfigFile")
		Menu, Tray, Add, Edit &Configuration, % editConfigFileFn	
		Menu, Tray, Default, Edit &Configuration
		reloadScriptFn := ObjBindMethod(this, "reloadScript")
		Menu, Tray, Add, &Reload This Script, % reloadScriptFn
		clearCacheAndReloadFn := ObjBindMethod(this, "clearCacheAndReload")
		Menu, Tray, Add, Clear Cache && Reload, % clearCacheAndReloadFn
		Menu, Tray, Add
		exitScriptFn := ObjBindMethod(this, "exitScript")
		Menu, Tray, Add, &Exit, % exitScriptFn
	}
	
	showAboutMessage() {
		MsgBox, 0, About MenuClip, % "MenuClip " . this.VERSION . " (c) takanuva15 `n`n" this.ABOUT_MENUCLIP
	}
	
	editConfigFile() {
		this.configManager.openEditConfigWindow()
	}
	
	reloadScript() {
		Reload
	}
	
	clearCacheAndReload() {
		this.clipManager.clipStore.cacheDirManager.clearCache()
		this.reloadScript()
	}
	
	exitScript() {
		ExitApp
	}
	
	static ABOUT_MENUCLIP := ""
		. "MenuClip is a free, open-source clipboard manager. "
		. "It watches your clipboard and stores new clips into memory, which you "
		. "can recall later by invoking the 'clip menu' through a hotkey.`n`n"
		. "See the README.md file on the MenuClip GitHub page (bit.ly/MenuClip) for more info "
		. "(and visit my profile at github.com/takanuva15)`n"
}