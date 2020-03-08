;Handles configuration file reading & writing
class ConfigGuiThemeOptions {
	static configManager
	static themes, themeStyle
	static CONFIG_HANDLE_THEME
	static CONFIG_HANDLE_AUTO_THEME_GROUPBOX
	static MINUTE_OPTIONS
	static CONFIG_HANDLE_DARK_START_TEXT, CONFIG_HANDLE_DARK_START_HR, CONFIG_HANDLE_DARK_START_MIN, CONFIG_HANDLE_DARK_START_AM
	__New(configManager) {
		this.configManager := configManager
		this.themeStyle := this.configManager.getTheme()
		this.generateMinuteOptions()
	}
	
	addAllOptions() {
		this.addThemeOpt()
		this.addAutoThemeOpts()
	}
	
	addThemeOpt() {
		this.themes := {"light":1, "dark":2, "auto":3}
		Gui EditConfig:Add, Text, xs y+10 w170, Theme:
		Gui EditConfig:Add, DDL, % "x+5 yp-2 w50 hWndMenuTheme Choose" this.themes[this.themeStyle], light|dark|auto
		if(this.themeStyle = "dark") {
			CtlColors.Attach(MenuTheme, "43474A","CCCCCC")
		}
		this.CONFIG_HANDLE_THEME := MenuTheme
	}
	
	addAutoThemeOpts() {
		Gui EditConfig:Add, GroupBox, xs y+10 w280 hWndAutoThemeGroupBox Section, Automatic Theme Options
		this.CONFIG_HANDLE_AUTO_THEME_GROUPBOX := AutoThemeGroupBox
		Gui EditConfig:Add, Text, xs+10 yp+20 w140 hWndDarkStartText, Activate dark theme at:
		this.CONFIG_HANDLE_DARK_START_TEXT := DarkStartText
		Gui EditConfig:Add, DDL, % "x+0 yp-2 w35 hWndDarkStartHr", 1|2|3|4|5|6|7|8|9|10|11|12
		this.CONFIG_HANDLE_DARK_START_HR := DarkStartHr
		Gui EditConfig:Add, DDL, % "x+5 yp w35 hWndDarkStartMin", % this.MINUTE_OPTIONS
		this.CONFIG_HANDLE_DARK_START_MIN := DarkStartMin
		Gui EditConfig:Add, DDL, % "x+5 yp w40 hWndDarkStartAM", AM|PM
		this.CONFIG_HANDLE_DARK_START_AM := DarkStartAM
		
		;GuiControl, EditConfig:Disable, %HrsOne%
		;Gui EditConfig:Add, Text, xs+10 y+8 w140, Deactivate dark theme at:
		;Gui EditConfig:Add, DDL, % "x+0 yp-2 w35", 1|2|3|4|5|6|7|8|9|10|11|12
		;Gui EditConfig:Add, DDL, % "x+5 yp w35", 1|2|3|4|5|6|7|8|9|10|11|12
		;Gui EditConfig:Add, DDL, % "x+5 yp w40", AM|PM
	}
	
	generateMinuteOptions() {
		t := "00|01|02|03|04|05|06|07|08|09"
		Loop, % loopIndex := 50
			t := t . "|" . (60 - loopIndex--)
		this.MINUTE_OPTIONS := t
	}
	
	saveConfigs() {
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_THEME, GetControlValue(this.CONFIG_HANDLE_THEME))
	}
}