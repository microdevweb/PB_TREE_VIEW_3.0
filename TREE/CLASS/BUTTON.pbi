; **********************************************************************************************************************
; AUTHOR      : microdevWeb
; CLASS       : BUTTON.pbi
; VERSION     : 3.0
; DATE        : 2019-06-29
; LICENCE     : CC-BY-NC-SA
; **********************************************************************************************************************
;-* PRIVATE METHODS
Procedure _BUTTON_displayToolTip(*this._BUTTON,*tree._TREE,mx,my)
  With *this
    If Len(\toolTip)
      *tree\drawMask(*tree)
      StartVectorDrawing(CanvasVectorOutput(*tree\canvas_id))
      VectorFont(FontID(*tree\toolTipFont))
      Protected bw = VectorTextWidth(\toolTip)
      Protected bh = VectorTextHeight(\toolTip)
      AddPathBox(mx,my + 10,bw + 10,bh + 20)
      VectorSourceColor(*tree\toolTipColors\back)
      FillPath()
      MovePathCursor(mx + 5,my + 20)
      VectorSourceColor(*tree\toolTipColors\front)
      DrawVectorText(\toolTip)
      StopVectorDrawing()
      gToolOn = #True
    EndIf
  EndWith
EndProcedure
;}
;-* PROTECTED METHODS
Procedure _BUTTON_build(*this._BUTTON,*item._ITEM,*tree._TREE,x,y)
  With *this
    Protected yc = y + (*tree\lineHeight / 2)
    Protected yy = yc - (*tree\buttonHeight /2)
    MovePathCursor(x,yy)
    DrawVectorImage(ImageID(\image),255,*tree\buttonWidth,*tree\buttonHeight)
    \item = *item
    \_buttonBox\x = x
    \_buttonBox\y = yy
    \_buttonBox\w = *tree\buttonWidth
    \_buttonBox\h = *tree\buttonHeight
  EndWith
EndProcedure

Procedure _BUTTON_manage_event(*this._BUTTON,*tree._TREE,mx,my)
  With *this
    Select EventType()
      Case #PB_EventType_MouseMove
        If (mx>= \_buttonBox\x And mx<=\_buttonBox\x + \_buttonBox\w) And (my>= \_buttonBox\y And my<=\_buttonBox\y + \_buttonBox\h) 
          SetGadgetAttribute(*tree\canvas_id,#PB_Canvas_Cursor,#PB_Cursor_Hand)
          _BUTTON_displayToolTip(*this,*tree,mx,my)
          ProcedureReturn #True
        EndIf
      Case #PB_EventType_LeftClick
        If mx>= \_buttonBox\x And mx<=\_buttonBox\x + \_buttonBox\w
          If my>= \_buttonBox\y And my<=\_buttonBox\y + \_buttonBox\h
            If \callBack
              \callBack(\item)
              ProcedureReturn #True
            EndIf
          EndIf
        EndIf
    EndSelect
    ProcedureReturn #False
  EndWith
EndProcedure
;}
;-* GETTERS
Procedure BUTTON_getImage(*this._BUTTON)
  With *this
    ProcedureReturn \image 
  EndWith
EndProcedure

Procedure.s BUTTON_getToolTip(*this._BUTTON)
  With *this
    ProcedureReturn \toolTip
  EndWith
EndProcedure

Procedure BUTTON_isDisabled(*this._BUTTON)
  With *this
    ProcedureReturn \disabled
  EndWith
EndProcedure

Procedure BUTTON_getCallback(*this._BUTTON)
  With *this
    ProcedureReturn \callBack
  EndWith
EndProcedure

;}
;-* SETTERS
Procedure BUTTON_setImage(*this._BUTTON,image)
  With *this
     \image = image
  EndWith
EndProcedure

Procedure BUTTON_setToolTip(*this._BUTTON,text.s)
  With *this
     \toolTip = text
  EndWith
EndProcedure

Procedure BUTTON_setDisabled(*this._BUTTON,state.b)
  With *this
     \disabled = state
  EndWith
EndProcedure

Procedure BUTTON_setCallback(*this._BUTTON,*callback)
  With *this
     \callBack = *callback
  EndWith
EndProcedure
;}
Procedure newButton(image,*callback)
  Protected *this._BUTTON = AllocateStructure(_BUTTON)
  With *this
    \methods = ?S_BUTTON
    \image = image
    \callBack = *callback
    \build = @_BUTTON_build()
    \namageEvent = @_BUTTON_manage_event()
    ProcedureReturn *this
  EndWith
EndProcedure

DataSection
  S_BUTTON:
  ; GETTETRS
  Data.i @BUTTON_getImage()
  Data.i @BUTTON_getToolTip()
  Data.i @BUTTON_isDisabled()
  Data.i @BUTTON_getCallback()
  ; SETTERS
  Data.i @BUTTON_setImage()
  Data.i @BUTTON_setToolTip()
  Data.i @BUTTON_setDisabled()
  Data.i @BUTTON_setCallback()
  E_BUTTON:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 46
; FirstLine = 30
; Folding = vfO+
; EnableXP