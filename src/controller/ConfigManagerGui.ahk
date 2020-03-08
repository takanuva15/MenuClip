#Include %A_ScriptDir%\src\controller\ConfigGuiGeneralOptions.ahk

;Handles configuration file reading & writing
class ConfigManagerGui {
	static configManager
	static CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD
	__New(configManager) {
		this.configManager := configManager
		this.themeStyle := this.configManager.getTheme()
		this.configGuiGeneralOptions := new MenuClip.Controller.ConfigGuiGeneralOptions(configManager)
		
		Gui +hWndEditConfig
		Gui EditConfig:-MinimizeBox -MaximizeBox
		Gui EditConfig:Margin, 10, 10
		
		if(this.themeStyle = "dark") {
			Gui EditConfig:Color, 2B2B2B, 43474A
			Gui EditConfig:Font, cCCCCCC
		}
		
		
		Gui EditConfig:Add, Tab3, , General
		Gui EditConfig:Tab, General
		this.configGuiGeneralOptions.addAllOptions()
		Gui EditConfig:Tab
		this.addSaveAndReloadButton()
		this.showGui()
	}
	
	addSaveAndReloadButton() {
		Gui EditConfig:Add, Button, x107 y+10 w110 h28 hWndSaveAndReload +Default, &Save and Reload
		this.CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD := SaveAndReload
		saveConfigsAndReloadFn := ObjBindMethod(this, "saveConfigsAndReload")
		GuiControl +g, %SaveAndReload%, % saveConfigsAndReloadFn
	}
	
	saveConfigsAndReload() {
		this.configGuiGeneralOptions.saveConfigs()
		Reload
	}
	
	showGui() {
		Gui EditConfig:Show, Autosize, Edit Configuration
	}
}