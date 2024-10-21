local CX = game:GetService("ContentProvider")
local isComingFromExecutor = checkcaller()
local PreloadAsync = CX.PreloadAsync

local ErrorScript = game:GetService("ReplicatedFirst"):FindFirstChild("LocalScript")

if ErrorScript then
    ErrorScript:Destroy()
end

local Old;



getgenv().Title = "Trenz.cc | Free FF2 Script"

if not LPH_OBFUSCATED then
	LPH_JIT_MAX = function(...) return(...) end;
	LPH_NO_VIRTUALIZE = function(...) return(...) end;
end

local utility = {}
local UIS = game:GetService("UserInputService");
local RS = game:GetService("RunService");
local TS = game:GetService("TweenService");
local mouse = game:GetService('Players').LocalPlayer:GetMouse()

local Library = {}
local UiColorTheme = Color3.fromRGB(19, 204, 139)
local mainKeybind = "RightAlt"
local canDrag = true

function utility:ToRGB(color)  
	return color.R*255,color.G*255,color.B*255
end

local savefile = {}

local function CreateDrag(gui)
	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		TS:Create(gui, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play();
	end

	local lastEnd = 0
	local lastMoved = 0
	local con
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if not canDrag then return end
			dragging = true
			dragStart = input.Position
			startPos = gui.Position

		end
	end)

	UIS.InputEnded:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)


	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
			lastMoved = os.clock()
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end


local tweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local tweenInfo2 = TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
function Library:tween(object, goal, callback)
	local tween = TS:Create(object, tweenInfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

function Library:tween2(object, goal, callback)
	local tween = TS:Create(object, tweenInfo2, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

-- // Initialize Main UI

local flags = {}
local savedFlags = {}
local flagtoggle = {}

local KindaHot = Instance.new('ScreenGui', gethui())

function Library:Init(options)

	local GUI = {
		CurrentTab = nil
	}


	local Main = Instance.new('Frame', KindaHot)
	local TopNar = Instance.new('Frame', Main)
	local TopCorner = Instance.new('UICorner', TopNar)
	local Title = Instance.new('TextLabel', TopNar)
	local MainCorner = Instance.new('UICorner', Main)
	local SideBar = Instance.new('Frame', Main)
	local SiderBarCorner = Instance.new('UICorner', SideBar)
	local TabScrollbar = Instance.new('ScrollingFrame', SideBar)
	local UIListLayout = Instance.new('UIListLayout', TabScrollbar)
	local UIPadding = Instance.new('UIPadding', TabScrollbar)

	KindaHot.Name = "KindaHot"
	KindaHot.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Main.Name = "Main"
	Main.Position = UDim2.new(0.3208,0,0.2481,0)
	Main.Size = UDim2.new(0,599,0,490)
	Main.BackgroundColor3 = Color3.new(0.0706,0.0706,0.0706)
	Main.BorderSizePixel = 0
	Main.BorderColor3 = Color3.new(0,0,0)
	Main.ZIndex = 100
	TopNar.Name = "TopNar"
	TopNar.Size = UDim2.new(0,599,0,39)
	TopNar.BackgroundColor3 = Color3.new(0.1373,0.1373,0.1373)
	TopNar.BorderSizePixel = 0
	TopNar.BorderColor3 = Color3.new(0,0,0)
	TopNar.ZIndex = 107
	TopCorner.CornerRadius = UDim.new(0,6)
	Title.Name = "asdfasdf"
	Title.Size = UDim2.new(0,167,0,39)
	Title.BackgroundColor3 = Color3.new(1,1,1)
	Title.BackgroundTransparency = 1
	Title.BorderSizePixel = 0
	Title.BorderColor3 = Color3.new(0,0,0)
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 15
    Title.Text = getgenv().Title
	Title.Visible = true
	Title.ZIndex = 108
	MainCorner.CornerRadius = UDim.new(0,6)
	SideBar.Name = "SideBar"
	SideBar.Position = UDim2.new(0,0,0.0673,0)
	SideBar.Size = UDim2.new(0,167,0,457)
	SideBar.BackgroundColor3 = Color3.new(0.1059,0.1059,0.1059)
	SideBar.BorderSizePixel = 0
	SideBar.BorderColor3 = Color3.new(0,0,0)
	SideBar.ZIndex = 105
	SiderBarCorner.CornerRadius = UDim.new(0,6)
	TabScrollbar.Name = "TabScrollbar"
	TabScrollbar.Position = UDim2.new(0,0,0.0131,0)
	TabScrollbar.Size = UDim2.new(0,167,0,451)
	TabScrollbar.BackgroundColor3 = Color3.new(1,1,1)
	TabScrollbar.BackgroundTransparency = 1
	TabScrollbar.BorderSizePixel = 0
	TabScrollbar.BorderColor3 = Color3.new(0,0,0)
	TabScrollbar.ZIndex = 110
	TabScrollbar.ScrollBarThickness = 0
	TabScrollbar.ScrollBarImageColor3 = Color3.new(0,0,0)
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0,5)
	UIPadding.PaddingTop = UDim.new(0,5)

	CreateDrag(Main)

	function Library:Toggle()
		KindaHot.Enabled = not KindaHot.Enabled
	end

	UIS.InputBegan:Connect(function(key, gp)
		if gp then return end;

		if key.KeyCode == Enum.KeyCode[mainKeybind] then
			Library:Toggle()
		end
	end)

	function GUI:NewTab(options)
		local tab = {
			Hover = false,
			Active = false
		}

		local Tab = Instance.new('Frame', TabScrollbar)
		local TextLabel = Instance.new('TextButton', Tab)
		local Frame = Instance.new('Frame', Tab)
		local Canvas = Instance.new(options.chat and 'Frame' or 'ScrollingFrame', Main)
		local CanvasLayout = Instance.new('UIListLayout', Canvas)
		local CanvasPad = Instance.new('UIPadding', Canvas)

		Canvas.Name = "Canvas"
		Canvas.Position = UDim2.new(0.2788,0,0.0796,0)
		Canvas.Size = UDim2.new(0,432,0,451)
		Canvas.BackgroundColor3 = Color3.new(1,1,1)
		Canvas.BackgroundTransparency = 1
		Canvas.BorderSizePixel = 0
		Canvas.BorderColor3 = Color3.new(0,0,0)
		Canvas.ZIndex = 110
		--Canvas.ScrollBarThickness = 0
		--Canvas.ScrollBarImageColor3 = Color3.new(0,0,0)
		CanvasLayout.Name = "CanvasLayout"
		CanvasLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		CanvasLayout.SortOrder = Enum.SortOrder.LayoutOrder
		CanvasLayout.Padding = UDim.new(0,5)
		CanvasPad.Name = "CanvasPad"
		CanvasPad.PaddingTop = UDim.new(0,5)
		CanvasPad.PaddingBottom = UDim.new(0,5)

		Tab.Name = "Tab"
		Tab.Position = UDim2.new(0.0329,0,0,0)
		Tab.Size = UDim2.new(0,149,0,30)
		Tab.BackgroundColor3 = Color3.new(0.1059,0.1059,0.1059)
		Tab.BorderSizePixel = 0
		Tab.BorderColor3 = Color3.new(0,0,0)
		Tab.ZIndex = 111
		TextLabel.Position = UDim2.new(0.0479,0,0,0)
		TextLabel.Size = UDim2.new(0,159,0,30)
		TextLabel.BackgroundColor3 = Color3.new(1,1,1)
		TextLabel.BackgroundTransparency = 1
		TextLabel.BorderSizePixel = 0
		TextLabel.BorderColor3 = Color3.new(0,0,0)
		TextLabel.Text = options.name
		TextLabel.TextColor3 = Color3.new(1,1,1)
		TextLabel.Font = Enum.Font.Gotham
		TextLabel.TextSize = 14
		TextLabel.ZIndex = 112
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		Frame.Position = UDim2.new(1,0,0,0)
		Frame.Size = UDim2.new(0,2,0,30)
		Frame.BackgroundColor3 = UiColorTheme
		Frame.BackgroundTransparency = 1
		Frame.BorderSizePixel = 0
		Frame.BorderColor3 = Color3.new(0,0,0)
		Frame.Visible = true
		Frame.ZIndex = 113
		Canvas.Visible = false

		if Canvas:IsA("ScrollingFrame") then
			Canvas.ScrollBarThickness = 0
			Canvas.ScrollBarImageColor3 = Color3.new(0,0,0)
			Canvas.AutomaticCanvasSize = Enum.AutomaticSize.Y;
		end

		function tab:Activate()
			if not tab.Active then
				if GUI.CurrentTab ~= nil then
					GUI.CurrentTab:Deactivate()
				end
				tab.Active = true
				Library:tween2(Frame, {BackgroundTransparency = 0})
				Library:tween2(Tab, {BackgroundColor3 = Color3.new(0.1333,0.1333,0.1333)})
				Canvas.Visible = true
				GUI.CurrentTab = tab
			end
		end

		function tab:Deactivate()
			if tab.Active then
				tab.Active = false
				tab.Hover = false
				Library:tween2(Frame, {BackgroundTransparency = 1})
				Canvas.Visible = false
				Library:tween2(Tab, {BackgroundColor3 = Color3.new(0.1059,0.1059,0.1059)})
			end
		end

		--[[Tab.MouseEnter:Connect(function()
			tab.Hover = true
			canDrag = false
		end)

		Tab.MouseLeave:Connect(function()
			tab.Hover = false
			canDrag = true
		end)]]

		TextLabel.MouseButton1Click:Connect(function()
			tab:Activate()
		end)

		--[[UIS.InputBegan:Connect(function(input, gpe)
			if gpe then return end

			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				if tab.Hover then
					tab:Activate()
				end
			end
		end)]]

		if GUI.CurrentTab == nil then
			tab.Activate()	
		end


		-- // Toggle

		function tab:Toggle(options)

			local toggle = {
				Hover = false,
				MouseDown = false,
				State = false,
				BindHover = false,
				Bind = nil,
			}

			local Toggle = Instance.new('Frame', Canvas)
			local ToggleTitle = Instance.new('TextButton', Toggle)
			local ToggleCorner = Instance.new('UICorner', Toggle)
			local ToggleBox = Instance.new('Frame', Toggle)
			local ToggleBoxCorner = Instance.new('UICorner', ToggleBox)
			local ToggleBind = Instance.new('TextButton', Toggle)

			Toggle.Name = "Toggle"
			Toggle.Position = UDim2.new(0.2988,0,0.5061,0)
			Toggle.Size = UDim2.new(0,408,0,30)
			Toggle.BackgroundColor3 = Color3.new(0.1059,0.1059,0.1059)
			Toggle.BorderSizePixel = 0
			Toggle.BorderColor3 = Color3.new(0,0,0)
			Toggle.ZIndex = 111
			ToggleTitle.Name = "ToggleTitle"
			ToggleTitle.Position = UDim2.new(0.027,0,0,0)
			ToggleTitle.Size = UDim2.new(0,397,0,30)
			ToggleTitle.BackgroundColor3 = Color3.new(1,1,1)
			ToggleTitle.BackgroundTransparency = 1
			ToggleTitle.BorderSizePixel = 0
			ToggleTitle.BorderColor3 = Color3.new(0,0,0)
			ToggleTitle.Text = options.name
			ToggleTitle.TextColor3 = Color3.new(1,1,1)
			ToggleTitle.Font = Enum.Font.Gotham
			ToggleTitle.TextSize = 13
			ToggleTitle.ZIndex = 112
			ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
			ToggleCorner.CornerRadius = UDim.new(0,6)
			ToggleBox.Name = "ToggleBox"
			ToggleBox.Position = UDim2.new(0.9191,0,0.1667,0)
			ToggleBox.Size = UDim2.new(0,20,0,20)
			ToggleBox.BackgroundColor3 = Color3.new(0.0706,0.0706,0.0706)
			ToggleBox.BorderSizePixel = 0
			ToggleBox.BorderColor3 = Color3.new(0,0,0)
			ToggleBox.ZIndex = 114
			ToggleBoxCorner.CornerRadius = UDim.new(0,5)
			ToggleBind.Name = options["name"]
			ToggleBind.Position = UDim2.new(0.6838,0,0,0)
			ToggleBind.Size = UDim2.new(0,83,0,30)
			ToggleBind.BackgroundColor3 = Color3.new(1,1,1)
			ToggleBind.BackgroundTransparency = 1
			ToggleBind.BorderSizePixel = 0
			ToggleBind.BorderColor3 = Color3.new(0,0,0)
			ToggleBind.Text = "bind"
			ToggleBind.TextColor3 = Color3.new(1,1,1)
			ToggleBind.Font = Enum.Font.Gotham
			ToggleBind.TextSize = 10
			ToggleBind.ZIndex = 112
			ToggleBind.TextXAlignment = Enum.TextXAlignment.Right

			table.insert(flagtoggle, toggle)
			table.insert(flags, options)

			toggle.State = options.default

			options.callback(toggle.State)

			if toggle.State then
				Library:tween(ToggleBox, {BackgroundColor3 = UiColorTheme})
			else
				Library:tween(ToggleBox, {BackgroundColor3 = Color3.fromRGB(18, 18, 18)})
			end

			function toggle:Toggle(boolean)
				if boolean == nil then
					toggle.State = not toggle.State
				else
					toggle.State = boolean
				end

				if toggle.State then
					Library:tween(ToggleBox, {BackgroundColor3 = UiColorTheme})
				else
					Library:tween(ToggleBox, {BackgroundColor3 = Color3.fromRGB(18, 18, 18)})
				end

				options.callback(toggle.State)
			end

			ToggleTitle.MouseButton1Down:Connect(function()
				toggle:Toggle()
			end)

			ToggleBind.MouseButton1Down:Connect(function()
				ToggleBind.Text = "..."

				if oldCon then
					oldCon:Disconnect()
				end

				oldCon = UIS.InputBegan:Connect(function(input, gp)
					if gp then return end;
					if input.UserInputType then
						ToggleBind.TextColor3 = Color3.fromRGB(197, 197, 197)
						ToggleBind.Text = "Bind : "..tostring(input.UserInputType):gsub("Enum.UserInputType.", "");
						toggle.Bind = input.UserInputType
						oldCon:Disconnect()
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
							return
						end
					end
					if input.KeyCode and input.KeyCode ~= Enum.KeyCode.Backspace then
						ToggleBind.Text = "Bind: "..tostring(input.KeyCode):gsub("Enum.KeyCode.", "");
						ToggleBind.TextColor3 = Color3.fromRGB(197, 197, 197)
						toggle.Bind = input.KeyCode
						oldCon:Disconnect()
					elseif input.KeyCode and input.KeyCode == Enum.KeyCode.Backspace then
						ToggleBind.Text = "Bind"
						toggle.Bind = nil
						oldCon:Disconnect()
					end
				end)
			end)

			UIS.InputBegan:Connect(function(input, gpe)
				if gpe then return end

				if input.UserInputType == Enum.UserInputType.MouseButton1 and toggle.Hover then
					--
				elseif input.KeyCode == toggle.Bind then
					toggle:Toggle()
				elseif input.UserInputType == toggle.Bind then
					toggle:Toggle()
				end
			end)

			UIS.InputEnded:Connect(function(input, gpe)
				if gpe then return end

				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					toggle.MouseDown = false
				end
			end)

			return toggle
		end

		function tab:Button(options)

			local button = {
				Hover = false,
				MouseDown = false
			}

			local Button = Instance.new('Frame', Canvas)
			local ButtonText = Instance.new('TextButton', Button)
			local ButtonCorner = Instance.new('UICorner', Button)

			Button.Name = "Button"
			Button.Position = UDim2.new(0.3339,0,0.6878,0)
			Button.Size = UDim2.new(0,408,0,30)
			Button.BackgroundColor3 = Color3.new(0.1059,0.1059,0.1059)
			Button.BorderSizePixel = 0
			Button.BorderColor3 = Color3.new(0,0,0)
			Button.ZIndex = 111
			ButtonText.Name = "Button"
			ButtonText.Position = UDim2.new(0.0009,0,0,0)
			ButtonText.Size = UDim2.new(0,405,0,30)
			ButtonText.BackgroundColor3 = Color3.new(1,1,1)
			ButtonText.BackgroundTransparency = 1
			ButtonText.BorderSizePixel = 0
			ButtonText.BorderColor3 = Color3.new(0,0,0)
			ButtonText.Text = options["name"]
			ButtonText.TextColor3 = Color3.new(1,1,1)
			ButtonText.Font = Enum.Font.Gotham
			ButtonText.TextSize = 13
			ButtonText.ZIndex = 112
			ButtonCorner.CornerRadius = UDim.new(0,6)

			ButtonText.MouseButton1Down:Connect(function()
				Library:tween(Button, {BackgroundColor3 = Color3.fromRGB(77, 77, 77)})
			end)

			ButtonText.MouseButton1Up:Connect(function()
				Library:tween(Button, {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
			end)

			ButtonText.MouseButton1Click:Connect(function()
				options.callback()
			end)


			return button
		end
		
		function tab:TextBox(options)
			local TextBox = Instance.new('Frame', Canvas)
			local TextBoxTitle = Instance.new('TextLabel', TextBox)
			local TextBoxCorner = Instance.new('UICorner', TextBox)
			local TextBack = Instance.new('Frame', TextBox)
			local ToggleBoxCorner = Instance.new('UICorner', TextBack)
			local TextInput = Instance.new('TextBox', TextBack)
			

			TextBox.Name = "TextBox"
			TextBox.Position = UDim2.new(0.7896,0,0.6714,0)
			TextBox.Size = UDim2.new(0,408,0,30)
			TextBox.BackgroundColor3 = Color3.new(0.1059,0.1059,0.1059)
			TextBox.BorderSizePixel = 0
			TextBox.BorderColor3 = Color3.new(0,0,0)
			TextBox.ZIndex = 111
			TextBoxTitle.Name = "TextBoxTitle"
			TextBoxTitle.Position = UDim2.new(0.027,0,0,0)
			TextBoxTitle.Size = UDim2.new(0,274,0,30)
			TextBoxTitle.BackgroundColor3 = Color3.new(1,1,1)
			TextBoxTitle.BackgroundTransparency = 1
			TextBoxTitle.BorderSizePixel = 0
			TextBoxTitle.BorderColor3 = Color3.new(0,0,0)
			TextBoxTitle.Text = options.name or "TextBox"
			TextBoxTitle.TextColor3 = Color3.new(1,1,1)
			TextBoxTitle.Font = Enum.Font.Gotham
			TextBoxTitle.TextSize = 13
			TextBoxTitle.ZIndex = 112
			TextBoxTitle.TextXAlignment = Enum.TextXAlignment.Left
			TextBoxCorner.CornerRadius = UDim.new(0,6)
			TextBack.Name = "TextBack"
			TextBack.Position = UDim2.new(0.701,0,0.1667,0)
			TextBack.Size = UDim2.new(0,108,0,20)
			TextBack.BackgroundColor3 = Color3.new(0.0706,0.0706,0.0706)
			TextBack.BorderSizePixel = 0
			TextBack.BorderColor3 = Color3.new(0,0,0)
			TextBack.ZIndex = 114
			ToggleBoxCorner.CornerRadius = UDim.new(0,5)
			TextInput.Name = "TextInput"
			TextInput.Size = UDim2.new(0,108,0,20)
			TextInput.BackgroundColor3 = Color3.new(1,1,1)
			TextInput.BackgroundTransparency = 1
			TextInput.BorderSizePixel = 0
			TextInput.BorderColor3 = Color3.new(0,0,0)
			TextInput.Text = ""
			TextInput.TextColor3 = Color3.new(0.698,0.698,0.698)
			TextInput.Font = Enum.Font.Gotham
			TextInput.TextSize = 11
			TextInput.ZIndex = 120
			TextInput.PlaceholderText = "Enter"
			
			TextInput.FocusLost:Connect(function()
				options.callback(TextInput.Text)
				TextInput.Text = ""
			end)
			
		end

		function tab:Dropdown(options)

			local dropdown = {
				value = nil
			}

			if not options.default then
				options.default = options.option1
			end

			local DropDown = Instance.new('Frame', Canvas)
			local DropDownText = Instance.new('TextButton', DropDown)
			local DpdwnCorner = Instance.new('UICorner', DropDown)
			local DropDownHolder = Instance.new('ScrollingFrame', DropDown)
			local DropDownLayout = Instance.new('UIListLayout', DropDownHolder)
			local DropDownPad = Instance.new('UIPadding', DropDownHolder)
			local DropDownArrow = Instance.new('ImageLabel', DropDown)

			--Properties

			DropDown.Name = "DropDown"
			DropDown.Position = UDim2.new(0.0278,0,0.3543,0)
			DropDown.Size = UDim2.new(0,408,0,30)
			DropDown.BackgroundColor3 = Color3.new(0.1059,0.1059,0.1059)
			DropDown.BorderSizePixel = 0
			DropDown.BorderColor3 = Color3.new(0,0,0)
			DropDown.AutomaticSize = Enum.AutomaticSize.Y
			DropDown.ZIndex = 111

			DropDownText.Name = "DropDownText"
			DropDownText.Position = UDim2.new(0.027,0,0,0)
			DropDownText.Size = UDim2.new(0,344,0,30)
			DropDownText.BackgroundColor3 = Color3.new(1,1,1)
			DropDownText.BackgroundTransparency = 1
			DropDownText.BorderSizePixel = 0
			DropDownText.BorderColor3 = Color3.new(0,0,0)
			DropDownText.Text = options.name.." : "..'<font color="#AAAAAA">'..options.default.."</font>"
			DropDownText.TextColor3 = Color3.new(1,1,1)
			DropDownText.Font = Enum.Font.Gotham
			DropDownText.TextSize = 13
			DropDownText.ZIndex = 112
			DropDownText.RichText = true
			DropDownText.TextXAlignment = Enum.TextXAlignment.Left

			DpdwnCorner.CornerRadius = UDim.new(0,6)

			DropDownHolder.Name = "DropDownHolder"
			DropDownHolder.Position = UDim2.new(-0,0,0.3714,0)
			DropDownHolder.Size = UDim2.new(0,407,0,44)
			DropDownHolder.BackgroundColor3 = Color3.new(1,1,1)
			DropDownHolder.BackgroundTransparency = 1
			DropDownHolder.BorderSizePixel = 0
			DropDownHolder.BorderColor3 = Color3.new(0,0,0)
			DropDownHolder.Visible = false
			DropDownHolder.AutomaticSize = Enum.AutomaticSize.Y
			DropDownHolder.ZIndex = 112
			DropDownHolder.ScrollBarThickness = 0
			DropDownHolder.ScrollBarImageColor3 = Color3.new(0,0,0)

			DropDownLayout.Name = "DropDownLayout"
			DropDownLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			DropDownLayout.SortOrder = Enum.SortOrder.LayoutOrder
			DropDownLayout.Padding = UDim.new(0,5)

			DropDownPad.Name = "DropDownPad"
			DropDownPad.PaddingBottom = UDim.new(0,10)
			DropDownPad.PaddingTop = UDim.new(0,15)

			DropDownArrow.Name = "DropDownArrow"
			DropDownArrow.Position = UDim2.new(0.9118,0,0.0667,0)
			DropDownArrow.Size = UDim2.new(0,26,0,26)
			DropDownArrow.BackgroundColor3 = Color3.new(1,1,1)
			DropDownArrow.BackgroundTransparency = 1
			DropDownArrow.BorderSizePixel = 0
			DropDownArrow.BorderColor3 = Color3.new(0,0,0)
			DropDownArrow.Rotation = 90
			--DropDownArrow.Image = "rbxassetid://11552476728"
			DropDownArrow.ZIndex = 113

			DropDownText.MouseButton1Down:Connect(function()
				DropDownHolder.Visible = not DropDownHolder.Visible
				if DropDownHolder.Visible then
					Library:tween(DropDownArrow, {Rotation = 0})
					task.spawn(function()
						wait(.1)
						for i, v in pairs(DropDownHolder:GetChildren()) do
							pcall(function()
								Library:tween(v, {BackgroundTransparency = 0})
								Library:tween(v.OptionText, {TextTransparency = 0})
							end)
						end
					end)
				else
					for i, v in pairs(DropDownHolder:GetChildren()) do
						pcall(function()
							Library:tween(v, {BackgroundTransparency = 1})
							Library:tween(v.OptionText, {TextTransparency = 1})
						end)
					end
					Library:tween(DropDownArrow, {Rotation = 90})
				end
			end)

			options.callback(options.default)

			for i, v in pairs(options) do
				if i ~= "name" and i ~= "callback" and i ~= "default" then
					local DropDownOption = Instance.new('Frame', DropDownHolder)
					local DropDownCorner = Instance.new('UICorner', DropDownOption)
					local OptionText = Instance.new('TextButton', DropDownOption)
					DropDownOption.Name = "DropDownOption"
					DropDownOption.Position = UDim2.new(-0.1593,0,0.4675,0)
					DropDownOption.Size = UDim2.new(0,384,0,25)
					DropDownOption.BackgroundColor3 = Color3.new(0.0706,0.0706,0.0706)
					DropDownOption.BorderSizePixel = 0
					DropDownOption.BorderColor3 = Color3.new(0,0,0)
					DropDownOption.ZIndex = 114

					DropDownCorner.CornerRadius = UDim.new(0,4)

					OptionText.Name = "OptionText"
					OptionText.Position = UDim2.new(0.027,0,0,0)
					OptionText.Size = UDim2.new(0,373,0,25)
					OptionText.BackgroundColor3 = Color3.new(1,1,1)
					OptionText.BackgroundTransparency = 1
					OptionText.TextTransparency = 1
					OptionText.BorderSizePixel = 0
					OptionText.BorderColor3 = Color3.new(0,0,0)
					OptionText.Text = tostring(v)
					OptionText.TextColor3 = Color3.new(1,1,1)
					OptionText.Font = Enum.Font.Gotham
					OptionText.TextSize = 12
					OptionText.ZIndex = 112


					OptionText.MouseButton1Down:Connect(function()
						for i, v in pairs(DropDownHolder:GetChildren()) do
							pcall(function()
								Library:tween(v, {BackgroundTransparency = 1})
								Library:tween(v.OptionText, {TextTransparency = 1})
							end)
						end
						DropDownHolder.Visible = not DropDownHolder.Visible
						options.value = OptionText.Text
						options.callback(options.value)
						DropDownText.Text = options.name.." : "..'<font color="#AAAAAA">'..options.value.."</font>"
						Library:tween(DropDownArrow, {Rotation = 90})
					end)
				end
			end


			return dropdown
		end

		function tab:Slider(options)

			local slider = {
				hover = false,
				MouseDown = false,
				connections = {},
				val = options.default
			}

			local Slider = Instance.new('ImageButton', Canvas)
			local SliderText = Instance.new('TextLabel', Slider)
			local SliderCorner = Instance.new('UICorner', Slider)
			local SliderBack = Instance.new('Frame', Slider)
			local SliderMain = Instance.new('Frame', SliderBack)
			local SliderMainCorner = Instance.new('UICorner', SliderMain)
			local SliderBackCorner = Instance.new('UICorner', SliderBack)
			local SliderAmt = Instance.new('TextBox', Slider)

			Slider.Name = "Slider"
			Slider.Position = UDim2.new(0.2988,0,0.5041,0)
			Slider.Size = UDim2.new(0,408,0,47)
			Slider.BackgroundColor3 = Color3.new(0.1059,0.1059,0.1059)
			Slider.BorderSizePixel = 0
			Slider.AutoButtonColor = false
			Slider.BorderColor3 = Color3.new(0,0,0)
			Slider.ZIndex = 111
			SliderText.Name = "SliderText"
			SliderText.Position = UDim2.new(0.027,0,0,0)
			SliderText.Size = UDim2.new(0,331,0,32)
			SliderText.BackgroundColor3 = Color3.new(1,1,1)
			SliderText.BackgroundTransparency = 1
			SliderText.BorderSizePixel = 0
			SliderText.BorderColor3 = Color3.new(0,0,0)
			SliderText.Text = options["name"]
			SliderText.TextColor3 = Color3.new(1,1,1)
			SliderText.Font = Enum.Font.Gotham
			SliderText.TextSize = 13
			SliderText.ZIndex = 112
			SliderText.TextXAlignment = Enum.TextXAlignment.Left
			SliderCorner.CornerRadius = UDim.new(0,6)
			SliderBack.Name = "SliderBack"
			SliderBack.Position = UDim2.new(0.027,0,0.6809,0)
			SliderBack.Size = UDim2.new(0,384,0,5)
			SliderBack.BackgroundColor3 = Color3.new(0.0706,0.0706,0.0706)
			SliderBack.BorderSizePixel = 0
			SliderBack.BorderColor3 = Color3.new(0,0,0)
			SliderBack.ZIndex = 114
			SliderMain.Name = "SliderMain"
			SliderMain.Position = UDim2.new(0.0009,0,0,0)
			SliderMain.Size = UDim2.new(0,308,0,5)
			SliderMain.BackgroundColor3 = UiColorTheme
			SliderMain.BorderSizePixel = 0
			SliderMain.BorderColor3 = Color3.new(0,0,0)
			SliderMain.ZIndex = 114
			SliderAmt.Name = "SliderAmt"
			SliderAmt.Position = UDim2.new(0.8382,0,0,0)
			SliderAmt.Size = UDim2.new(0,53,0,32)
			SliderAmt.BackgroundColor3 = Color3.new(1,1,1)
			SliderAmt.BackgroundTransparency = 1
			SliderAmt.BorderSizePixel = 0
			SliderAmt.BorderColor3 = Color3.new(0,0,0)
			SliderAmt.Text = "0"
			SliderAmt.TextColor3 = Color3.new(1,1,1)
			SliderAmt.Font = Enum.Font.Gotham
			SliderAmt.TextSize = 13
			SliderAmt.ZIndex = 112
			SliderAmt.TextXAlignment = Enum.TextXAlignment.Right

			table.insert(flagtoggle, slider)
			table.insert(flags, options)

			function slider:SetValue(v)
				if v == nil then
					local percentage = math.clamp((mouse.X - SliderBack.AbsolutePosition.X) / (SliderBack.AbsoluteSize.X), 0, 1)
					local value = ((options.max - options.min) * percentage) + options.min
					SliderAmt.Text = string.format("%.2f", value)
					SliderMain.Size = UDim2.fromScale(percentage, 1)
				else
					SliderAmt.Text = tostring(v)
					SliderMain.Size = UDim2.fromScale(((v - options.min) / (options.max - options.min)), 1)
				end
				options.callback(slider:GetValue())
			end

			function slider:GetValue()
				return tonumber(SliderAmt.Text)
			end

			slider:SetValue(options.default)

			Slider.MouseEnter:Connect(function()
				slider.Hover = true
				canDrag = false
			end)

			Slider.MouseLeave:Connect(function()
				slider.Hover = false
				canDrag = true
			end)

			SliderAmt.FocusLost:Connect(function()
				local toNum
				pcall(function()
					toNum = tonumber(SliderAmt.Text)
				end)
				if toNum then
					toNum = math.clamp(toNum, options.min, options.max)
					slider:SetValue(toNum)
				else
					SliderAmt.Text = "only number :<"
				end
			end)

			local Connection;
			table.insert(slider.connections, UIS.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					pcall(function()
						Connection:Disconnect();
						Connection = nil;
					end)
				end
			end))

			--LPH_NO_VIRTUALIZE(function()
			table.insert(slider.connections, Slider.MouseButton1Down:Connect(function()
				if(Connection) then
					Connection:Disconnect();
				end;

				Connection = RS.Heartbeat:Connect(function()
					--options.callback()
					--if slider.Hover then
					slider:SetValue()
					slider.val = slider:GetValue()
					--end
				end)
			end))
			--end)()

			return slider
		end

		function tab:NewSection(options)
			local Section = Instance.new('TextLabel', Canvas)

			Section.Name = "Section"
			Section.Position = UDim2.new(0.0278,0,0,0)
			Section.Size = UDim2.new(0,408,0,24)
			Section.BackgroundColor3 = Color3.new(1,1,1)
			Section.BackgroundTransparency = 1
			Section.BorderSizePixel = 0
			Section.BorderColor3 = Color3.new(0,0,0)
			Section.Text = options.name
			Section.TextColor3 = Color3.new(1,1,1)
			Section.Font = Enum.Font.Gotham
			Section.TextSize = 13
			Section.ZIndex = 112
			Section.TextXAlignment = Enum.TextXAlignment.Left
		end

		function tab:Colorpicker(options)
			local colorpicker = {}

			local ColorPickerPopout = Instance.new('Frame', Main)
			local hUESelection = Instance.new('ImageLabel', ColorPickerPopout)
			local sVSelection = Instance.new('ImageLabel', ColorPickerPopout)
			local PopoutCorner = Instance.new('UICorner', ColorPickerPopout)
			local TextLabel = Instance.new('TextLabel', ColorPickerPopout)

			ColorPickerPopout.Name = "ColorPickerPopout"
			ColorPickerPopout.Position = UDim2.new(1.0117,0,0,0)
			ColorPickerPopout.Size = UDim2.new(0,197,0,178)
			ColorPickerPopout.BackgroundColor3 = Color3.new(0.1059,0.1059,0.1059)
			ColorPickerPopout.BorderSizePixel = 0
			ColorPickerPopout.BorderColor3 = Color3.new(0,0,0)
			ColorPickerPopout.ZIndex = 110
			ColorPickerPopout.Visible = false
			hUESelection.Name = "hUESelection"
			hUESelection.Position = UDim2.new(0.8579,0,0.0562,0)
			hUESelection.Size = UDim2.new(0,15,0,132)
			hUESelection.BackgroundColor3 = Color3.new(1,1,1)
			hUESelection.BackgroundTransparency = 1
			hUESelection.BorderSizePixel = 0
			hUESelection.BorderColor3 = Color3.new(0,0,0)
			--hUESelection.Image = "rbxassetid://11970136481"
			hUESelection.ZIndex = 111
			sVSelection.Name = "sVSelection"
			sVSelection.Position = UDim2.new(0.0508,0,0.0562,0)
			sVSelection.Size = UDim2.new(0,143,0,132)
			--sVSelection.BackgroundColor3 = Color3.new(1,1,1)
			sVSelection.BackgroundTransparency = 0
			sVSelection.BorderSizePixel = 0
			sVSelection.BorderColor3 = Color3.new(0,0,0)
			--sVSelection.Image = "rbxassetid://11970108040"
			sVSelection.ZIndex = 111
			PopoutCorner.CornerRadius = UDim.new(0,6)
			TextLabel.Position = UDim2.new(0,0,0.7978,0)
			TextLabel.Size = UDim2.new(0,197,0,36)
			TextLabel.BackgroundColor3 = Color3.new(1,1,1)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.BorderColor3 = Color3.new(0,0,0)
			TextLabel.Text = "255, 255, 255"
			TextLabel.TextColor3 = Color3.new(1,1,1)
			TextLabel.Font = Enum.Font.SourceSans
			TextLabel.TextSize = 14
			TextLabel.ZIndex = 112

			local sVSlider = Instance.new("Frame")
			sVSlider.Name = "SV_slider"
			sVSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			sVSlider.BackgroundTransparency = 1
			sVSlider.Position = UDim2.new(0.961, 0, 0.0187, 0)
			sVSlider.Size = UDim2.new(0, 7, 0, 7)

			local uICorner1 = Instance.new("UICorner")
			uICorner1.Name = "UICorner"
			uICorner1.CornerRadius = UDim.new(0, 100)
			uICorner1.Parent = sVSlider

			local uIStroke1 = Instance.new("UIStroke")
			uIStroke1.Name = "UIStroke"
			uIStroke1.Color = Color3.fromRGB(255, 255, 255)
			uIStroke1.Parent = sVSlider

			sVSlider.Parent = sVSelection

			local ColorPicker = Instance.new('Frame', Canvas)
			local ColorPickerTitle = Instance.new('TextButton', ColorPicker)
			local ColorPickerCorner = Instance.new('UICorner', ColorPicker)
			local Selected_Color = Instance.new('Frame', ColorPicker)
			local SelectedCorner = Instance.new('UICorner', Selected_Color)

			local Hslider = Instance.new("Frame")
			Hslider.Name = "H_Slider"
			Hslider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Hslider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Hslider.Position = UDim2.new(-0.214, 0, -0.0139, 0)
			Hslider.Size = UDim2.new(0, 19, 0, 3)
			Hslider.Parent = hUESelection

			ColorPicker.Name = "ColorPicker"
			ColorPicker.Position = UDim2.new(0.3038,0,0.7429,0)
			ColorPicker.Size = UDim2.new(0,408,0,30)
			ColorPicker.BackgroundColor3 = Color3.new(0.1059,0.1059,0.1059)
			ColorPicker.BorderSizePixel = 0
			ColorPicker.BorderColor3 = Color3.new(0,0,0)
			ColorPicker.ZIndex = 111
			ColorPickerTitle.Name = "ColorPickerTitle"
			ColorPickerTitle.Position = UDim2.new(0.027,0,0,0)
			ColorPickerTitle.Size = UDim2.new(0,394,0,30)
			ColorPickerTitle.BackgroundColor3 = Color3.new(1,1,1)
			ColorPickerTitle.BackgroundTransparency = 1
			ColorPickerTitle.BorderSizePixel = 0
			ColorPickerTitle.BorderColor3 = Color3.new(0,0,0)
			ColorPickerTitle.Text = options.name
			ColorPickerTitle.TextColor3 = Color3.new(1,1,1)
			ColorPickerTitle.Font = Enum.Font.Gotham
			ColorPickerTitle.TextSize = 13
			ColorPickerTitle.ZIndex = 112
			ColorPickerTitle.TextXAlignment = Enum.TextXAlignment.Left
			ColorPickerCorner.CornerRadius = UDim.new(0,6)
			Selected_Color.Name = "Selected Color"
			Selected_Color.Position = UDim2.new(0.8701,0,0.1667,0)
			Selected_Color.Size = UDim2.new(0,40,0,20)
			Selected_Color.BackgroundColor3 = options.default
			Selected_Color.BorderSizePixel = 0
			Selected_Color.BorderColor3 = Color3.new(0,0,0)
			Selected_Color.ZIndex = 114
			SelectedCorner.CornerRadius = UDim.new(0,5)

			ColorPickerTitle.MouseButton1Down:Connect(function()
				for i, v in pairs(Main:GetChildren()) do
					if v.Name == "ColorPickerPopout" and v.Visible == true and v ~= ColorPickerPopout then
						v.Visible = false
					end
				end
				ColorPickerPopout.Visible = not ColorPickerPopout.Visible
			end)

			options.callback(options.default)

			ColorH = 1 - (math.clamp(Hslider.AbsolutePosition.Y - hUESelection.AbsolutePosition.Y, 0, hUESelection.AbsoluteSize.Y) / hUESelection.AbsoluteSize.Y)
			ColorS = (math.clamp(sVSlider.AbsolutePosition.X - sVSelection.AbsolutePosition.X, 0, sVSelection.AbsoluteSize.X) / sVSelection.AbsoluteSize.X)
			ColorV = 1 - (math.clamp(sVSlider.AbsolutePosition.Y - sVSelection.AbsolutePosition.Y, 0, sVSelection.AbsoluteSize.Y) / sVSelection.AbsoluteSize.Y)

			function colorpicker:UpdateColorPicker()
				--if colorpickerContainer.Visible == true then 
				Selected_Color.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
				R,G,B = utility:ToRGB(Selected_Color.BackgroundColor3)
				Hslider.Position = UDim2.new(-0.133,0,ColorH,0)
				sVSelection.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
				TextLabel.Text = tostring(math.floor(R)) .. "," .. tostring(math.floor(G)) ..  "," ..tostring(math.floor(B))

				options.callback(Selected_Color.BackgroundColor3)
			end

			function colorpicker.SetValue(self,H,S,V)

				ColorH = H
				ColorS  = S
				ColorV = V
				self:UpdateColorPicker()

			end

			sVSelection.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					if ColorInput then
						ColorInput:Disconnect()
					end
					ColorInput = RS.RenderStepped:Connect(function()
						local ColorX = (math.clamp(mouse.X - sVSelection.AbsolutePosition.X, 0, sVSelection.AbsoluteSize.X) / sVSelection.AbsoluteSize.X)
						local ColorY = (math.clamp(mouse.Y - sVSelection.AbsolutePosition.Y, 0, sVSelection.AbsoluteSize.Y) / sVSelection.AbsoluteSize.Y)
						sVSlider.Position = UDim2.new(ColorX, 0, ColorY, 0)
						ColorS = ColorX
						ColorV = 1 - ColorY
						colorpicker:UpdateColorPicker()
					end)
				end
			end))

			sVSelection.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					if ColorInput then
						ColorInput:Disconnect()
					end
				end
			end)

			hUESelection.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					if HueInput then
						HueInput:Disconnect()
					end

					HueInput = RS.RenderStepped:Connect(function()
						local HueY = (math.clamp(mouse.Y - hUESelection.AbsolutePosition.Y, 0, hUESelection.AbsoluteSize.Y) / hUESelection.AbsoluteSize.Y)


						ColorH =  HueY


						colorpicker:UpdateColorPicker()
					end)
				end
			end))

			hUESelection.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					if HueInput then
						HueInput:Disconnect()
					end
				end
			end)

			return colorpicker
		end

		function tab:Chat(options)
			local chat = {}
			local ChatFeature = Instance.new('Frame', Canvas)
			local MessageInput = Instance.new('Frame', ChatFeature)
			local InputCorner = Instance.new('UICorner', MessageInput)
			local TextBox = Instance.new('TextBox', MessageInput)
			local ChatsHolder = Instance.new('ScrollingFrame', ChatFeature)
			local MessageLayout = Instance.new('UIListLayout', ChatsHolder)

			--Properties

			ChatFeature.Name = "ChatFeature"
			ChatFeature.Position = UDim2.new(0.2788,0,0.0796,0)
			ChatFeature.Size = UDim2.new(0,432,0,451)
			ChatFeature.BackgroundColor3 = Color3.new(1,1,1)
			ChatFeature.BackgroundTransparency = 1
			ChatFeature.BorderSizePixel = 0
			ChatFeature.BorderColor3 = Color3.new(0,0,0)
			ChatFeature.ZIndex = 112
			MessageInput.Name = "MessageInput"
			MessageInput.Position = UDim2.new(0.0394,0,0.9113,0)
			MessageInput.Size = UDim2.new(0,398,0,28)
			MessageInput.BackgroundColor3 = Color3.new(0,0,0)
			MessageInput.BackgroundTransparency = 0.5
			MessageInput.BorderSizePixel = 0
			MessageInput.BorderColor3 = Color3.new(0,0,0)
			MessageInput.ZIndex = 113
			InputCorner.CornerRadius = UDim.new(0,6)
			TextBox.Position = UDim2.new(0.0276,0,0,0)
			TextBox.Size = UDim2.new(0,387,0,28)
			TextBox.BackgroundColor3 = Color3.new(1,1,1)
			TextBox.BackgroundTransparency = 1
			TextBox.BorderSizePixel = 0
			TextBox.BorderColor3 = Color3.new(0,0,0)
			TextBox.Text = ""
			TextBox.TextColor3 = Color3.new(0,0,0)
			TextBox.Font = Enum.Font.Gotham
			TextBox.TextSize = 12
			TextBox.TextColor3 = Color3.new(178, 178, 178)
			TextBox.ZIndex = 114
			TextBox.TextXAlignment = Enum.TextXAlignment.Left
			TextBox.PlaceholderText = "Enter Message"
			ChatsHolder.Name = "ChatsHolder"
			ChatsHolder.Size = UDim2.new(0,432,0,411)
			ChatsHolder.BackgroundColor3 = Color3.new(1,1,1)
			ChatsHolder.BackgroundTransparency = 1
			ChatsHolder.BorderSizePixel = 0
			ChatsHolder.BorderColor3 = Color3.new(0,0,0)
			ChatsHolder.ZIndex = 113
			ChatsHolder.ScrollBarThickness = 0
			ChatsHolder.ScrollBarImageColor3 = Color3.new(0,0,0)
			ChatsHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
			MessageLayout.Name = "MessageLayout"
			MessageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
			MessageLayout.SortOrder = Enum.SortOrder.LayoutOrder
			MessageLayout.Padding = UDim.new(0, 10)

			function chat:SendMessage(text)
				local Message = Instance.new('TextLabel', ChatsHolder)
				Message.Name = "Message"
				Message.Position = UDim2.new(0.0394,0,0.2683,0)
				Message.Size = UDim2.new(0,414,0,28)
				Message.BackgroundColor3 = Color3.new(1,1,1)
				Message.BackgroundTransparency = 1
				Message.BorderSizePixel = 0
				Message.RichText = true
				Message.BorderColor3 = Color3.new(0,0,0)
				Message.Text = '<font color="#b2b2b2">'..game:GetService("Players").LocalPlayer.Name.."</font>\n"..text
				Message.TextColor3 = Color3.new(1,1,1)
				Message.Font = Enum.Font.Gotham
				Message.TextWrapped = true
				Message.TextSize = 14
				Message.AutomaticSize = Enum.AutomaticSize.Y
				Message.ZIndex = 114
				Message.TextXAlignment = Enum.TextXAlignment.Left
			end

			TextBox.FocusLost:Connect(function(entered)
				if entered and TextBox.Text ~= "" then
					chat:SendMessage(TextBox.Text)
					TextBox.Text = ""
				end
			end)

			return chat
		end

		return tab
	end

	return GUI
end
local lib = Library:Init{}

local tab1 = lib:NewTab{name = "Catching"}
local tab2 = lib:NewTab{name = "Player"}

local sec1 = tab1:NewSection({name = "Custom Mags"})

local part = Instance.new("Part")
part.Size = Vector3.new(0, 0, 0)
part.Color = Color3.fromRGB(128, 128, 128)
part.Transparency = 1
part.CanCollide = false
part.Anchored = true
part.Parent = workspace

local football = workspace:FindFirstChild("Football")

if football then
    part.Position = football.Position
    football:GetPropertyChangedSignal("Position"):Connect(function()
        part.Position = football.Position
    end)
end

workspace.ChildAdded:Connect(function(child)
    if child.Name == "Football" then
        part.Position = child.Position
        child:GetPropertyChangedSignal("Position"):Connect(function()
            part.Position = child.Position
        end)
    end
end)

tab1:Toggle({
	name = "Show Hitbox Visualizer",
	default = false,
	flag = "Toggle",
	callback = function(v)
		if v then
			part.Transparency = 0.5
		else
			part.Transparency = 1
		end
	end,
})

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local magnetToggle = false
local magnetRadius = 0

local function teleportCloseFootball()
    local character = LocalPlayer.Character
    if not character then return end
    local catchRight = character:FindFirstChild("CatchRight")
    if not catchRight then return end
    
    local closestFootball = nil
    local closestDistance = magnetRadius

    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Part") and obj.Name == "Football" then
            local distance = (obj.Position - character.HumanoidRootPart.Position).magnitude
            if distance < closestDistance then
                closestFootball = obj
                closestDistance = distance
            end
        end
    end

    if closestFootball then
        local tween = TweenService:Create(closestFootball, TweenInfo.new(0), {Position = catchRight.Position})
        tween:Play()
        tween.Completed:Wait()
    end
end

game:GetService("RunService").Stepped:Connect(teleportCloseFootball)


tab1:Toggle({
	name = "Activate Magnets",
	default = false,
	flag = "Toggle",
	callback = function(v)
		magnetToggle = v
		if not magnetToggle then
			magnetRadius = 0
		end
	end,
})

tab1:Slider({
	name = "Magnet Radius",
	min = 0,
	max = 45,
	default = 0,
	callback = function(v)
		if magnetToggle then
			magnetRadius = v
			part.Size = Vector3.new(v, v, v)
		end
	end,
})

local sec2 = tab2:NewSection({name = "Custom JP"})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local jumpToggle = false
local jumpBoostAmount = 0

humanoid.StateChanged:Connect(function(_, newState)
    if newState == Enum.HumanoidStateType.Jumping then
        task.wait(0.01)
        humanoidRootPart.Velocity = Vector3.new(humanoidRootPart.Velocity.X, humanoidRootPart.Velocity.Y + jumpBoostAmount)
    end
end)

tab2:Toggle({
    name = "Activate JP",
    default = false,
    flag = "Toggle",
    callback = function(v)
        jumpToggle = v
        if not jumpToggle then
            jumpBoostAmount = 0
        end
    end,
})

tab2:Slider({
    name = "JumpPower Value",
    min = 50,
    max = 70,
    default = 50,
    callback = function(v)
        if jumpToggle then
            if v == 50 then
                jumpBoostAmount = 0
            elseif v == 70 then
                jumpBoostAmount = 15
            else
                jumpBoostAmount = (v - 50) / 20 * 15
            end
        end
    end,
})


local userInplocal userInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local quickTPBind = Enum.KeyCode.F
local quickTPEnabled = false
local quickTPSpeed = 0 
local cooldownTime = 0.2

local quickTPCooldown = os.clock()
local player = Players.LocalPlayer

local function moveCharacterForward()
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChild("Humanoid")

    if not quickTPEnabled then return end
    if not character or not humanoidRootPart or not humanoid then return end
    if (os.clock() - quickTPCooldown) < cooldownTime then return end

    local speed = quickTPSpeed
    local forwardVector = humanoidRootPart.CFrame.LookVector

    humanoidRootPart.CFrame = humanoidRootPart.CFrame + (forwardVector * speed)

    quickTPCooldown = os.clock()
end

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == quickTPBind then
        moveCharacterForward()
    end
end)

tab2:Toggle({
	name = "Activate QuickTP",
	default = false,
	flag = "Toggle",
	callback = function(v)
		quickTPEnabled = v
		if not quickTPEnabled then
			quickTPSpeed = 0
		end
	end,
})

tab2:Slider({
	name = "QuickTP Value",
	min = 0,
	max = 5,
	default = 0,
	callback = function(v)
		if quickTPEnabled then
			quickTPSpeed = v
		end
	end,
})
