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
