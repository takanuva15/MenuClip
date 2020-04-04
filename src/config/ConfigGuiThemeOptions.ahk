;Handles configuration file reading & writing
class ConfigGuiThemeOptions {
	static configManager
	static themes, themeStyle
	static CONFIG_HANDLE_THEME
	static CONFIG_HANDLE_AUTO_THEME_GROUPBOX
	static HR_OPTIONS := "01|02|03|04|05|06|07|08|09|10|11|12"
	static MINUTE_OPTIONS
	static CONFIG_HANDLE_DARK_START_TEXT, CONFIG_HANDLE_DARK_START_HR, CONFIG_HANDLE_DARK_START_MIN, CONFIG_HANDLE_DARK_START_PM
	static CONFIG_HANDLE_DARK_STOP_TEXT, CONFIG_HANDLE_DARK_STOP_HR, CONFIG_HANDLE_DARK_STOP_MIN, CONFIG_HANDLE_DARK_STOP_PM
	__New(configManager) {
		this.configManager := configManager
		this.configThemeManager := configManager.configThemeManager
		this.themeStyle := this.configThemeManager.CONFIG_VAL_THEME
		this.generateMinuteOptions()
	}
	
	addAllThemeOptions() {
		this.addThemeOpt()
		this.addAutoThemeOpts()
		this.disableAutoThemeConfigBySelectedTheme()
	}
	
	addThemeOpt() {
		this.themes := {"light":1, "dark":2, "auto":3}
		Gui EditConfig:Add, Text, xs y+10 w170, Theme:
		Gui EditConfig:Add, DDL, % "x+5 yp-2 w50 hWndMenuTheme Choose" this.themes[this.themeStyle], light|dark|auto
		if(this.configManager.getTheme() = "dark") {
			CtlColors.Attach(MenuTheme, "43474A","CCCCCC")
		}
		this.CONFIG_HANDLE_THEME := MenuTheme
		disableAutoThemeConfigBySelectedThemeFn := ObjBindMethod(this, "disableAutoThemeConfigBySelectedTheme")
		GuiControl +g, %MenuTheme%, % disableAutoThemeConfigBySelectedThemeFn
	}
	
	addAutoThemeOpts() {
		Gui EditConfig:Add, GroupBox, xs y+10 w280 hWndAutoThemeGroupBox Section, Automatic Theme Options
		this.CONFIG_HANDLE_AUTO_THEME_GROUPBOX := AutoThemeGroupBox
		Gui EditConfig:Add, Text, xs+10 yp+20 w140 hWndDarkStartText, Activate dark theme at:
		this.CONFIG_HANDLE_DARK_START_TEXT := DarkStartText
		
		Gui EditConfig:Add, DDL, % "x+0 yp-2 w35 hWndDarkStartHr Choose" this.configThemeManager.CONFIG_VAL_DARK_START_HR + 0, % this.HR_OPTIONS
		this.CONFIG_HANDLE_DARK_START_HR := DarkStartHr
		
		Gui EditConfig:Add, DDL, % "x+5 yp w35 hWndDarkStartMin Choose" this.configThemeManager.CONFIG_VAL_DARK_START_MIN + 1, % this.MINUTE_OPTIONS
		this.CONFIG_HANDLE_DARK_START_MIN := DarkStartMin
		
		Gui EditConfig:Add, DDL, % "x+5 yp w40 hWndDarkStartPM Choose" this.configThemeManager.CONFIG_VAL_DARK_START_PM + 1, AM|PM
		this.CONFIG_HANDLE_DARK_START_PM := DarkStartPM
		
		
		Gui EditConfig:Add, Text, xs+10 y+8 w140 hWndDarkStopText, Deactivate dark theme at:
		this.CONFIG_HANDLE_DARK_STOP_TEXT := DarkStopText
		
		Gui EditConfig:Add, DDL, % "x+0 yp-2 w35 hWndDarkStopHr Choose" this.configThemeManager.CONFIG_VAL_DARK_STOP_HR + 0, % this.HR_OPTIONS
		this.CONFIG_HANDLE_DARK_STOP_HR := DarkStopHr
		
		Gui EditConfig:Add, DDL, % "x+5 yp w35 hWndDarkStopMin Choose" this.configThemeManager.CONFIG_VAL_DARK_STOP_MIN + 1, % this.MINUTE_OPTIONS
		this.CONFIG_HANDLE_DARK_STOP_MIN := DarkStopMin
		
		Gui EditConfig:Add, DDL, % "x+5 yp w40 hWndDarkStopPM Choose" this.configThemeManager.CONFIG_VAL_DARK_STOP_PM + 1, AM|PM
		this.CONFIG_HANDLE_DARK_STOP_PM := DarkStopPM
		
		if(this.configManager.getTheme() = "dark") {
			CtlColors.Attach(DarkStartHr, "43474A","CCCCCC")
			CtlColors.Attach(DarkStartMin, "43474A","CCCCCC")
			CtlColors.Attach(DarkStartPM, "43474A","CCCCCC")
			CtlColors.Attach(DarkStopHr, "43474A","CCCCCC")
			CtlColors.Attach(DarkStopMin, "43474A","CCCCCC")
			CtlColors.Attach(DarkStopPM, "43474A","CCCCCC")
		}
	}
	
	disableAutoThemeConfigBySelectedTheme() {
		selectedTheme := GetControlValue(this.CONFIG_HANDLE_THEME)
		if(selectedTheme != "auto") {
			GuiControl, EditConfig:Disable, % this.CONFIG_HANDLE_AUTO_THEME_GROUPBOX
			GuiControl, EditConfig:Disable, % this.CONFIG_HANDLE_DARK_START_TEXT
			GuiControl, EditConfig:Disable, % this.CONFIG_HANDLE_DARK_START_HR
			GuiControl, EditConfig:Disable, % this.CONFIG_HANDLE_DARK_START_MIN
			GuiControl, EditConfig:Disable, % this.CONFIG_HANDLE_DARK_START_PM
			GuiControl, EditConfig:Disable, % this.CONFIG_HANDLE_DARK_STOP_TEXT
			GuiControl, EditConfig:Disable, % this.CONFIG_HANDLE_DARK_STOP_HR
			GuiControl, EditConfig:Disable, % this.CONFIG_HANDLE_DARK_STOP_MIN
			GuiControl, EditConfig:Disable, % this.CONFIG_HANDLE_DARK_STOP_PM
		} else {
			GuiControl, EditConfig:Enable, % this.CONFIG_HANDLE_AUTO_THEME_GROUPBOX
			GuiControl, EditConfig:Enable, % this.CONFIG_HANDLE_DARK_START_TEXT
			GuiControl, EditConfig:Enable, % this.CONFIG_HANDLE_DARK_START_HR
			GuiControl, EditConfig:Enable, % this.CONFIG_HANDLE_DARK_START_MIN
			GuiControl, EditConfig:Enable, % this.CONFIG_HANDLE_DARK_START_PM
			GuiControl, EditConfig:Enable, % this.CONFIG_HANDLE_DARK_STOP_TEXT
			GuiControl, EditConfig:Enable, % this.CONFIG_HANDLE_DARK_STOP_HR
			GuiControl, EditConfig:Enable, % this.CONFIG_HANDLE_DARK_STOP_MIN
			GuiControl, EditConfig:Enable, % this.CONFIG_HANDLE_DARK_STOP_PM
		}
	}
	
	generateMinuteOptions() {
		t := "00|01|02|03|04|05|06|07|08|09"
		Loop, % loopIndex := 50
			t := t . "|" . (60 - loopIndex--)
		this.MINUTE_OPTIONS := t
	}
	
	saveConfigs() {
		this.configManager.writeConfigToFile(this.configThemeManager.CONFIG_NAME_THEME, GetControlValue(this.CONFIG_HANDLE_THEME))
		this.configManager.writeConfigToFile(this.configThemeManager.CONFIG_NAME_DARK_START_HR, GetControlValue(this.CONFIG_HANDLE_DARK_START_HR))
		this.configManager.writeConfigToFile(this.configThemeManager.CONFIG_NAME_DARK_START_MIN, GetControlValue(this.CONFIG_HANDLE_DARK_START_MIN))
		this.configManager.writeConfigToFile(this.configThemeManager.CONFIG_NAME_DARK_START_PM, this.convertPMValToBinary(GetControlValue(this.CONFIG_HANDLE_DARK_START_PM)))
		this.configManager.writeConfigToFile(this.configThemeManager.CONFIG_NAME_DARK_STOP_HR, GetControlValue(this.CONFIG_HANDLE_DARK_STOP_HR))
		this.configManager.writeConfigToFile(this.configThemeManager.CONFIG_NAME_DARK_STOP_MIN, GetControlValue(this.CONFIG_HANDLE_DARK_STOP_MIN))
		this.configManager.writeConfigToFile(this.configThemeManager.CONFIG_NAME_DARK_STOP_PM, this.convertPMValToBinary(GetControlValue(this.CONFIG_HANDLE_DARK_STOP_PM)))
	}
	
	convertPMValToBinary(pmVal) {
		return pmVal = "PM"
	}
}