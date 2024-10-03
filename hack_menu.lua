local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Hack Menu", HidePremium = false, IntroEnabled = true, IntroText = "Hack Menu", SaveConfig = true, ConfigFolder = "OrionTest"})

getgenv().isHighlighting = false

function gCheck(cg)
    if cg == "sb" and game.PlaceId ~= 6403373529 then
        return false
    end

    if cg == "bh" and game.PlaceId ~= 4924922222 then
        return false
    end

    return true
end

local mainTab = Window:MakeTab({
    Name = "Main",
    PremiumOnly = false
})

local toolsTab = Window:MakeTab({
    Name = "Tools",
    PremiumOnly = false
})

local slapBattlesTab = Window:MakeTab({
    Name = "Slap Battles",
    PremiumOnly = false
})

local brookhavenTab = Window:MakeTab({
    Name = "Brookhaven",
    PremiumOnly = false
})

mainTab:AddToggle({
    Name = "Highlight Players (doesn't work good)",
    Default = false,
    Callback = function(val)
        local players = game:GetService('Players')

        if val == false then
            isHighlighting = false

            for _, v in pairs(workspace:GetChildren())do
                if v:FindFirstChild("Humanoid") then
                    if v:FindFirstChild("Highlight") then
                        v.Highlight:Destroy()
                    end
                end
            end

            for _, p in pairs(players:GetPlayers()) do
                if p.Character:FindFirstChild("Highlight") then
                    p.Character.Highlight:Destroy()
                end
            end

        elseif val == true and not isHighlighting then
            isHighlighting = true

            while isHighlighting do
                wait(1)

                if isHighlighting == false then
                    break
                end

                for _, v in pairs(workspace:GetChildren()) do
                    if v:FindFirstChild("Humanoid") then
                        if not v:FindFirstChild("Highlight") then
                            Instance.new("Highlight", v)
                        end
                    end
                end

                for _, p in pairs(players:GetPlayers()) do
                    if not p.Character:FindFirstChild("Highlight") then
                        Instance.new("Highlight", p.Character)
                    end
                end
            end
        end
    end
})

mainTab:AddTextbox({
    Name = "Teleport To Player",
    TextDisappear = true,
    Callback = function(val)
        local player = game.Players.LocalPlayer

        local targetPlayer = game.Players:FindFirstChild(val)

        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            player.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position)

            OrionLib:MakeNotification({
                Name = "Teleported!",
                Content = `Teleported To Player {targetPlayer}.`,
                Time = 5,
            })
        end
    end
})

mainTab:AddSlider({
    Name = "Jump Height",
    Min = game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower,
    Max = 10000,
    Default = 50,
    Increasment = 1,
    ValueName = "jump power",
    Callback = function(val)
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = tonumber(val)
    end
})

mainTab:AddSlider({
    Name = "Walkspeed",
    Min = game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed,
    Max = 10000,
    Default = 16,
    Increasment = 1,
    ValueName = "speed",
    Callback = function(val)
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = tonumber(val)
    end
})

toolsTab:AddButton({
    Name = "Aimbot",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Tool",
            Content = "Starting Aimbot...",
            Time = 5
        })
        
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/sixpennyfox4/lua-tools/refs/heads/main/aimbot.lua')))()
    end
})

toolsTab:AddButton({
    Name = "Dex",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Tool",
            Content = "Starting Dex...",
            Time = 5
        })

        loadstring(game:HttpGet(('https://raw.githubusercontent.com/sixpennyfox4/lua-tools/refs/heads/main/Dex.lua')))()
    end
})

toolsTab:AddButton({
    Name = "Infinite Yield",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Tool",
            Content = "Starting Infinite Yield...",
            Time = 5
        })

        loadstring(game:HttpGet(('https://raw.githubusercontent.com/sixpennyfox4/lua-tools/refs/heads/main/Infinite%20Yield.lua')))()
    end
})

toolsTab:AddButton({
    Name = "Chat Paint",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Tool",
            Content = "Starting Chat Paint...",
            Time = 5
        })
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ocfi/Choose-ARt-able-remove/main/wassdaadwasda"))()
    end
})

slapBattlesTab:AddToggle({
    Name = "Anti Void",
    Default = false,
    Callback = function(val)
        if not gCheck("sb") then
            return
        end

        local mainArena = workspace.Arena["main island"]
        local battleArena = workspace.Battlearena

        if val == true then
            local antVP = Instance.new("Part", workspace.Arena["main island"])
            local antVPb = Instance.new("Part", battleArena)

            antVP.Name = "ANTVP"
            antVP.Anchored = true
            antVP.Transparency = 0.5
            antVP.CFrame = CFrame.new(-4.08799744, -15.9228516, 1.83599997, 0, 1, -0, -1, 0, 0, 0, 0, 1)
            antVP.Size = Vector3.new(12.5, 800, 800)

            antVPb.Name = "ANTVP"
            antVPb.Anchored = true
            antVPb.Transparency = 0.5
            antVPb.CFrame = CFrame.new(3417.198, 72.2148895, 2.81490707, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            antVPb.Size = Vector3.new(800, 14, 1200)
        elseif val == false then
            if mainArena:FindFirstChild("ANTVP") then
                mainArena.ANTVP:Destroy()
            end

            if battleArena:FindFirstChild("ANTVP") then
                battleArena.ANTVP:Destroy()
            end
        end
    end
})

slapBattlesTab:AddToggle({
    Name = "Anti Ragdoll (resets character)",
    Default = false,
    Callback = function(val)
        if not gCheck("sb") then
            return
        end

        getgenv().antiragdolsb = val
            if getgenv().antiragdolsb then
                game.Players.LocalPlayer.Character.Humanoid.Health = 0
                game.Players.LocalPlayer.CharacterAdded:Connect(function()
                    game.Players.LocalPlayer.Character:WaitForChild("Ragdolled").Changed:Connect(function()
                        if game.Players.LocalPlayer.Character:WaitForChild("Ragdolled").Value == true and getgenv().antiragdolsb then
                            repeat task.wait() game.Players.LocalPlayer.Character.Torso.Anchored = true
                            until game.Players.LocalPlayer.Character:WaitForChild("Ragdolled").Value == false
                            game.Players.LocalPlayer.Character.Torso.Anchored = false
                        end
                    end)
                end)
            end

    end
})

brookhavenTab:AddToggle({
    Name = "Go Trough Doors",
    Default = false,
    Callback = function(val)
        if not gCheck("bh") then
            return
        end

        if val == true then
            for _, m in pairs(workspace["001_Lots"]:GetChildren()) do
                if m:FindFirstChild("HousePickedByPlayer") then
                    local hm = m.HousePickedByPlayer.HouseModel
    
                    if hm:FindFirstChild("001_HouseDoors") then
                        if hm["001_HouseDoors"]:FindFirstChild("HouseDoorFront") then
                            hm["001_HouseDoors"].HouseDoorFront.Door.CanCollide = not val
                        end
                    end
                end
            end
        elseif val == false then
            for _, m in pairs(workspace["001_Lots"]:GetChildren()) do
                if m:FindFirstChild("HousePickedByPlayer") then
                    local hm = m.HousePickedByPlayer.HouseModel
    
                    if hm:FindFirstChild("001_HouseDoors") then
                        if hm["001_HouseDoors"]:FindFirstChild("HouseDoorFront") then
                            hm["001_HouseDoors"].HouseDoorFront.Door.CanCollide = not val
                        end
                    end
                end
            end
        end
    end
})

brookhavenTab:AddToggle({
    Name = "Ban Bypass",
    Default = false,
    Callback = function(val)
        if not gCheck("bh") then
            return
        end

        if val == true then
            for _, m in pairs(workspace["001_Lots"]:GetChildren()) do
                if m:FindFirstChild("HousePickedByPlayer") then
                    local hm = m.HousePickedByPlayer.HouseModel
    
                    for _, p in pairs(hm:GetChildren()) do
                        if string.find(p.Name, "BannedBlock") then
                            p.CanCollide = not val
                        end
                    end
                end
            end
        elseif val == false then
            for _, m in pairs(workspace["001_Lots"]:GetChildren()) do
                if m:FindFirstChild("HousePickedByPlayer") then
                    local hm = m.HousePickedByPlayer.HouseModel
    
                    for _, p in pairs(hm:GetChildren()) do
                        if string.find(p.Name, "BannedBlock") then
                            p.CanCollide = not val
                        end
                    end
                end
            end
        end
    end
})

OrionLib:Init()
