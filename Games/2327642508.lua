local group = _G.TimGui.Groups.CreateNewGroup("Laundry","Прачечная")
local LocalPlayer = game.Players.LocalPlayer
local Clothing = game.Workspace.Debris.Clothing
local Events = game.ReplicatedStorage.Events
local MyPlot = LocalPlayer.NonSaveVars.OwnsPlot.Value
group.Create(2,"Speed","Donate: NitroSpeed","НитроСкорость",function(val)
    LocalPlayer.Gamepasses.NitroSpeed.Value = val.Value
end)
group.Create(1,"DC","Drop cloth in chute","Положить чистую одежду",function(val)
    Events.DropClothesInChute:FireServer()
end)
LocalPlayer.NonSaveVars.OwnsPlot.Changed:Connect(function()
	MyPlot = LocalPlayer.NonSaveVars.OwnsPlot.Value
end)
local function MachineClick(isGrab)
	if MyPlot then
		local Machines = MyPlot.WashingMachines:GetChildren()
		table.sort(Machines,function(a,b)
			return tonumber(a.Name) > tonumber(b.Name)
		end)
		for k,v in pairs(Machines) do
			if v.Config.Started.Value or v.Config.CycleFinished.Value then
				if isGrab then
					Events.UnloadWashingMachine:FireServer(v)
				end
			elseif not isGrab then
				Events.LoadWashingMachine:FireServer(v)
			end
		end
	end
end
group.Create(1,"DCM","Drop cloth in machine","Положить грязную одежду в машины",function(val)
	MachineClick(false)
end)
group.Create(1,"GCM","Grab cloth from machine","Взять чистую одежду из машины",function(val)
	MachineClick(true)
end)
group.Create(0,"Tittle","Grab","Брать")
group.Create(0,"TIP","P.S:It grab clothings in 25 studs","P.S:Оно берёт одежду менее 25 шагов")
local function TPClothing(notrare,oneOnly)
	local Count
	if tonumber(oneOnly) ~= nil then
		Count = oneOnly
		oneOnly = false
	end
    for k,v in pairs(Clothing:GetChildren()) do
        if v.Name == "Magnet" then continue end
        if v:FindFirstChild("Sound") or notrare then
            if LocalPlayer.NonSaveVars.TotalWashingMachineCapacity.Value < LocalPlayer.NonSaveVars.BackpackAmount.Value + 1 then
            	_G.TimGui.Print("Warning","You don't have enough washing machine capacity","Проблема","Тебе не хватает место в машинах")
				return
            elseif 0 < LocalPlayer.NonSaveVars.BackpackAmount.Value and LocalPlayer.NonSaveVars.BasketStatus.Value == "Clean" then
            	_G.TimGui.Print("Warning","You can't put dirty laundry in a clean basket","Проблема","Ты не можешь положить это в корзину с чистыми панталонами")
				return
            elseif LocalPlayer.NonSaveVars.BackpackAmount.Value > LocalPlayer.NonSaveVars.BasketSize.Value then
            	_G.TimGui.Print("Warning","Basket is full","Проблема","Корзина заполнена")
				return
            else
				Events.GrabClothing:FireServer(v)
				if notrare then
					local magn = LocalPlayer.Character.PrimaryPart.Position.Magnitude
					magn = math.abs(magn) - math.abs(v.CFrame.Position.Magnitude)
					if magn <= 25 then
						if Count ~= nil then
							Count += -1
							if Count == 0 then
								oneOnly = true
							end
						end
						game.SoundService.Misc.Pick:Play()
						if oneOnly then return end
						wait()
					end
				else
					game.SoundService.Misc.Pick:Play()
				end
            end
        end
    end
end

group.Create(1,"TPMagnit","Grab Magnit","Взять магнит",function()
    for k,v in pairs(Clothing:GetChildren()) do
        if v.Name == "Magnet" then
            game.SoundService.Misc.Pick:Play()
            Events.GrabClothing:FireServer(v)
            break
        end
    end
end)

group.Create(1,"TPRareClothings","Grab Rare Clothings","Взять редкие вещи",function()
    TPClothing(false)
end)

group.Create(1,"TPClothings","Grab Clothing","Взять вещь",function()
    TPClothing(true,true)
end)

group.Create(1,"TPAllClothings","Grab All Clothings","Взять все вещи",function()
    TPClothing(true,false)
end)

group.Create(0,"Tittle2","TP","ТП")
local function TPtoClothing(notrare)
    for k,v in pairs(Clothing:GetChildren()) do
        if v.Name == "Magnet" then continue end
        if v:FindFirstChild("Sound") or notrare then
            LocalPlayer.Character.PrimaryPart.CFrame = v.CFrame
            return
        end
    end
end

group.Create(1,"TPtMagnit","TP to Magnit","ТП в магнит",function()
    for k,v in pairs(Clothing:GetChildren()) do
        if v.Name == "Magnet" then
            local magn = math.abs(v.CFrame.Position.Magnitude - LocalPlayer.Character.PrimaryPart.Position.Magnitude)
            if magn > 25 then continue end
            LocalPlayer.Character.PrimaryPart.CFrame = v.CFrame
        end
    end
end)

group.Create(1,"TPtRareClothing","TP to Rare Clothing","ТП в редкую вещь",function()
    TPtoClothing(false)
end)

group.Create(1,"TPtClothings","TP to Clothing","ТП в вещь",function()
    TPtoClothing(true)
end)

group.Create(1,"MyPlot","TP to my plot","ТП ко мне на участок",function()
	if MyPlot then
		LocalPlayer.Character.PrimaryPart.CFrame = MyPlot.Spawn.Bottom.CFrame + Vector3.new(0,5,0)
	end
end)
local OptPos = CFrame.new(Vector3.new(-25, 5, -10),Vector3.new(90,0,0))
local chutePos = CFrame.new(Vector3.new(-135, 5, -10),Vector3.new(-90,0,0))
group.Create(1,"OptimalPosition","TP to optimal position for grab","ТП на оптимальную точка для взятия предметов",function()
	LocalPlayer.Character.PrimaryPart.CFrame = OptPos
end)
group.Create(1,"OptimalPositionChute","TP to chute","ТП к здавателю",function()
	LocalPlayer.Character.PrimaryPart.CFrame = chutePos
end)
group.Create(0,"Tittle3","AFK","АФК")
local AFK = group.Create(2,"AFK","AFK enable","Включить АФК")
local fiveempty = group.Create(2,"5 amount empty for rare cloth","5 amount empty for rare cloth","Оставить 5 пустых мест для редких предметов")
local grabRare = group.Create(2,"Grab only rare cloth","Grab only rare cloths","Брать только редкие панталоны")
fiveempty.Main.Value = true

while task.wait() do
	if AFK.Value and MyPlot then
		LocalPlayer.Character.PrimaryPart.CFrame = MyPlot.Spawn.Bottom.CFrame + Vector3.new(0,5,0)
		wait()
		MachineClick(false)
		wait()
		MachineClick(true)
		if 0 < LocalPlayer.NonSaveVars.BackpackAmount.Value and LocalPlayer.NonSaveVars.BasketStatus.Value == "Clean" then
			LocalPlayer.Character.PrimaryPart.CFrame = chutePos
			wait(LocalPlayer:GetNetworkPing()+0.05)
			Events.DropClothesInChute:FireServer()
			wait()
		end
		local empty = LocalPlayer.NonSaveVars.TotalWashingMachineCapacity.Value - LocalPlayer.NonSaveVars.BackpackAmount.Value
		if empty ~= 0 then
			LocalPlayer.Character.PrimaryPart.CFrame = OptPos
			wait()
			TPClothing(false)
			if fiveempty then
				if empty <= 5 then
					continue
				end
			end
			if not grabRare.Value then
				local grabing = LocalPlayer.NonSaveVars.BasketSize.Value/4
				if empty - grabing < 5 then
					grabing = grabing - (empty-grabing+5)
				end
				TPClothing(true,grabing)
			end
		end
	end
end
