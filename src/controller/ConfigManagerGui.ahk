;Handles configuration file reading & writing
class ConfigManagerGui {
	static configManager
	static CONFIG_HANDLE_HOTKEY
	static CONFIG_HANDLE_MAX_CLIPS_TO_STORE
	static CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD
	__New(configManager) {
		this.configManager := configManager
		Gui +hWndEditConfig
		Gui EditConfig:-MinimizeBox -MaximizeBox
		this.addHotkeyOpt()
		this.addMaxClipsToStoreOpt()
		this.addSaveAndReloadButton()
		this.showGui()
	}
	
	addHotkeyOpt() {
		Gui EditConfig:Add, Text, x10 y10 w150 h15, Hotkey:
		Gui EditConfig:Add, Edit, x140 y8 w100 h18 hWndShowMenuHotkey, % this.configManager.getShowMenuHotkey()
		this.CONFIG_HANDLE_HOTKEY := ShowMenuHotkey
	}
	
	addMaxClipsToStoreOpt() {
		Gui EditConfig:Add, Text, x10 y40 w150 h15, Number of clips to store:
		Gui EditConfig:Add, Edit, x140 y38 w32 h18 hWndMaxClipsToStore, % this.configManager.getMaxClipsToStore()
		this.CONFIG_HANDLE_MAX_CLIPS_TO_STORE := MaxClipsToStore
	}
	
	addSaveAndReloadButton() {
		Gui EditConfig:Add, Button, x75 y70 w100 h25 hWndSaveAndReload, &Save and Reload
		this.CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD := SaveAndReload
		saveConfigAndReloadFn := ObjBindMethod(this, "saveConfigAndReload")
		GuiControl +g, %SaveAndReload%, % saveConfigAndReloadFn
	}
	
	saveConfigAndReload() {
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_HOTKEY, this.getConfigOptionValue(this.CONFIG_HANDLE_HOTKEY))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_MAX_CLIPS_TO_STORE, this.getConfigOptionValue(this.CONFIG_HANDLE_MAX_CLIPS_TO_STORE))
		Reload
	}
	
	getConfigOptionValue(hWnd) {
		GuiControlGet, tmp,, %hWnd%
		return tmp
	}
	
	showGui() {
		Gui EditConfig:Show, w250 h100, Edit Configuration
	}
}