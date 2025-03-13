function _G.PasteTEObject(TEObj,parent:Instance)
	if type(TEObj) == "string" then
		TEObj = game.HttpService:JSONDecode(TEObj)
	end
	local Inst = Instance.new(TEObj["Props"]["ClassName"]["value"],parent)
	if TEObj["Props"]["ClassName"]["value"] == "Seat" then
		local reload = true
		Inst.Touched:Connect(function(other:Instance)
			local char = game.Players.LocalPlayer.Character
			if other.Parent == char and reload and char:FindFirstChildOfClass("Humanoid").Sit == false then
				local SeatWeld = Instance.new("Weld",Inst)
				SeatWeld.Part0 = Inst
				SeatWeld.Part1 = char:FindFirstChild("HumanoidRootPart")
				SeatWeld.C0 = CFrame.new(0,Inst.Size.Y/2,0)
				SeatWeld.C1 = CFrame.new(0,char:FindFirstChild("HumanoidRootPart").RootRigAttachment.CFrame.Y/2,0)
				SeatWeld.C1 += Vector3.new(0,-char:FindFirstChildOfClass("Humanoid").BodyDepthScale.Value,0)
				char:FindFirstChildOfClass("Humanoid").Sit = true
				local Connect Connect = char:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("Sit"):Connect(function()
					SeatWeld:Destroy()
					Connect:Disconnect()
					reload = false
					SeatWeld = nil
					wait(1)
					reload = true
				end)
				while SeatWeld do
					wait(0.75)
					SeatWeld.Enabled = false
					wait()
					SeatWeld.Enabled = true
				end
			end
		end)
	end
	TEObj.Props.Parent = nil
	TEObj.Props.ClassName = nil
	for k,v in pairs(TEObj["Props"]) do
		local s,r = pcall(function()
			if type(v["value"]) == "table" then
				if v["type"] == "CFrame" then
					Inst[k] = CFrame.new(table.unpack(v["value"]))
				elseif v["type"] == "Vector3" then
					Inst[k] = Vector3.new(table.unpack(v["value"]))
				elseif v["type"] == "Vector2" then
					Inst[k] = Vector2.new(table.unpack(v["value"]))
				elseif v["type"] == "Color3" then
					Inst[k] = Color3.new(table.unpack(v["value"]))
				elseif v["type"] == "UDim" then
					Inst[k] = UDim.new(table.unpack(v["value"]))
				elseif v["type"] == "UDim2" then
					Inst[k] = UDim2.new(table.unpack(v["value"]))
				else
					print("UnknownType:",v["type"],"Property:",k)
				end
			elseif v["type"] == "BrickColor" then
				Inst[k] = BrickColor.new(v["value"])
			elseif v["type"] == "Instance" then
				local Obj
				if v["value"] ~= nil then
					local Path = string.split(v["value"],".")
					Obj = game
					for _,v in pairs(Path) do
						Obj = Obj:FindFirstChild(v)
						if not Obj then
							Obj = nil
							break
						end
					end
				end
				Inst[k] = Obj
			else
				Inst[k] = v["value"]
			end
		end)
		if not s then
			print("Error(load TEObject):",TEObj.Props.Name.value,"Property:",k,r)
		end
	end
	for k,v in pairs(TEObj["Children"]) do
		local s,r = pcall(function()
			_G.PasteTEObject(v,Inst)
		end)
		if not s then
			warn("Error on create: "..tostring(r))
		end
	end
end
