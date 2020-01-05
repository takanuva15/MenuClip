;Handles configuration file reading & writing
class ConfigManager {
	static CONFIG_FILE_NAME
	static CONFIG_SECTION := "Configuration Options"
	static CONFIG_NAME_HOTKEY := "SHOW_MENU_HOTKEY"
	static CONFIG_NAME_MAX_CLIPS_TO_STORE := "MAX_CLIPS_TO_STORE"
	static CONFIG_NAME_MAX_MENUITEM_LABEL_LENGTH := "MAX_MENUITEM_LABEL_LENGTH"
	static CONFIG_NAME_ALT_PASTE_APPS := "ALTERNATE_PASTE_APPS"
	static CONFIG_NAME_THEME := "THEME"
	
	static CONFIG_VAL_HOTKEY
	static CONFIG_VAL_MAX_CLIPS_TO_STORE
	static CONFIG_VAL_MAX_MENUITEM_LABEL_LENGTH
	static CONFIG_VAL_ALT_PASTE_APPS
	static CONFIG_VAL_THEME
	
	__New(configFileName) {
		this.CONFIG_FILE_NAME := configFileName
		this.readAllConfigOptionsFromFile()
	}
	
	readConfigFromFile(configKeyName) {
		IniRead, tmpReadInStorageVar, % this.CONFIG_FILE_NAME, % this.CONFIG_SECTION, %configKeyName%
		return tmpReadInStorageVar
	}
	
	readAllConfigOptionsFromFile() {
		this.CONFIG_VAL_HOTKEY := this.readConfigFromFile(this.CONFIG_NAME_HOTKEY)
		this.CONFIG_VAL_MAX_CLIPS_TO_STORE := this.readConfigFromFile(this.CONFIG_NAME_MAX_CLIPS_TO_STORE)
		this.CONFIG_VAL_MAX_MENUITEM_LABEL_LENGTH := this.readConfigFromFile(this.CONFIG_NAME_MAX_MENUITEM_LABEL_LENGTH)
		this.CONFIG_VAL_ALT_PASTE_APPS := this.readConfigFromFile(this.CONFIG_NAME_ALT_PASTE_APPS)
		this.CONFIG_VAL_THEME := this.readConfigFromFile(this.CONFIG_NAME_THEME)
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
}