loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimExplorer/Main.lua"))()
local MainFrame = game.CoreGui.TimEXPLORER:FindFirstChildOfClass("Frame")
MainFrame.Position = UDim2.new(1,0,0,0)

_G.TimGui.Add.CB("TE","TimExplorer","Map",7,"TimExplorer",function(interface)
    MainFrame.Position = UDim2.new(0.8,0,0,0)
    _G.TimGui.TEOpen = interface.Value
    if interface.Value then
      _G.TimGui.Path.Main.Position = UDim2.new(0.8, -400, 0, 0)
      if _G.TimGui.XTwo then
        goal.Position = UDim2.new(0.8, -700, 0, 0)
      end
      if not _G.TimGui.Opened then
        _G.TimGui.Path.Main.Position = UDim2.new(0.8, -400, 1, -25)
        if _G.TimGui.XTwo then
        goal.Position = UDim2.new(0.8, -700, 1, -25)
      end
      end
    else
      _G.TimGui.Path.Main.Position = UDim2.new(1, -400, 0, 0)
      if _G.TimGui.XTwo then
        goal.Position = UDim2.new(1, -700, 0, 0)
      end
      if not _G.TimGui.Opened then
        _G.TimGui.Path.Main.Position = UDim2.new(1, -400, 1, -25)
        if _G.TimGui.XTwo then
          goal.Position = UDim2.new(1, -700, 1, -25)
        end
      end
    end
end)
