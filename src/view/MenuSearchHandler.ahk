;Handles changes to the menu
class MenuSearchHandler {
	static menuGui
	__New(menuGui) {
		this.menuGui := menuGui
	}
	
	handleSearch() {
		searchStr := this.menuGui.getControlValue(this.menuGui.HANDLE_SEARCH_BOX)
		this.filteredClips := this.menuGui.clipStore.getClipsFilteredBy(searchStr)
		GuiControl, , % this.menuGui.HANDLE_CLIPS_VIEW, |
		filteredClipsTextOnly := []
		Loop, % loopIndex := this.filteredClips.maxIndex()
			filteredClipsTextOnly.insertAt(1, this.filteredClips[loopIndex--].clip)
		this.menuGui.populateMenuFromArray(filteredClipsTextOnly)
		GuiControl, Choose, % this.menuGui.HANDLE_CLIPS_VIEW, 1
	}
	
	printClips() {
		s := ""
		for index, element in this.filteredClips {
			s := s . element.clip . ", "
		}
	}
}