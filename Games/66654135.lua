-- Murder Mystory 2
local GetData = game.ReplicatedStorage.Remotes.Gameplay.GetCurrentPlayerData
local Data = GetData:InvokeServer()
local ESPGroup = _G.TimGui.Groups.ESP
local group = _G.TimGui.Groups.CreateNewGroup("MM2")
local ESP = {}
local Murder
local Sheriff
ESPGroup.Create(0,"MM2","MM2","MM2")
ESP.Innocent = ESPGroup.Create(2,"Innocent","ESP to innocent","ESP на невиновного")
ESP.Murderer = ESPGroup.Create(2,"Murderer","ESP to murderer","ESP на убийцу")
ESP.Sheriff = ESPGroup.Create(2,"Sheriff","ESP to sheriff","ESP на шерифа")
ESP.Killed = ESPGroup.Create(2,"Killed","ESP to killed","ESP на убитых")
ESP.GunDrop = ESPGroup.Create(2,"Gun","ESP to dropped gun","ESP на пистолет")
local ESPColor = {
	Murderer = Color3.new(1,0,0),
	Sheriff = Color3.new(0,0,1),
	Innocent = Color3.new(0,1,0)
}

local function ESPUpd(char,color)
	if char then
		local ESPObj = char:FindFirstChild("NotESP")
		if not ESPObj then
			ESPObj = Instance.new("Highlight")
			ESPObj.Parent = char
			ESPObj.Name = "NotESP"
			ESPObj.Adornee = char
			ESPObj.Archivable = true
			ESPObj.Enabled = true
			ESPObj.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			ESPObj.FillTransparency = 0.5
			ESPObj.OutlineTransparency = 0
		end
		ESPObj.FillColor = color
		ESPObj.OutlineColor = color
	end
end

local SheriffNick = group.Create(0,"SheriffNick","Sheriff: nobody","Шериф: никто")
local MurderNick = group.Create(0,"MurderNick","Murder: nobody","Убийца: никто")
local GunDropName = "GunDrop"
local Map
local function NewMap(isMap)
	if isMap then
		wait()
		if isMap:FindFirstChild("Base") or isMap:FindFirstChild("CoinContainer") then
			Map = isMap
		end
	else
		for k,v in pairs(game.Workspace:GetChildren()) do
			NewMap(v)
		end
	end
end
game.Workspace.ChildAdded:Connect(NewMap)
while Map == nil do
	NewMap()
	wait()
end

local FirstAFK = true
local MoneyVisual = "CoinVisual"
local reset = group.Create(2,"AFKReset","Reset on full bag","Умерать при полном шишке")
group.Create(2,"AFK","AFK(get money)","АФК",function(val)
	if FirstAFK then
		FirstAFK = false
		local function getMoney()
			local money
			local dist
			local char = game.Players.LocalPlayer.Character
			if not char then return end
			if not char.PrimaryPart then return end
			if not Map:FindFirstChild("CoinContainer") then return end
			local children = Map.CoinContainer:GetChildren()
			if #children == 0 then return end
			local visibles = 0
			for k,v in pairs(children) do
				local visual = v:FindFirstChild(MoneyVisual)
				if visual then
					if visual.Transparency == 0 then
						visibles += 1
						local pos = v.Position - char.PrimaryPart.Position
						local thisDist = math.abs(pos.X) + math.abs(pos.Y) + math.abs(pos.Z)
						if dist == nil then
							dist = thisDist
							money = v
						elseif thisDist < dist then
							dist = thisDist
							money = v
						end
					end
				end
			end
			if visibles == 0 then
				if reset.Value then
					if char:FindFirstChild("Humanoid") then
						if Data[char.Name] then
							if not Data[char.Name].Dead then
								char.Humanoid:TakeDamage(math.huge)
							end
						end
					end
				end
				return
			end
			return money,dist
		end
		while task.wait(0.2) do
			if val.Value then
				local money,distance = getMoney()
				if money then
					local char = game.Players.LocalPlayer.Character
					local timer = math.abs(distance)/30 +0.1
					if timer < 30 then
						local goal = {}
						goal.CFrame = money.CFrame -- + Vector3.new(0, -2, 0)
						local Tween = game:GetService("TweenService"):Create(char.PrimaryPart, TweenInfo.new(timer), goal)
						for t=1,20 do
							Tween:Play() 
							wait(timer/20)
							Tween:Pause()
							if money then
								local visual = money:FindFirstChild(MoneyVisual)
								if visual then
									if visual.Transparency == 0 then continue end
								end
							end
							break
						end
					else
						char.PrimaryPart.CFrame = money.CFrame
						wait(1.5)
					end
				end
			end
		end
	end
end)

group.Create(0,"TPs","Teleports","Телепорты")
local function GetRandomSpwn(parent)
	local children = parent:GetChildren()
	return children[math.random(1,#children)]
end
group.Create(1,"TP to map","TP to map","ТП на карту",function()
	game.Players.LocalPlayer.Character.PrimaryPart.CFrame = GetRandomSpwn(Map.Spawns).CFrame
end)
group.Create(1,"TP to spawn","TP to spawn","ТП на спавн",function()
	game.Players.LocalPlayer.Character.PrimaryPart.CFrame = GetRandomSpwn(game.Workspace.Lobby.Spawns).CFrame
end)
group.Create(1,"TP to gun","TP to gun","ТП к пистолету",function()
	game.Players.LocalPlayer.Character.PrimaryPart.CFrame = Map[GunDropName].CFrame
end)
group.Create(1,"TP to murder","TP to murder","ТП к убийце",function()
	game.Players.LocalPlayer.Character.PrimaryPart.CFrame = Murder.Character.PrimaryPart.CFrame
end)
group.Create(1,"TP to sheriff","TP to sheriff","ТП к шерифу",function()
	game.Players.LocalPlayer.Character.PrimaryPart.CFrame = Sheriff.Character.PrimaryPart.CFrame
end)
group.Create(0,"AutoTPs","Auto Teleports","Авто телепорты")
local autoTPMurd = group.Create(2,"AutoTP to murder","AutoTP to murder","АвтоТП к убийце")
local autoTPSher = group.Create(2,"AutoTP to sheriff","AutoTP to sheriff","АвтоТП к шерифу")
group.Create(0,"AIM","AIM","АИМ")
local AIM = group.Create(2,"AIMM","AIM to murder","Наводка на убийцу")
local AAIM = group.Create(2,"AAIM","AutoAIM to murder","Авто наводка на убийцу")

game:GetService("RunService").RenderStepped:Connect(function()
	local char = game.Players.LocalPlayer.Character
	if char then
		if Murder then
			if AAIM.Value and char:FindFirstChild("Gun") then
				AIM.Main.Value = true
			elseif AAIM.Value then
				AIM.Main.Value = false
			end if AIM.Value then
				game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(char.Head.Position, Murder.Character.HumanoidRootPart.Position) 
			end
			if autoTPMurd.Value then
				char.PrimaryPart.CFrame = Murder.Character.PrimaryPart.CFrame
			end
		end if Sheriff then
			if autoTPSher.Value then
				game.Players.LocalPlayer.Character.PrimaryPart.CFrame = Sheriff.Character.PrimaryPart.CFrame
			end
		end
	end
end)

while task.wait(0.25) do
	if not Map.Parent then
		NewMap()
	end
	Data = GetData:InvokeServer()
	local gundrop = Map:FindFirstChild(GunDropName)
	if gundrop then
		if ESP.GunDrop.Value then
			ESPUpd(gundrop,Color3.new(1,1,0))
		elseif gundrop:FindFirstChild("NotESP") then
			gundrop.NotESP:Destroy()
		end
	end
	Murder = nil
	Sheriff = nil
	for _,player in pairs(game.Players:GetPlayers()) do
		if player == game.Players.LocalPlayer then continue end
		local v = Data[player.Name]
		local active = false
		if not v then
			if ESP.Killed.Value then
				active = true
				ESPUpd(player.Character,Color3.new(1,1,1))
			end
		else
			if v.Dead then
				if ESP.Killed.Value then
					active = true
					ESPUpd(player.Character,Color3.new(1,1,1))
				end
			else
				if ESP[v.Role] then
					if ESP[v.Role].Value then
						active = true
						ESPUpd(player.Character,ESPColor[v.Role])
					end
					if v.Role == "Sheriff" then
						Sheriff = player
					elseif v.Role == "Murderer" then
						Murder = player
					end
				elseif v.Role == "Hero" then
					Sheriff = player
					if ESP.Sheriff.Value then
						active = true
						ESPUpd(player.Character,ESPColor.Sheriff)
					end
				end
			end
		end
		if active == false then
			local ESPObj = player.Character
			if ESPObj then
				ESPObj = ESPObj:FindFirstChild("NotESP")
				if ESPObj then
					ESPObj:Destroy()
				end
			end
		end
	end
	if Sheriff then
		SheriffNick.Text = "Sheriff: "..Sheriff.Name
		SheriffNick.RusText = "Шериф: "..Sheriff.Name
	else
		SheriffNick.Text = "Sheriff: nobody"
		SheriffNick.RusText = "Шериф: никто"
	end if Murder then
		MurderNick.Text = "Murder: "..Murder.Name
		MurderNick.RusText = "Убийца: "..Murder.Name
	else
		MurderNick.Text = "Murder: nobody"
		MurderNick.RusText = "Убийца: никто"
	end
end
