if getgenv().isUsingUiConfig == true and game.Players.LocalPlayer.Name == getgenv().Username then
    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
    local Window = OrionLib:MakeWindow({Name = "ControlBotZ Config", HidePremium = false, IntroText = "ControlBotZ Config", SaveConfig = false})

    local configTab = Window:MakeTab({
        Name = "CONFIG",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    configTab:AddTextbox({
        Name = "Bots(table format):",
        Default = '',
        TextDisappear = false,
        Callback = function(val)
            Xeno.SetGlobal("zBots", (function() local t = {}; for bot in val:gmatch('"([^"]+)"') do table.insert(t, bot) end; return t end)())
        end
    })

    configTab:AddTextbox({
        Name = "Prefix:",
        Default = '',
        TextDisappear = false,
        Callback = function(val)
            Xeno.SetGlobal("zPrefix", val)
        end
    })

    Xeno.SetGlobal("zHook", "")

    configTab:AddTextbox({
        Name = "Webhook:",
        Default = '',
        TextDisappear = false,
        Callback = function(val)
            Xeno.SetGlobal("zHook", val)
        end
    })

    configTab:AddButton({
        Name = "Start",
        Callback = function()
            Xeno.SetGlobal("zStart", 1)
        end
    })

    configTab:AddButton({
        Name = "Destroy UI",
        Callback = function()
            OrionLib:Destroy()
        end
    })

    OrionLib:Init()
end
