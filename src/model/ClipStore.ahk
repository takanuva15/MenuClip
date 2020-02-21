﻿#Include %A_ScriptDir%\src\model\CacheDirManager.ahk

;Manages the stored clips. (Basically an array manager)
class ClipStore {
	static clips := []
	static cacheDirManager
	__New() {
		this.cacheDirManager := new MenuClip.Model.CacheDirManager()
		this.clips := this.cacheDirManager.restoreFromCache()
	}
	
	getClips() {
		return this.clips
	}
	
	getClipsFilteredBy(searchStr) {
		tmp := []
		for index, element in this.clips {
			if(InStr(element, searchStr)) {
				tmp.push({"origIndex": index, "clip": element})
			}
		}
		return tmp
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