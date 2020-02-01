;Handles configuration file reading & writing
class ConfigManagerGui {
	static configManager
	static COL_TWO_X := 185
	static CONFIG_HANDLE_HOTKEY
	static CONFIG_HANDLE_MAX_CLIPS_TO_STORE
	static CONFIG_HANDLE_MAX_MENUITEM_LABEL_LENGTH
	static CONFIG_HANDLE_ALT_PASTE_APPS
	static CONFIG_HANDLE_THEME
	static CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD
	__New(configManager) {
		this.configManager := configManager
		this.themeStyle := this.configManager.getTheme()
		
		Gui +hWndEditConfig
		Gui EditConfig:-MinimizeBox -MaximizeBox
		if(this.themeStyle = "dark") {
			Gui EditConfig:Color, 2B2B2B, 43474A
			Gui EditConfig:Font, cA9B7C6
		}
		
		this.addHotkeyOpt()
		this.addMaxClipsToStoreOpt()
		this.addMaxMenuItemLabelLengthOpt()
		this.addAltPasteAppsOpt()
		this.addSaveAndReloadButton()
		this.addThemeOpt()
	}
	
	addHotkeyOpt() {
		Gui EditConfig:Add, Text, x10 y10 w150 h15, Hotkey:
		Gui EditConfig:Add, Edit, % "x" this.COL_TWO_X " y8 w100 h18 hWndShowMenuHotkey", % this.configManager.getShowMenuHotkey()
		this.CONFIG_HANDLE_HOTKEY := ShowMenuHotkey
	}
	
	addMaxClipsToStoreOpt() {
		Gui EditConfig:Add, Text, x10 y40 w150 h15, Number of clips to store:
		Gui EditConfig:Add, Edit, % "x" this.COL_TWO_X " y38 w32 h18 hWndMaxClipsToStore", % this.configManager.getMaxClipsToStore()
		this.CONFIG_HANDLE_MAX_CLIPS_TO_STORE := MaxClipsToStore
	}
	
	addMaxMenuItemLabelLengthOpt() {
		Gui EditConfig:Add, Text, x10 y70 w170 h15, Max length of menu item preview:
		Gui EditConfig:Add, Edit, % "x" this.COL_TWO_X " y68 w32 h18 hWndMaxMenuItemLabelLength", % this.configManager.getMaxMenuitemLabelLength()
		this.CONFIG_HANDLE_MAX_MENUITEM_LABEL_LENGTH := MaxMenuItemLabelLength
	}
	
	addAltPasteAppsOpt() {
		Gui EditConfig:Add, Text, x10 y100 w170, App exes that use Shift+Ins pasting: (comma-separated)
		Gui EditConfig:Add, Edit, % "x" this.COL_TWO_X " y98 w100 r2 hWndAltPasteApps", % this.configManager.getAltPasteApps()
		this.CONFIG_HANDLE_ALT_PASTE_APPS := AltPasteApps
	}
	
	addThemeOpt() {
		this.themes := {"light":1, "dark":2}
		Gui EditConfig:Add, Text, x10 y145 w170 h15, Theme:
		Gui EditConfig:Add, DDL, % "x" this.COL_TWO_X " y143 w50 hWndMenuTheme Choose" this.themes[this.configManager.getTheme()], light|dark
		this.CONFIG_HANDLE_THEME := MenuTheme
	}
	
	addSaveAndReloadButton() {
		Gui EditConfig:Add, Button, x100 y185 w100 h28 hWndSaveAndReload cFF0000, &Save and Reload
		this.CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD := SaveAndReload
		saveConfigAndReloadFn := ObjBindMethod(this, "saveConfigAndReload")
		GuiControl +g, %SaveAndReload%, % saveConfigAndReloadFn
	}
	
	saveConfigAndReload() {
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_HOTKEY, this.getConfigOptionValue(this.CONFIG_HANDLE_HOTKEY))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_MAX_CLIPS_TO_STORE, this.getConfigOptionValue(this.CONFIG_HANDLE_MAX_CLIPS_TO_STORE))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_MAX_MENUITEM_LABEL_LENGTH, this.getConfigOptionValue(this.CONFIG_HANDLE_MAX_MENUITEM_LABEL_LENGTH))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_ALT_PASTE_APPS, this.getConfigOptionValue(this.CONFIG_HANDLE_ALT_PASTE_APPS))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_THEME, this.getConfigOptionValue(this.CONFIG_HANDLE_THEME))
		Reload
	}
	
	getConfigOptionValue(hWnd) {
		GuiControlGet, tmp,, %hWnd%
		return tmp
	}
	
	showGui() {
		Gui EditConfig:Show, w300 h220, Edit Configuration
	}
}