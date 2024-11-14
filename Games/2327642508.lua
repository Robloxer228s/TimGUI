local group = _G.TimGui.Groups.CreateNewGroup("Laundry","Прачечная")
local LocalPlayer = game.Players.LocalPlayer
local Clothing = game.Workspace.Debris.Clothing
group.Create(2,"Speed","Donate: NitroSpeed","НитроСкорость",function(val)
    LocalPlayer.Gamepasses.NitroSpeed.Value = val.Value
end)
group.Create(0,"Tittle","Grab","Брать")
group.Create(0,"TIP","P.S:It grab clothings in 25 studs","P.S:Оно берёт одежду менее 25 шагов")
local function TPClothing(notrare)
    for k,v in pairs(Clothing:GetChildren()) do
        if v.Name == "Magnet" then continue end
        if v:FindFirstChild("Sound") or notrare then
            local magn = math.abs(v.CFrame.Position.Magnitude - LocalPlayer.Character.PrimaryPart.Position.Magnitude)
            if magn > 25 then continue end
            v.Anchored = true
            v.CFrame = LocalPlayer.Character.PrimaryPart.CFrame
            if notrare then return end
        end
    end
end

group.Create(1,"TPMagnit","Grab Magnit","Взять магнит",function()
    for k,v in pairs(Clothing:GetChildren()) do
        if v.Name == "Magnet" then
            local magn = math.abs(v.CFrame.Position.Magnitude - LocalPlayer.Character.PrimaryPart.Position.Magnitude)
            if magn > 25 then continue end
            v.Anchored = true
            v.CFrame = LocalPlayer.Character.PrimaryPart.CFrame
        end
    end
end)

group.Create(1,"TPRareClothings","Grab Rare Clothings","Взять редкие вещи",function()
    TPClothing(false)
end)

group.Create(1,"TPClothings","Grab Clothing","Взять вещь",function()
    TPClothing(true)
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
