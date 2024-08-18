local CopiedObject
local SelectedObj
local system = {}
system.Parent = game.CoreGui
--Values
system.sizeY = 25
system.ObjCreated = 0
system.indent = 25
system.indentMax = 0

system.BSize = 55
system.CBSize = system.BSize / 1.5
system.Pindent = 5
system.PrsizeY = 40
system.CountAct = 0
system.CountProp = 0
--Images
system.ClassImage = {}
system.ClassImage.NoImage = "rbxassetid://18625331480"
system.ClassImage.Part = "rbxassetid://18566785665"
system.ClassImage.Workspace = "rbxassetid://18566918285"
system.ClassImage.Model = "rbxassetid://18574538652" 
system.ClassImage.ClickDetector = "rbxassetid://18574641762"
system.ClassImage.Terrain = "rbxassetid://18574777343"
system.ClassImage.Folder = "rbxassetid://18574929926"
system.ClassImage.RemoteFunction = "rbxassetid://18575774710"
system.ClassImage.RemoteEvent = "rbxassetid://18575766724"
system.ClassImage.SpawnLocation = "rbxasset://textures/SpawnLocation.png"
system.ClassImage.Lighting = "rbxassetid://18580198683"
system.ClassImage.ReplicatedStorage = "rbxassetid://18580204969"
local Val = "rbxassetid://18580874045"
system.ClassImage.IntValue = Val
system.ClassImage.BoolValue = Val
system.ClassImage.BrickColorValue = Val
system.ClassImage.CFrameValue = Val
system.ClassImage.NumberValue = Val
system.ClassImage.ObjectValue = Val
system.ClassImage.RayValue = Val
system.ClassImage.StringValue = Val
system.ClassImage["Vector3Value"] = Val
system.ClassImage["Color3Value"] = Val
system.ClassImage.Players = "rbxassetid://18590943302"
system.ClassImage.Player = "rbxassetid://18590938477"
system.ClassImage.LocalScript = "rbxassetid://18591202423"
system.ClassImage.Script = "rbxassetid://18591184066"
system.ClassImage.SelectionBox = "rbxassetid://18596364505"
system.ClassImage.Highlight = "rbxassetid://18596534888"
system.ClassImage.ScreenGui = "rbxassetid://18596781150"
system.ClassImage.TextLabel = "rbxassetid://18596885920"
system.ClassImage.ImageLabel = "rbxassetid://18596925367"
system.ClassImage.ImageButton = "rbxassetid://18606153825"
system.ClassImage.TextButton = "rbxassetid://18606147849"
--system.ClassImage
--system.ClassImage
--system.ClassImage
--Acts
--Forever
system.ActsF = {}
system.ActsF.Delete = function(obj) obj:Destroy() end
system.ActsF.Copy = function(obj) 
	CopiedObject = obj:Clone() 
	CopiedObject.Parent = nil
end
system.ActsF.Cut = function(obj) 
	CopiedObject = obj
	CopiedObject.Parent = nil
end

system.ActsF["Paste into"] = function(obj) CopiedObject.Parent = obj end

--Not Forever
system.ActsNF = {}
--Type: Part
system.ActsNF.Part = {}
system.ActsNF.Part["Teleport to part"] = function(obj)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame end

--Type: ClickDetector
system.ActsNF.ClickDetector = {}
system.ActsNF.ClickDetector["Fire click detector"] = function(obj) FireClickDetector(obj) end
--Type:Terrain
system.ActsNF.Terrain = {}
system.ActsNF.Terrain["Clear terrain"] = function(obj) obj:Clear() end
--Type:RemoteEvent
system.ActsNF.RemoteEvent = {}
system.ActsNF.RemoteEvent["Fire remote event"] = function(obj) obj:FireServer() end
-- Props
--Forever
system.PropsF = {}
system.PropsF.Parent = 5
system.PropsF.Name = 1
system.PropsF.ClassName = 0
--Not Forever
system.PropsNF = {}
--type:Terrain
system.PropsNF.Terrain = {}
system.PropsNF.Terrain.WaterColor = 4
system.PropsNF.Terrain.WaterReflectance = 3
system.PropsNF.Terrain.WaterTransparency = 3
system.PropsNF.Terrain.WaterWaveSize = 3
system.PropsNF.Terrain.WaterWaveSpeed = 3
--type: ClickDetector
system.PropsNF.ClickDetector = {}
system.PropsNF.ClickDetector.MaxActivationDistance = 3
system.PropsNF.ClickDetector.CursorIcon = 1
--Type: Values
system.PropsNF.BoolValue = { Value = 1 }
system.PropsNF.BoolValue = { Value = 2 }
system.PropsNF.IntValue = { Value = 3 }
system.PropsNF.NumberValue = { Value = 3 }
system.PropsNF["Color3Value"] = { Value = 4 }
system.PropsNF.ObjectValue = { Value = 5 }
system.PropsNF["Vector3Value"] = { Value = 6 }
system.PropsNF.CFrameValue = { Value = 10 }
system.PropsNF.BrickColorValue = { Value = 12 }
--Type:Part
system.PropsNF.Part = {}
system.PropsNF.Part.Transparency = 3
system.PropsNF.Part.TopSurface = 11
system.PropsNF.Part.Size = 6
system.PropsNF.Part.Rotation = 6
system.PropsNF.Part.RootPriority = 3
system.PropsNF.Part.Reflectance = 3
system.PropsNF.Part.Position = 6
system.PropsNF.Part.PivotOffset = 10
system.PropsNF.Part.Orientation = 6
system.PropsNF.Part.Material = 11
system.PropsNF.Part.MaterialVariant = 1
system.PropsNF.Part.Massless = 2
system.PropsNF.Part.Locked = 2
system.PropsNF.Part.LocalTransparencyModifier = 3
system.PropsNF.Part.Color = 4
system.PropsNF.Part.CollisionGroup = 1
system.PropsNF.Part.CanCollide = 2
system.PropsNF.Part.CanTouch = 2
system.PropsNF.Part.CanQuery = 2
system.PropsNF.Part.Anchored = 2
system.PropsNF.Part.CFrame = 10
system.PropsNF.Part.BrickColor = 12
system.PropsNF.Part.Shape = 11
--Type: MeshPart
system.PropsNF.MeshPart = table.clone(system.PropsNF.Part)
system.PropsNF.MeshPart.Shape = nil
system.PropsNF.MeshPart.MeshId = 1
system.PropsNF.MeshPart.TextureID = 1
system.PropsNF.MeshPart.MeshSize = 0
system.PropsNF.MeshPart.CollisionFidelity = 11
system.PropsNF.MeshPart.FluidFidelity = 11
-- Type: SpawnLocation
system.PropsNF.SpawnLocation = table.clone(system.PropsNF.Part)
system.PropsNF.SpawnLocation.AllowTeamChangeOnTouch = 2
system.PropsNF.SpawnLocation.Duration = 3
system.PropsNF.SpawnLocation.Enabled = 2
system.PropsNF.SpawnLocation.Neutral = 2
system.PropsNF.SpawnLocation.TeamColor = 12
--Type: Players
system.PropsNF.Players = {}
system.PropsNF.Players.BubbleChat = 0
system.PropsNF.Players.ClassicChat = 0
system.PropsNF.Players.LocalPlayer = 0
system.PropsNF.Players.MaxPlayers = 0
system.PropsNF.Players.PreferredPlayers = 0
system.PropsNF.Players.RespawnTime = 3
system.PropsNF.Players.CharacterAutoLoads = 2
--Type: Model and Workspace
local temp = {}
temp.PrimaryPart = 0
temp.WorldPivot = 10 
temp.LevelOfDetail = 11
temp.ModelStreamingMode = 11

system.PropsNF.Model = temp
system.PropsNF.Workspace = table.clone(temp)

system.PropsNF.Workspace.CurrentCamera = 0
system.PropsNF.Workspace.DistributedGameTime = 3
system.PropsNF.Workspace.AllowThirdPartySales = 2
system.PropsNF.Workspace.FallenPartsDestroyHeight = 3
system.PropsNF.Workspace.GlobalWind = 6
system.PropsNF.Workspace.Gravity = 3
system.PropsNF.Workspace.StreamingEnabled = 2
--Type:Lighting
system.PropsNF.Lighting = {}
system.PropsNF.Lighting.Ambient = 4
system.PropsNF.Lighting.Brightness = 3
system.PropsNF.Lighting.ColorShift_Bottom = 4
system.PropsNF.Lighting.ColorShift_Top = 4
system.PropsNF.Lighting.EnvironmentDiffuseScale = 3
system.PropsNF.Lighting.EnvironmentSpecularScale = 3
system.PropsNF.Lighting.GlobalShadows = 2
system.PropsNF.Lighting.OutdoorAmbient = 4
system.PropsNF.Lighting.ShadowSoftness = 3
system.PropsNF.Lighting.ClockTime = 3
system.PropsNF.Lighting.GeographicLatitude = 3
system.PropsNF.Lighting.ExposureCompensation = 3
system.PropsNF.Lighting.FogColor = 4
system.PropsNF.Lighting.FogEnd = 3
system.PropsNF.Lighting.FogStart = 3
--Type:Script
system.PropsNF.Script = { Enabled = 2 }
system.PropsNF.Script.RunContext = 11
--Type:LocalScript
system.PropsNF.LocalScript = { Enabled = 2 }
--Type:Player
system.PropsNF.Player = {}
system.PropsNF.Player.AccountAge = 0
system.PropsNF.Player.CharacterAppearanceId = 3
system.PropsNF.Player.UserId = 3
system.PropsNF.Player.DisplayName = 1
system.PropsNF.Player.Team = 0
system.PropsNF.Player.TeamColor = 12
system.PropsNF.Player.Neutral = 2
system.PropsNF.Player.CameraMode = 11
system.PropsNF.Player.CameraMaxZoomDistance = 3
system.PropsNF.Player.CameraMinZoomDistance = 3
system.PropsNF.Player.DevEnableMouseLock = 2
system.PropsNF.Player.DevComputerMovementMode = 11
system.PropsNF.Player.DevTouchMovementMode = 11
system.PropsNF.Player.DevComputerCameraMode = 11
system.PropsNF.Player.DevTouchCameraMode = 11
--Type:SelectionBox
system.PropsNF.SelectionBox = {}
system.PropsNF.SelectionBox.Adornee = 5
system.PropsNF.SelectionBox.LineThickness = 3
system.PropsNF.SelectionBox.Color3 = 4
system.PropsNF.SelectionBox.SurfaceColor3 = 4
system.PropsNF.SelectionBox.SurfaceTransparency = 3
system.PropsNF.SelectionBox.Transparency = 3
system.PropsNF.SelectionBox.Visible = 2
--Type: Highlight
system.PropsNF.Highlight = {}
system.PropsNF.Highlight.Adornee = 5
system.PropsNF.Highlight.FillColor = 4
system.PropsNF.Highlight.FillTransparency = 3
system.PropsNF.Highlight.OutlineColor = 4
system.PropsNF.Highlight.OutlineTransparency = 3
system.PropsNF.Highlight.DepthMode = 11
system.PropsNF.Highlight.Enabled = 2
--Type: ScreenGui
system.PropsNF.ScreenGui = {}
system.PropsNF.ScreenGui.ClipToDeviceSafeArea = 3
system.PropsNF.ScreenGui.SafeAreaCompatibility = 11
system.PropsNF.ScreenGui.ScreenInsets = 11
system.PropsNF.ScreenGui.DisplayOrder = 3
system.PropsNF.ScreenGui.Enabled = 2
system.PropsNF.ScreenGui.IgnoreGuiInset = 2
system.PropsNF.ScreenGui.ResetOnSpawn = 2
system.PropsNF.ScreenGui.ZIndexBehavior = 11
system.PropsNF.ScreenGui.SelectionGroup = 2
system.PropsNF.ScreenGui.AbsolutePosition = 0
system.PropsNF.ScreenGui.AbsoluteRotation = 0
system.PropsNF.ScreenGui.AbsoluteSize = 0
local guis = {}
guis.AbsolutePosition = 0
guis.AbsoluteRotation = 0
guis.AbsoluteSize = 0
guis.Active = 2
guis.AnchorPoint = 7
guis.AutomaticSize = 11
guis.BackgroundColor3 = 4
guis.BackgroundTransparency = 3
guis.BorderColor3 = 4
guis.BorderMode = 11
guis.BorderSizePixel = 3
guis.Interactable = 2 
guis.LayoutOrder = 3
guis.Position = 9
guis.Rotation = 3
guis.Size = 9
guis.SizeConstraint = 11
guis.Visible = 2
guis.ZIndex = 3
guis.ClipsDescendants = 2
guis.AutoLocalize = 2
guis.Selectable = 2
guis.SelectionGroup = 2
guis.SelectionOrder = 3
guis.GuiState = 0
--type: frame
system.PropsNF.Frame = table.clone(guis)
system.PropsNF.Frame.Style = 11
--type: ScrollingFrame
system.PropsNF.ScrollingFrame = table.clone(guis)
system.PropsNF.ScrollingFrame.AbsoluteCanvesSize = 7
system.PropsNF.ScrollingFrame.AbsoluteWindowSize = 7
system.PropsNF.ScrollingFrame.AutomaticCanvasSize = 11
system.PropsNF.ScrollingFrame.BottomImage = 1
system.PropsNF.ScrollingFrame.CanvasPosition = 7
system.PropsNF.ScrollingFrame.CanvasSize = 9
system.PropsNF.ScrollingFrame.ElasticBehavior = 11
system.PropsNF.ScrollingFrame.HorizontalScrollBarInset = 11
system.PropsNF.ScrollingFrame.MidImage = 1
system.PropsNF.ScrollingFrame.ScrollBarImageColor3 = 4
system.PropsNF.ScrollingFrame.ScrollBarImageTransparency = 3
system.PropsNF.ScrollingFrame.ScrollBarThickness = 3
system.PropsNF.ScrollingFrame.ScrollingDirection = 11
system.PropsNF.ScrollingFrame.ScrollingEnabled = 2
system.PropsNF.ScrollingFrame.TopImage = 1
system.PropsNF.ScrollingFrame.VerticalScrollBarInset = 11
system.PropsNF.ScrollingFrame.VerticalScrollBarPosition = 11

--type: TextLabel
system.PropsNF.TextLabel = table.clone(guis)
system.PropsNF.TextLabel.ContentText = 1
system.PropsNF.TextLabel.Font = 11
system.PropsNF.TextLabel.FontFace = 11
system.PropsNF.TextLabel.LineHeight = 3
system.PropsNF.TextLabel.LocalizedText = 0
system.PropsNF.TextLabel.MaxVisibleGraphemes = 3
--system.PropsNF.TextLabel.OpenTypeFeatures = 1
--system.PropsNF.TextLabel.OpenTypeFeaturesError = 0
system.PropsNF.TextLabel.RichText = 2
system.PropsNF.TextLabel.Text = 1
system.PropsNF.TextLabel.TextBounds = 0
system.PropsNF.TextLabel.TextColor3 = 4
system.PropsNF.TextLabel.TextDirection = 11
system.PropsNF.TextLabel.TextFits = 0
system.PropsNF.TextLabel.TextScaled = 2
system.PropsNF.TextLabel.TextSize = 3
system.PropsNF.TextLabel.TextStrokeColor3 = 4
system.PropsNF.TextLabel.TextStrokeTransparency = 3
system.PropsNF.TextLabel.TextTransparency = 3
system.PropsNF.TextLabel.TextTruncate = 11
system.PropsNF.TextLabel.TextWrapped = 2
system.PropsNF.TextLabel.TextXAlignment = 11
system.PropsNF.TextLabel.TextYAlignment = 11
--type:ImageLabel
system.PropsNF.ImageLabel = table.clone(guis)
system.PropsNF.ImageLabel.Image = 1
system.PropsNF.ImageLabel.ImageColor3 = 4
system.PropsNF.ImageLabel.ImageRectOffset = 7
system.PropsNF.ImageLabel.ImageRectSize = 7
system.PropsNF.ImageLabel.ImageTransparency = 3
system.PropsNF.ImageLabel.ResampleMode = 11
system.PropsNF.ImageLabel.ScaleType = 11
system.PropsNF.ImageLabel.SliceScale = 3
system.PropsNF.ImageLabel.TileSize = 9

--types: TextButton and Image button
local buttons = {}
buttons.AutoButtonColor = 2
buttons.Modal = 2
buttons.Selected = 2
buttons.Style = 11
system.PropsNF.TextButton = table.clone(system.PropsNF.TextLabel, buttons)
system.PropsNF.ImageButton = table.clone(system.PropsNF.ImageLabel, buttons)
system.PropsNF.ImageButton.HoverImage = 1
system.PropsNF.ImageButton.PressedImage = 1

--GUI
system.gui = Instance.new("ScreenGui")
system.gui.Parent = system.Parent
system.gui.IgnoreGuiInset = true
system.gui.Name = "TimEXPLORER"
system.gui.ResetOnSpawn = false
system.gui.DisplayOrder = 2
--MainFrame
system.frame = Instance.new("Frame")
system.frame.Parent = system.gui 
system.frame.Size = UDim2.new(0.2,0,1,0)
system.frame.Position = UDim2.new(0.8,0,0,0)
system.frame.BackgroundColor3 = Color3.fromRGB(5,5,25)
--Frames
system.frames = {}

-- Object frame moved to line 391

system.frames.Properties = Instance.new("ScrollingFrame")
system.frames.Properties.Parent = system.frame
system.frames.Properties.Size = UDim2.new(1,0,0.5,-system.BSize /2)
system.frames.Properties.Position = UDim2.new(0,0,0.5,system.BSize /2)
system.frames.Properties.ScrollBarThickness = 6
system.frames.Properties.BackgroundTransparency = 1

system.frames.Activites = Instance.new("ScrollingFrame")
system.frames.Activites.Parent = system.frame
system.frames.Activites.Size = UDim2.new(1,0,0.5,-system.BSize /2)
system.frames.Activites.Position = UDim2.new(0,0,0.5,system.BSize /2)
system.frames.Activites.ScrollBarThickness = 6
system.frames.Activites.BackgroundTransparency = 1

--Buttons Change Properties and Activity
local PoA = 1
local PoASC

local Prop = Instance.new("TextButton")
Prop.Parent = system.frame
Prop.Text = "Properties"
Prop.Size = UDim2.new(0.49,0,0,system.BSize)
Prop.Position = UDim2.new(0,0,0.5,-system.BSize /2)
Prop.BackgroundColor3 = Color3.fromRGB(40,40,80)
Prop.TextColor3 = Color3.fromRGB(255,255,255)
Prop.TextScaled = true
Prop.Activated:Connect(function() PoA = 1 PoASC() end)

local Act = Instance.new("TextButton")
Act.Parent = system.frame
Act.Text = "Activites"
Act.Size = UDim2.new(0.49,0,0,system.BSize)
Act.Position = UDim2.new(0.51,0,0.5,-system.BSize /2)
Act.BackgroundColor3 = Color3.fromRGB(40,40,80)
Act.TextColor3 = Color3.fromRGB(255,255,255)
Act.TextScaled = true
Act.Activated:Connect(function() PoA = 2 PoASC() end)

system.frames.Objects = Instance.new("ScrollingFrame")
system.frames.Objects.LayoutOrder = 1
system.frames.Objects.Parent = system.frame
system.frames.Objects.Size = UDim2.new(1,0,1,0)
system.frames.Objects.ScrollBarThickness = 6
system.frames.Objects.BackgroundColor3 = system.frame.BackgroundColor3

PoASC = function()
	if PoA == 1 then
		Act.BackgroundTransparency = 0
		Prop.BackgroundTransparency = 1
		system.frames.Activites.Visible = false
		system.frames.Properties.Visible = true
	else
		Prop.BackgroundTransparency = 0
		Act.BackgroundTransparency = 1
		system.frames.Activites.Visible = true
		system.frames.Properties.Visible = false
	end
end

PoASC()
local temp = Instance.new("BoolValue")
temp.Changed:Connect(function()
	while true do
		wait(0.1)
		system.frames.Objects.CanvasSize = UDim2.new(1,(system.indent * system.indentMax)-8, 0, system.sizeY * system.ObjCreated)
		system.frames.Properties.CanvasSize = UDim2.new(0,0,0,system.CountProp * (system.PrsizeY + system.Pindent))
		system.frames.Activites.CanvasSize = UDim2.new(0,0,0,system.CountAct * (system.PrsizeY + system.Pindent))
		if SelectedObj then
			system.frames.Objects.Size = UDim2.new(1,0,0.5,-system.BSize /2)
		else
			system.frames.Objects.Size = UDim2.new(1,0,1,0)
		end
	end
end)
temp.Value = true

--Functios
system.Functions = {}



local Update = function()
	local count = 0
	local tab = {}
	for i=1,system.indentMax +1 do
		tab[i] = {}
	end
	local temp = system.frames.Objects:GetChildren()
	table.sort(temp,function(a,b)
		for k,v in pairs(a.Object.Value.Parent:GetChildren()) do
			if v == a.Object.Value then
				a = k
				break
			end
		end
		for k,v in pairs(b.Object.Value.Parent:GetChildren()) do
			if v == b.Object.Value then
				b = k
				break
			end
		end
		--print(b)
		return a > b
	end)
	for k,v in pairs(temp) do
		if not (v.Indent.Value == 0) then
			tab[v.Indent.Value][v.Count.Value] =  v
		end
	end

	local ChangeCount
	--local ReCallCC = function(v,t,i) ChangeCount(v,t,i) end
	ChangeCount = function(vv,tab,ind)
		count += 1
		vv.Count.Value = count
		if vv.Add.Text == "-" then
			for k,v in pairs(vv.Object.Value:GetChildren()) do
				for kv,vk in pairs(tab[ind]) do
					if vk.Object.Value == v then
						ChangeCount(vk,tab,ind+1)
					end
				end
			end
		end
	end

	for k,v in pairs(system.frames.Objects:GetChildren()) do
		local success,response = pcall(function()
		        local ccc = v.Object.Value:GetChildren()
		        if #ccc == 0 then
			        v.Add.Visible = false
		        elseif not v.Add.Visible then
			        v.Add.Visible = true
		        end
		        if v.Indent.Value == 0 then
			        v.Count.Value = count
			        if v.Add.Text == "-" then
				        for kk,vv in pairs(tab[1]) do
					        if vv.Object.Value.Parent == v.Object.Value then
				                        ChangeCount(vv,tab,2)
					        end
				        end
			        end
			        count += 1
			end
		end) 
		if not success then
			warn("error to update:" .. v.Name) 
		end
	end
end

local function addParentRecursive(object, t)
	if (object and object.Parent) then
		table.insert(t, object.Parent == game and "game" or object.Parent.Name)
		addParentRecursive(object.Parent, t)
	end
end
local function getPath(object, useWaitForChild)
	local t = {object.Name}
	addParentRecursive(object, t)
	local path = t[#t]
	if (useWaitForChild) then
		for i = #t-1, 1, -1 do
			path = path .. ":WaitForChild(\"" .. t[i] .. "\")"
		end
	else
		for i = #t-1, 1, -1 do
			local name = t[i]
			if (name:match("[^%w_]+") or name:sub(1, 1):match("%d")) then
				path = path .. "[\"" .. name .. "\"]"
			else
				path = path .. "." .. name
			end;
		end
	end
	return path
end

local ITS = function(SoI, tIns)
	if tIns then
		return getPath(SoI, false)
	else
		local str = string.gsub("return instance","instance",SoI)
		return loadstring(str)()
	end
end

local ConvertString = function(str,strto)
	local convert = string.gsub("return ToWhat.new(Parameters)","ToWhat",strto)
	convert = string.gsub(convert,"Parameters",str)
	return loadstring(convert)()
end

system.Functions.AddAct = function(name,func,temporary)
	local temp = Instance.new("TextButton")
	temp.Parent = system.frames.Activites
	temp.Name = name 
	temp.Text = name 
	temp.Position = UDim2.new(0.1,0,0,system.CountAct * (system.PrsizeY + system.Pindent))
	temp.Size = UDim2.new(0.8,0,0,system.PrsizeY)
	temp.TextScaled = true
	temp.BackgroundColor3 = Color3.fromRGB(40,40,80)
	temp.TextColor3 = Color3.fromRGB(255,255,255)
	system.CountAct = system.CountAct +1
	local isTemp = Instance.new("BoolValue")
	isTemp.Parent = temp
	isTemp.Name = "temp"
	isTemp.Value = temporary
	temp.Activated:Connect(function() func(SelectedObj) end)
end
system.Functions.AddProp = function(name,func,temporary)
	local temp = Instance.new("Frame")
	temp.Parent = system.frames.Properties
	temp.Name = name 
	temp.Position = UDim2.new(0,0,0,system.CountProp * (system.PrsizeY + system.Pindent))
	temp.Size = UDim2.new(1,0,0,system.PrsizeY)
	temp.BackgroundColor3 = Color3.fromRGB(40,40,80)
	system.CountProp = system.CountProp +1
	local tempp = Instance.new("TextLabel")
	tempp.Parent = temp
	tempp.Name = "Text"
	tempp.BackgroundTransparency = 1
	tempp.TextColor3 = Color3.new(1,1,1)
	tempp.TextScaled = true
	tempp.Size = UDim2.new(0.5,0,1,0)
	tempp.Text = name .. ":"
	if func == 0 then
		tempp.TextColor3 = Color3.new(0.5,0.5,0.5)
		tempp = Instance.new("TextLabel")
		tempp.Size = UDim2.new(0.5,0,1,0)
		tempp.Position = UDim2.new(0.5,0,0,0)
		tempp.Parent = temp
		tempp.Name = "Value"
		tempp.BackgroundTransparency = 1
		tempp.TextColor3 = Color3.new(0.5, 0.5, 0.5)
		tempp.TextScaled = true
		if SelectedObj then
			tempp.Text = tostring(SelectedObj[name])
		else
			tempp.Text = ""
		end
	elseif not (func == 2) then
		local Color
		if func == 4 then 
			Color = Instance.new("TextLabel")
			Color.Size = UDim2.new(0,system.Pindent*2,0,system.Pindent*2)
			Color.Position = UDim2.new(0,0,0,-system.Pindent)
			Color.Parent = temp
			Color.Name = "Color"
			Color.BackgroundColor3 = SelectedObj[name]
			Color.Text = ""
		end
		tempp = Instance.new("TextBox")
		tempp.Size = UDim2.new(0.5,0,1,0)
		tempp.Position = UDim2.new(0.5,0,0,0)
		tempp.Parent = temp
		tempp.Name = "Value"
		tempp.BackgroundTransparency = 1
		tempp.TextColor3 = Color3.new(1,1,1)
		tempp.TextScaled = true
		tempp.ClearTextOnFocus = false
		if SelectedObj and not (SelectedObj[name] == nil) then
			tempp.Text = tostring(SelectedObj[name])
			if func == 5 then
				tempp.Text = ITS(SelectObj[name], true)
			end
		else
			tempp.Text = ""
		end
		tempp.FocusLost:Connect(function()
			local value = tempp.Text
			if func == 1 then
				SelectedObj[name] = value
			elseif func == 3 then
				SelectedObj[name] = tonumber(value)
			elseif func == 4 then
				SelectedObj[name] = ConvertString(value,"Color3")
				Color.BackgroundColor3 = SelectedObj[name]
			elseif func == 5 then
				SelectedObj[name] = ITS(value, false)
			elseif func == 6 then
				SelectedObj[name] = ConvertString(value,"Vector3")
			elseif func == 7 then
				SelectedObj[name] = ConvertString(value,"Vector2")
			elseif func == 8 then
				SelectedObj[name] = ConvertString(value,"UDim")
			elseif func == 9 then
				SelectedObj[name] = ConvertString(value,"UDim2")
			elseif func == 10 then
				SelectedObj[name] = ConvertString(value,"CFrame")
			elseif func == 11 then
				SelectedObj[name] = loadstring(string.gsub("return ENUM","ENUM",value))()
			elseif func == 12 then
				SelectedObj[name] = ConvertString(value,"BrickColor")
			end
		end)
	else
		local value = false
		tempp = Instance.new("TextButton")
		tempp.Size = UDim2.new(0,system.CBSize,0,system.CBSize)
		tempp.Position = UDim2.new(0.75,-system.CBSize/2,0.5,-system.CBSize/2)
		tempp.Parent = temp
		tempp.Name = "Value"
		tempp.BackgroundColor3 = Color3.new(1,1,1)
		tempp.TextColor3 = Color3.new(0,0,0)
		tempp.Text = ""
		tempp.TextScaled = true
		if SelectedObj and SelectedObj[name] == true then
			tempp.Text = "✔"
			value = true
		end
		tempp.Activated:Connect(function()
			value = not value
			SelectedObj[name] = value
			if value then
				tempp.Text = "✔"
			else
				tempp.Text = ""
			end
		end)
	end
	local isTemp = Instance.new("BoolValue")
	isTemp.Parent = temp
	isTemp.Name = "temp"
	isTemp.Value = temporary
end

system.Functions.ChangeObj = function(obj)
	SelectedObj = obj
	system.frames.Properties:FindFirstChild("ClassName").Value.Text = obj.ClassName
	system.frames.Properties:FindFirstChild("Name").Value.Text = obj.Name
	system.frames.Properties:FindFirstChild("Parent").Value.Text = ITS(obj.Parent, true)
	for k,v in pairs(system.frames.Activites:GetChildren()) do
		if v.temp.Value then 
			system.CountAct = system.CountAct - 1
			v:Destroy()
		end
	end
	for k,v in pairs(system.frames.Properties:GetChildren()) do
		if v.temp.Value then 
			system.CountProp = system.CountProp - 1
			v:Destroy()
		end
	end
	for k,v in pairs(system.ActsNF) do
		if k == obj.ClassName then 
			for name,func in pairs(v) do
				system.Functions.AddAct(name,func,true)
			end
		end
	end

	for k,v in pairs(system.PropsNF) do
		if k == obj.ClassName then 
			for name,func in pairs(v) do
				system.Functions.AddProp(name,func,true)
			end
		end
	end
end

local ParentChanged = function(but,v)
	if but:FindFirstChild("Add") then
		if but.Add.Text == "-" then
			for kk,vv in pairs(v:GetChildren()) do
				system.Functions.DelObj(vv)
			end
		end
		but:Destroy()
		system.ObjCreated = system.ObjCreated -1
		Update()
	end
	if SelectedObj == v then
	        if not v.Parent then
		        SelectedObj = nil
	        else
		        system.frames.Properties:FindFirstChild("Parent").Value.Text = ITS(v.Parent, true)
	        end
	end
end

system.Functions.NewObj = function(obj,indent)
	if system.indentMax < indent then system.indentMax = indent end
	local tempF = Instance.new("Frame")
	tempF.Parent = system.frames.Objects
	tempF.Size = UDim2.new(1,-system.sizeY * 1.5,0,system.sizeY)
	tempF.Name = obj.Name 
	tempF.BackgroundTransparency = 1
	tempF.BackgroundColor3 = Color3.new(0.25,0.25,0.7)
	system.ObjCreated = system.ObjCreated +1
	local temp = Instance.new("ObjectValue")
	temp.Parent = tempF
	temp.Name = "Object"
	temp.Value = obj
	local temp = Instance.new("IntValue")
	temp.Parent = tempF
	temp.Name = "Indent"
	temp.Value = indent
	local count = Instance.new("IntValue")
	count.Parent = tempF
	count.Name = "Count"
	local chn = function()
		tempF.Position = UDim2.new(0,system.indent * indent + system.sizeY,0,count.Value * system.sizeY) 
	end
	count.Changed:Connect(chn)
	count.Value = system.ObjCreated -1
	chn()
	local tempAdd = Instance.new("TextButton")
	tempAdd.Parent = tempF
	tempAdd.Size = UDim2.new(0,system.sizeY,1,0)
	tempAdd.Position = UDim2.new(0,-system.sizeY,0,0)
	tempAdd.TextScaled = true
	tempAdd.Text = "+"
	tempAdd.Name = "Add"
	tempAdd.BackgroundTransparency = 1
	tempAdd.TextColor3 = Color3.new(1,1,1)
	obj.ChildAdded:Connect(function(v)
		wait(0.1)
		if not tempAdd then return end
		if tempAdd.Text == "-" then
			local but = system.Functions.NewObj(v,indent+1)
			v.AncestryChanged:Connect(function() ParentChanged(but,v) end)
			wait(0.1)
			if not v.Parent then ParentChanged(but,v) end
		end
		Update()
	end)
	tempAdd.Activated:Connect(function()
		if tempAdd.Text == "+" then
			tempAdd.Text = "-"
			for k,v in pairs(obj:GetChildren()) do
				local but = system.Functions.NewObj(v,indent+1)
				v.AncestryChanged:Connect(function() ParentChanged(but,v) end)
			end
		else
			tempAdd.Text = "+"
			for k,v in pairs(obj:GetChildren()) do
				system.Functions.DelObj(v,indent+1)
			end
		end
		Update()
	end)
	local temp = Instance.new("TextButton")
	temp.Parent = tempF
	temp.Size = UDim2.new(1,-system.sizeY,1,0)
	temp.Position = UDim2.new(0,system.sizeY,0,0)
	temp.TextScaled = true
	temp.Text = obj.Name
	temp.BackgroundTransparency = 1
	temp.TextColor3 = Color3.new(1,1,1)
	temp.TextXAlignment = Enum.TextXAlignment.Left
	obj:GetPropertyChangedSignal("Name"):Connect(function()
		temp.Text = obj.Name
		tempF.Name = obj.Name
	end)
	temp.Activated:Connect(function()
		for k,v in pairs(system.frames.Objects:GetChildren()) do   
			v.BackgroundTransparency = 1
		end
		tempF.BackgroundTransparency = 0
		system.Functions.ChangeObj(obj)
	end)
	local temp = Instance.new("ImageLabel")
	temp.Parent = tempF
	temp.Size = UDim2.new(0,system.sizeY,1,0)
	if system.ClassImage[obj.ClassName] then
		temp.Image = system.ClassImage[obj.ClassName]
	else
		temp.Image = system.ClassImage.NoImage
	end
	temp.Position = UDim2.new(0,0,0,0)
	temp.Name = "Class"
	temp.BackgroundTransparency = 1
	return tempF
end

system.Functions.DelObj = function(obj)
	system.indentMax = 0
	for k,v in pairs(system.frames.Objects:GetChildren()) do
		if not v:FindFirstChild("Object") then return end
		if v.Object.Value == obj then 
			if v.Add.Text == "-" then
				for kv,vv in pairs(obj:GetChildren()) do
					system.Functions.DelObj(vv)
				end
			end
			v:Destroy()
			system.ObjCreated = system.ObjCreated -1
		else
			if system.indentMax < v.Indent.Value then system.indentMax = v.Indent.Value end
		end
	end
end

for name,func in pairs(system.ActsF) do
	system.Functions.AddAct(name,func,false)
end

for name,func in pairs(system.PropsF) do
	system.Functions.AddProp(name,func,false)
end
for k,v in pairs(game:GetChildren()) do
	--system.Functions.NewObj(v,0) 
end
system.Functions.NewObj(game.Workspace,0)
system.Functions.NewObj(game.Players,0)
system.Functions.NewObj(game.Lighting,0)
system.Functions.NewObj(game.ReplicatedStorage,0)

Update()
