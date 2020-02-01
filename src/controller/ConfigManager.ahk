;Handles configuration file reading & writing
class ConfigManager {
	static VERSION
	static CONFIG_FILE_NAME
	static CONFIG_SECTION := "Configuration Options"
	static CONFIG_NAME_HOTKEY := "SHOW_MENU_HOTKEY"
	static CONFIG_NAME_MAX_CLIPS_TO_STORE := "MAX_CLIPS_TO_STORE"
	static CONFIG_NAME_MAX_MENUITEM_LABEL_LENGTH := "MAX_MENUITEM_LABEL_LENGTH"
	static CONFIG_NAME_ALT_PASTE_APPS := "SHIFT_INS_PASTE_APPS"
	static CONFIG_NAME_THEME := "THEME"
	
	static CONFIG_VAL_HOTKEY
	static CONFIG_VAL_MAX_CLIPS_TO_STORE
	static CONFIG_VAL_MAX_MENUITEM_LABEL_LENGTH
	static CONFIG_VAL_ALT_PASTE_APPS
	static CONFIG_VAL_THEME
	
	__New(versionNum, configFileName) {
		this.VERSION := versionNum
		this.CONFIG_FILE_NAME := configFileName
		this.readAllConfigOptionsFromFile()
		this.writeAllConfigOptionsToFile()
		
		this.configManagerGui := new MenuClip.Controller.ConfigManagerGui(this)
	}
	
	readConfigFromFile(configKeyName, defaultValue) {
		IniRead, tmpReadInStorageVar, % this.CONFIG_FILE_NAME, % this.CONFIG_SECTION, %configKeyName%, %defaultValue%
		return tmpReadInStorageVar
	}
	
	readAllConfigOptionsFromFile() {
		this.CONFIG_VAL_HOTKEY := this.readConfigFromFile(this.CONFIG_NAME_HOTKEY, "^+v")
		this.CONFIG_VAL_MAX_CLIPS_TO_STORE := this.readConfigFromFile(this.CONFIG_NAME_MAX_CLIPS_TO_STORE, 15)
		this.CONFIG_VAL_MAX_MENUITEM_LABEL_LENGTH := this.readConfigFromFile(this.CONFIG_NAME_MAX_MENUITEM_LABEL_LENGTH, 50)
		this.CONFIG_VAL_ALT_PASTE_APPS := this.readConfigFromFile(this.CONFIG_NAME_ALT_PASTE_APPS, A_Space)
		this.CONFIG_VAL_THEME := this.readConfigFromFile(this.CONFIG_NAME_THEME, "light")
	}
	
	writeConfigToFile(configKeyName, configValue) {
		IniWrite, %configValue%, % this.CONFIG_FILE_NAME, % this.CONFIG_SECTION, %configKeyName%
	}
	
	writeAllConfigOptionsToFile() {
		this.writeConfigToFile(this.CONFIG_NAME_HOTKEY, this.CONFIG_VAL_HOTKEY)
		this.writeConfigToFile(this.CONFIG_NAME_MAX_CLIPS_TO_STORE, this.CONFIG_VAL_MAX_CLIPS_TO_STORE)
		this.writeConfigToFile(this.CONFIG_NAME_MAX_MENUITEM_LABEL_LENGTH, this.CONFIG_VAL_MAX_MENUITEM_LABEL_LENGTH)
		this.writeConfigToFile(this.CONFIG_NAME_ALT_PASTE_APPS, this.CONFIG_VAL_ALT_PASTE_APPS)
		this.writeConfigToFile(this.CONFIG_NAME_THEME, this.CONFIG_VAL_THEME)
	}
	
	getVersionNum() {
		return this.VERSION
	}
	
	getConfigFileName() {
		return this.CONFIG_FILE_NAME
	}
	
	getShowMenuHotkey() {
		return this.CONFIG_VAL_HOTKEY
	}
	
	getMaxClipsToStore() {
		return this.CONFIG_VAL_MAX_CLIPS_TO_STORE
	}
	
	getMaxMenuitemLabelLength() {
		return this.CONFIG_VAL_MAX_MENUITEM_LABEL_LENGTH
	}
	
	getAltPasteApps() {
		return this.CONFIG_VAL_ALT_PASTE_APPS
	}
	
	getTheme() {
		return this.CONFIG_VAL_THEME
	}
	
	openEditConfigWindow() {
		this.configManagerGui.showGui()
	}
}