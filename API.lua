local API
if _G.TimGui and _G.TimGui.Modules then
	API = _G.TimGui.Modules
else API = {}
end API.ApiVersion = 1
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
end
--- ESP ------------------------------------------------------
API.ESP = {}
local Binded = {}
local HighlightsPlrs = {}
local ESPFolder = Instance.new("Folder",_G.TimGui.Path.gui)
local BoardsSize = 7
API.ESP.Bind = function(PrioryN,func)
	local Priory = Binded[PrioryN]
	if Priory == nil then
		Priory = {}
		Binded[PrioryN] = Priory
	end table.insert(Priory,func)
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
			return a[1]>b[2]
		end) local res,broke
		for _,v in pairs(Priory) do
			for _,f in pairs(v[2]) do
				local val = f(Player)
				if val == false then
					broke = true
					break
				elseif typeof(val) == "Color3" then
					res = val
					break
				end
			end if broke or res then break end
		end local highlight = HighlightsPlrs[Player]
		local board = highlight:FindFirstChild("board")
		if not highlight then warn("No highlight for "..Player.Name) return end
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
	for k,v in pairs(BoardsPlrs) do 
		v.Size = UDim2.new(BoardsSize,0,BoardsSize/3.3,0)
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
			for k=1,20,1 do
				if not Character.Parent then break end
				task.wait(1.5)
				highlight.Adornee = Character
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

return API
