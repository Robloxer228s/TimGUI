-- Zombie lab
local group = _G.TimGui.Groups.CreateNewGroup("Zombie lab")
local Events = game.ReplicatedStorage.Remotes
group.Create(1,"virus","Get virus","Получить вирус",function() 
	Events.GiveVirus:FireServer()
end) 
group.Create(1,"cure","Get cure","Получить инъекцию",function() 
	Events.GiveCure:FireServer()
end) 

-- Costomize --
local pathIDK = game.Players.LocalPlayer.PlayerGui.Main
group.Create(0,"Tittle1","Costomize(Zombie)","Костомизировать зобли")
group.Create(1,"cf","Change face","Изменить лицо",function() 
	pathIDK.ChooseFaceFrame.Visible = true
end) 
group.Create(1,"cs","Change skin","Изменить цвет кожи",function() 
	pathIDK.ChooseColorFrame.Visible = true
end) 
-- Other --
group.Create(0,"Tittle2","Other","Другое")
group.Create(1,"dh","Delete human only","Удалить только для людей",function() 
game.Workspace.HumanOnlyDoor:Destroy()
end) 
group.Create(1,"ds","Delete safe virus zone","Удалить антивирус",function() 
game.Workspace.AntiWeaponZone:Destroy()
end) 

group.Create(0,"Tittle3","Kill zombies","Убийство зомби")
local aknz = group.Create(2,"aknz","Kill NPC Zombies(auto)","Убить НПС зомби(авто)")

local function killZombie(char) 
	if not char:FindFirstChild("HumanoidRootPart") then return false end
	if _G.TimGui.Values.Spare[char.Name] then return true end
	local args = {
		[1] = char:WaitForChild("Humanoid"),
		[2] = char:WaitForChild("HumanoidRootPart"),
		[3] = math.huge,
	}
	--In character
	if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
		if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("GunScript_Server") then
			game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").GunScript_Server.InflictTarget:FireServer(unpack(args))
			return true
		end
	end
	-- Find gun and kill char
	for k,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:FindFirstChild("GunScript_Server") then
			v.GunScript_Server.InflictTarget:FireServer(unpack(args))
			return true
		end
	end
	return false
end

group.Create(1,"kaz","Kill All Zombies","Убить всех зомби",function() 
	for k,v in pairs(game.Players:GetPlayers()) do
		killZombie(v.Character)
	end
end) 

local ZN = group.Create(3,"ZN","Zombie:","Зомби:") 
group.Create(1,"kz","Kill Zombie","Убить зомби",function() 
	v = game.Players:FindFirstChild(ZN.Value) 
	if v then
		killZombie(v.Character)
	end
end) 

group.Create(1,"knz","Kill NPC Zombies","Убить НПС зомби",function()
	for k, v in pairs(game.Workspace.Zombies:GetChildren()) do
		killZombie(v)
	end
end) 

local KTZWAM = group.Create(2,"KAM","Kill those zombies who are moving","убивать, тех зомби кто двигается")
local function Check(Char) 
	local function Changed()
		if KTZWAM.Value then 
			killZombie(Char)
		end
	end
	Char:WaitForChild("Humanoid",math.huge):GetPropertyChangedSignal("MoveDirection"):Connect(Changed)
end

local function NewPlayer(Player) 
	if not Player:IsA("Player") then return end
	Player.CharacterAdded:Connect(Check)
	Check(Player.Character) 
end

for k, v in pairs(game.Players:GetPlayers()) do
	if not v.Character then v.CharacterAdded:Wait() end
	if v.Character:FindFirstChild("Humanoid") then
		NewPlayer(v)
	else
		local i = Instance.new("BoolValue")
		i.Changed:Connect(function()
			NewPlayer(v)
		end)
		i.Value = true
	end
end

game.Players.PlayerAdded:Connect(NewPlayer)

while true do 
	wait(1) 
	if aknz.Value then
		for k, v in pairs(game.Workspace.Zombies:GetChildren()) do
			if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
				killZombie(v)
			end 
		end
	end
end 
