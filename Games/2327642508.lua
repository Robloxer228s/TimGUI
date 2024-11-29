local group = _G.TimGui.Groups.CreateNewGroup("Laundry","Прачечная")
local LocalPlayer = game.Players.LocalPlayer
local Clothing = game.Workspace.Debris.Clothing
local Events = game.ReplicatedStorage.Events
group.Create(2,"Speed","Donate: NitroSpeed","НитроСкорость",function(val)
    LocalPlayer.Gamepasses.NitroSpeed.Value = val.Value
end)
group.Create(0,"Tittle","Grab","Брать")
group.Create(0,"TIP","P.S:It grab clothings in 25 studs","P.S:Оно берёт одежду менее 25 шагов")
local function TPClothing(notrare,fullbaskNR)
    for k,v in pairs(Clothing:GetChildren()) do
        if v.Name == "Magnet" then continue end
        if v:FindFirstChild("Sound") or notrare then
            if LocalPlayer.NonSaveVars.TotalWashingMachineCapacity.Value < LocalPlayer.NonSaveVars.BackpackAmount.Value + 1 then
            	_G.TimGui.Print("Warning","You don't have enough washing machine capacity","Проблема","Тебе не хватает место в машинах")
            elseif 0 < LocalPlayer.NonSaveVars.BackpackAmount.Value and LocalPlayer.NonSaveVars.BasketStatus.Value == "Clean" then
            	_G.TimGui.Print("Warning","You can't put dirty laundry in a clean basket","Проблема","Ты не можешь положить это в корзину с чистыми панталонами")
            elseif LocalPlayer.NonSaveVars.BackpackAmount.Value < LocalPlayer.NonSaveVars.BasketSize.Value then
            	_G.TimGui.Print("Warning","Basket is full","Проблема","Корзина пуста")
            else
            	game.SoundService.Misc.Pick:Play()
            	Events.GrabClothing:FireServer(v)
            end
            if notrare and not fullbaskNR then return end
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
    TPClothing(true,false)
end)

group.Create(1,"TPAllClothings","Grab All Clothings","Взять все вещи",function()
    TPClothing(true,true)
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
