;Handles configuration file reading & writing
class ConfigManagerGui {
	static configManager
	static CONFIG_HANDLE_MAX_CLIPS_TO_STORE
	static CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD
	__New(configManager) {
		this.configManager := configManager
		Gui +hWndEditConfig
		Gui EditConfig:-MinimizeBox -MaximizeBox
		this.addMaxClipsToStoreOpt()
		this.addSaveAndReloadButton()
		this.showGui()
	}
	
	addMaxClipsToStoreOpt() {
		Gui EditConfig:Add, Text, x10 y10 w150 h15, Number of clips to store:
		Gui EditConfig:Add, Edit, x140 y8 w32 h18 hWndMaxClipsToStore, % this.configManager.getMaxClipsToStore()
		this.CONFIG_HANDLE_MAX_CLIPS_TO_STORE := MaxClipsToStore
		;viewMaxClipsFn := ObjBindMethod(this, "viewMaxClips")
		;GuiControl +g, %MaxClipsToStore%, % viewMaxClipsFn
	}
	
	addSaveAndReloadButton() {
		Gui EditConfig:Add, Button, x50 y70 w100 h25 hWndSaveAndReload, &Save and Reload
		this.CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD := SaveAndReload
		saveConfigAndReloadFn := ObjBindMethod(this, "saveConfigAndReload")
		GuiControl +g, %SaveAndReload%, % saveConfigAndReloadFn
	}
	
	OnChange() {
		; this is run when the GuiControl changes
	}
	
	viewMaxClips(CtrlHwnd) {
		GuiControlGet, tmp,, %CtrlHwnd%
		Msgbox %tmp%
		;MsgBox % CtrlHwnd . "::" . GuiEvent . "::" . EventInfo
	}
	
	saveConfigAndReload() {
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_MAX_CLIPS_TO_STORE, this.getConfigOptionValue(this.CONFIG_HANDLE_MAX_CLIPS_TO_STORE))
		Reload
	}
	
	getConfigOptionValue(hWnd) {
		GuiControlGet, tmp,, %hWnd%
		return tmp
	}
	
	showGui() {
		Gui EditConfig:Show, w190 h100, Edit Configuration
	}
}