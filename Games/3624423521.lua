--Underground war 2.0
local LocalPlayer = game.Players.LocalPlayer
local iii = 0
local Other = _G.TimGui.Groups.Other
Other.Create(0,"Game","Game","Игра")
local SuperSword = Other.Create(2,"SuperSword","Super sword","Супер меч")
while task.wait() do
    if iii == 50 then
        iii = 0
        wait(0.5)
    end
    if LocalPlayer.Character and SuperSword.Value then
        local YPP = LocalPlayer.Character.PrimaryPart
        local sword = LocalPlayer.Character:FindFirstChild("Sword")
        if sword then sword = sword:FindFirstChild("Handle") end
        if sword and YPP then
            iii += 1
            for k,v in pairs(game.Players:GetPlayers()) do
                if _G.TimGui.Values.Spare[v.Name] then continue end
                if v.Team ~= LocalPlayer.Team then
                    if not v.Character then continue end
                    local PP = v.Character.PrimaryPart
                    if PP then
                        if (YPP.Position-PP.Position).Magnitude < 40 then
                            local antikill = v.Character:FindFirstChild("Sword")
                            if antikill then antikill:Destroy() end
                            firetouchinterest(sword,PP)
                        end
                    end
                end
            end
        end
    end
end
