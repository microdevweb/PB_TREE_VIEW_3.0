; **********************************************************************************************************************
; AUTHOR      : microdevWeb
; PACKAGE     : TREE.pbi
; VERSION     : 3.0
; DATE        : 2019-06-29
; LICENCE     : CC-BY-NC-SA
; **********************************************************************************************************************
DeclareModule TREE
  Interface Button
    ; GETTETRS
    getImage()
    getToolTip.s()
    isDisabled()
    getCallback()
    ; SETTERS
    setImage(image)
    setToolTip(text.s)
    setDisabled(state.b)
    setCallback(callback)    
  EndInterface
  Interface Item
    ; GETTERS
    getTitle.s()
    getImage()
    hasCheckBox.b()
    isExpanded.b()
    isSelectable()
    ; SETTERS
    setTitle(title.s)
    setImage(image)
    setCheckBox(state.b)
    setExpanded(state.b)
    setSelectable(state.b)
    ; PUBLIC METHODS
    addChild(item)
    free()
    freeChildren()
    setData(value.l)
    getData()
    setSelectedCallback(callback)
    addButton(button)
  EndInterface
  Interface Tree
    ; GETTERS
    getImageWidht()
    getImageHeight()
    getlineHeight()
    getButtonWidth()
    getButtonHeight()
    ; SETTERS
    setImageWidht(width)
    setImageHeight(height)
    setlineHeight(height)
    setButtonWidth(width)
    setButtonHeight(height)
    setColors(back,front,line)
    setSelectedColors(back,front)
    setTolltipColors(back,front)
    setExpandedIcons(expanded,collapsed)
    setCheckedIcons(checked,unChecked)
    ; PUBLIC METHODS
    addChild(item)
    build()
    free()
    freeChildren()
    setSelectedCallback(callback)
    removeItem(item)
  EndInterface
  
  Declare newTreeView(containerId)
  Declare newItem(title.s,image = 0)
  Declare newButton(image,*callback)
EndDeclareModule

Module TREE
  EnableExplicit
  UsePNGImageDecoder()
  Global gToolOn.b = #False
  
  
  XIncludeFile "CLASS/CLASSES.pbi"
  Declare TREE_build(*this._TREE)
  XIncludeFile "CLASS/BUTTON.pbi"
  XIncludeFile "CLASS/ITEM.pbi"
  XIncludeFile "CLASS/TREE.pbi"
  
  DataSection
    expanded:
    IncludeBinary "IMG/full.ico"
    collapsed:
    IncludeBinary "IMG/collap.ico"
    checked:
    IncludeBinary "IMG/checked.ico"
    unChecked:
    IncludeBinary "IMG/unCheck.ico"
  EndDataSection
EndModule
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 59
; FirstLine = 42
; Folding = -
; EnableXP