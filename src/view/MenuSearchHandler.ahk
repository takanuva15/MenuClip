;Handles changes to the search box
class MenuSearchHandler {
	static menuGui
	__New(menuGui) {
		this.menuGui := menuGui
	}
	
	handleSearch() {
		searchStr := GetControlValue(this.menuGui.HANDLE_SEARCH_BOX)
		this.menuGui.clipStore.applyFilter(searchStr)
		GuiControl, , % this.menuGui.HANDLE_CLIPS_VIEW, |
		this.menuGui.menuClipsViewHandler.populateMenuFromArray(this.menuGui.clipStore.getFilteredClipsForDisplay())
		GuiControl, Choose, % this.menuGui.HANDLE_CLIPS_VIEW, 1
	}
}