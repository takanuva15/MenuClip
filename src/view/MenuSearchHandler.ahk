;Handles changes to the search box
class MenuSearchHandler {
	static menuGui
	__New(menuGui) {
		this.menuGui := menuGui
	}
	
	handleSearch() {
		searchStr := GetControlValue(this.menuGui.HANDLE_SEARCH_BOX)
		this.filteredClips := this.menuGui.clipStore.getClipsFilteredBy(searchStr)
		GuiControl, , % this.menuGui.HANDLE_CLIPS_VIEW, |
		filteredClipsTextOnly := []
		Loop, % loopIndex := this.filteredClips.maxIndex()
			filteredClipsTextOnly.insertAt(1, this.filteredClips[loopIndex--].clip)
		this.menuGui.populateMenuFromArray(filteredClipsTextOnly)
		GuiControl, Choose, % this.menuGui.HANDLE_CLIPS_VIEW, 1
	}
}