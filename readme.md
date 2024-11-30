```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/lvvyh-Rblx/ui/refs/heads/main/lib.lua"))()
```

### Create A Window
```lua
local Window = library:NewWindow({
	Name = "Test Window", -- Name of the window | string
	Keybind = "LeftControl", -- Keybind to open/close window | string
	UseCoreGui = true -- use coregui as the parent | bool
})
```

### Create A Tab
```lua
local Tab = Window:NewTab({
	Name = "Tab Name" -- Name of the tab | string
})
```

#### Edit/Remove A Tab
```lua
Tab:Edit("New Name")
Tab:Remove()
```

### Create A Label
```lua
local Label = Tab:NewLabel({
	Name = "Example Label"
})
```

#### Edit/Remove A Label
```lua
Label:Edit("New Name")
Label:Remove()
```

### Create A Button
```lua
local Button = Tab:NewButton({
	Name = "Example Button",
	Callback = function()
		
	end
})
```

#### Edit/Remove A Button
```lua
Button:Edit({
    Name = "New Name", -- optional
    Callback = function() -- optional
        
    end
})
Button:Remove()
```
