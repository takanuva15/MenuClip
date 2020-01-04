;Handles configuration file reading & writing
class ConfigManager {
	static CONFIG_FILE_NAME
	static CONFIG_SECTION := "Configuration Options"
	static CONFIG_NAME_MAX_CLIPS_TO_STORE := "MAX_CLIPS_TO_STORE"
	static CONFIG_NAME_MAX_MENUITEM_LABEL_LENGTH := "MAX_MENUITEM_LABEL_LENGTH"
	static CONFIG_NAME_ALT_PASTE_APPS := "ALTERNATE_PASTE_APPS"
	
	static CONFIG_VAL_MAX_CLIPS_TO_STORE
	static CONFIG_VAL_MAX_MENUITEM_LABEL_LENGTH
	static CONFIG_VAL_ALT_PASTE_APPS
	
	__New(configFileName) {
		this.CONFIG_FILE_NAME := configFileName
		this.readAllConfigOptionsFromFile()
	}
	
	readAllConfigOptionsFromFile() {
		IniRead, tmpReadInStorageVar, % this.CONFIG_FILE_NAME, % this.CONFIG_SECTION, % this.CONFIG_NAME_MAX_CLIPS_TO_STORE
		this.CONFIG_VAL_MAX_CLIPS_TO_STORE := tmpReadInStorageVar
		IniRead, tmpReadInStorageVar, % this.CONFIG_FILE_NAME, % this.CONFIG_SECTION, % this.CONFIG_NAME_MAX_MENUITEM_LABEL_LENGTH
		this.CONFIG_VAL_MAX_MENUITEM_LABEL_LENGTH := tmpReadInStorageVar
		IniRead, tmpReadInStorageVar, % this.CONFIG_FILE_NAME, % this.CONFIG_SECTION, % this.CONFIG_NAME_ALT_PASTE_APPS
		this.CONFIG_VAL_ALT_PASTE_APPS := tmpReadInStorageVar
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
}