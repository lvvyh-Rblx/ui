# This Is Unfinished
*this ui library was made only for me to use*
<br/>
<br/>
<br/>
<br/>
<br/>

### Booting The Library
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/lvvyh-Rblx/ui/refs/heads/main/lib.lua"))()
```

### Create A Window
```lua
local Window = Library:NewWindow({
	Name = "Test Window", -- Name of the window | string
	Keybind = "LeftControl", -- Keybind to open/close window | string
	UseCoreGui = true -- Use coregui as the parent | bool
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
Tab:Edit("New Name") -- Changes the text to the new text
Tab:Remove() -- Removes the tab
```

### Create A Label
```lua
local Label = Tab:NewLabel({
	Name = "Example Label" -- Text to show on the label | string
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
	Name = "Example Button", -- Text that shows on the button | string
	Callback = function() -- Code executed when the button is clicked | function
		
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

### Create A Toggle
```lua
local Toggle = Tab:NewToggle({
	Name = "Example Toggle", -- Text that shows on the toggle | string
	Default = false, -- Default state of the toggle | bool
	Callback = function(enabled) -- Code executed on toggle enable/disable | function

	end
})
```

#### Edit/Remove A Toggle
```lua
Toggle:Edit({
	Name = "New Name", -- New name for the toggle | string, optional
	Enabled = false, -- New state of the toggle | bool, optional
	Callback = function(enabled) -- New callback for the toggle | function, optional
		
	end
})
```

### Send Notification
```lua
Window:Notify({
	Name = "Notification", -- Name of the notification | string
	Description = "Description", -- Notification description | string, optional
	Icon = "rbxassetid://105259546800352" -- Icon for the notification | string, optional
	Duration = 3 -- How long the notification stays for | number
})
```
<br/>

*Made by: Lvvyh*
