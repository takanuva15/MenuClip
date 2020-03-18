#Include %A_ScriptDir%\src\controller\ConfigGuiGeneralOptions.ahk
#Include %A_ScriptDir%\src\controller\ConfigGuiThemeOptions.ahk

;Handles configuration file reading & writing
class ConfigManagerGui {
	static configManager
	static themeStyle
	static configGuiGeneralOptions, configGuiThemeOptions
	static CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD
	__New(configManager) {
		this.configManager := configManager
		this.themeStyle := this.configManager.getTheme()
		this.configGuiGeneralOptions := new MenuClip.Controller.ConfigGuiGeneralOptions(configManager)
		this.configGuiThemeOptions := new MenuClip.Controller.ConfigGuiThemeOptions(configManager)
		
		Gui +hWndEditConfig
		Gui EditConfig:-MinimizeBox -MaximizeBox
		Gui EditConfig:Margin, 10, 10
		
		if(this.themeStyle = "dark") {
			Gui EditConfig:Color, 2B2B2B, 43474A
			Gui EditConfig:Font, cCCCCCC
		}
		
		Gui EditConfig:Add, Tab3, , General|Theme
		Gui EditConfig:Tab, General
		this.configGuiGeneralOptions.addAllOptions()
		Gui EditConfig:Tab, Theme
		this.configGuiThemeOptions.addAllOptions()
		Gui EditConfig:Tab
		this.addSaveAndReloadButton()
	}
	
	addSaveAndReloadButton() {
		Gui EditConfig:Add, Button, x107 y+10 w110 h26 hWndSaveAndReload +Default, Save and Reload
		this.CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD := SaveAndReload
		saveConfigsAndReloadFn := ObjBindMethod(this, "saveConfigsAndReload")
		GuiControl +g, %SaveAndReload%, % saveConfigsAndReloadFn
		
		if(this.themeStyle = "dark") {
			NORMAL_STATE := [0, 0x43474A, , 0xCCCCCC, , , "White"]
			HOVER_STATE := [0, "Gray", , "White", , , "White"]
			ImageButton.create(SaveAndReload, NORMAL_STATE, HOVER_STATE)
		}
	}
	
	saveConfigsAndReload() {
		this.configGuiGeneralOptions.saveConfigs()
		this.configGuiThemeOptions.saveConfigs()
		Reload
	}
	
	showGui() {
		Gui EditConfig:Show, Autosize, Edit Configuration
	}
}