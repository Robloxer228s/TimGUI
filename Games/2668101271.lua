local LocalPlayer = game.Players.LocalPlayer
local group = _G.TimGui.Groups.CreateNewGroup("Fling Things and Fling People","Летающие люди")
local CharEvents = game.ReplicatedStorage.CharacterEvents

local AntiGrab = group.Create(2,"AntiGrab","Anti grab","Запретить взятие")
AntiGrab.CFGSave = true
local function DisableGrab(char)
    if AntiGrab.Value then
        char:WaitForChild("HumanoidStateTypeByGettingFlung").Enabled = false
        char:WaitForChild("Humanoid"):GetPropertyChangedSignal("Sit"):Connect(function()
            if char.Humanoid.Sit then
                if char.Humanoid.SeatPart == nil then
                    char.Humanoid.Sit = false
                    char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
                end
            end
        end)
        local HRP = char:WaitForChild("HumanoidRootPart")
        HRP:WaitForChild("FirePlayerPart"):Destroy()
    end
end
LocalPlayer.IsHeld.Changed:Connect(function()
    if LocalPlayer.IsHeld.Value and AntiGrab.Value then
        CharEvents.Struggle:FireServer(LocalPlayer)
        DisableGrab(LocalPlayer.Character)
    end
end)
game:GetService("RunService").RenderStepped:Connect(function()
    if LocalPlayer.IsHeld.Value and AntiGrab.Value then
        CharEvents.Struggle:FireServer(LocalPlayer)
    end
end)
LocalPlayer.CharacterAdded:Connect(DisableGrab)
local ThrowOut = group.Create(2,"ThrowOut","Throw out the map","Выбрасывать за карту")
local TPpos = CFrame.new(0,0,0)
group.Create(1,"SetPosTP","Set position for tp","Сделать позицию для ТП",function()
    TPpos = LocalPlayer.Character.PrimaryPart.CFrame
end)
local TPEnable = group.Create(2,"EnableTP","Enable tp","Включить тп (при отпуске)")
game.Workspace.ChildAdded:Connect(function(child)
    if child.Name == "GrabParts" then
        local GrabPart = child:FindFirstChild("GrabPart")
        if GrabPart then
            GrabPart = GrabPart:FindFirstChild("WeldConstraint")
            if GrabPart then
                GrabPart = GrabPart.Part1
                child.Destroying:Wait()
                if ThrowOut.Value then
                    GrabPart.RotVelocity += Vector3.new(0,100000,0)
            end if TPEnable.Value and GrabPart.Anchored == false then
                    GrabPart.CFrame = TPpos
                end
            end
        end
    end
end)
