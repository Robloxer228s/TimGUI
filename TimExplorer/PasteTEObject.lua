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
				SeatWeld.C0 = CFrame.new(0,Inst.Size.Y/2,0)
				if char:FindFirstChild("HumanoidRootPart") then
					SeatWeld.Part1 = char.HumanoidRootPart
					if char.HumanoidRootPart:FindFirstChild("RootRigAttachment") then
						SeatWeld.C1 = CFrame.new(0,char.HumanoidRootPart.RootRigAttachment.CFrame.Y/2,0)
						SeatWeld.C1 += Vector3.new(0,-char.Humanoid.BodyDepthScale.Value,0)
					else
						SeatWeld.C1 = CFrame.new(0,-char.HumanoidRootPart.Size.Y/2,0)
					end
				end
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
					for k,s in pairs(v.value) do
						v.value[k] = string.gsub(s,"}","")
						v.value[k] = string.gsub(s,"{","")
					end
					Inst[k] = UDim2.new(table.unpack(v.value))
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
			elseif v["type"] == "NumberRange" then
				local val = string.split(v["value"]," ")
				if val[#val] == "" then
					val[#val] = nil
				end Inst[k] = NumberRange.new(table.unpack(val))
			elseif v["type"] == "NumberSequence" then
				local val = string.split(v["value"]," ")
				if val[#val] == "" then
					val[#val] = nil
				end
				local Sequence = {}
				for k=1,(#val/3) do
					local i = (k-1)*3+1
					Sequence[k] = NumberSequenceKeypoint.new(val[i], val[i+1], val[i+2])
				end
				Inst[k] = NumberSequence.new(Sequence)
			elseif v["type"] == "ColorSequence" then
				local val = string.split(v["value"]," ")
				if val[#val] == "" then
					val[#val] = nil
				end
				local Sequence = {}
				for k=1,(#val/5) do
					local i = (k-1)*5+1
					Sequence[k] = ColorSequenceKeypoint.new(val[i], Color3.new(val[i+1],val[i+2],val[i+3]))
				end
				Inst[k] = ColorSequence.new(Sequence)
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
	return Inst
end
