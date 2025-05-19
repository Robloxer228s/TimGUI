local Slaps = {
    b={"Default+Extended","Стандартная+Удлинённая"},
    GeneralHit={"Dual","Двойная"},
    SnowHit={"Snow","Снег"},
    PullHit={"Pull","Тяни"},
    BullHit={"Bull","Бык"},
    HitSwapper={"Swapper","Заменитель"},
    DiceHit={"Dice","Игральная кость"},
    HtStun={"Stun","Оглушитель"}
}
local Hit = game.ReplicatedStorage.b
local LocalPlayer = game.Players.LocalPlayer
local SB = _G.TimGui.Groups.CreateNewGroup("Slap battles5","Битвы перчаток")
local SS = _G.TimGui.Groups.CreateNewGroup("SelectSlap")
SS.Visible = false
SB.Create(1,"SYS","Select your slap","Выбери свою перчатку",function()
    SS.OpenGroup()
end)
for k,v in pairs(Slaps) do
    local ThisEvent = game.ReplicatedStorage:FindFirstChild(k)
    SS.Create(2,k,v[1],v[2],function(val)
        if val.Value then
            Hit = ThisEvent
            for k,v in pairs(SS.Objects) do
                if v.Type == 2 and v ~= val then
                    v.Main.Value = false
                end
            end
        elseif ThisEvent == Hit then
            val.Main.Value = true
        end
    end).Main.Value = Hit == ThisEvent
end
local ReloadTP = SB.Create(3,"Reload after TP","Reload after TP","Перезарядка после ТП")
local ReloadEvent = SB.Create(3,"Reload after fire event","Reload after fire event","Перезарядка после запуска перчатки")
ReloadTP.Main.Text = 0.1
ReloadEvent.Main.Text = 0.3
SB.Create(1,"Hit all","Hit all","Ударить всех",function()
    local LHRP = LocalPlayer.Character.PrimaryPart
    if not LHRP then return end
    for k,v in pairs(game.Players:GetPlayers()) do
		if v == LocalPlayer then continue end
		if _G.TimGui.Values.Spare[v.Name] then continue end
        local char = v.Character
        if not char then continue end
        local HRP = char.PrimaryPart
        if not HRP then continue end
        if not char:FindFirstChild("isInArena") then continue end
        if char.isInArena.Value then
            local RTP = tonumber(ReloadTP.Value) or 0.1
            local RE = tonumber(ReloadEvent.Value) or 0.3
            LHRP.CFrame = HRP.CFrame task.wait(RTP)
            LHRP.CFrame = HRP.CFrame
            Hit:FireServer(HRP) task.wait(RE)
        end
    end
end)
SB.Create(2,"Auto hit","Auto hit all(afk)","Автобить всех(афк)",function(val)
    if val.Value then
        local LHRP = LocalPlayer.Character.PrimaryPart
        if not LHRP then val.Main.Value = false return end
        while val.Value and task.wait() do
            for k,v in pairs(game.Players:GetPlayers()) do
				if v == LocalPlayer then continue end
				if _G.TimGui.Values.Spare[v.Name] then continue end
                local char = v.Character
                if not char then continue end
                local HRP = char.PrimaryPart
                if not HRP then continue end
                if not char:FindFirstChild("isInArena") then continue end
                if char.isInArena.Value then
                    local RTP = tonumber(ReloadTP.Value) or 0.1
                    local RE = tonumber(ReloadEvent.Value) or 0.3
                    LHRP.CFrame = HRP.CFrame task.wait(RTP)
                    LHRP.CFrame = HRP.CFrame
                    Hit:FireServer(HRP) task.wait(RE)
                end
            end
        end
    end
end)
local DistanceNearby = SB.Create(3,"DAHN","Distance of auto hit nearby","Дистанция для удара рядом")
SB.Create(2,"Auto hit nearby","Auto hit nearby","Автобить всех кто рядом",function(val)
    if val.Value then
        local LHRP = LocalPlayer.Character.PrimaryPart
        if not LHRP then val.Main.Value = false return end
        local DistN = tonumber(DistanceNearby.Value) or 15
        while val.Value and task.wait() do
            for k,v in pairs(game.Players:GetPlayers()) do
				if v == LocalPlayer then continue end
				if _G.TimGui.Values.Spare[v.Name] then continue end
                local char = v.Character
                if not char then continue end
                local HRP = char.PrimaryPart
                if not HRP then continue end
                if not char:FindFirstChild("isInArena") then continue end
                if char.isInArena.Value then
                    local Dist = (LHRP.Position-HRP.Position).Magnitude
					if Dist < DistN then
                        local RE = tonumber(ReloadEvent.Value) or 0.3
                        Hit:FireServer(HRP) task.wait(RE)
                    end
                end
            end
        end
    end
end)
LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("isInArena")
    for k,v in pairs(SB.Objects) do
        if v.Type == 2 and v.Value then
            v.Main.Value = false
            task.wait() v.Main.Value = true
        end
    end
end)
