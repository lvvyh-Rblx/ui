local Players = game:GetService("Players")
local Http = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local library = {}

library.Windows = {}

local defaultSettings = {
	Name = "Window",
	Keybind = "LeftControl",
	UseCoreGui = false,
}

function library:NewWindow(settings)
	local visible = true
	local minimized = false
	local dragging = false
	local dragInput, dragStart, startPos
	
	settings = settings or {}
	for k, v in pairs(defaultSettings) do
		if settings[k] == nil then
			settings[k] = v
		end
	end
	
	-- Window storage
	local window = {
		Tabs = {},
	}
	
	-- Create the ScreenGui
	local parent = settings.UseCoreGui and game:GetService("CoreGui") or Players.LocalPlayer:WaitForChild("PlayerGui")
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = Http:GenerateGUID()
	screenGui.IgnoreGuiInset = true
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = 999
	screenGui.Parent = parent
	
	-- Create instances for base window
	local windowFrame = Instance.new("Frame", screenGui)
	local windowCorner = Instance.new("UICorner", windowFrame)
	local bar = Instance.new("Frame", screenGui)
	local barCorner = Instance.new("UICorner", bar)
	local barBottom = Instance.new("Frame", bar)
	local closeButton = Instance.new("TextButton", bar)
	local closeButtonCorner = Instance.new("UICorner", closeButton)
	local minButton = Instance.new("TextButton", bar)
	local minButtonCorner = Instance.new("UICorner", minButton)
	local title = Instance.new("TextLabel", bar)
	local titleConstraint = Instance.new("UITextSizeConstraint", title)
	local line = Instance.new("Frame", windowFrame)
	local tabList = Instance.new("ScrollingFrame", windowFrame)
	local tabLayout = Instance.new("UIListLayout", tabList)
	
	-- Set Properties for window
	windowFrame.Name = "Window"
	windowFrame.BackgroundColor3 = Color3.fromRGB(38, 28, 45)
	windowFrame.Position = UDim2.new(0.243, 0, 0.276, 0)
	windowFrame.Size = UDim2.new(0.385, 0, 0.461, 0)
	
	line.Name = "Line"
	line.BackgroundColor3 = Color3.fromRGB(75, 43, 156)
	line.Position = UDim2.new(0.276, 0, 0.05, 0)
	line.Size = UDim2.new(0.005, 0, .95, 0)
	line.BorderSizePixel = 0
	
	tabList.Name = "TabList"
	tabList.BackgroundTransparency = 1
	tabList.Position = UDim2.new(0.012, 0, 0.136, 0)
	tabList.Size = UDim2.new(0.254, 0, 0.861, 0)
	tabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	tabList.CanvasSize = UDim2.new(0, 0, 0.9, 0)
	tabList.ScrollBarThickness = 0
	
	bar.Name = "Bar"
	bar.BackgroundColor3 = Color3.fromRGB(75, 43, 156)
	bar.Position = UDim2.new(0.243, 0, 0.275, 0)
	bar.Size = UDim2.new(0.385, 0, 0.055, 0)
	
	barBottom.Name = "BarBottom"
	barBottom.BackgroundColor3 = Color3.fromRGB(75, 43, 156)
	barBottom.Position = UDim2.new(0.002, 0, 0.597, 0)
	barBottom.Size = UDim2.new(0.997, 0, 0.393, 0)
	barBottom.BorderColor3 = Color3.fromRGB(75, 43, 156)
	
	closeButton.Name = "Close"
	closeButton.BackgroundColor3 = Color3.fromRGB(255, 17, 88)
	closeButton.Position = UDim2.new(0.947, 0, 0.321, 0)
	closeButton.Size = UDim2.new(0.028, 0, 0.358, 0)
	closeButton.Text = ""
	
	minButton.Name = "Min"
	minButton.BackgroundColor3 = Color3.fromRGB(255, 247, 54)
	minButton.Position = UDim2.new(0.897, 0, 0.321, 0)
	minButton.Size = UDim2.new(0.028, 0, 0.358, 0)
	minButton.Text = ""
	
	title.Name = "Title"
	title.BackgroundTransparency = 1
	title.Position = UDim2.new(0.026, 0, 0.107, 0)
	title.Size = UDim2.new(0.598, 0, 0.768, 0)
	title.FontFace = Font.fromEnum(Enum.Font.Roboto)
	title.FontFace.Weight = Enum.FontWeight.Bold
	title.Text = settings.Name
	title.TextColor3 = Color3.fromRGB(230, 230, 230)
	title.TextScaled = true
	title.TextXAlignment = Enum.TextXAlignment.Left
	
	windowCorner.CornerRadius = UDim.new(0.065, 0)
	barCorner.CornerRadius = UDim.new(0.45, 0)
	closeButtonCorner.CornerRadius = UDim.new(1, 0)
	minButtonCorner.CornerRadius = UDim.new(1, 0)
	titleConstraint.MaxTextSize = 44
	titleConstraint.MinTextSize = 1
	tabLayout.Padding = UDim.new(0, 10)
	
	-- Window Dragging
	local function update(input)
		local delta = input.Position - dragStart
		local newPosition = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
		TweenService:Create(windowFrame, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = newPosition}):Play()
		TweenService:Create(bar, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = newPosition}):Play()
	end
	
	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = bar.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	bar.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
	
	-- Close button functionality
	closeButton.MouseButton1Click:Connect(function()
		visible = not visible
		screenGui.Enabled = visible
	end)
	
	-- Minimize button functionality
	minButton.MouseButton1Click:Connect(function()
		minimized = not minimized
		minButton.Visible = false
		
		if minimized then
			TweenService:Create(windowFrame, TweenInfo.new(1, Enum.EasingStyle.Circular), {
				["Size"] = UDim2.new(windowFrame.Size.X.Scale, 0, .05, 0)
			}):Play()
			TweenService:Create(windowCorner, TweenInfo.new(1.5, Enum.EasingStyle.Circular), {
				["CornerRadius"] = UDim.new(.5,0)
			}):Play()
			
			task.delay(.5, function()
				barBottom.Visible = false
			end)
		else
			barBottom.Visible = true
			TweenService:Create(windowFrame, TweenInfo.new(1, Enum.EasingStyle.Circular), {
				["Size"] = UDim2.new(windowFrame.Size.X.Scale, 0, .425, 0)
			}):Play()
			TweenService:Create(windowCorner, TweenInfo.new(1, Enum.EasingStyle.Circular), {
				["CornerRadius"] = UDim.new(.065,0)
			}):Play()
		end
		
		task.wait(1.3)
		minButton.Visible = true
	end)
	
	-- Add toggle functionality for the keybind
	local keybind = settings.Keybind
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == Enum.KeyCode[keybind] then
			visible = not visible
			screenGui.Enabled = visible
		end
	end)
	
	-- Function to create a new tab
	function window:NewTab(tabSettings)
		local tab = {}
		
		tabSettings = tabSettings or {}
		local tabName = tabSettings.Name or "Tab"
		
		-- Create tab instances
		local tabFrame = Instance.new("Frame", tabList)
		local tabAspect = Instance.new("UIAspectRatioConstraint", tabFrame)
		local tabCorner = Instance.new("UICorner", tabFrame)
		local tabTitle = Instance.new("TextLabel", tabFrame)
		local tabButton = Instance.new("TextButton", tabFrame)
		local tabTitleConstraint = Instance.new("UITextSizeConstraint", tabTitle)
		
		-- Set tab properties
		tabFrame.Name = tabName
		tabFrame.BackgroundColor3 = Color3.fromRGB(57, 51, 74)
		tabFrame.Size = UDim2.new(1, 0, 0, 65)
		
		tabTitle.Name = "Title"
		tabTitle.BackgroundTransparency = 1
		tabTitle.Position = UDim2.new(0.048, 0, 0.108, 0)
		tabTitle.Size = UDim2.new(0.894, 0, 0.769, 0)
		tabTitle.FontFace = Font.fromEnum(Enum.Font.Roboto)
		tabTitle.Text = tabName
		tabTitle.TextColor3 = Color3.fromRGB(171, 161, 179)
		tabTitle.TextScaled = true
		
		tabButton.Name = "Button"
		tabButton.BackgroundTransparency = 1
		tabButton.Size = UDim2.new(1, 0, 1, 0)
		tabButton.Text = ""
		
		tabCorner.CornerRadius = UDim.new(0.15, 0)
		tabAspect.AspectRatio = 2.892
		tabTitleConstraint.MaxTextSize = 40
		tabTitleConstraint.MinTextSize = 1
		
		function tab:Remove()
			tabFrame:Destroy()
		end
		
		function tab:Edit(newName)
			newName = newName or "Tab"
			tabTitle.Text = newName
		end
		
		return tab
	end
	
	-- Store and return the window
	table.insert(library.Windows, window)
	return window
end



return library