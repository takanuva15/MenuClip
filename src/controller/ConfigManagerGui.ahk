;Handles configuration file reading & writing
class ConfigManagerGui {
	static configManager
	static themes
	static CONFIG_HANDLE_HOTKEY
	static CONFIG_HANDLE_MAX_CLIPS_TO_STORE
	static CONFIG_HANDLE_MAX_MENUITEM_LABEL_LENGTH
	static CONFIG_HANDLE_ALT_PASTE_APPS
	static CONFIG_HANDLE_THEME
	static CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD
	__New(configManager) {
		this.configManager := configManager
		this.themeStyle := this.configManager.getTheme()
		
		Gui +hWndEditConfig
		Gui EditConfig:-MinimizeBox -MaximizeBox
		Gui EditConfig:Margin, 10, 10
		
		Gui EditConfig:Font, % (FontOptions := "s8"), % (FontName := "Segoe UI Regular")
		OD_Colors.SetItemHeight(FontOptions, FontName)
		
		if(this.themeStyle = "dark") {
			Gui EditConfig:Color, 2B2B2B, 43474A
			Gui EditConfig:Font, cCCCCCC
		}
		
		this.addHotkeyOpt()
		this.addMaxClipsToStoreOpt()
		this.addMaxWidth()
		this.addAltPasteAppsOpt()
		this.addThemeOpt()
		this.addSaveAndReloadButton()
	}
	
	addHotkeyOpt() {
		Gui EditConfig:Add, Text, xm ym w170, Hotkey:
		Gui EditConfig:Add, Edit, x+5 yp-2 w100 h17 hWndShowMenuHotkey, % this.configManager.getShowMenuHotkey()
		this.CONFIG_HANDLE_HOTKEY := ShowMenuHotkey
	}
	
	addMaxClipsToStoreOpt() {
		Gui EditConfig:Add, Text, xm y+10 w170, Number of clips to store:
		Gui EditConfig:Add, Edit, x+5 yp-2 w32 h17 hWndMaxClipsToStore, % this.configManager.getMaxClipsToStore()
		this.CONFIG_HANDLE_MAX_CLIPS_TO_STORE := MaxClipsToStore
	}
	
	addMaxWidth() {
		Gui EditConfig:Add, Text, xm y+10 w170, Max width:
		Gui EditConfig:Add, Edit, x+5 yp-2 w32 h17 hWndMaxMenuItemLabelLength, % this.configManager.getMaxWidth()
		this.CONFIG_HANDLE_MAX_MENUITEM_LABEL_LENGTH := MaxMenuItemLabelLength
	}
	
	addAltPasteAppsOpt() {
		Gui EditConfig:Add, Text, xm y+10 w170, App exes that use Shift+Ins pasting: (comma-separated)
		Gui EditConfig:Add, Edit, x+5 yp-2 w100 r2 hWndAltPasteApps, % this.configManager.getAltPasteApps()
		this.CONFIG_HANDLE_ALT_PASTE_APPS := AltPasteApps
	}
	
	addThemeOpt() {
		this.themes := {"light":1, "dark":2}
		Gui EditConfig:Add, Text, xm y+10 w170, Theme:
		Gui EditConfig:Add, DDL, % "x+5 yp-2 w50 hWndMenuTheme +0x0210 Choose" this.themes[this.themeStyle], light|dark
		if(this.themeStyle = "dark") {
			OD_Colors.Attach(MenuTheme, {T: 0xCCCCCC, B: 0x43474A})
		} else {
			OD_Colors.Attach(MenuTheme, {})
		}
		this.CONFIG_HANDLE_THEME := MenuTheme
	}
	
	addSaveAndReloadButton() {
		Gui EditConfig:Add, Button, x93 y+20 w110 h28 hWndSaveAndReload +Default, &Save and Reload
		this.CONFIG_HANDLE_BUTTON_SAVE_AND_RELOAD := SaveAndReload
		saveConfigAndReloadFn := ObjBindMethod(this, "saveConfigAndReload")
		GuiControl +g, %SaveAndReload%, % saveConfigAndReloadFn
	}
	
	saveConfigAndReload() {
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_HOTKEY, this.getConfigOptionValue(this.CONFIG_HANDLE_HOTKEY))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_MAX_CLIPS_TO_STORE, this.getConfigOptionValue(this.CONFIG_HANDLE_MAX_CLIPS_TO_STORE))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_MAX_WIDTH, this.getConfigOptionValue(this.CONFIG_HANDLE_MAX_MENUITEM_LABEL_LENGTH))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_ALT_PASTE_APPS, this.getConfigOptionValue(this.CONFIG_HANDLE_ALT_PASTE_APPS))
		this.configManager.writeConfigToFile(this.configManager.CONFIG_NAME_THEME, this.getConfigOptionValue(this.CONFIG_HANDLE_THEME))
		Reload
	}
	
	getConfigOptionValue(hWnd) {
		GuiControlGet, tmp,, %hWnd%
		return tmp
	}
	
	showGui() {
		Gui EditConfig:Show, w295 h200, Edit Configuration
	}
}