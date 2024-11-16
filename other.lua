local group = _G.TimGui.Groups.CreateNewGroup("Other","Другое")
local LocalPlayer = game.Players.LocalPlayer
if mouse1click ~= nil then
    group.Create(2,"Clicker","AutoClicker","Автокликер",function(val)
        wait(1)
        while task.wait() and val.Value do
            mouse1click()
        end
    end)
end

if game:GetService("UserInputService").TouchEnabled then
	local Sgui = Instance.new("ScreenGui",LocalPlayer.PlayerGui)
	local SCenter = Instance.new("ImageLabel",Sgui)
	local SButton = Instance.new("ImageButton",Sgui)
	local Enabled = Instance.new("BoolValue",Sgui)
	local LSize = 32 
	local LBSizeD = 1.25
	local OldHumanoid

	Sgui.IgnoreGuiInset = true
	Sgui.Name = "MouseLock(ShiftLock)"
    	Sgui.Enabled = false
	Sgui.ResetOnSpawn = false

	SCenter.Image = "rbxasset://textures/MouseLockedCursor.png"
	SCenter.Size = UDim2.new(0,LSize,0,LSize)
	SCenter.Position = UDim2.new(0.5,-LSize/2,0.5,-LSize/2)
	SCenter.BackgroundTransparency = 1
	SCenter.Visible = false

	SButton.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
	SButton.Size = UDim2.new(0,62/LBSizeD,0,62/LBSizeD)
	SButton.Position = UDim2.new(0.9,-62/LBSizeD,0.8,-62/LBSizeD)
	SButton.BackgroundTransparency = 1
	SButton.Activated:Connect(function() Enabled.Value = not Enabled.Value end)

	Enabled.Name = "Enabled"
	Enabled.Changed:Connect(function()
		local char = workspace.CurrentCamera.CameraSubject.Parent
		if char:IsA("Model") then
			if char:FindFirstChild("Humanoid") then
				char.Humanoid.AutoRotate = not Enabled.Value
			end
		end
		SCenter.Visible = Enabled.Value
		if Enabled.Value then
			SButton.Image = "rbxasset://textures/ui/mouseLock_on@2x.png"
			if char:FindFirstChild("Humanoid") then
				oldHumanoid = char.Humanoid
				char.Humanoid.CameraOffset += Vector3.new(2.5,0,0)
			end
		else
			SButton.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
			if char:FindFirstChild("Humanoid") then
				if oldHumanoid then
					oldHumanoid.CameraOffset += Vector3.new(-2.5,0,0)
				end
			end
		end
	end)

	local function upd()
		if Enabled.Value then
			local camera = workspace.CurrentCamera
			local Char = camera.CameraSubject.Parent
			if Char:IsA("Model") then
				local HRP = Char.PrimaryPart
				if HRP then
					local Length = 900000
					local CamR = Vector3.new(camera.CFrame.LookVector.X *Length, HRP.Position.Y, camera.CFrame.LookVector.Z*Length)
					HRP.CFrame = CFrame.new(HRP.Position, CamR)
				end
			end
		end
	end

	LocalPlayer:GetMouse().Move:Connect(upd)
	game:GetService("RunService").RenderStepped:Connect(upd)
    	workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function(char)
		local char = workspace.CurrentCamera.CameraSubject.Parent
		if char:IsA("Model") then
			local en = Enabled.Value
		        Enabled.Value = false
		        char:WaitForChild("HumanoidRootPart",math.huge)
		        wait()
		        Enabled.Value = en
		end
    	end)
	    group.Create(2,"SL(ML)","Shift Lock/Mouse Lock(for mobile)","Шифт лок/блокировка мыши (для телефонов)",function(val)
	        Sgui.Enabled = val.Value
	    end)
else
    group.Create(1,"SL","Enable shift Lock","Включить shiftlock switch",function()
        LocalPlayer.DevEnableMouseLock = true
    end)
end
