#Include %A_ScriptDir%\src\model\CacheDirManager.ahk

;Manages the stored clips. (Basically an array manager)
class ClipStore {
	static clips := []
	static cacheDirManager
	static filterString := ""
	static filteredClips := []
	__New() {
		this.cacheDirManager := new MenuClip.Model.CacheDirManager()
		this.clips := this.cacheDirManager.restoreFromCache()
		this.applyFilter(this.filterString)
	}
	
	applyFilter(searchStr) {
		this.filterString := searchStr
		this.filteredClips := []
		for index, element in this.clips {
			if(InStr(element, searchStr)) {
				this.filteredClips.push({"origIndex": index, "clip": element})
			}
		}
	}
	
	getFilteredClips() {
		filteredClipsTextOnly := []
		for index, element in this.filteredClips {
			filteredClipsTextOnly.push(this.filteredClips[index].clip)
		}
		return filteredClipsTextOnly
	}
	
	getClips() {
		return this.clips
	}
	
	getAtIndex(index) {
		return this.clips[index]
	}
	
	insertAtTop(clip) {
		this.clips.insertAt(1, clip)
		this.cacheDirManager.insertAtTopOfCache(clip)
	}
	
	moveToTop(index) {
		tmp := this.clips[index]
		Loop, % loopIndex := index - 1
			this.clips[loopIndex + 1] := this.clips[loopIndex--]
		this.clips[1] := tmp
		
		this.cacheDirManager.moveToTopOfCache(index)
	}
	
	deleteAtIndex(index) {
		this.clips.removeAt(index)
		this.cacheDirManager.deleteFromCache(index)
	}
	
	getSize() {
		;avoids returning blank if clips empty
		return this.clips.maxIndex() ? this.clips.maxIndex() : 0
	}
	
	printClips() {
		s := ""
		for index, element in this.clips {
			s := s . element . ", "
		}
		
		t := ""
		for index, element in this.cachedClipFileNames {
			t := t . element . ", "
		}
		MsgBox % s . "`n`n" . t
	}
}