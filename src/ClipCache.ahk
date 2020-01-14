;Manages the stored clips. (Basically an array manager)
class ClipCache {
	static cacheDir := "cache\"
	static clips := []
	static cachedClipFileNames := []
	__New(callbackOnReadFn) {
		if(!InStr(FileExist(this.cacheDir), "D")) {
			FileCreateDir, cache
		}
		this.restoreFromCache(callbackOnReadFn)
	}
	
	restoreFromCache(callbackOnReadFn) {
		;tmp := ClipboardAll
		Loop, Files, % this.cacheDir . "*.txt"
		{
			;FileRead, clip, A_LoopFileName
			this.cachedClipFileNames.push(A_LoopFileName)
		}
		
		Loop, % index := this.cachedClipFileNames.maxIndex()
		{
			FileRead, clip, % this.cacheDir . this.cachedClipFileNames[index--]
			this.clips.insertAt(1, clip)
			;MsgBox % "reading " . this.cachedClipFileNames[index] 
			callbackOnReadFn.call(clip)
		}
		;Clipboard := tmp
		
	}
	
	getAtIndex(index) {
		return this.clips[index]
	}
	
	insertAtTop(clip) {
		this.clips.insertAt(1, clip)
		
		Loop, % index := this.cachedClipFileNames.length()
		{
			fileName := this.cachedClipFileNames[index]
			RegExMatch(fileName, "^(?P<Num>\d+)\.", file)
			FileMove, % this.cacheDir . fileName, % this.cacheDir . fileNum + 1 . ".txt"
			this.cachedClipFileNames[fileNum + 1] := fileNum + 1 . ".txt"
			index--
		}
		
		this.cachedClipFileNames.removeAt(1)		
		
		;fileNum := this.cachedClipFileNames.maxIndex() ? this.cachedClipFileNames.maxIndex() + 1 : 1
		;fileName := % fileNum . ".txt.clip"
		;if(!FileExist(this.cacheDir fileName))
			;this.cachedClipFileNames.push(fileName)
		FileAppend, %clip%, % this.cacheDir . "1.txt"
		this.cachedClipFileNames.insertAt(1, "1.txt")
	}
	
	moveToTop(index) {
		tmp := this.clips[index]
		Loop, % loopIndex := index - 1
		{
			this.clips[loopIndex + 1] := this.clips[loopIndex--]
		}
		this.clips[1] := tmp
		
		tmp := this.cachedClipFileNames[index]
		FileMove, % this.cacheDir . tmp, % this.cacheDir . tmp . ".tmp"
		Loop, % loopIndex := index - 1
		{
			fileName := this.cachedClipFileNames[loopIndex--]
			RegExMatch(fileName, "^(?P<Num>\d+)\.", file)
			FileMove, % this.cacheDir . fileName, % this.cacheDir . fileNum + 1 . ".txt"
			this.cachedClipFileNames[fileNum + 1] := fileNum + 1 . ".txt"
		}
		FileMove, % this.cacheDir . tmp . ".tmp", % this.cacheDir . "1.txt"
	}
	
	deleteAtIndex(index) {
		this.clips.removeAt(index)
		
		;Works as of now because we only ever delete the last element. However, should be a loop available to rename files below this in the cache if we theoretically deleted from the middle of the menu.
		FileDelete, % this.cacheDir this.cachedClipFileNames[index]
	}
	
	getSize() {
		return this.clips.maxIndex() ? this.clips.maxIndex() : 0
	}
	
	printClips() {
		s := ""
		for index, element in this.clips {
			s := s . element . ", "
		}
		MsgBox %s%
		
		s := ""
		for index, element in this.cachedClipFileNames {
			s := s . element . ", "
		}
		MsgBox %s%
	}
}