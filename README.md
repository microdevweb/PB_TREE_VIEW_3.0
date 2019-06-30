# Tree view for PureBasic version 3.0 Beta 1
This new version is full object and very easier than old version. At the moment it haven't really finished, i shall add button options with callback.

Twoo classes exist at the moment, Tree is the main class and Item is the class for yours items.

## Tree class
### Constructor
For use this tree view, you must create a container into your window, that is this container it give positions and size of the tree view. You need pass this container id to the constructor.
```
newTreeView(containerId)
```
### Getters
```
getImageWidht()

return the image width (this size is used for drawing the image) by default 24 pxl
```
```
getImageHeight()

return the image height (this size is used for drawing the image) by default 24 pxl
```
```
getlineHeight()

return the space between rows  by default 26 pxl
```
### Setters
```
setImageWidht(width)

set the image width (this size is used for drawing the image)
```

```
setImageHeight(height)

set the image height (this size is used for drawing the image) 
```

```
setlineHeight(height)

set the space between rows 
```
### Public methods
```
addChild(item)

add a child to the tree view
  * item object from Item class
  * return Item instance
```

```
build()

build and display this tree view
```

```
free()

free this object and its children
```

```
freeChildren()

free its children only
```

```
setSelectedCallback(callback)

For use this method, you must create a procedure like this.

Procedure myProcedure(item.TREE::Item)
  ; my code
EndProcedure

call the method with the address of your procedure like this

setSelectedCallback(@myProcedure())

After you enjoy of all methods of Item class when the user selected a item (the item must be selectable)

```

## Item class

# Constructor
```
newItem(title.s,image = 0)
  * title.s = the title displayed for this item
  * image = one icon id than you want see or null for don't see anything.
```
# Getters
```
getTitle.s()

```

```
getImage()

```

```
hasCheckBox.b()

```

```
isExpanded.b()


```

# Setters
```
setTitle(title.s)

```

```
setImage(image)

```

```
setCheckBox(state.b)

```

```
setExpanded(state.b)

```

# Public methods
```
addChild(item)
```

```
free()
```

```
freeChildren()
```

```
setData(value.l)
```

```
getData()
```

```
setSelectedCallback(callback)
```
