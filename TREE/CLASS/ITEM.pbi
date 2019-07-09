; **********************************************************************************************************************
; AUTHOR      : microdevWeb
; CLASS       : ITEM.pbi
; VERSION     : 3.0
; DATE        : 2019-06-29
; LICENCE     : CC-BY-NC-SA
; **********************************************************************************************************************

;-* PRIVATE METHODS
Procedure _ITEM_hoverExpand(*this._ITEM,mx,my)
  ; look if the mouse is hover the epanded box
  With *this
    If \_epandBoxPos\w 
      If mx >= \_epandBoxPos\x And mx <=\_epandBoxPos\x + \_epandBoxPos\w
        If my >= \_epandBoxPos\y And my <=\_epandBoxPos\y + \_epandBoxPos\h
          ProcedureReturn #True
        EndIf
      EndIf
    EndIf
    ProcedureReturn #False
  EndWith
EndProcedure

Procedure _ITEM_hoverCheckedBox(*this._ITEM,mx,my)
  ; look if the mouse is hover the epanded box
  With *this
    If \_checkBoxPos\w 
      If mx >= \_checkBoxPos\x And mx <=\_checkBoxPos\x + \_checkBoxPos\w
        If my >= \_checkBoxPos\y And my <=\_checkBoxPos\y + \_checkBoxPos\h
          ProcedureReturn #True
        EndIf
      EndIf
    EndIf
    ProcedureReturn #False
  EndWith
EndProcedure

Procedure _ITEM_hoverImageBox(*this._ITEM,mx,my)
  ; look if the mouse is hover the epanded box
  With *this
    If \_imageBoxPos\w 
      If mx >= \_imageBoxPos\x And mx <=\_imageBoxPos\x + \_imageBoxPos\w
        If my >= \_imageBoxPos\y And my <=\_imageBoxPos\y + \_imageBoxPos\h
          ProcedureReturn #True
        EndIf
      EndIf
    EndIf
    ProcedureReturn #False
  EndWith
EndProcedure

Procedure _ITEM_hoverTitleBox(*this._ITEM,mx,my)
  ; look if the mouse is hover the epanded box
  With *this
    If \_titleBoxPos\w 
      If mx >= \_titleBoxPos\x And mx <=\_titleBoxPos\x + \_titleBoxPos\w
        If my >= \_titleBoxPos\y And my <=\_titleBoxPos\y + \_titleBoxPos\h
          ProcedureReturn #True
        EndIf
      EndIf
    EndIf
    ProcedureReturn #False
  EndWith
EndProcedure
;}

;-* PROTECTED METHODS
Procedure _ITEM_build(*this._ITEM,*tree._TREE,x,y,noLine.b = #False)
  With *this
    Protected xx = x,yy = y,yc = Y + *tree\lineHeight / 2
    \_checkBoxPos\w = 0
    \_epandBoxPos\w = 0
    \_imageBoxPos\w = 0
    \_titleBoxPos\w = 0
    ; if the item has some children
    ; we draw the expanded icon
    If ListSize(\myChildren())
      MovePathCursor(xx,yc - 8)
      If  \expanded
        DrawVectorImage(ImageID(*tree\expandIconExpanded),255,16,16)
      Else
        DrawVectorImage(ImageID(*tree\expangIconCollapsed),255,16,16)
      EndIf
      ; we memorise the position for events management
      \_epandBoxPos\x = xx
      \_epandBoxPos\y = yc - 8
      \_epandBoxPos\w = 16
      \_epandBoxPos\h = 16
      ; x position for next element
      xx + 18
    EndIf
    ; we draw the checkbox
    If \checkBox
      MovePathCursor(xx,yc - 8)
      If \checked
        DrawVectorImage(ImageID(*tree\checked),255,16,16)
      Else
        DrawVectorImage(ImageID(*tree\unChecked),255,16,16)
      EndIf
      ; we memorise the position for events management
      \_checkBoxPos\x = xx
      \_checkBoxPos\y = yc - 8
      \_checkBoxPos\w = 16
      \_checkBoxPos\h = 16
      ; x position for next element
      xx + 18
    EndIf
    ; we draw the image if not null
    If \image
      MovePathCursor(xx,yc - (*tree\imageHeight / 2))
      DrawVectorImage(ImageID(\image),255,*tree\imageWidh,*tree\imageHeight)
      ; we memorise the position for events management
      \_imageBoxPos\x = xx
      \_imageBoxPos\y = yc - (*tree\imageHeight / 2)
      \_imageBoxPos\w = *tree\imageWidh
      \_imageBoxPos\h = *tree\imageHeight
      ; x position for next element
      xx + *tree\imageWidh + 5
    EndIf
    ; we draw the title
    Protected ht = VectorTextHeight("W")
    If \selectable And \selected
      VectorSourceColor(*tree\selectedColors\back)
      AddPathBox(xx,yc - (ht / 2),VectorTextWidth(\title),ht)
      FillPath()
      VectorSourceColor(*tree\selectedColors\front)
    Else
      VectorSourceColor(*tree\myColor\front)
    EndIf
    MovePathCursor(xx,yc - (ht / 2))
    DrawVectorText(*this\title)
    ; we memorise the position for events management
    \_titleBoxPos\x = xx
    \_titleBoxPos\y = yc - (ht / 2)
    \_titleBoxPos\w = VectorTextWidth(\title)
    \_titleBoxPos\h = ht
    ; we set the max width of tree
    If *tree\maxWidth < \_titleBoxPos\x + \_titleBoxPos\w
      *tree\maxWidth = \_titleBoxPos\x + \_titleBoxPos\w
    EndIf
    ; x position for next element
    xx + VectorTextWidth(\title)
    ; we memorize the y position into the map for will find to easy the item
    AddMapElement(*tree\_children(),Str(yy)+"_"+Str(yy + *tree\lineHeight))
    *tree\_children() = *this
    ; draw the buttons
    Protected xbt = xx + 4
    ForEach \myButtons()
      \myButtons()\build(\myButtons(),*this,*tree,xbt,yy)
      xbt + *tree\buttonWidth + 4
    Next
    ; draw vertical line
    Protected ly = yy + (*tree\lineHeight / 2),lx1 = (x - *tree\children_tabulation) + 8,lx2 = x 
    If Not noLine
      MovePathCursor(lx1,ly)
      AddPathLine(lx2,ly)
      VectorSourceColor(*tree\lineColor)
      DotPath(0.5,2)
    EndIf
    ; jump next row
    yy + *tree\lineHeight
    ; we throw look into the children list only if expanded
    Protected lxv = x + 8,lyv1 = yy,lyv2,lineOn.b = #False
    If \expanded
      ForEach \myChildren()
        lineOn = #True
        yy = \myChildren()\build(\myChildren(),*tree,x + *tree\children_tabulation,yy,#False)
        lyv2 = yy 
      Next
    EndIf
    ; draw vertical line
    If lineOn And Not noLine
      lyv2 - (*tree\lineHeight / 2)
      MovePathCursor(lxv,lyv1)
      AddPathLine(lxv,lyv2)
      VectorSourceColor(*tree\lineColor)
      DotPath(0.5,2)
    EndIf
    ProcedureReturn yy
  EndWith
EndProcedure

Procedure _ITEM_event(*this._ITEM,*tree._TREE,mx,my)
  With *this
    Protected hoverButton.b = #False
    Static clickOn.b,oldX
    Select EventType()
      Case #PB_EventType_MouseMove
        SetGadgetAttribute(*tree\canvas_id,#PB_Canvas_Cursor,#PB_Cursor_Default)
        If clickOn
          If \dropTarget <> -1
            DragText(Str(*this),#PB_Drag_Copy)
          EndIf
        EndIf
        If _ITEM_hoverExpand(*this,mx,my)
          SetGadgetAttribute(*tree\canvas_id,#PB_Canvas_Cursor,#PB_Cursor_Hand)
        EndIf
        If _ITEM_hoverCheckedBox(*this,mx,my)
          SetGadgetAttribute(*tree\canvas_id,#PB_Canvas_Cursor,#PB_Cursor_Hand)
        EndIf
        If \selectable
          If _ITEM_hoverImageBox(*this,mx,my)
            SetGadgetAttribute(*tree\canvas_id,#PB_Canvas_Cursor,#PB_Cursor_Hand)
          EndIf
          If _ITEM_hoverTitleBox(*this,mx,my)
            SetGadgetAttribute(*tree\canvas_id,#PB_Canvas_Cursor,#PB_Cursor_Hand)
          EndIf
        EndIf
        ForEach \myButtons()
          If \myButtons()\namageEvent(\myButtons(),*tree,mx,my) 
            hoverButton = #True
            Break 
          EndIf
        Next
        If Not hoverButton And gToolOn
          *tree\drawMask(*tree)
          gToolOn = #False
        EndIf
      Case #PB_EventType_LeftClick
        If _ITEM_hoverExpand(*this,mx,my)
          \expanded =  \expanded ! 1
          ProcedureReturn #True ; the tree is need to refresh
        EndIf
        If _ITEM_hoverCheckedBox(*this,mx,my)
          \checked = \checked ! 1
          ProcedureReturn #True ; the tree is need to refresh
        EndIf
        If \selectable
          If _ITEM_hoverImageBox(*this,mx,my)
            *tree\unselectItems(*tree)
            \selected =  \selected ! 1
            If \selectCallback
              \selectCallback(*this)
            EndIf
            If *tree\selectCallback
              *tree\selectCallback(*this)
            EndIf
            ProcedureReturn #True ; the tree is need to refresh
          EndIf
          If _ITEM_hoverTitleBox(*this,mx,my)
            *tree\unselectItems(*tree)
            \selected = ~ \selected
            If \selectCallback
              \selectCallback(*this)
            EndIf
            If *tree\selectCallback
              *tree\selectCallback(*this)
            EndIf
            ProcedureReturn #True ; the tree is need to refresh
          EndIf
        EndIf
        ForEach \myButtons()
          If \myButtons()\namageEvent(\myButtons(),*tree,mx,my) : Break : EndIf
        Next
      Case #PB_EventType_LeftButtonDown
        If Not clickOn
          oldX = mx
          clickOn = #True
        EndIf
      Case #PB_EventType_LeftButtonUp
        clickOn = #False
    EndSelect
    ProcedureReturn #False ; the tree isn't need to refresh
  EndWith
EndProcedure

Procedure _ITEM_unselect(*this._ITEM)
  With *this
    \selected = #False
    ForEach \myChildren()
      \myChildren()\unselectItems(\myChildren())
    Next
  EndWith
EndProcedure

Procedure _ITEM_remove(*this._ITEM,*toRemove)
  With *this
    If *this = *toRemove
      Define i.TREE::Item  = *this
      i\free()
      ProcedureReturn #True
    EndIf
    ForEach \myChildren()
      If \myChildren()\removeItem(\myChildren(),*toRemove)
        DeleteElement(\myChildren())
        ProcedureReturn #True
      EndIf
    Next
    ProcedureReturn #False
  EndWith
EndProcedure
;}

;-* PUBLIC METHODS
Procedure ITEM_addChild(*this._ITEM,*item)
  With *this
    AddElement(\myChildren())
    \myChildren() = *item
    ProcedureReturn *item
  EndWith
EndProcedure

Procedure ITEM_free(*this._ITEM)
  With *this
    ForEach \myChildren()
      ITEM_free(\myChildren())
      DeleteElement(\myChildren())
    Next
    FreeStructure(*this)
  EndWith
EndProcedure

Procedure ITEM_freeChildren(*this._ITEM)
  With *this
    ForEach \myChildren()
      ITEM_free(\myChildren())
      DeleteElement(\myChildren())
    Next
  EndWith
EndProcedure

Procedure ITEM_setData(*this._ITEM,value.l)
  With *this
   \myData = value
  EndWith
EndProcedure

Procedure ITEM_getData(*this._ITEM)
  With *this
   ProcedureReturn \myData
  EndWith
EndProcedure

Procedure ITEM_setSelectedCallback(*this._ITEM,*callback)
  With *this
    \selectCallback = *callback
  EndWith
EndProcedure

Procedure ITEM_addButton(*this._ITEM,*button)
  With *this
    AddElement(\myButtons())
    \myButtons() = *button
    ProcedureReturn *button
  EndWith
EndProcedure

Procedure ITEM_enableDragEvent(*this._ITEM,target)
  With *this
    \dropTarget = target
  EndWith
EndProcedure
;}

;-* GETTERS
Procedure.s ITEM_getTitle(*this._ITEM) 
  With *this
    ProcedureReturn \title
  EndWith
EndProcedure

Procedure ITEM_getImage(*this._ITEM) 
  With *this
    ProcedureReturn \image
  EndWith
EndProcedure

Procedure ITEM_hasCheckBox(*this._ITEM) 
  With *this
    ProcedureReturn \checkBox
  EndWith
EndProcedure

Procedure ITEM_isExpanded(*this._ITEM) 
  With *this
    ProcedureReturn \expanded
  EndWith
EndProcedure

Procedure ITEM_isSelectable(*this._ITEM) 
  With *this
    ProcedureReturn \selectable
  EndWith
EndProcedure

;}

;-* SETTERS
Procedure.s ITEM_SetTitle(*this._ITEM,title.s) 
  With *this
    \title = title
  EndWith
EndProcedure

Procedure ITEM_setImage(*this._ITEM,image) 
  With *this
    \image = image
  EndWith
EndProcedure

Procedure ITEM_setCheckBox(*this._ITEM,state.b) 
  With *this
    \checkBox = state
  EndWith
EndProcedure

Procedure ITEM_setExpanded(*this._ITEM,state.b) 
  With *this
    \expanded = state
  EndWith
EndProcedure

Procedure ITEM_setSelectable(*this._ITEM,state.b) 
  With *this
     \selectable = state
  EndWith
EndProcedure
;}

Procedure newItem(title.s,image = 0)
  Protected *this._ITEM = AllocateStructure(_ITEM)
  With *this
    \methods = ?S_ITEM
    \title = title
    \image = image
    \build = @_ITEM_build()
    \manageEvents = @_ITEM_event()
    \unselectItems = @_ITEM_unselect()
    \selectable = #True
    \removeItem = @_ITEM_remove()
    \dropTarget = -1
    ProcedureReturn *this
  EndWith
EndProcedure

DataSection
  S_ITEM:
  ; GETTERS
  Data.i @ITEM_getTitle()
  Data.i @ITEM_getImage()
  Data.i @ITEM_hasCheckBox()
  Data.i @ITEM_isExpanded()
  Data.i @ITEM_isSelectable()
  ; SETTERS
  Data.i @ITEM_SetTitle()
  Data.i @ITEM_setImage()
  Data.i @ITEM_setCheckBox()
  Data.i @ITEM_setExpanded()
  Data.i @ITEM_setSelectable()
  ; PUBLIC METHODS
  Data.i @ITEM_addChild()
  Data.i @ITEM_free()
  Data.i @ITEM_freeChildren()
  Data.i @ITEM_setData()
  Data.i @ITEM_getData()
  Data.i @ITEM_setSelectedCallback()
  Data.i @ITEM_addButton()
  Data.i @ITEM_enableDragEvent()
  E_ITEM:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 190
; FirstLine = 12
; Folding = AAgAgHAADBEA5
; EnableXP