# This Is Unfinished
*this ui library was made only for me to use*
<br/>
<br/>
<br/>
<br/>
<br/>


```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/lvvyh-Rblx/ui/refs/heads/main/lib.lua"))()
```

### Create A Window
```lua
local Window = library:NewWindow({
	Name = "Test Window", -- Name of the window | string, required
	Keybind = "LeftControl", -- Keybind to open/close window | string, required
	UseCoreGui = true -- Use coregui as the parent | bool, optional
})
```

### Create A Tab
```lua
local Tab = Window:NewTab({
	Name = "Tab Name" -- Name of the tab | string, required
})
```

#### Edit/Remove A Tab
```lua
Tab:Edit("New Name") -- Changes the text to the new text
Tab:Remove() -- Removes the tab
```

### Create A Label
```lua
local Label = Tab:NewLabel({
	Name = "Example Label" -- Text to show on the label | string, required
})
```

#### Edit/Remove A Label
```lua
Label:Edit("New Name") -- Changes the text to the new text
Label:Remove() -- Removes the label
```

### Create A Button
```lua
local Button = Tab:NewButton({
	Name = "Example Button", -- Text that shows on the button | string, required
	Callback = function() -- Code executed when the button is clicked | function, optional
		
	end
})
```

#### Edit/Remove A Button
```lua
Button:Edit({
    Name = "New Name", -- New name for the button | string, optional
    Callback = function() -- New callback for the button | string, optional
        
    end
})
Button:Remove() -- Removes the button
```
<br/>

*Made by: Lvvyh*
