local LocalPlayer = game.Players.LocalPlayer
local EatEvent = game.ReplicatedStorage.Remotes.Eat
local group = _G.TimGui.Groups.CreateNewGroup("Waffles","Вафли")
local AutoEat = group.Create(2,"AutoEat","Auto eat waffles","Авто есть вафли")
local AutoEatOther = group.Create(2,"AutoEatOther","Auto eat other","Авто есть разное")
task.spawn(function()
    while task.wait() do
        if AutoEat.Value then
            for k,v in pairs(game.Workspace.Waffles:GetDescendants()) do
                if v:IsA("BasePart") and AutoEat.Value then
                    EatEvent:FireServer(v)
                    wait()
                end
            end
        end
    end
end) task.spawn(function()
    while task.wait() do
        if AutoEatOther.Value then
            for k,v in pairs(game.Workspace.Edible:GetDescendants()) do
                if v:IsA("BasePart") and AutoEatOther.Value then
                    EatEvent:FireServer(v)
                    wait()
                end
            end
        end
    end
end)
