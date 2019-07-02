; **********************************************************************************************************************
; AUTHOR      : microdevWeb
; CLASS       : TREE.pbi
; VERSION     : 3.0
; DATE        : 2019-06-29
; LICENCE     : CC-BY-NC-SA
; **********************************************************************************************************************
;-* PRIVATE METHODS
Declare _TREE_drawMask(*this._TREE)
Procedure _TREE_buildChildren(*this._TREE)
  With *this
    Protected y = 10
    StartVectorDrawing(ImageVectorOutput(\maskImage))
    VectorSourceColor($FFFFFFFF)
    FillVectorOutput()
    VectorSourceColor($FF000000)
    VectorFont(FontID(\font))
    ForEach \myChildren()
      y = \myChildren()\build(\myChildren(),*this,10,y)
    Next
    StopVectorDrawing()
    \maxHeight = y
  EndWith
EndProcedure

Procedure _TREE_EVENT()
  Protected *this._TREE = GetGadgetData(EventGadget())
  With *this
    If *this
      Protected y = GetGadgetAttribute(\canvas_id,#PB_Canvas_MouseY)
      Protected x = GetGadgetAttribute(\canvas_id,#PB_Canvas_MouseX)
      Protected y1,y2
      ; look which item is hovered
      ForEach \_children()
        y1 = Val(StringField(MapKey(\_children()),1,"_"))
        y2 = Val(StringField(MapKey(\_children()),2,"_"))
        If y>= y1 And y <= y2
          If \_children()\manageEvents(\_children(),*this,x,y)
            TREE_build(*this)
          EndIf
          Break
        EndIf
      Next
    EndIf
  EndWith
EndProcedure

Procedure _TREE_evContainer()
  Protected *this._TREE = GetGadgetData(EventGadget())
  With *this
    ResizeGadget(\scroll_id,#PB_Ignore,#PB_Ignore,GadgetWidth(\container_id),GadgetHeight(\container_id))
    ResizeGadget(\canvas_id,#PB_Ignore,#PB_Ignore,GadgetWidth(\container_id),GadgetHeight(\container_id))
    _TREE_drawMask(*this)
  EndWith
EndProcedure
;}
;-* PROTECTED METHODS
Procedure _TREE_unselectItems(*this._TREE)
  With *this
    ForEach \myChildren()
      \myChildren()\unselectItems(\myChildren())
    Next
  EndWith
EndProcedure

Procedure _TREE_drawMask(*this._TREE)
  With *this
    StartDrawing(CanvasOutput(\canvas_id))
    DrawImage(ImageID(\maskImage),0,0)
    StopDrawing()
    If \maxWidth > GadgetWidth(\scroll_id) - 10
      SetGadgetAttribute(\scroll_id,#PB_ScrollArea_InnerWidth,\maxWidth)
    Else
      SetGadgetAttribute(\scroll_id,#PB_ScrollArea_InnerWidth,GadgetWidth(\scroll_id) - 10)
    EndIf
    If \maxHeight > GadgetHeight(\scroll_id) - 10
      SetGadgetAttribute(\scroll_id,#PB_ScrollArea_InnerHeight,\maxHeight)
    Else
      SetGadgetAttribute(\scroll_id,#PB_ScrollArea_InnerHeight,GadgetHeight(\scroll_id) - 10)
    EndIf
  EndWith
EndProcedure
;}
;-* GETTERS
Procedure TREE_getImageWidht(*this._TREE)
  With *this
    ProcedureReturn \imageWidh
  EndWith
EndProcedure

Procedure TREE_getImageHeight(*this._TREE)
  With *this
    ProcedureReturn \imageHeight
  EndWith
EndProcedure

Procedure TREE_getlineHeight(*this._TREE)
  With *this
    ProcedureReturn \lineHeight
  EndWith
EndProcedure

Procedure TREE_getButtonWidth(*this._TREE)
  With *this
     ProcedureReturn \buttonWidth
  EndWith
EndProcedure

Procedure TREE_getButtonHeight(*this._TREE)
  With *this
     ProcedureReturn \buttonHeight 
  EndWith
EndProcedure
;}
;-* SETTERS
Procedure TREE_setImageWidht(*this._TREE,widht)
  With *this
     \imageWidh = widht
  EndWith
EndProcedure

Procedure TREE_setImageHeight(*this._TREE,height)
  With *this
     \imageHeight = height
  EndWith
EndProcedure

Procedure TREE_setlineHeight(*this._TREE,height)
  With *this
     \lineHeight = height
  EndWith
EndProcedure

Procedure TREE_setButtonWidth(*this._TREE,widht)
  With *this
     \buttonWidth = widht
  EndWith
EndProcedure

Procedure TREE_setButtonHeight(*this._TREE,height)
  With *this
     \buttonHeight = height
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS
Procedure TREE_addChild(*this._TREE,*item)
  With *this
    AddElement(\myChildren())
    \myChildren() = *item
    ProcedureReturn *item
  EndWith
EndProcedure

Procedure TREE_build(*this._TREE)
  With *this
    ; we create the scroll Area
    OpenGadgetList(\container_id)
    If Not \scroll_id
      \scroll_id = ScrollAreaGadget(#PB_Any,0,0,GadgetWidth(\container_id),GadgetHeight(\container_id),
                                    GadgetWidth(\container_id) - 10 ,GadgetHeight(\container_id) - 10,10)
      If Not \canvas_id
        \canvas_id = CanvasGadget(#PB_Any,0,0,GadgetWidth(\container_id),GadgetHeight(\container_id),#PB_Canvas_Keyboard)
        SetGadgetData(\canvas_id,*this)
        BindGadgetEvent(\canvas_id,@_TREE_EVENT())
      EndIf
      CloseGadgetList()
      SetGadgetData(\container_id,*this)
      BindGadgetEvent(\container_id,@_TREE_evContainer())
    EndIf
    ; we create the mask image
    If Not IsImage(\maskImage) Or \maskImage = 0
      \maskImage = CreateImage(#PB_Any,GadgetWidth(\container_id),GadgetHeight(\container_id))
    EndIf
    ClearMap(\_children())
    _TREE_buildChildren(*this)
    CloseGadgetList()
    _TREE_drawMask(*this)
  EndWith
EndProcedure

Procedure TREE_free(*this._TREE)
  With *this
    
  EndWith
EndProcedure

Procedure TREE_freeChildren(*this._TREE)
  With *this
    ForEach \myChildren()
      FreeStructure(\myChildren())
      DeleteElement(\myChildren())
    Next
  EndWith
EndProcedure

Procedure TREE_setSelectedCallback(*this._TREE,*callback)
  With *this
    \selectCallback = *callback
  EndWith
EndProcedure
;}

Procedure newTreeView(containerId)
  Protected *this._TREE = AllocateStructure(_TREE)
  With *this
    \methods = ?S_TREE
    \unselectItems = @_TREE_unselectItems()
    \container_id = containerId
    \children_tabulation = 4
    \font = LoadFont(#PB_Any,"Arial",10,#PB_Font_HighQuality)
    \imageWidh = 24
    \imageHeight = 24
    \lineHeight = 26
    \buttonWidth = 16
    \buttonHeight = 16
    \toolTipColors\back = $FF212121
    \toolTipColors\front = $FFFFFFFF
    \toolTipFont = LoadFont(#PB_Any,"Arial",10,#PB_Font_HighQuality)
    \drawMask = @_TREE_drawMask()
    ProcedureReturn *this
  EndWith
EndProcedure

DataSection
  S_TREE:
  ; GETTERS
  Data.i @TREE_getImageWidht()
  Data.i @TREE_getImageHeight()
  Data.i @TREE_getlineHeight()
  Data.i @TREE_getButtonWidth()
  Data.i @TREE_getButtonHeight()
  ; SETTERS
  Data.i @TREE_setImageWidht()
  Data.i @TREE_setImageHeight()
  Data.i @TREE_setlineHeight()
  Data.i @TREE_setButtonWidth()
  Data.i @TREE_setButtonHeight()
  ; PUBLIC METHODS
  Data.i @TREE_addChild()
  Data.i @TREE_build()
  Data.i @TREE_free()
  Data.i @TREE_freeChildren()
  Data.i @TREE_setSelectedCallback()
  E_TREE:
EndDataSection



; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 8
; Folding = D8B505
; EnableXP