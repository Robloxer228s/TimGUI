-- Froggy
local group = _G.TimGui.Groups.ESP
local ESPV = group.Create(2,"ESPVgame","ESP all","ESP все",function()_G.TimGui.Modules.ESP.Refresh()end) 
local ESPF = group.Create(2,"ESPFgame","ESP froggy","ESP к лягушке",function()_G.TimGui.Modules.ESP.Refresh()end) 

_G.TimGui.Modules.ESP.Bind(2,function(Player)
	if Player.Character.Name~=Player.Name then
		if ESPF.Value then
			return Color3.new(1,0,0)
		end
	elseif ESPV.Value then
		return Color3.new(0,1,0)
	end
end)
