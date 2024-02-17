_G.AGF("TP to Waypoint") 
_G.AGF("Waypoints Settings") 

local Name = _G.ATBF("Name", "Name:", "Waypoints Settings", 1) 
local Create = _G.ABF("Create", "Create and set or set", "Waypoints Settings", 2) 
-- local SetW = _G.ABF("Set", "Set", "Waypoints Settings", 1) 
-- local Delete = _G.ABF("Delete", "Delete", "Waypoints Settings", 3) 

local Waypoints = {}
local Created = {}

local function Set() 
Waypoints[Name.Text] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end

-- SetW.Activated:Connect(Set()) 
Create.Activated:Connect(function() 
if not Created[Name.Text] then
local tmp = _G.ABF(Name.Text, Name.Text, "TP to Waypoint", #Created + 1) 
local Nam = Name.Text
tmp.Activated:Connect(function() 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Waypoints[Nam]
end) 
Created[Name.Text] = true
end
Set() 
end) 
