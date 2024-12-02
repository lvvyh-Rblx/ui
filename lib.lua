local Players = game:GetService("Players")
local Http = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

local ranks = {
	[2796125870] = "VIP", -- lvvyh
	[7639224876] = "Owner", -- lvvyyh
	[7418331758] = "Imposter", -- lvvvyh
	[2533698025] = "I Love You", -- holiday
}

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
	local parent = settings.UseCoreGui and gethui() or player:WaitForChild("PlayerGui")
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = Http:GenerateGUID()
	screenGui.IgnoreGuiInset = true
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = 999
	screenGui.Parent = parent
	
	-- Create instances for window
	local windowFrame = Instance.new("Frame", screenGui)
	local windowAspect = Instance.new("UIAspectRatioConstraint", windowFrame)
	local windowCorner = Instance.new("UICorner", windowFrame)
	local bottomBar = Instance.new("Frame", windowFrame)
	local bottomBarCorner = Instance.new("UICorner", bottomBar)
	local playerIcon = Instance.new("ImageLabel", bottomBar)
	local playerIconCorner = Instance.new("UICorner", playerIcon)
	local welcomeText = Instance.new("TextLabel", bottomBar)
	local welcomeTextConstraint = Instance.new("UITextSizeConstraint", welcomeText)
	local rankText = Instance.new("TextLabel", bottomBar)
	local rankTextConstraint = Instance.new("UITextSizeConstraint", rankText)
	local line = Instance.new("Frame", windowFrame)
	local tabListBackground = Instance.new("Frame", windowFrame)
	local tabListBackgroundCorner = Instance.new("UICorner", tabListBackground)
	local bar = Instance.new("Frame", screenGui)
	local barAspect = Instance.new("UIAspectRatioConstraint", bar)
	local barCorner = Instance.new("UICorner", bar)
	local barGradient = Instance.new("UIGradient", bar)
	local closeButton = Instance.new("TextButton", bar)
	local closeCorner = Instance.new("UICorner", closeButton)
	local minButton = Instance.new("TextButton", bar)
	local minCorner = Instance.new("UICorner", minButton)
	local title = Instance.new("TextLabel", bar)
	local tabWindowsFolder = Instance.new("Folder", windowFrame)
	local tabList = Instance.new("ScrollingFrame", windowFrame)
	local tabListLayout = Instance.new("UIListLayout", tabList)
	
	-- Set properties for window
	windowFrame.Name = "Window"
	windowFrame.BackgroundColor3 = Color3.fromRGB(42, 38, 42)
	windowFrame.Position = UDim2.new(0.255, 0, 0.221, 0)
	windowFrame.Size = UDim2.new(0.325, 0, 0.399, 0)
	
	bottomBar.Name = "BottomBar"
	bottomBar.BackgroundColor3 = Color3.fromRGB(17, 13, 27)
	bottomBar.Position = UDim2.new(0, 0, 0.903, 0)
	bottomBar.Size = UDim2.new(1, 0, 0.097, 0)
	bottomBar.ZIndex = 100
	
	line.Name = "Line"
	line.BackgroundColor3 = Color3.fromRGB(61, 42, 86)
	line.Position = UDim2.new(0.266, 0, 0.104, 0)
	line.Size = UDim2.new(0.01, 0, 0.896, 0)
	line.BorderSizePixel = 0
	
	tabListBackground.Name = "TabListBackground"
	tabListBackground.BackgroundColor3 = Color3.fromRGB(51, 47, 54)
	tabListBackground.Position = UDim2.new(0, 0, 0.041, 0)
	tabListBackground.Size = UDim2.new(0.266, 0, 0.956, 0)
	
	playerIcon.Name = "PlayerIcon"
	playerIcon.BackgroundTransparency = 1
	playerIcon.Position = UDim2.new(0.01, 0, 0.1, 0)
	playerIcon.Size = UDim2.new(0.056, 0, 0.833, 0)
	playerIcon.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420) or ""
	playerIcon.ZIndex = 999
	
	welcomeText.Name = "WelcomeText"
	welcomeText.BackgroundTransparency = 1
	welcomeText.Position = UDim2.new(0.079, 0, 0, 0)
	welcomeText.Size = UDim2.new(0.495, 0, 1, 0)
	welcomeText.Text = `Welcome, {player.DisplayName}.`
	welcomeText.TextColor3 = Color3.fromRGB(158, 158, 158)
	welcomeText.TextScaled = true
	welcomeText.TextXAlignment = Enum.TextXAlignment.Left
	welcomeText.ZIndex = 999
	
	rankText.Name = "Rank"
	rankText.BackgroundTransparency = 1
	rankText.Position = UDim2.new(0.63, 0, 0, 0)
	rankText.Size = UDim2.new(0.354, 0, 0.931, 0)
	rankText.Text = `[{ranks[player.UserId] or "Guest"}]`
	rankText.TextColor3 = Color3.fromRGB(158, 158, 158)
	rankText.TextScaled = true
	rankText.TextXAlignment = Enum.TextXAlignment.Right
	rankText.ZIndex = 999
	
	bar.Name = "Bar"
	bar.Position = UDim2.new(0.255, 0, 0.221, 0)
	bar.Size = UDim2.new(0.325, 0, 0.042, 0)
	
	closeButton.Name = "Close"
	closeButton.BackgroundColor3 = Color3.fromRGB(255, 17, 88)
	closeButton.Position = UDim2.new(0.947, 0, 0.321, 0)
	closeButton.Size = UDim2.new(0.026, 0, 0.358, 0)
	closeButton.Text = ""
	
	minButton.Name = "Min"
	minButton.BackgroundColor3 = Color3.fromRGB(255, 247, 54)
	minButton.Position = UDim2.new(0.897, 0, 0.321, 0)
	minButton.Size = UDim2.new(0.026, 0, 0.358, 0)
	minButton.Text = ""
	
	title.Name = "Title"
	title.BackgroundTransparency = 1
	title.Position = UDim2.new(0.024, 0, 0, 0)
	title.Size = UDim2.new(0.55, 0, 1, 0)
	title.FontFace = Font.fromEnum(Enum.Font.TitilliumWeb)
	title.FontFace.Bold = true
	title.FontFace.Weight = Enum.FontWeight.Bold
	title.Text = settings.Name
	title.TextColor3 = Color3.fromRGB(159, 159, 159)
	title.TextScaled = true
	title.TextXAlignment = Enum.TextXAlignment.Left
	
	tabList.Name = "TabList"
	tabList.BackgroundTransparency = 1
	tabList.Position = UDim2.new(0.012, 0, 0.123, 0)
	tabList.Size = UDim2.new(0.246, 0, 0.78, 0)
	tabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	tabList.CanvasSize = UDim2.new(0, 0, 0.9, 0)
	tabList.ScrollBarThickness = 0
	
	barGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(34, 16, 44)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(129, 50, 189))
	})
	barGradient.Rotation = -90
	
	windowAspect.AspectRatio = 1.448
	windowCorner.CornerRadius = UDim.new(0.04, 0)
	bottomBarCorner.CornerRadius = UDim.new(0.2, 0)
	welcomeTextConstraint.MaxTextSize = 23
	rankTextConstraint.MaxTextSize = 22
	playerIconCorner.CornerRadius = UDim.new(1, 0)
	tabListBackgroundCorner.CornerRadius = UDim.new(0.15, 0)
	barAspect.AspectRatio = 13.867
	barCorner.CornerRadius = UDim.new(0.25, 0)
	closeCorner.CornerRadius = UDim.new(1, 0)
	minCorner.CornerRadius = UDim.new(1, 0)
	tabListLayout.Padding = UDim.new(0, 10)
	tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	
	-- Tab list canvas size updating
	local function updateCanvasSize()
		local contentSize = tabListLayout.AbsoluteContentSize
		tabList.CanvasSize = UDim2.new(0, contentSize.X, 0, contentSize.Y + 10)
	end

	tabList.ChildAdded:Connect(updateCanvasSize)
	tabList.ChildRemoved:Connect(updateCanvasSize)
	tabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)
	
	-- Update rank text color
	if ranks[player.UserId] ~= nil then
		local rank = ranks[player.UserId]
		
		if rank == "Owner" then
			task.spawn(function()
				while true do
					local tween1 = TweenService:Create(rankText, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
						["TextColor3"] = Color3.fromRGB(255, 199, 242)
					})
					tween1:Play()
					tween1.Completed:Wait()
					
					local tween2 = TweenService:Create(rankText, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
						["TextColor3"] = Color3.fromRGB(255, 255, 255)
					})
					tween2:Play()
					tween2.Completed:Wait()
				end
			end)
		elseif rank == "Imposter" then
			task.spawn(function()
				while true do
					local tween1 = TweenService:Create(rankText, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
						["TextColor3"] = Color3.fromRGB(255, 0, 0)
					})
					tween1:Play()
					tween1.Completed:Wait()

					local tween2 = TweenService:Create(rankText, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
						["TextColor3"] = Color3.fromRGB(0, 0, 0)
					})
					tween2:Play()
					tween2.Completed:Wait()
				end
			end)
		elseif rank == "I Love You" then
			task.spawn(function()
				while true do
					local tween1 = TweenService:Create(rankText, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
						["TextColor3"] = Color3.fromRGB(255, 0, 0)
					})
					tween1:Play()
					tween1.Completed:Wait()

					local tween2 = TweenService:Create(rankText, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
						["TextColor3"] = Color3.fromRGB(255, 255, 255)
					})
					tween2:Play()
					tween2.Completed:Wait()
				end
			end)
		elseif rank == "Friend" then
			task.spawn(function()
				while true do
					local tween1 = TweenService:Create(rankText, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
						["TextColor3"] = Color3.fromRGB(255, 255, 78)
					})
					tween1:Play()
					tween1.Completed:Wait()

					local tween2 = TweenService:Create(rankText, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
						["TextColor3"] = Color3.fromRGB(75, 237, 255)
					})
					tween2:Play()
					tween2.Completed:Wait()
				end
			end)
		elseif rank == "Santa" then
			task.spawn(function()
				while true do
					local tween1 = TweenService:Create(rankText, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
						["TextColor3"] = Color3.fromRGB(255, 0, 4)
					})
					tween1:Play()
					tween1.Completed:Wait()

					local tween2 = TweenService:Create(rankText, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
						["TextColor3"] = Color3.fromRGB(34, 255, 0)
					})
					tween2:Play()
					tween2.Completed:Wait()
				end
			end)
		elseif rank == "VIP" then
			task.spawn(function()
				while true do
					local tween1 = TweenService:Create(rankText, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
						["TextColor3"] = Color3.fromRGB(255, 225, 0)
					})
					tween1:Play()
					tween1.Completed:Wait()

					local tween2 = TweenService:Create(rankText, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
						["TextColor3"] = Color3.fromRGB(221, 170, 16)
					})
					tween2:Play()
					tween2.Completed:Wait()
				end
			end)
		end
	end
	
	-- Window dragging
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
				["Size"] = UDim2.new(windowFrame.Size.X.Scale, 0, 0.01, 0)
			}):Play()
			task.delay(.75, function()
				windowFrame.Visible = false
			end)
		else
			windowFrame.Visible = true
			TweenService:Create(windowFrame, TweenInfo.new(1, Enum.EasingStyle.Circular), {
				["Size"] = UDim2.new(windowFrame.Size.X.Scale, 0, .399, 0)
			}):Play()
		end
		
		task.wait(1.1)
		minButton.Visible = true
	end)
	
	-- Add functionality for the keybind
	local keybind = settings.Keybind
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == Enum.KeyCode[keybind] then
			visible = not visible
			screenGui.Enabled = visible
		end
	end)
	
	-- Notification function
	function window:Notify(notificationSettings)
		notificationSettings = notificationSettings or {}
		
		local title = notificationSettings.Name or "Title"
		local description = notificationSettings.Description or ""
		local icon = notificationSettings.Icon or ""
		local duration = notificationSettings.Duration or 3
		
		StarterGui:SetCore("SendNotification", {
			Title = title,
			Text = description,
			Icon = icon,
			Duration = duration
		})
	end
	
	-- Function to create a new tab
	function window:NewTab(tabSettings)
		local tab = {}
		
		tabSettings = tabSettings or {}
		local tabName = tabSettings.Name or "Tab"
		local tabOrder = 0
		
		-- Create tab instances
		local tabFrame = Instance.new("Frame", tabList)
		local tabAspect = Instance.new("UIAspectRatioConstraint", tabFrame)
		local tabCorner = Instance.new("UICorner", tabFrame)
		local tabTitle = Instance.new("TextLabel", tabFrame)
		local tabButton = Instance.new("TextButton", tabFrame)
		local tabTitleConstraint = Instance.new("UITextSizeConstraint", tabTitle)
		local tabWindow = Instance.new("ScrollingFrame", tabWindowsFolder)
		local tabWindowLayout = Instance.new("UIListLayout", tabWindow)
		local tabWindowPadding = Instance.new("UIPadding", tabWindow)
		
		-- Set tab properties
		tabFrame.Name = tabName
		tabFrame.BackgroundColor3 = Color3.fromRGB(40, 38, 45)
		tabFrame.Size = UDim2.new(1, 0, 0, 65)
		
		tabTitle.Name = "Title"
		tabTitle.BackgroundTransparency = 1
		tabTitle.Position = UDim2.new(0.048, 0, 0.108, 0)
		tabTitle.Size = UDim2.new(0.894, 0, 0.769, 0)
		tabTitle.FontFace = Font.fromEnum(Enum.Font.Roboto)
		tabTitle.Text = tabName
		tabTitle.TextColor3 = Color3.fromRGB(150, 146, 153)
		tabTitle.TextScaled = true
		
		tabButton.Name = "Button"
		tabButton.BackgroundTransparency = 1
		tabButton.Size = UDim2.new(1, 0, 1, 0)
		tabButton.Text = ""
		
		tabWindow.Name = tabName
		tabWindow.BackgroundTransparency = 1
		tabWindow.Position = UDim2.new(0.293, 0, 0.135, 0)
		tabWindow.Size = UDim2.new(0.698, 0, 0.778, 0)
		tabWindow.CanvasSize = UDim2.new(0, 0, 0.9, 0)
		tabWindow.ScrollBarThickness = 0
		tabWindow.Visible = false
		
		tabCorner.CornerRadius = UDim.new(0.15, 0)
		tabAspect.AspectRatio = 2.892
		tabTitleConstraint.MaxTextSize = 40
		tabTitleConstraint.MinTextSize = 1
		tabWindowLayout.Padding = UDim.new(0, 15)
		tabWindowLayout.SortOrder = Enum.SortOrder.LayoutOrder
		tabWindowPadding.PaddingLeft = UDim.new(0.013, 0)
		
		-- Tab window canvas size updating
		local function updateCanvasSize()
			local contentSize = tabWindowLayout.AbsoluteContentSize
			tabWindow.CanvasSize = UDim2.new(0, contentSize.X, 0, contentSize.Y + 10)
		end

		tabWindow.ChildAdded:Connect(updateCanvasSize)
		tabWindow.ChildRemoved:Connect(updateCanvasSize)
		tabWindowLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)
		
		-- Tab button functionality
		tabButton.MouseButton1Click:Connect(function()
			for _, v in pairs(tabWindowsFolder:GetChildren()) do
				if v.Name ~= tabName then
					v.Visible = false
				else
					v.Visible = true
				end
			end
		end)
		
		-- Tab functions
		function tab:Remove()
			tabFrame:Destroy()
		end
		
		function tab:Edit(newName)
			newName = newName or "Tab"
			tabTitle.Text = newName
		end
		
		-- Labels
		function tab:NewLabel(labelSettings)
			tabOrder += 1
			local label = {}
			
			labelSettings = labelSettings or {}
			local labelName = labelSettings.Name or "Label"
			
			-- Create label instances
			local labelFrame = Instance.new("Frame", tabWindow)
			local labelText = Instance.new("TextLabel", labelFrame)
			local labelAspect = Instance.new("UIAspectRatioConstraint", labelFrame)
			local labelConstraint = Instance.new("UITextSizeConstraint", labelText)
			local labelLine = Instance.new("Frame", labelFrame)
			local labelLineGradient = Instance.new("UIGradient", labelLine)
			
			-- Set label properties
			labelFrame.Name = "Label"
			labelFrame.BackgroundTransparency = 1
			labelFrame.Size = UDim2.new(1, 0, 0, 41)
			labelFrame.LayoutOrder = tabOrder
			
			labelText.Name = "LabelText"
			labelText.BackgroundTransparency = 1
			labelText.Size = UDim2.new(1, 0, .8, 0)
			labelText.Text = labelName
			labelText.TextScaled = true
			labelText.TextColor3 = Color3.fromRGB(221, 212, 225)
			
			labelLine.Name = "Line"
			labelLine.BackgroundColor3 = Color3.fromRGB(141, 141, 141)
			labelLine.Position = UDim2.new(0, 0, 0.875, 0)
			labelLine.Size = UDim2.new(1, 0, .1, 0)
			
			labelLineGradient.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.2, 0),
				NumberSequenceKeypoint.new(0.8, 0),
				NumberSequenceKeypoint.new(1, 1),
			})
			
			labelAspect.AspectRatio = 12.588
			labelConstraint.MaxTextSize = 42
			labelConstraint.MinTextSize = 1
			
			-- Label functions
			function label:Edit(newText)
				newText = newText or "Label"
				labelText.Text = newText
			end
			
			function label:Remove()
				labelFrame:Destroy()
			end
						
			return label
		end
		
		-- Buttons
		function tab:NewButton(buttonSettings)
			tabOrder += 1
			local button = {}
			
			buttonSettings = buttonSettings or {}
			local buttonName = buttonSettings.Name or "Button"
			local callback = buttonSettings.Callback or function() end
			
			-- Create button instances
			local buttonFrame = Instance.new("Frame", tabWindow)
			local buttonAspect = Instance.new("UIAspectRatioConstraint", buttonFrame)
			local buttonCorner = Instance.new("UICorner", buttonFrame)
			local buttonStroke = Instance.new("UIStroke", buttonFrame)
			local iconImage = Instance.new("ImageLabel", buttonFrame)
			local buttonText = Instance.new("TextLabel", buttonFrame)
			local buttonConstraint = Instance.new("UITextSizeConstraint", buttonText)
			local buttonInstance = Instance.new("TextButton", buttonFrame)
			
			-- Set button properties
			buttonFrame.Name = "Button"
			buttonFrame.BackgroundColor3 = Color3.fromRGB(45, 40, 47)
			buttonFrame.Size = UDim2.new(0.98, 0, 0, 64)
			buttonFrame.LayoutOrder = tabOrder
			
			iconImage.Name = "Icon"
			iconImage.BackgroundTransparency = 1
			iconImage.Position = UDim2.new(0.881, 0,0.107, 0)
			iconImage.Size = UDim2.new(0.08, 0, 0.747, 0)
			iconImage.Image = "rbxassetid://98518382987099"
			iconImage.ImageColor3 = Color3.fromRGB(12, 12, 12)
			
			buttonText.Name = "Title"
			buttonText.BackgroundTransparency = 1
			buttonText.Position = UDim2.new(0.063, 0, 0.038, 0)
			buttonText.Size = UDim2.new(0.798, 0, .969, 0)
			buttonText.Text = buttonName
			buttonText.TextColor3 = Color3.fromRGB(221, 212, 225)
			buttonText.TextScaled = true
			buttonText.TextXAlignment = Enum.TextXAlignment.Left
			
			buttonInstance.Name = "Button"
			buttonInstance.BackgroundTransparency = 1
			buttonInstance.Size = UDim2.new(1, 0, 1, 0)
			buttonInstance.Text = ""
			
			buttonAspect.AspectRatio = 8
			buttonCorner.CornerRadius = UDim.new(0.3, 0)
			buttonStroke.Thickness = 3
			buttonStroke.Color = Color3.fromRGB(33, 33, 33)
			buttonConstraint.MaxTextSize = 14
			buttonConstraint.MinTextSize = 1
			
			-- Button functionality
			buttonInstance.MouseButton1Click:Connect(function()
				pcall(callback)
			end)
			
			-- Button functions
			function button:Edit(newSettings)
				newSettings = newSettings or {}
				if newSettings.Name ~= nil then
					buttonText.Text = newSettings.Name
				end
				
				if newSettings.Callback ~= nil then
					callback = newSettings.Callback
				end
			end
			
			function button:Remove()
				buttonFrame:Destroy()
			end
			
			return button
		end
		
		-- Toggles
		function tab:NewToggle(toggleSettings)
			tabOrder += 1 
			local toggle = {}
			
			toggleSettings = toggleSettings or {}
			local toggleName = toggleSettings.Name or "Toggle"
			local currentState = toggleSettings.Default or false
			local callback = toggleSettings.Callback or function() end
			
			-- Create toggle instances
			local toggleFrame = Instance.new("Frame", tabWindow)
			local toggleAspect = Instance.new("UIAspectRatioConstraint", toggleFrame)
			local toggleCorner = Instance.new("UICorner", toggleFrame)
			local toggleStroke = Instance.new("UIStroke", toggleFrame)
			local toggleBox = Instance.new("Frame", toggleFrame)
			local toggleBoxCorner = Instance.new("UICorner", toggleBox)
			local toggleButton = Instance.new("TextButton", toggleFrame)
			local toggleText = Instance.new("TextLabel", toggleFrame)
			local toggleTextConstraint = Instance.new("UITextSizeConstraint", toggleText)
			
			-- Set toggle properties
			toggleFrame.Name = "Toggle"
			toggleFrame.BackgroundColor3 = Color3.fromRGB(45, 40, 47)
			toggleFrame.Size = UDim2.new(0.98, 0, 0, 64)
			toggleFrame.LayoutOrder = tabOrder
			
			toggleBox.Name = "Box"
			toggleBox.BackgroundColor3 = (currentState == true and Color3.fromRGB(16, 255, 104)) or Color3.fromRGB(255, 17, 88)
			toggleBox.Position = UDim2.new(0.874, 0, 0.1, 0)
			toggleBox.Size = UDim2.new(0.102, 0, 0.814, 0)
			
			toggleText.Name = "Title"
			toggleText.BackgroundTransparency = 1
			toggleText.Position = UDim2.new(0.063, 0, 0.038, 0)
			toggleText.Size = UDim2.new(0.798, 0, .969, 0)
			toggleText.Text = toggleName
			toggleText.TextColor3 = Color3.fromRGB(221, 212, 225)
			toggleText.TextScaled = true
			toggleText.TextXAlignment = Enum.TextXAlignment.Left
			
			toggleButton.Name = "Button"
			toggleButton.BackgroundTransparency = 1
			toggleButton.Size = UDim2.new(1, 0, 1, 0)
			toggleButton.Text = ""
			
			toggleAspect.AspectRatio = 8
			toggleCorner.CornerRadius = UDim.new(0.3, 0)
			toggleStroke.Thickness = 3
			toggleStroke.Color = Color3.fromRGB(33, 33, 33)
			toggleBoxCorner.CornerRadius = UDim.new(0.25, 0)
			toggleTextConstraint.MaxTextSize = 14
			
			-- Toggle functionality
			toggleButton.MouseButton1Click:Connect(function()
				currentState = not currentState
				toggleBox.BackgroundColor3 = (currentState == true and Color3.fromRGB(16, 255, 104)) or Color3.fromRGB(255, 17, 88)

				task.spawn(function()
					pcall(function()
						callback(currentState)
					end)
				end)
			end)
			
			if toggleSettings.Default == true then
				task.spawn(function()
					pcall(function()
						callback(currentState)
					end)
				end)
			end
			
			-- Toggle functions
			function toggle:Edit(newSettings)
				newSettings = newSettings or {}
				
				if newSettings.Name ~= nil then
					toggleText.Text = newSettings.Name
				end
				
				if newSettings.Enabled ~= nil then
					toggleBox.BackgroundColor3 = (currentState == true and Color3.fromRGB(16, 255, 104)) or Color3.fromRGB(255, 17, 88)
					
					task.spawn(function()
						pcall(function()
							callback(currentState)
						end)
					end)
				end
				
				if newSettings.Callback ~= nil then
					callback = newSettings.Callback
				end
			end
			
			function toggle:Remove()
				toggleFrame:Destroy()
			end
			
			return toggle
		end
		
		-- Sliders
		function tab:NewSlider(sliderSettings)
			tabOrder += 1
			local slider = {}
			local sliderDragging = false
			local sliderDragInput
			
			sliderSettings = sliderSettings or {}
			sliderSettings.Name = sliderSettings.Name or "Slider"
			sliderSettings.MinMax = sliderSettings.MinMax or {0, 1}
			sliderSettings.Increment = sliderSettings.Increment or 0.1
			local value = sliderSettings.CurrentValue or 0
			local callback = sliderSettings.Callback or function() end
			local min, max = unpack(sliderSettings.MinMax)
			local value = math.clamp(sliderSettings.CurrentValue or min, min, max)
			local callback = sliderSettings.Callback or function() end
			
			-- Create slider instances
			local sliderFrame = Instance.new("Frame", tabWindow)
			local sliderAspect = Instance.new("UIAspectRatioConstraint", sliderFrame)
			local sliderCorner = Instance.new("UICorner", sliderFrame)
			local sliderStroke = Instance.new("UIStroke", sliderFrame)
			local sliderBar = Instance.new("Frame", sliderFrame)
			local sliderCircle = Instance.new("Frame", sliderBar)
			local sliderCircleCorner = Instance.new("UICorner", sliderCircle)
			local sliderDisplay = Instance.new("Frame", sliderFrame)
			local sliderDisplayCorner = Instance.new("UICorner", sliderDisplay)
			local sliderDisplayStroke = Instance.new("UIStroke", sliderDisplay)
			local sliderDisplayText = Instance.new("TextLabel", sliderDisplay)
			local sliderDisplayTextConstraint = Instance.new("UITextSizeConstraint", sliderDisplayText)
			local sliderText = Instance.new("TextLabel", sliderFrame)
			local sliderTextConstraint = Instance.new("UITextSizeConstraint", sliderText)
			local sliderBox = Instance.new("Frame", sliderFrame)
			
			-- Set slider properties
			sliderFrame.Name = "Slider"
			sliderFrame.BackgroundColor3 = Color3.fromRGB(45, 40, 47)
			sliderFrame.Size = UDim2.new(0.975, 0, 0.155, 0)
			sliderFrame.LayoutOrder = tabOrder
			
			sliderBar.Name = "Bar"
			sliderBar.BackgroundColor3 = Color3.fromRGB(104, 100, 109)
			sliderBar.Position = UDim2.new(0.54, 0, 0.48, 0)
			sliderBar.Size = UDim2.new(0.3, 0, 0.081, 0)
			
			sliderCircle.Name = "Circle"
			sliderCircle.BackgroundColor3 = Color3.fromRGB(77, 73, 79)
			sliderCircle.Position = UDim2.new(0, 0, -1.688, 0)
			sliderCircle.Size = UDim2.new(0.129, 0, 4, 0)
			
			sliderDisplay.Name = "Display"
			sliderDisplay.BackgroundColor3 = Color3.fromRGB(62, 59, 63)
			sliderDisplay.Position = UDim2.new(0.88, 0, 0.135, 0)
			sliderDisplay.Size = UDim2.new(0.085, 0, 0.679, 0)
			
			sliderDisplayText.Name = "DisplayText"
			sliderDisplayText.BackgroundTransparency = 1
			sliderDisplayText.Size = UDim2.new(1,0,1,0)
			sliderDisplayText.TextColor3 = Color3.fromRGB(150, 150, 150)
			sliderDisplayText.TextScaled = true
			sliderDisplayText.Text = tostring(value)
			
			sliderText.Name = "Title"
			sliderText.BackgroundTransparency = 1
			sliderText.Position = UDim2.new(0.063, 0, 0.038, 0)
			sliderText.Size = UDim2.new(0.457, 0, 0.969, 0)
			sliderText.TextColor3 = Color3.fromRGB(221, 212, 225)
			sliderText.TextScaled = true
			sliderText.TextXAlignment = Enum.TextXAlignment.Left
			sliderText.Text = sliderSettings.Name
			
			sliderBox.Name = "BarBox"
			sliderBox.BackgroundTransparency = 1
			sliderBox.Position = UDim2.new(0.54, 0, 0.25, 0)
			sliderBox.Size = UDim2.new(0.316, 0, 0.5, 0)
			
			sliderAspect.AspectRatio = 8
			sliderCorner.CornerRadius = UDim.new(0.3, 0)
			sliderStroke.Color = Color3.fromRGB(33, 33, 33)
			sliderStroke.Thickness = 3
			sliderCircleCorner.CornerRadius = UDim.new(1, 0)
			sliderDisplayCorner.CornerRadius = UDim.new(0.25, 0)
			sliderDisplayStroke.Color = Color3.fromRGB(38, 37, 39)
			sliderDisplayTextConstraint.MaxTextSize = 26
			sliderTextConstraint.MaxTextSize = 14
			
			-- Slider functionality
			local function sliderUpdate(input)
				local sliderBarAbsPos = sliderBar.AbsolutePosition
				local sliderBarAbsSize = sliderBar.AbsoluteSize
				local normalizedValue = math.clamp((input.Position.X - sliderBarAbsPos.X) / sliderBarAbsSize.X, 0, 1)
				value = math.clamp(min + normalizedValue * (max - min), min, max)
				value = math.round(value / sliderSettings.Increment) * sliderSettings.Increment
				sliderCircle.Position = UDim2.new(normalizedValue - 0.05, 0, -1.688, 0)
				sliderDisplayText.Text = tostring(math.floor(value*100)/100)

				pcall(callback, value)
			end
			
			sliderBox.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					sliderDragging = true
					sliderUpdate(input)
				end
			end)

			sliderBox.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					sliderDragging = false
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if sliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					sliderUpdate(input)
				end
			end)
			
			-- Slider functions
			function slider:Edit(newSettings)
				newSettings = newSettings or {}
				
				sliderSettings.MinMax = newSettings.MinMax or sliderSettings.MinMax
				sliderSettings.Increment = newSettings.Increment or sliderSettings.Increment
				value = newSettings.CurrentValue or value
				callback = newSettings.Callback or callback
				
				if newSettings.Name ~= nil then
					sliderText.Text = newSettings.Name
				end
				
				if newSettings.CurrentValue ~= nil then
					sliderDisplayText.Text = tostring(math.floor(value*100)/100)
				end
				
				min, max = unpack(sliderSettings.MinMax)
			end
			
			function slider:Remove()
				sliderFrame:Destroy()
			end
			
			return slider
		end
		
		return tab
	end
	
	-- Store and return the window
	table.insert(library.Windows, window)
	return window
end


return library
