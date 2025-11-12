local API
if _G.TimGui and _G.TimGui.Modules then
	API = _G.TimGui.Modules
else API = {}
end API.ApiVersion = 2
--- Players --------------------------------------------------
API.Players = {}
local LP = game.Players.LocalPlayer
API.Players.ForEveryone = function(func,ignoreLP)
	if not func then error("No function!") end
	for k,v in pairs(game.Players:GetPlayers()) do 
		if not ignoreLP and v ~= LP then
			func(v)
		end
	end game.Players.PlayerAdded:Connect(func)
end local ClonedRAnim = {}
API.Players.MakeRepeatAnimator = function(Anim,RAnim)
	if not Anim or not RAnim then warn("Animator is nil") return end
	if ClonedRAnim[RAnim] then return end
	ClonedRAnim[RAnim]=true
	local bindedAnimTracks = {}
	local function CloneAT(AnimTrack)
		if not bindedAnimTracks[AnimTrack] then
			bindedAnimTracks[AnimTrack] = true
			local Animation = AnimTrack.Animation
			local cloneAT = RAnim:LoadAnimation(Animation)
			local function Bind(Param,func)
				AnimTrack:GetPropertyChangedSignal(Param):Connect(function()
					func(AnimTrack[Param])
				end) func(AnimTrack[Param])
			end local function AutoSet(Param)
				Bind(Param,function()
					cloneAT[Param] = AnimTrack[Param]
				end)
			end Bind("IsPlaying",function(v)
				if v then 
					cloneAT:Play()
				else cloneAT:Stop()
				end
			end) AutoSet("Looped")
			AutoSet("Priority")
			Bind("Speed",function(v)
				cloneAT:AdjustSpeed(v)
			end) Bind("TimePosition",function(v)
				if math.abs(v-cloneAT.TimePosition) > 0.1 then
					cloneAT.TimePosition=v
				end
			end)
		end
	end for k,v in pairs(Anim:GetPlayingAnimationTracks()) do
		CloneAT(v)
	end Anim.AnimationPlayed:Connect(CloneAT)
end
API.Players.MakeCloneR15 = function(Char:Model,cloneAnimators,welded)
	local hum = Char:FindFirstChildOfClass("Humanoid")
	if not hum then warn("Humanoid not founded") return end
	if hum.RigType ~= Enum.HumanoidRigType.R15 then warn("Character is not R15") return end
	Char.Archivable = true
	local oldClone = Char:FindFirstChild("Clone")
	local clone = oldClone or Char:Clone()
	local Root = Char:WaitForChild("LowerTorso"):FindFirstChild("Root")
	clone.Parent = Char
	if welded and clone.PrimaryPart then
		clone.PrimaryPart:Destroy()
		local CloneRoot = clone:WaitForChild("LowerTorso"):FindFirstChild("Root")
		CloneRoot.Part0 = Char.PrimaryPart
	end clone.Name = "Clone"
	if not oldClone then
		local RightHand = Char:FindFirstChild("RightHand")
		local cloneRightHand = clone:FindFirstChild("RightHand")
		if RightHand and cloneRightHand then
			RightHand.ChildAdded:Connect(function(weld)
				if weld.Name == "RightGrip" and cloneRightHand.Parent then
					weld.Part0 = cloneRightHand
				end
			end)
		end
	end local cloneHum = clone:FindFirstChildOfClass("Humanoid")
	if cloneAnimators then
		local anim = hum:FindFirstChildOfClass("Animator")
		local cloneAnim = cloneHum:FindFirstChildOfClass("Animator")
		if anim and cloneHum then
			API.Players.MakeRepeatAnimator(anim,cloneAnim)
		end
	end local function BindHumP(Param)
		hum:GetPropertyChangedSignal(Param):Connect(function()
			cloneHum[Param] = hum[Param]
		end) cloneHum[Param] = hum[Param]
	end BindHumP("Health")
	BindHumP("MaxHealth")
	BindHumP("DisplayName")
	return clone,Root
end API.Players.DelCloneR15 = function(Char:Model)
	local clone = Char:FindFirstChild("Clone")
	if not clone then return end
	local hum = Char:FindFirstChildOfClass("Humanoid")
	if not hum then warn("Humanoid not founded") return end
	if hum.RigType ~= Enum.HumanoidRigType.R15 then warn("Character is not R15") return end
	clone:Destroy()
	local RightHand = Char:FindFirstChild("RightHand")
	if not RightHand then return end
	local RightGrip = RightHand:FindFirstChild("RightGrip")
	if RightGrip then RightGrip.Part0 = RightHand end
end
--- ESP ------------------------------------------------------
API.ESP = {}
local Binded = {}
local HighlightsPlrs = {}
local ESPFolder = Instance.new("Folder")
if _G.TimGui and _G.TimGui.Path then
	ESPFolder.Parent = _G.TimGui.Path.gui
else ESPFolder.Parent = game.CoreGui
end ESPFolder.Name = "NotESP"
local BoardsSize = 7
API.ESP.Bind = function(PrioryN,func)
	local Priory = Binded[PrioryN]
	if Priory == nil then
		Priory = {}
		Binded[PrioryN] = Priory
	end table.insert(Priory,1,func)
	API.ESP.Refresh()
end API.ESP.EnableBoards = true
API.ESP.Refresh = function(Player:Player?)
	if not Player then
		for k,v in pairs(game.Players:GetPlayers()) do
			if v ~= LP then 
				API.ESP.Refresh(v)
			end
		end
	else 
		local Priory = {}
		for k,v in pairs(Binded) do
			table.insert(Priory,{k,v})
		end table.sort(Priory,function(a,b)
			return a[1]>b[1]
		end) local res,broke
		for _,v in pairs(Priory) do
			for _,f in pairs(v[2]) do
				local s,val = pcall(f,Player)
				if s then
					if val == false then
						broke = true
						break
					elseif typeof(val) == "Color3" then
						res = val
						break
					end
				else task.spawn(function() error(val) end)
				end
			end if broke or res then break end
		end local highlight = HighlightsPlrs[Player]
		if not highlight then warn("No highlight for "..Player.Name) return end
		local board = highlight:FindFirstChild("board")
		if not board then warn("No board for "..Player.Name) return end
		if not res then
			highlight.Enabled = false
			board.Enabled = false
		else highlight.Enabled = true
			board.Enabled = API.ESP.EnableBoards
			highlight.FillColor = res
			highlight.OutlineColor = res
	        board.nick.TextColor3 = res
		end
	end
end API.ESP.SetBoardSize = function(size)
	BoardsSize = tonumber(size)or 7
	for k,v in pairs(HighlightsPlrs) do 
		v.board.Size = UDim2.new(BoardsSize,0,BoardsSize/3.3,0)
	end API.ESP.Refresh()
end
API.Players.ForEveryone(function(Player)
	local highlight = Instance.new("Highlight",ESPFolder)
	highlight.Enabled = false
	highlight.Name = Player.Name
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	HighlightsPlrs[Player] = highlight
	local board = Instance.new("BillboardGui",highlight)
	board.Size = UDim2.new(BoardsSize,0,BoardsSize/3.3,0)
	board.Name = "board"
	board.AlwaysOnTop = true
	board.Enabled = false
	local name = Instance.new("TextLabel",board)
	name.Size = UDim2.new(1,0,0.6,0)
	name.BackgroundTransparency = 1
	name.TextStrokeTransparency = 0
	name.TextColor3 = Player.TeamColor.Color
	name.TextScaled = true
	name.Text = Player.Name
	name.Name = "nick"
	local dist = Instance.new("TextLabel",board)
	dist.Size = UDim2.new(0.6,0,0.4,0)
	dist.Position = UDim2.new(0,0,0.6,0)
	dist.BackgroundTransparency = 1
	dist.TextStrokeTransparency = 0
	dist.TextStrokeColor3 = Color3.new(1,1,1)
	dist.TextColor3 = Color3.new(0,0,0)
	dist.TextScaled = true
	dist.Text = 0
	local health = Instance.new("TextLabel",board)
	health.Size = UDim2.new(0.4,0,0.4,0)
	health.Position = UDim2.new(0.6,0,0.6,0)
	health.BackgroundTransparency = 1
	health.TextStrokeTransparency = 0
	health.TextColor3 = Color3.new(1,1,0)
	health.TextScaled = true
	health.Text = ".../..."
	local function newChar(Character)
		board.Adornee = Character
		highlight.Adornee = Character
		task.spawn(function()
			while Character.Parent do
				task.wait(2)
				if highlight.Enabled then
					highlight.Adornee = Character
				end
			end
		end)
		local hum = Character:FindFirstChildOfClass("Humanoid")or Character:WaitForChild("Humanoid")
		local function refreshHP()
			if hum.Parent == nil then return end
			local HP = Player.Character.Humanoid.Health
			local MHP = Player.Character.Humanoid.MaxHealth
			local res = HP/MHP
			health.Text = math.floor(HP).."/"..MHP
			health.TextColor3 = Color3.new(res,1-res,0)
		end refreshHP()
		hum:GetPropertyChangedSignal("MaxHealth"):Connect(refreshHP)
		hum:GetPropertyChangedSignal("Health"):Connect(refreshHP)
		API.ESP.Refresh(Player)
	end if Player.Character then newChar(Player.Character) end
	Player.CharacterAdded:Connect(newChar)
	task.spawn(function()
		while highlight.Parent do
			wait(0.25)
			if board.Enabled then
				if LP.Character and Player.Character then
					local LHRP = LP.Character.PrimaryPart
					local HRP = Player.Character.PrimaryPart
					if LHRP and HRP then
						local count = LHRP.Position - HRP.Position
						local adding = math.abs(count.X) + math.abs(count.Y) + math.abs(count.Z)
						dist.Text = math.floor(adding)
					end
				end
			end
		end
	end)
end,false)
game.Players.PlayerRemoving:Connect(function(Player)
	HighlightsPlrs[Player]:Destroy()
	HighlightsPlrs[Player] = nil
end)
--- Freeze -----------------------------------------------------------------------------------
API.Freeze = {}
local BindedFreeze = {}
API.Freeze.Bind = function(PrioryN,func)
	local Priory = BindedFreeze[PrioryN]
	if Priory == nil then
		Priory = {}
		BindedFreeze[PrioryN] = Priory
	end table.insert(Priory,1,func)
	API.Freeze.Refresh()
end API.Freeze.EnableFakeChars = true
API.Freeze.ThisRefreshIntTab = {}
API.Freeze.Refresh = function(Player:Player?)
	if not Player then
		for k,v in pairs(game.Players:GetPlayers()) do
			if v ~= LP then 
				API.Freeze.Refresh(v)
			end
		end
	else API.Freeze.ThisRefreshIntTab[Player] += 1
		local character = Player.Character
		if not character then return end
		local Priory = {}
		for k,v in pairs(BindedFreeze) do
			table.insert(Priory,{k,v})
		end table.sort(Priory,function(a,b)
			return a[1]>b[1]
		end) local res,broke
		local enableFakeChars = API.Freeze.EnableFakeChars
		for _,v in pairs(Priory) do
			for _,f in pairs(v[2]) do
				local s,val,enFakeChars = pcall(f,Player)
				if s then
					if val == false then
						broke = true
						break
					else
						res = val
						if enFakeChars ~= nil then enableFakeChars = enFakeChars end
						break
					end
				else task.spawn(function() error(val) end)
				end
			end if broke or res then break end
		end 
		if not res then
			if character:FindFirstChild("Clone") then
				local cloneChar,Root = API.Players.MakeCloneR15(character)
				Root.Enabled = true
				Root.Parent.Anchored = false
			end character.PrimaryPart.Anchored = false
			API.Players.DelCloneR15(character)
		else local RootPart = character.PrimaryPart
			if not RootPart then character:GetPropertyChangedSignal("PrimaryPart") RootPart = character.PrimaryPart end
			RootPart.Anchored = not enableFakeChars
			if enableFakeChars then
				local cloneChar,Root = API.Players.MakeCloneR15(character,true,true)
				RootPart = Root.Parent
				Root.Enabled = false
				Root.Parent.Anchored = true
			elseif character:FindFirstChild("Clone") then
				local cloneChar,Root = API.Players.MakeCloneR15(character)
				Root.Enabled = true
				Root.Parent.Anchored = false
				API.Players.DelCloneR15(character)
			end if typeof(res)=="Vector3" then
				res = CFrame.new(res)
			end if typeof(res)=="CFrame" then
				RootPart.CFrame = res
			elseif type(res)=="function" then
				res(RootPart,Player,API.Freeze.ThisRefreshIntTab)
			end
		end
	end
end
API.Players.ForEveryone(function(Player)
	API.Freeze.ThisRefreshIntTab[Player] = 0
	local function newChar(Character)
		Character:GetPropertyChangedSignal("PrimaryPart"):Wait()
		task.wait(0.25)
		API.Freeze.Refresh(Player)
	end Player.CharacterAdded:Connect(newChar)
end,false)

return API
