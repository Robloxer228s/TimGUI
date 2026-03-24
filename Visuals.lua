local Visuals = _G.TimGui.Groups.CreateNewGroup("Visuals3","Визуалы")
Visuals.Create(0,"Helpful","Helpful","Полезные")
local InvsCanCollide = Visuals.Create(2,"InvsCanCollide","Show invisible blocks(can collide)","Показывать невидимые барьеры")
local InvsCantCollide = Visuals.Create(2,"InvsCantCollide","Show invisible blocks(can't collide)","Показывать невидимые блоки(можно пройти сквозь них)")
local StopPartInvisibleBindable = Instance.new("BindableEvent")
local ChangeInvisbleToTransparency = 0.5
local MaxTransparencyForCIP = 0.9
local updateBEvent = Instance.new("BindableEvent")
local function getIsChangeTranspInvs(isCanCollide)
    if isCanCollide then
        return InvsCanCollide.Value
    else return InvsCantCollide.Value
    end
end 
local function oneNewPartForInvisible(Part:BasePart)
    local doChange = false
    local oldTransparency
    local function update(setOld)
        if setOld then
            oldTransparency = Part.Transparency
        end if getIsChangeTranspInvs(Part.CanCollide) then
            if Part.Transparency>=MaxTransparencyForCIP then
                doChange = true
                Part.Transparency = ChangeInvisbleToTransparency
            end
        end if not doChange then
            if not setOld then
                Part.Transparency = oldTransparency
            end
        end
    end local TListener = Part:GetPropertyChangedSignal("Transparency"):Connect(function()
        if doChange then
            doChange = false
        else update(true)
        end
    end) local CListener = Part:GetPropertyChangedSignal("CanCollide"):Connect(function()
        update(false)
    end)
    local updList = updateBEvent.Event:Connect(function()
        update(false)
    end)
    local function Close()
        if TListener.Connected then
            TListener:Disconnect()
            CListener:Disconnect()
            updList:Disconnect()
            Part.Transparency = oldTransparency
        end
    end Part.AncestryChanged:Connect(function()
        if not Part:IsDescendantOf(game.Workspace) then
            Close()
        end
    end) update(true)
    StopPartInvisibleBindable.Event:Once(Close)
end local InvisibleListenStarted = false
game.Workspace.DescendantAdded:Connect(function(Part)
    if InvisibleListenStarted and Part:IsA("BasePart") then
        oneNewPartForInvisible(Part)
    end
end) local function loadILonS()
    for k,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            oneNewPartForInvisible(v)
        end
    end InvisibleListenStarted = true
end
InvsCanCollide.OnChange(function()
    if not InvisibleListenStarted then loadILonS() end
    updateBEvent:Fire(true)
end) InvsCantCollide.OnChange(function()
    if not InvisibleListenStarted then loadILonS() end
    updateBEvent:Fire(true)
end)
Visuals.Create(1,"DestroyBlockMesh","Destroy BlockMesh's","Удали BlockMesh",function()
    for k,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BlockMesh") then
            v:Destroy()
        end
    end
end)
