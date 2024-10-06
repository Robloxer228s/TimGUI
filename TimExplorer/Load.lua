loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimExplorer/Main.lua"))()
_G.TimGui.XTwo = false
local MainFrame = game.CoreGui.TimEXPLORER:FindFirstChildOfClass("Frame")
MainFrame.Position = UDim2.new(1,0,0,0)

_G.TimGui.Add.CB("TE","TimExplorer","Map",11,"TimExplorer",function(interface)
    _G.TimGui.TEOpen = interface.Value
    if interface.Value then
      MainFrame.Position = UDim2.new(0.8,0,0,0)
      _G.TimGui.Path.Main.Position = UDim2.new(0.8, -400, 0, 0)
      if _G.TimGui.XTwo then
        _G.TimGui.Path.Main.Position = UDim2.new(0.8, -700, 0, 0)
      end
      if not _G.TimGui.Opened then
        _G.TimGui.Path.Main.Position = UDim2.new(0.8, -400, 1, -25)
        if _G.TimGui.XTwo then
        _G.TimGui.Path.Main.Position = UDim2.new(0.8, -700, 1, -25)
      end
      end
    else
      MainFrame.Position = UDim2.new(1,0,0,0)
      _G.TimGui.Path.Main.Position = UDim2.new(1, -400, 0, 0)
      if _G.TimGui.XTwo then
        _G.TimGui.Path.Main.Position = UDim2.new(1, -700, 0, 0)
      end
      if not _G.TimGui.Opened then
        _G.TimGui.Path.Main.Position = UDim2.new(1, -400, 1, -25)
        if _G.TimGui.XTwo then
          _G.TimGui.Path.Main.Position = UDim2.new(1, -700, 1, -25)
        end
      end
    end
end)
