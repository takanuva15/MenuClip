;Handles configuration file reading & writing
class ConfigThemeManager {
	static CONFIG_NAME_THEME := "THEME"
	static CONFIG_NAME_DARK_START_HR := "DARK_START_HR"
	static CONFIG_NAME_DARK_START_MIN := "DARK_START_MIN"
	static CONFIG_NAME_DARK_START_PM := "DARK_START_PM"
	static CONFIG_NAME_DARK_STOP_HR := "DARK_STOP_HR"
	static CONFIG_NAME_DARK_STOP_MIN := "DARK_STOP_MIN"
	static CONFIG_NAME_DARK_STOP_PM := "DARK_STOP_PM"
	
	static CONFIG_VAL_THEME, calculatedTheme
	static CONFIG_VAL_DARK_START_HR, CONFIG_VAL_DARK_START_MIN, CONFIG_VAL_DARK_START_PM
	static CONFIG_VAL_DARK_STOP_HR, CONFIG_VAL_DARK_STOP_MIN, CONFIG_VAL_DARK_STOP_PM
	
	__New(configManager) {
		this.configManager := configManager
	}
	
	determineTheme() {
		this.CONFIG_VAL_THEME := this.configManager.readConfigFromFile(this.CONFIG_NAME_THEME, "light")
		this.CONFIG_VAL_DARK_START_HR := this.configManager.readConfigFromFile(this.CONFIG_NAME_DARK_START_HR, "05")
		this.CONFIG_VAL_DARK_START_MIN := this.configManager.readConfigFromFile(this.CONFIG_NAME_DARK_START_MIN, "00")
		this.CONFIG_VAL_DARK_START_PM := this.configManager.readConfigFromFile(this.CONFIG_NAME_DARK_START_PM, "1")
		this.CONFIG_VAL_DARK_STOP_HR := this.configManager.readConfigFromFile(this.CONFIG_NAME_DARK_STOP_HR, "09")
		this.CONFIG_VAL_DARK_STOP_MIN := this.configManager.readConfigFromFile(this.CONFIG_NAME_DARK_STOP_MIN, "00")
		this.CONFIG_VAL_DARK_STOP_PM := this.configManager.readConfigFromFile(this.CONFIG_NAME_DARK_STOP_PM, "0")
		
		if(this.CONFIG_VAL_THEME = "auto") {
			darkStartHr := this.CONFIG_VAL_DARK_START_HR + (this.CONFIG_VAL_DARK_START_PM ? 12 : 0)
			darkStopHr := this.CONFIG_VAL_DARK_STOP_HR + (this.CONFIG_VAL_DARK_STOP_PM ? 12 : 0)
			
			darkStartTime := this.convertTimeToFullStr(darkStartHr, this.CONFIG_VAL_DARK_START_MIN)
			darkStopTime := this.convertTimeToFullStr(darkStopHr, this.CONFIG_VAL_DARK_STOP_MIN)
			
			if(darkStopTime < darkStartTime) {
				EnvAdd, darkStopTime, 1, Days
			}
			if(A_Now >= darkStartTime && A_Now < darkStopTime) {
				this.calculatedTheme := "dark"
				reloadTime := this.getNextOccurrenceOfTimeAsFullStr(darkStopHr, this.CONFIG_VAL_DARK_STOP_MIN)
				EnvSub, reloadTime, %A_Now%, Seconds
			} else {
				this.calculatedTheme := "light"
				reloadTime := this.getNextOccurrenceOfTimeAsFullStr(darkStartHr, this.CONFIG_VAL_DARK_START_MIN)
				EnvSub, reloadTime, %A_Now%, Seconds
			}
			triggerGuiRecolorFn := ObjBindMethod(this, "triggerGuiRecolor")
			SetTimer, % triggerGuiRecolorFn, % reloadTime * -1000
		} else {
			this.calculatedTheme := this.CONFIG_VAL_THEME
		}
	}
	
	writeThemeConfigs() {
		this.configManager.writeConfigToFile(this.CONFIG_NAME_THEME, this.CONFIG_VAL_THEME)
		this.configManager.writeConfigToFile(this.CONFIG_NAME_DARK_START_HR, this.CONFIG_VAL_DARK_START_HR)
		this.configManager.writeConfigToFile(this.CONFIG_NAME_DARK_START_MIN, this.CONFIG_VAL_DARK_START_MIN)
		this.configManager.writeConfigToFile(this.CONFIG_NAME_DARK_START_PM, this.CONFIG_VAL_DARK_START_PM)
		this.configManager.writeConfigToFile(this.CONFIG_NAME_DARK_STOP_HR, this.CONFIG_VAL_DARK_STOP_HR)
		this.configManager.writeConfigToFile(this.CONFIG_NAME_DARK_STOP_MIN, this.CONFIG_VAL_DARK_STOP_MIN)
		this.configManager.writeConfigToFile(this.CONFIG_NAME_DARK_STOP_PM, this.CONFIG_VAL_DARK_STOP_PM)
	}
	
	;parts were derived from https://autohotkey.com/board/topic/19960-got-problems-while-checking-the-system-time/://autohotkey.com/board/topic/19960-got-problems-while-checking-the-system-time/page-2?&
	;not under MIT license
	;takes in an hour (24-hour format) and a minute. Returns the next occurrence of that time today
	getNextOccurrenceOfTimeAsFullStr(hour, min) {
		next := this.convertTimeToFullStr(hour, min)
		if (next < A_Now) {
			EnvAdd, next, 1, Days
		}
		return next
	}
	
	;converts an hour (24-hour format) and a minute into a full string with YYYYMMDDHH24MISS format
	convertTimeToFullStr(hour, min) {
		hourStr := (StrLen(hour) = 1 ? "0" : "") hour ;pads single digit hour
		minStr := (StrLen(min) = 1 ? "0" : "") min
		hhmm := hourStr . minStr
		return % A_YYYY A_MM A_DD hhmm "00"
	}
	
	triggerGuiRecolor() {
		recolorOpts := {"light":"dark", "dark":"light"}
		this.configManager.clipManager.menuGui.recolorGui(recolorOpts[this.calculatedTheme])
		this.configManager.clipManager.menuGui.initReloadOnMenuQuit()
	}
}