```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/lvvyh-Rblx/ui/refs/heads/main/lib.lua"))()
```

### Create A window
```lua
local Window = library:NewWindow({
	Name = "Test Window", -- Name of the window | string
	Keybind = "LeftControl", -- Keybind to open/close window | string
	UseCoreGui = false -- use coregui as the parent | bool
})
```
