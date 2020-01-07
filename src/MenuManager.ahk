;Handles changes to the menu
class MenuManager {
	static menuName := "clipMenu"
	static menuItemValues := [] ;Used to store the full values of the menu items shown in the menu (in case of long menu items)
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
		;this is called only once to prevent error if no clips	
		if(this.isMenuEmpty) {
			Menu, % this.menuName, DeleteAll
			this.isMenuEmpty := false 
		}
		
		;avoid recording consecutive identical copies
		if(menuItem = this.menuItemValues[1]) {
			return
		}
		
		callOnItemClickWithValueFn := this.callOnItemClickWithValueFn
		menuItemLabel := menuItem
		;not using a ternary below because it worsens readability
		if(StrLen(menuItemLabel) > this.MAX_MENUITEM_LABEL_LENGTH) {
			menuItemLabel := SubStr(menuItem, 1, this.MAX_MENUITEM_LABEL_LENGTH) . "..."
		}
		Menu, % this.menuName, Insert, 1&, %menuItemLabel%, % callOnItemClickWithValueFn
		this.menuItemValues.insertAt(1, menuItem)
	}
	
	deleteItem(menuItemPos) {
		Menu, % this.menuName, Delete, %menuItemPos%&
		this.menuItemValues.removeAt(menuItemPos)
	}
	
	moveLastSelectedItemToTop() {
		lastSelectedItem := this.menuItemValues[A_ThisMenuItemPos]
		lastSelectedItemPos := A_ThisMenuItemPos
		this.deleteItem(lastSelectedItemPos)
		this.insertItemAtTop(lastSelectedItem)
	}
	
	showMenu() {
		Menu, % this.menuName, Show
	}
	
	getMenuItemCount() {
		return this.menuItemValues.maxIndex()
	}
	
	callOnItemClickWithValue() {
		this.onItemClickFn.call(this.menuItemValues[A_ThisMenuItemPos])
	}
	
	setTheme() {
		if(this.MENU_THEME = "dark") {
			Menu, % this.menuName, Color, bfbfbf
		} else {
			Menu, % this.menuName, Color, Default
		}
	}
	
	printArray() {
		s := ""
		for index, element in this.menuItemValues {
			s := s . element . " ,"
		}
		MsgBox %s%
	}
}