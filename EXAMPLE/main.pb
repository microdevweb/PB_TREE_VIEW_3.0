; ***************************************************************************************
; Example : manage some categories
; ***************************************************************************************
XIncludeFile "..\TREE\TREE.pbi"
Structure _item
  name.s
  item.TREE::Item
EndStructure
Global NewList myBank._item()
Global NewList myExpense_account._item()
Global NewList myCar._item()


Enumeration 
  #MAIN_FORM 
  #CONTAINER_TREE 
  #CONTAINER_WORK 
  #SLITER
EndEnumeration
Enumeration 1
  #IMG_BANK
  #IMG_EDIT
  #IMG_ADD
  #IMG_EXPENS
  #IMG_CAR
  #IMG_DELETE
EndEnumeration
; catch images
CatchImage(#IMG_BANK,?ico_bank)
CatchImage(#IMG_EDIT,?ico_edit)
CatchImage(#IMG_DELETE,?ico_delete)
CatchImage(#IMG_ADD,?ico_add)
CatchImage(#IMG_EXPENS,?ico_expens)
CatchImage(#IMG_CAR,?ico_car)
; create tree
Global.TREE::Tree myTree = TREE::newTreeView(#CONTAINER_TREE)
; edit method
Procedure evAddBank(item.TREE::Item)
  Debug "Add bank"
  item\addChild(TREE::newItem("New Bank"))
  myTree\build()
EndProcedure
Procedure evEditBank(item.TREE::Item)
  With item
    If ChangeCurrentElement(myBank(),item\getData())
      Debug "Edit bank : "+myBank()\name
    EndIf
  EndWith
EndProcedure
Procedure evDeleteBank(item.TREE::Item)
  With item
;     CallDebugger
    If ChangeCurrentElement(myBank(),item\getData())
      If myTree\removeItem(item)
        myTree\build()
        Debug "Delete bank : "+myBank()\name
      EndIf
    EndIf
  EndWith
EndProcedure

Procedure fillItemCar(item.TREE::Item)
  Restore car
  Repeat
    Define d.s 
    Read.s d
    If d <> "-1"
      AddElement(myCar())
      myCar()\name = d
      myCar()\item = item\addChild(TREE::newItem(d))
    EndIf
  Until d = "-1"
EndProcedure

Procedure ev_size()
  ResizeGadget(#CONTAINER_TREE,#PB_Ignore,#PB_Ignore,#PB_Ignore,WindowHeight(#MAIN_FORM))
EndProcedure
; open a window
OpenWindow(#MAIN_FORM,0,0,800,600,"Teste",#PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_SizeGadget)
ContainerGadget(#CONTAINER_TREE,0,0,800,600,#PB_Container_Double)
CloseGadgetList()
ContainerGadget(#CONTAINER_WORK,0,0,800,600,#PB_Container_Double)
CloseGadgetList()
SplitterGadget(#SLITER,0,0,800,600,#CONTAINER_TREE,#CONTAINER_WORK,#PB_Splitter_Vertical|#PB_Splitter_Separator)
BindEvent(#PB_Event_SizeWindow,@ev_size(),#MAIN_FORM)
; create tree view

Global.TREE::Item iBank,iExpens
iBank = myTree\addChild(TREE::newItem("Bank",#IMG_BANK))
Define bt.TREE::Button = iBank\addButton(TREE::newButton(#IMG_ADD,@evAddBank()))
bt\setToolTip("Add a new bank")
iExpens = myTree\addChild(TREE::newItem("Expens",#IMG_EXPENS))
; load data
Restore bank
Repeat
  Define d.s 
  Read.s d
  If d <> "-1"
    AddElement(myBank())
    myBank()\name = d
    myBank()\item = iBank\addChild(TREE::newItem(d))
    myBank()\item\setData(@myBank())
    Define bt.TREE::Button = myBank()\item\addButton(TREE::newButton(#IMG_EDIT,@evEditBank()))
    bt\setToolTip("Edit bank")
    Define bt.TREE::Button = myBank()\item\addButton(TREE::newButton(#IMG_DELETE,@evDeleteBank()))
    bt\setToolTip("Delete bank")
  EndIf
Until d = "-1"
Global *car
Restore expens
Repeat
  Define d.s 
  Read.s d
  If d <> "-1"
    AddElement(myExpense_account())
    myExpense_account()\name = d
    If d = "Car"
      myExpense_account()\item = iExpens\addChild(TREE::newItem(d,#IMG_CAR))
      *car = myExpense_account()\item
    Else
      myExpense_account()\item = iExpens\addChild(TREE::newItem(d))
    EndIf
  EndIf
Until d = "-1"
fillItemCar(*car)

myTree\build()

Repeat
  WaitWindowEvent()
Until Event() = #PB_Event_CloseWindow
DataSection
  bank:
  Data.s "ING","Belfius","Cash","-1"

  expens:
  Data.s "Food","Car","Clothes","Healthi","-1"

  car:
  Data.s "Gasoline","Insurance","-1"

  ico_bank:
  IncludeBinary "IMG/bank.ico"
  ico_edit:
  IncludeBinary "IMG/edit.ico"
  ico_delete:
  IncludeBinary "IMG/delete.ico"
  ico_add:
  IncludeBinary "IMG/add.ico"
  ico_expens:
  IncludeBinary "IMG/expens.ico"
  ico_car:
  IncludeBinary "IMG/car.ico"
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 51
; FirstLine = 39
; Folding = ---
; EnableXP