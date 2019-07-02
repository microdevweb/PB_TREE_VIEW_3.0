; **********************************************************************************************************************
; AUTHOR      : microdevWeb
; CLASS       : CLASSES.pbi
; VERSION     : 3.0
; DATE        : 2019-06-29
; LICENCE     : CC-BY-NC-SA
; **********************************************************************************************************************
Prototype _p_build_item(*this,*tree,x,y,*parent = 0)
Prototype _p_mamage_event(*this,*tree,mx,my)
Prototype _p_unselect(*this)
Prototype _p_selectCallback(*this)
Prototype _p_build_button(*this,*item,*tree,x,y)
Prototype _p_drawMask(*this)
Structure _POS
  x.l
  y.l
  w.l
  h.l
EndStructure
Structure _COLORS
  back.l
  front.l
EndStructure
Structure _BUTTON
  *methods
  image.l
  toolTip.s
  _buttonBox._POS
  *callBack._p_unselect
  disabled.b
  build._p_build_button
  namageEvent._p_mamage_event
  *item
EndStructure
Structure _ITEM
  *methods
  title.s
  image.l
  checkBox.b
  checked.b
  expanded.b
  List *myChildren._ITEM()
  build._p_build_item
  manageEvents._p_mamage_event
  unselectItems._p_unselect
  myData.l
  selectable.b
  selected.b
  _checkBoxPos._POS
  _epandBoxPos._POS
  _imageBoxPos._POS
  _titleBoxPos._POS
  selectCallback._p_selectCallback
  List *myButtons._BUTTON()
EndStructure
Structure _TREE
  *methods
  unselectItems._p_unselect
  container_id.l ; the container that receive the tree view
  scroll_id.l    ; the scroll area is create by the class
  canvas_id.l
  List *myChildren._ITEM()
  Map *_children._ITEM()
  children_tabulation.l
  font.l
  currentY.l
  currentX.l
  maxWidth.l
  maxHeight.l
  imageWidh.l
  imageHeight.l
  lineHeight.l
  selectCallback._p_selectCallback
  buttonWidth.l
  buttonHeight.l
  toolTipColors._COLORS
  toolTipFont.l
  maskImage.l
  drawMask._p_drawMask
EndStructure
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 78
; FirstLine = 45
; Folding = -
; EnableXP