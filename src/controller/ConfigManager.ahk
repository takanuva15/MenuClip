#Include %A_ScriptDir%\src\controller\ConfigManagerGui.ahk

;Handles configuration file reading & writing
class ConfigManager {
	static VERSION
	static CONFIG_FILE_NAME := "config.ini"
	static CONFIG_SECTION := "Configuration Options"
	static CONFIG_NAME_HOTKEY := "SHOW_MENU_HOTKEY"
	static CONFIG_NAME_MAX_CLIPS_TO_STORE := "MAX_CLIPS_TO_STORE"
	static CONFIG_NAME_MAX_WIDTH := "MAX_WIDTH"
	static CONFIG_NAME_MAX_HEIGHT := "MAX_HEIGHT"
	static CONFIG_NAME_ALT_PASTE_APPS := "SHIFT_INS_PASTE_APPS"
	static CONFIG_NAME_CONV_SPEC_CHAR := "CONV_SPEC_CHAR"
	
	static CONFIG_NAME_THEME := "THEME"
	static CONFIG_NAME_DARK_START_HR := "DARK_START_HR"
	static CONFIG_NAME_DARK_START_MIN := "DARK_START_MIN"
	static CONFIG_NAME_DARK_START_PM := "DARK_START_PM"
	static CONFIG_NAME_DARK_STOP_HR := "DARK_STOP_HR"
	static CONFIG_NAME_DARK_STOP_MIN := "DARK_STOP_MIN"
	static CONFIG_NAME_DARK_STOP_PM := "DARK_STOP_PM"
	
	static CONFIG_VAL_HOTKEY
	static CONFIG_VAL_MAX_CLIPS_TO_STORE
	static CONFIG_VAL_MAX_WIDTH
	static CONFIG_VAL_MAX_HEIGHT
	static CONFIG_VAL_ALT_PASTE_APPS
	static CONFIG_VAL_CONV_SPEC_CHAR
	
	static CONFIG_VAL_THEME, calculatedTheme
	static CONFIG_VAL_DARK_START_HR, CONFIG_VAL_DARK_START_MIN, CONFIG_VAL_DARK_START_PM
	static CONFIG_VAL_DARK_STOP_HR, CONFIG_VAL_DARK_STOP_MIN, CONFIG_VAL_DARK_STOP_PM
	
	__New(versionNum) {
		this.VERSION := versionNum
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
		this.CONFIG_VAL_MAX_CLIPS_TO_STORE := this.readConfigFromFile(this.CONFIG_NAME_MAX_CLIPS_TO_STORE, 100)
		this.CONFIG_VAL_MAX_WIDTH := this.readConfigFromFile(this.CONFIG_NAME_MAX_WIDTH, 350)
		this.CONFIG_VAL_MAX_HEIGHT := this.readConfigFromFile(this.CONFIG_NAME_MAX_HEIGHT, 12)
		this.CONFIG_VAL_ALT_PASTE_APPS := this.readConfigFromFile(this.CONFIG_NAME_ALT_PASTE_APPS, A_Space)
		this.CONFIG_VAL_CONV_SPEC_CHAR := this.readConfigFromFile(this.CONFIG_NAME_CONV_SPEC_CHAR, 1)
		this.determineTheme()
	}
	
	determineTheme() {
		this.CONFIG_VAL_THEME := this.readConfigFromFile(this.CONFIG_NAME_THEME, "light")
		this.CONFIG_VAL_DARK_START_HR := this.readConfigFromFile(this.CONFIG_NAME_DARK_START_HR, "05")
		this.CONFIG_VAL_DARK_START_MIN := this.readConfigFromFile(this.CONFIG_NAME_DARK_START_MIN, "00")
		this.CONFIG_VAL_DARK_START_PM := this.readConfigFromFile(this.CONFIG_NAME_DARK_START_PM, "1")
		this.CONFIG_VAL_DARK_STOP_HR := this.readConfigFromFile(this.CONFIG_NAME_DARK_STOP_HR, "09")
		this.CONFIG_VAL_DARK_STOP_MIN := this.readConfigFromFile(this.CONFIG_NAME_DARK_STOP_MIN, "00")
		this.CONFIG_VAL_DARK_STOP_PM := this.readConfigFromFile(this.CONFIG_NAME_DARK_STOP_PM, "0")
		
		if(this.CONFIG_VAL_THEME = "auto") {
			darkStartHr := this.CONFIG_VAL_DARK_START_HR + (this.CONFIG_VAL_DARK_START_PM ? 12 : 0)
			if(A_Hour > darkStartHr) {
				this.calculatedTheme := "dark"
			} else if(A_Hour = darkStartHr && A_Min >= this.CONFIG_VAL_DARK_START_MIN + 0) {
				this.calculatedTheme := "dark"
			} else {
				this.calculatedTheme := "light"
			}
			this.setAutoThemeTimer()
		} else {
			this.calculatedTheme := this.CONFIG_VAL_THEME
		}
	}
	
	writeConfigToFile(configKeyName, configValue) {
		IniWrite, %configValue%, % this.CONFIG_FILE_NAME, % this.CONFIG_SECTION, %configKeyName%
	}
	
	writeAllConfigOptionsToFile() {
		this.writeConfigToFile(this.CONFIG_NAME_HOTKEY, this.CONFIG_VAL_HOTKEY)
		this.writeConfigToFile(this.CONFIG_NAME_MAX_CLIPS_TO_STORE, this.CONFIG_VAL_MAX_CLIPS_TO_STORE)
		this.writeConfigToFile(this.CONFIG_NAME_MAX_WIDTH, this.CONFIG_VAL_MAX_WIDTH)
		this.writeConfigToFile(this.CONFIG_NAME_MAX_HEIGHT, this.CONFIG_VAL_MAX_HEIGHT)
		this.writeConfigToFile(this.CONFIG_NAME_ALT_PASTE_APPS, this.CONFIG_VAL_ALT_PASTE_APPS)
		this.writeConfigToFile(this.CONFIG_NAME_CONV_SPEC_CHAR, this.CONFIG_VAL_CONV_SPEC_CHAR)
		this.writeThemeConfigs()
	}
	
	writeThemeConfigs() {
		this.writeConfigToFile(this.CONFIG_NAME_THEME, this.CONFIG_VAL_THEME)
		this.writeConfigToFile(this.CONFIG_NAME_DARK_START_HR, this.CONFIG_VAL_DARK_START_HR)
		this.writeConfigToFile(this.CONFIG_NAME_DARK_START_MIN, this.CONFIG_VAL_DARK_START_MIN)
		this.writeConfigToFile(this.CONFIG_NAME_DARK_START_PM, this.CONFIG_VAL_DARK_START_PM)
		this.writeConfigToFile(this.CONFIG_NAME_DARK_STOP_HR, this.CONFIG_VAL_DARK_STOP_HR)
		this.writeConfigToFile(this.CONFIG_NAME_DARK_STOP_MIN, this.CONFIG_VAL_DARK_STOP_MIN)
		this.writeConfigToFile(this.CONFIG_NAME_DARK_STOP_PM, this.CONFIG_VAL_DARK_STOP_PM)
	}
	
	getVersionNum() {
		return this.VERSION
	}
	
	getShowMenuHotkey() {
		return this.CONFIG_VAL_HOTKEY
	}
	
	getMaxClipsToStore() {
		return this.CONFIG_VAL_MAX_CLIPS_TO_STORE
	}
	
	getMaxWidth() {
		return this.CONFIG_VAL_MAX_WIDTH
	}
	
	getMaxHeight() {
		return this.CONFIG_VAL_MAX_HEIGHT
	}
	
	getAltPasteApps() {
		return this.CONFIG_VAL_ALT_PASTE_APPS
	}
	
	getConvSpecChar() {
		return this.CONFIG_VAL_CONV_SPEC_CHAR
	}
	
	getTheme() {
		return this.calculatedTheme
	}
	
	openEditConfigWindow() {
		this.configManagerGui.showGui()
	}
	
	;obtained from https://autohotkey.com/board/topic/19960-got-problems-while-checking-the-system-time/://autohotkey.com/board/topic/19960-got-problems-while-checking-the-system-time/page-2?&
	;not under MIT license
	setAutoThemeTimer() {
		darkStartHr := this.CONFIG_VAL_DARK_START_HR + (this.CONFIG_VAL_DARK_START_PM ? 12 : 0)
		darkStartHr := (StrLen(darkStartHr) = 1 ? "0" : "") darkStartHr ;pads single digit hour
		target_time := darkStartHr . this.CONFIG_VAL_DARK_START_MIN
		target = % A_YYYY A_MM A_DD target_time "00"
		if (target < A_Now) {
			EnvAdd, target, 1, Days
		}
		EnvSub, target, %A_Now%, Seconds
		reloadFn := ObjBindMethod(this, "reloadFn")
		SetTimer, % reloadFn, % target * -1000
	}
	
	reloadFn() {
		Reload
	}
}