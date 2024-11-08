-- Froggy
local group = _G.TimGui.Groups.ESP
local ESPV = group.Create(2,"ESPVgame","ESP all","ESP все") 
local ESPF = group.Create(2,"ESPFgame","ESP froggy","ESP к лягушке") 

local function CESP(char)
	local ESP = Instance.new("Highlight")
	ESP.Parent = char
	ESP.Name = "NotEsp"
	ESP.Adornee = char
	ESP.Archivable = true
	ESP.Enabled = true
	ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	ESP.FillColor = Color3.new(1,1,1)
	local dest = false
	if char.Name == "Frogge" then
		if ESPF.Value then
			ESP.FillColor = Color3.new(0, 1, 0) 
		else
			ESP:Destroy() 
			return
		end
	end
	ESP.FillTransparency = 0.5
	ESP.OutlineColor = ESP.FillColor
	ESP.OutlineTransparency = 0
end

local function AddPlayer(player)
	player.CharacterAdded:Connect(function(char) 
		if ESPV.Value then
			CESP(char) 
		elseif char.Name == "Frogge" and ESPF.Value then
			CESP(char) 
		end
	end)
end

for k,player in pairs(game.Players:GetChildren()) do
	if not (player == game.Players.LocalPlayer) then
		AddPlayer(player)
	end
end
game.Players.PlayerAdded:Connect(AddPlayer)

ESPV.OnChange(function(val) 
	for k,player in pairs(game.Players:GetChildren()) do
		local char = player.Character
		if ESPV.Value and not (player == game.Players.LocalPlayer) then
			CESP(char) 
		elseif not val.Value and char:FindFirstChild("NotEsp") then
			char.NotEsp:Destroy() 
		end
	end
end) 

ESPF.OnChange(function(val) 
	for k,player in pairs(game.Players:GetChildren()) do
		local char = player.Character
		if char.Name == "Frogge" and val.Value then
			CESP(char) 
		elseif char.Name == "Frogge" and char:FindFirstChild("NotEsp") then
			char.NotEsp:Destroy() 
		end
	end
end) 
