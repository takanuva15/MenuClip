;Manages the cache directory which holds file backups for what's on the clip menu
class CacheDirManager {
	static configManager
	static cacheDir := "cache\"
	static cachedClipFileNames := []
	__New(configManager) {
		this.configManager := configManager
		if(!InStr(FileExist(this.cacheDir), "D")) {
			FileCreateDir, % this.cacheDir
		}
		this.verifyCache()
	}
	
	;returns array of what was restored from cache
	restoreFromCache() {
		Loop, Files, % this.cacheDir . "*.txt"
			this.cachedClipFileNames.push(A_LoopFileName)
		
		tmp := []
		Loop, % index := this.cachedClipFileNames.maxIndex()
		{
			FileRead, clip, % this.cacheDir . this.cachedClipFileNames[index--]
			tmp.insertAt(1, clip)
		}
		return tmp
	}
	
	insertAtTopOfCache(clip) {
		Loop, % index := this.cachedClipFileNames.length()
		{
			fileName := this.cachedClipFileNames[index]
			RegExMatch(fileName, "^(?P<Num>\d+)\.", file)
			FileMove, % this.cacheDir . fileName, % this.cacheDir . fileNum + 1 . ".txt"
			this.cachedClipFileNames[fileNum + 1] := fileNum + 1 . ".txt"
			index--
		}
		this.cachedClipFileNames.removeAt(1)		
		FileAppend, %clip%, % this.cacheDir . "1.txt"
		this.cachedClipFileNames.insertAt(1, "1.txt")
	}
	
	moveToTopOfCache(index) {
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
	
	deleteFromCache(index) {
		;Works as of now because we only ever delete the last element in ClipManager. However, should be a loop available to rename files below this in the cache if we theoretically deleted from the middle of the menu.
		FileDelete, % this.cacheDir this.cachedClipFileNames[index]
		this.cachedClipFileNames.removeAt(index)
	}
	
	clearCache() {
		FileRemoveDir, % this.cacheDir, 1
		FileCreateDir, % this.cacheDir
	}
	
	verifyCache() {
		fileList := []
		Loop, Files, % this.cacheDir . "*"
			fileList.push(A_LoopFileName)
		fileList := this.sortArray(fileList, "N")
		numFiles := fileList.maxIndex()
		maxFileCount := this.configManager.getMaxClipsToStore()
		
		;Delete excess clips above maximum allowed
		Loop, % numFiles - maxFileCount
			FileDelete, % this.cacheDir . fileList[A_Index + maxFileCount]
		
		;Temp name remaining clips prior to rename
		Loop, % numFiles > maxFileCount ? maxFileCount : numFiles
			FileMove, % this.cacheDir . fileList[A_Index], % this.cacheDir . fileList[A_Index] . ".bak"
		
		;Rename remaining clips
		Loop, % index := numFiles > maxFileCount ? maxFileCount : numFiles
		{
			;Msgbox % "Comparing " fileList[index] " with " index . ".txt"
			FileMove, % this.cacheDir . fileList[index] . ".bak", % this.cacheDir . index . ".txt"
			index--
		}
		
	}
	
	;https://autohotkey.com/board/topic/93570-sortarray/ 
	;Not under MIT license
	sortArray(arr,options="") {		
		if	!IsObject(arr)
			return	0
		new :=	[]
		if	(options="Flip") {
			While	(i :=	arr.MaxIndex()-A_Index+1)
				new.Insert(arr[i])
			return	new
		}
		list := ""
		For each, item in arr
			list .=	item "`n"
		list :=	Trim(list,"`n")
		Sort, list, %options%
		Loop, parse, list, `n, `r
			new.Insert(A_LoopField)
		return	new
	}
}