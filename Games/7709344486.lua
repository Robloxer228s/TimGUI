local LocalPlayer = game.Players.LocalPlayer
local Velocity = Instance.new("AlignPosition",game.Workspace.CurrentCamera)
local RagdollEnabled = false
local UseItem = game.ReplicatedStorage.Packages.Net:WaitForChild("RE/UseItem")
local SuperSteal = _G.TimGui.Groups.Other.Create("SuperSteal","Super steal(requires TaserGun)","Супер ворование(требуется электрошокер)")
local path = game:GetService("PathfindingService"):CreatePath{
	AgentCanClimb=true,
	AgentCanJump=true,
	WaypointSpacing=math.huge,
}
Velocity.Mode = Enum.PositionAlignmentMode.OneAttachment
Velocity.MaxForce = math.huge
local Character
local WalkTo = {}
local function newCharacter(char:Model)
	char:WaitForChild("Humanoid")
	char:WaitForChild("HumanoidRootPart")
	Character = char
	Velocity.Attachment0 = Character.PrimaryPart:FindFirstChildOfClass("Attachment")
	RagdollEnabled,WalkTo = false,{}
	Character:FindFirstChildOfClass("Humanoid").StateChanged:Connect(function(old,state)
		if state == Enum.HumanoidStateType.Physics then
			RagdollEnabled = true
		end if state == Enum.HumanoidStateType.GettingUp then
			RagdollEnabled = false
		end
	end) Velocity.Enabled = RagdollEnabled
end if LocalPlayer.Character then newCharacter(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(newCharacter)
local function VelocityNewPath(Position:Vector3)
	if Character.PrimaryPart then
		WalkTo = {}
		path:ComputeAsync(Character.PrimaryPart.Position,Position)
		for k,v in pairs(path:GetWaypoints()) do
			table.insert(WalkTo,v.Position+Vector3.new(0,5,0))
		end
	end
end local Hitbox = game.Workspace:WaitForChild("SpawnLocation")
game:GetService("RunService").RenderStepped:Connect(function()
	if Character.PrimaryPart and RagdollEnabled then
		local to = WalkTo[1]
		if (Character.PrimaryPart.Position-to).Magnitude<5 then
			table.remove(WalkTo,1)
			to = WalkTo[1]
		end if to then
			Velocity.Position = to
			Velocity.Enabled = true
		else Velocity.Enabled = false
		end
	else Velocity.Enabled = false
	end Hitbox.CanTouch = not Velocity.Enabled
end) local BasePos = game.Workspace:WaitForChild("SpawnLocation").CFrame
for k,v in pairs(game.Workspace.Plots:GetChildren()) do
	if v.PlotSign.YourBase.Enabled then
		Hitbox = v.DeliveryHitbox
		BasePos = Hitbox.CFrame
	end
end local function onSteal()
	if not LocalPlayer.Character then return end
	local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		local item = LocalPlayer.Backpack:FindFirstChild("Taser Gun")
		if item then
			hum:EquipTool(item) 
			UseItem:FireServer(Character.PrimaryPart)
		end VelocityNewPath(BasePos.Position-BasePos.LookVector*Hitbox.Size.Z*1.5)
	end
end for k,v in pairs(game.Workspace.Plots:GetDescendants()) do
	if v:IsA("ProximityPrompt") then
		v.Triggered:Connect(function()
			if v.ActionText == "Steal" then
				onSteal()
			end
		end)
	end
end
