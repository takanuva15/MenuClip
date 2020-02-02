;;License note by takanuva15: This code is authored by "Just Me" (https://autohotkey.com/board/topic/89793-set-height-of-listbox-rows/#entry568445) and is NOT under the MIT license provided in the root directory of this repository. Please see the code comments for information on its license.

LB_AdjustItemHeight(HListBox, Adjust) {
   Return LB_SetItemHeight(HListBox, LB_GetItemHeight(HListBox) + Adjust)
}

LB_GetItemHeight(HListBox) {
   Static LB_GETITEMHEIGHT := 0x01A1
   SendMessage, %LB_GETITEMHEIGHT%, 0, 0, , ahk_id %HListBox%
   Return ErrorLevel
}

LB_SetItemHeight(HListBox, NewHeight) {
   Static LB_SETITEMHEIGHT := 0x01A0
   SendMessage, %LB_SETITEMHEIGHT%, 0, %NewHeight%, , ahk_id %HListBox%
   WinSet, Redraw, , ahk_id %HListBox%
   Return ErrorLevel
}