function _G.PasteTEObject(TEObj,parent:Instance)
	if type(TEObj) == "string" then
		TEObj = game.HttpService:JSONDecode(TEObj)
	end
	local Inst = Instance.new(TEObj["Props"]["ClassName"]["value"],parent)
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
