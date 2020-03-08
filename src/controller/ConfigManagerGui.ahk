#Include %A_ScriptDir%\src\controller\ConfigGuiGeneralOptions.ahk

;Handles configuration file reading & writing
class ConfigManagerGui {
	static configManager
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
		this.configGuiGeneralOptions.addAllOptions()
		this.showGui()
	}
	
	showGui() {
		Gui EditConfig:Show, Autosize, Edit Configuration
	}
}