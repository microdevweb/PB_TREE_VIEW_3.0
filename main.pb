
XIncludeFile "TREE/TREE.pbi"

OpenWindow(0,0,0,800,600,"Teste",#PB_Window_ScreenCentered|#PB_Window_SystemMenu)
ContainerGadget(0,0,0,800,600,#PB_Container_Double)
CloseGadgetList()
Global myTree.TREE::Tree = TREE::newTreeView(0)
Global projectItem.TREE::Item = myTree\addChild(TREE::newItem("Project",CatchImage(#PB_Any,?PROJECT_ICO)))
Global classItem.TREE::Item = myTree\addChild(TREE::newItem("Class",CatchImage(#PB_Any,?CLASS_ICO)))

Procedure _eventTree(item.TREE::Item)
  Debug item\getTitle()
EndProcedure


projectItem\setCheckBox(#True)
projectItem\addChild(TREE::newItem("teste"))
ite1.TREE::Item = classItem\addChild(TREE::newItem("Package",CatchImage(#PB_Any,?PACKAGE_ICO)))
ite1\addChild(TREE::newItem("item 1"))
ite1\addChild(TREE::newItem("item 2"))
ite1\addChild(TREE::newItem("item 3"))

myTree\setSelectedCallback(@_eventTree())
myTree\build()
Repeat
  WaitWindowEvent()
Until Event() = #PB_Event_CloseWindow

DataSection
  PROJECT_ICO:
  IncludeBinary "IMG/project_icon.png"
  CLASS_ICO:
  IncludeBinary "IMG/class_icon.png"
  PACKAGE_ICO:
  IncludeBinary "IMG/package_icon.png"
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 20
; FirstLine = 5
; Folding = -
; EnableXP