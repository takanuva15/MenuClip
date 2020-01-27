;Handles configuration file reading & writing
class ConfigManagerGui {
	static configManager
	static COL_TWO_X := 175
	static CONFIG_HANDLE_HOTKEY
	static CONFIG_HANDLE_MAX_CLIPS_TO_STORE
	static CONFIG_HANDLE_MAX_MENUITEM_LABEL_LENGTH
	static CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD
	__New(configManager) {
		this.configManager := configManager
		Gui +hWndEditConfig
		Gui EditConfig:-MinimizeBox -MaximizeBox
		this.addHotkeyOpt()
		this.addMaxClipsToStoreOpt()
		this.addMaxMenuItemLabelLengthOpt()
		this.addSaveAndReloadButton()
		this.showGui()
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
	
	addSaveAndReloadButton() {
		Gui EditConfig:Add, Button, x100 y100 w100 h25 hWndSaveAndReload, &Save and Reload
		this.CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD := SaveAndReload
		saveConfigAndReloadFn := ObjBindMethod(this, "saveConfigAndReload")
		GuiControl +g, %SaveAndReload%, % saveConfigAndReloadFn
	}
	
	saveConfigAndReload() {
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_HOTKEY, this.getConfigOptionValue(this.CONFIG_HANDLE_HOTKEY))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_MAX_CLIPS_TO_STORE, this.getConfigOptionValue(this.CONFIG_HANDLE_MAX_CLIPS_TO_STORE))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_MAX_MENUITEM_LABEL_LENGTH, this.getConfigOptionValue(this.CONFIG_HANDLE_MAX_MENUITEM_LABEL_LENGTH))
		Reload
	}
	
	getConfigOptionValue(hWnd) {
		GuiControlGet, tmp,, %hWnd%
		return tmp
	}
	
	showGui() {
		Gui EditConfig:Show, w300 h150, Edit Configuration
	}
}