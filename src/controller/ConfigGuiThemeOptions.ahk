;Handles configuration file reading & writing
class ConfigGuiThemeOptions {
	static configManager
	static themes, themeStyle
	static CONFIG_HANDLE_THEME
	__New(configManager) {
		this.configManager := configManager
		this.themeStyle := this.configManager.getTheme()
	}
	
	addAllOptions() {
		this.addThemeOpt()
	}
	
	addThemeOpt() {
		this.themes := {"light":1, "dark":2}
		Gui EditConfig:Add, Text, xs y+10 w170, Theme:
		Gui EditConfig:Add, DDL, % "x+5 yp-2 w50 hWndMenuTheme Choose" this.themes[this.themeStyle], light|dark
		if(this.themeStyle = "dark") {
			CtlColors.Attach(MenuTheme, "43474A","CCCCCC")
		}
		this.CONFIG_HANDLE_THEME := MenuTheme
	}
	
	saveConfigs() {
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_THEME, GetControlValue(this.CONFIG_HANDLE_THEME))
	}
}