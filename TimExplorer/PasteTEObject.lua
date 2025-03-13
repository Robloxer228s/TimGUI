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
			elseif v["type"] == "Instance" then
				local Path = string.split(v["value"],".")
				local Obj = game
				for _,v in pairs(Path) do
					Obj = Obj:FindFirstChild(v)
					if not Obj then
						Obj = nil
						break
					end
				end
				Inst[k] = Obj
			else
				Inst[k] = v["value"]
			end
		end)
		if not s then
			print("Error(load TEObject):",TEObj.Props.Name,"Property:",k,r)
		end
	end
	for k,v in pairs(TEObj["Children"]) do
		_G.PasteTEObject(v,Inst)
	end
end
wait(2)
local lol = '{"Children":[],"Props":{"RightParamB":{"value":0.5,"type":"number"},"TopSurfaceInput":{"value":0,"type":"EnumItem"},"Anchored":{"value":false,"type":"boolean"},"FrontSurfaceInput":{"value":0,"type":"EnumItem"},"BottomParamB":{"value":0.5,"type":"number"},"FrontParamB":{"value":0.5,"type":"number"},"BottomSurfaceInput":{"value":0,"type":"EnumItem"},"CanCollide":{"value":true,"type":"boolean"},"BackSurfaceInput":{"value":0,"type":"EnumItem"},"LeftSurface":{"value":0,"type":"EnumItem"},"FrontParamA":{"value":-0.5,"type":"number"},"ClassName":{"value":"Seat","type":"string"},"Orientation":{"value":["-0.06400000303983688","-1.0880000591278076","0.0010000000474974513"],"type":"Vector3"},"BackParamB":{"value":0.5,"type":"number"},"TopSurface":{"value":0,"type":"EnumItem"},"Velocity":{"value":["0","0","0"],"type":"Vector3"},"RightParamA":{"value":-0.5,"type":"number"},"Disabled":{"value":false,"type":"boolean"},"Transparency":{"value":0,"type":"number"},"Color":{"value":["0.105882","0.164706","0.207843"],"type":"Color3"},"TopParamB":{"value":0.5,"type":"number"},"CollisionGroupId":{"value":0,"type":"number"},"TopParamA":{"value":-0.5,"type":"number"},"Reflectance":{"value":0,"type":"number"},"BackSurface":{"value":0,"type":"EnumItem"},"RotVelocity":{"value":["0","0","0"],"type":"Vector3"},"Name":{"value":"Seat","type":"string"},"BottomParamA":{"value":-0.5,"type":"number"},"Material":{"value":256,"type":"EnumItem"},"Archivable":{"value":true,"type":"boolean"},"Size":{"value":["4","1","2"],"type":"Vector3"},"RightSurface":{"value":0,"type":"EnumItem"},"FrontSurface":{"value":0,"type":"EnumItem"},"RightSurfaceInput":{"value":0,"type":"EnumItem"},"BackParamA":{"value":-0.5,"type":"number"},"Parent":{"value":"Workspace","type":"Instance"},"CFrame":{"value":["20.8963165","0.497077912","-1.58107877","0.999819696","1.06556317e-05","-0.0189899821","1.06556308e-05","0.999999464","0.00112213544","0.0189899839","-0.00112213555","0.99981904"],"type":"CFrame"},"CustomPhysicalProperties":{"type":"Instance"},"BottomSurface":{"value":0,"type":"EnumItem"},"Rotation":{"value":["-0.06400000303983688","-1.0880000591278076","-0.0010000000474974513"],"type":"Vector3"},"Locked":{"value":false,"type":"boolean"},"BrickColor":{"value":"Black","type":"BrickColor"},"Position":{"value":["20.896316528320312","0.49707791209220886","-1.5810787677764893"],"type":"Vector3"},"LeftSurfaceInput":{"value":0,"type":"EnumItem"},"LeftParamA":{"value":-0.5,"type":"number"},"Shape":{"value":1,"type":"EnumItem"},"LeftParamB":{"value":0.5,"type":"number"}}}'
_G.PasteTEObject(lol,game.Workspace)
