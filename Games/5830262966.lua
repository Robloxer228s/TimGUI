-- Imposible Squid Game! Glass bridge
local group = _G.TimGui.Groups.CreateNewGroup("Glass","Стекло")
local glass = game.Workspace.segmentSystem.Segments
group.Create(2,"CanCollide","Can Collide For All Glass","Возможность прикоснуться ко всему стеклу",function()
    for k,v in pairs(glass:GetChildren()) do
        local center = v:FindFirstChild("Center")
        if center then
            center.CanCollide = true
        end
    end
end)
group.Create(2,"Select not breakable glass","Select not breakable glass","Выбрать настоящее стекло",function(val)
    for k,v in pairs(glass:GetChildren()) do
        local fold = v:FindFirstChild("Folder")
        if fold then
            for k,v in pairs(fold:GetChildren()) do
                if not v:FindFirstChild("breakable") and val.Value then
                    v.Transparency = 0
                else
                    v.Transparency = 0.6
                end
            end
        end
    end
end)
