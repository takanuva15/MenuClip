;Handles configuration file reading & writing
class ConfigGuiGeneralOptions {
	static configManager
	static CONFIG_HANDLE_HOTKEY
	static CONFIG_HANDLE_MAX_CLIPS_TO_STORE
	static CONFIG_HANDLE_MAX_WIDTH
	static CONFIG_HANDLE_MAX_HEIGHT
	static CONFIG_HANDLE_ALT_PASTE_APPS
	static CONFIG_HANDLE_THEME
	static CONFIG_HANDLE_CONV_SPEC_CHAR
	__New(configManager) {
		this.configManager := configManager
	}
	
	addAllOptions() {
		this.addHotkeyOpt()
		this.addMaxClipsToStoreOpt()
		this.addMaxWidth()
		this.addMaxHeight()
		this.addAltPasteAppsOpt()
		this.addConvSpecCharOpt()
	}
	
	addHotkeyOpt() {
		Gui EditConfig:Add, Text, w170 Section, Hotkey:
		Gui EditConfig:Add, Edit, x+5 yp-2 w100 h17 hWndShowMenuHotkey, % this.configManager.getShowMenuHotkey()
		this.CONFIG_HANDLE_HOTKEY := ShowMenuHotkey
	}
	
	addMaxClipsToStoreOpt() {
		Gui EditConfig:Add, Text, xs y+10 w170, Number of clips to store:
		Gui EditConfig:Add, Edit, x+5 yp-2 w32 h17 hWndMaxClipsToStore, % this.configManager.getMaxClipsToStore()
		this.CONFIG_HANDLE_MAX_CLIPS_TO_STORE := MaxClipsToStore
	}
	
	addMaxWidth() {
		Gui EditConfig:Add, Text, xs y+10 w170, Max width:
		Gui EditConfig:Add, Edit, x+5 yp-2 w32 h17 hWndMaxWidth, % this.configManager.getMaxWidth()
		this.CONFIG_HANDLE_MAX_WIDTH := MaxWidth
	}
	
	addMaxHeight() {
		Gui EditConfig:Add, Text, xs y+10 w170, Max height (# rows):
		Gui EditConfig:Add, Edit, x+5 yp-2 w32 h17 hWndMaxHeight, % this.configManager.getMaxHeight()
		this.CONFIG_HANDLE_MAX_HEIGHT := MaxHeight
	}
	
	addAltPasteAppsOpt() {
		Gui EditConfig:Add, Text, xs y+10 w170, App exes that use Shift+Ins pasting: (comma-separated)
		Gui EditConfig:Add, Edit, x+5 yp-2 w100 r2 hWndAltPasteApps, % this.configManager.getAltPasteApps()
		this.CONFIG_HANDLE_ALT_PASTE_APPS := AltPasteApps
	}
	
	addConvSpecCharOpt() {
		Gui EditConfig:Add, Text, xs y+10 w170, Convert tabs and newlines to [\t] and [\n] in clips view
		Gui EditConfig:Add, CheckBox, % "x+5 yp-2 w100 r2 hWndConvSpecChar Checked" this.configManager.getConvSpecChar()
		this.CONFIG_HANDLE_CONV_SPEC_CHAR := ConvSpecChar
	}
	
	saveConfigs() {
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_HOTKEY, GetControlValue(this.CONFIG_HANDLE_HOTKEY))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_MAX_CLIPS_TO_STORE, GetControlValue(this.CONFIG_HANDLE_MAX_CLIPS_TO_STORE))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_MAX_WIDTH, GetControlValue(this.CONFIG_HANDLE_MAX_WIDTH))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_MAX_HEIGHT, GetControlValue(this.CONFIG_HANDLE_MAX_HEIGHT))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_ALT_PASTE_APPS, GetControlValue(this.CONFIG_HANDLE_ALT_PASTE_APPS))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_CONV_SPEC_CHAR, GetControlValue(this.CONFIG_HANDLE_CONV_SPEC_CHAR))
	}
}