;Handles changes to the menu
class MenuManager {
	static menuName := "clipMenu"
	static isMenuEmpty := true
	static MAX_MENUITEM_LABEL_LENGTH
	static MENU_THEME
	__New(configManager, onItemClickFn) {
		this.MAX_MENUITEM_LABEL_LENGTH := configManager.getMaxMenuitemLabelLength()
		this.MENU_THEME := configManager.getTheme()
		this.onItemClickFn := onItemClickFn
		this.callOnItemClickWithValueFn := ObjBindMethod(this, "callOnItemClickWithValue")
		
		Menu, % this.menuName, Add
		this.setTheme()
	}
	
	insertItemAtTop(menuItem) {
		;MsgBox % "called " . menuItem
		;this is called only once to prevent error if no clips	
		if(this.isMenuEmpty) {
			Menu, % this.menuName, DeleteAll
			this.isMenuEmpty := false 
		}
		
		callOnItemClickWithValueFn := this.callOnItemClickWithValueFn
		menuItemLabel := menuItem
		;not using a ternary below because it worsens readability
		if(StrLen(menuItemLabel) > this.MAX_MENUITEM_LABEL_LENGTH) {
			menuItemLabel := SubStr(menuItem, 1, this.MAX_MENUITEM_LABEL_LENGTH) . "..."
		}
		Menu, % this.menuName, Insert, 1&, %menuItemLabel%, % callOnItemClickWithValueFn
		;this.clipCache.insertAtTop(menuItem)
	}
	
	deleteItem(menuItemPos) {
		Menu, % this.menuName, Delete, %menuItemPos%&
		;this.clipCache.deleteAtIndex(menuItemPos)
	}
	
	moveLastSelectedItemToTop() {
		;lastSelectedItem := this.clipCache.getAtIndex(A_ThisMenuItemPos)
		lastSelectedItem := A_ThisMenuItem
		lastSelectedItemPos := A_ThisMenuItemPos
		this.deleteItem(lastSelectedItemPos)
		this.insertItemAtTop(lastSelectedItem)
	}
	
	showMenu() {
		Menu, % this.menuName, Show
	}
	
	;getMenuItemCount() {
		;return this.clipCache.getSize()
	;}
	
	callOnItemClickWithValue() {
		this.onItemClickFn.call(A_ThisMenuItemPos)
	}
	
	setTheme() {
		if(this.MENU_THEME = "dark") {
			Menu, % this.menuName, Color, bfbfbf
		} else {
			Menu, % this.menuName, Color, Default
		}
	}
}