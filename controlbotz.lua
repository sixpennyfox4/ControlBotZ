local TextChatService = game:GetService("TextChatService")
local LocalPLR = game.Players.LocalPlayer

getgenv().Prefix = "."
getgenv().Username = ""

function chat(msg)
    
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
    else
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    end

end

chat("ControlBotZ Running!")

function commands(player, message)
    local msg = message:lower()

    -- REJOIN:
    if msg == getgenv().Prefix .. 'rejoin' then

        if player.Name ~= getgenv().Username then
            return
        end

        LocalPLR:Kick("REJOINING...")
        wait()
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPLR)
    
    end

    -- RESET:
    if msg == getgenv().Prefix .. "reset" then

        if player.Name ~= getgenv().Username then
            return
        end

        LocalPLR.Character.Humanoid.Health = 0

    end

    -- JUMP:
    if msg == getgenv().Prefix .. "jump" then

        if player.Name ~= getgenv().Username then
            return
        end

        LocalPLR.Character.Humanoid.Jump = true

    end

    -- BRING:
    if msg == getgenv().Prefix .. "bring" then
        
        if player.Name ~= getgenv().Username then
            return
        end

        LocalPLR.Character:FindFirstChild("HumanoidRootPart").CFrame = game.Players[getgenv().Username].Character:FindFirstChild("HumanoidRootPart").CFrame
    
    end

    -- CHAT:
    if msg:sub(1, 5) == getgenv().Prefix .. "chat" then
        
        if player.Name ~= getgenv().Username then
            return
        end

        chat(message:sub(7))

    end

    -- SIT:
    if msg == getgenv().Prefix .. "sit" then
        
        if player.Name ~= getgenv().Username then
            return
        end
        
        LocalPLR.Character.Humanoid.Sit = true

    end

    -- SPEED:
    if msg:sub(1, 6) == getgenv().Prefix .. "speed" then
        
        if player.Name ~= getgenv().Username then
            return
        end

        LocalPLR.Character.Humanoid.WalkSpeed = msg:sub(8)

    end

    -- SHUTDOWN:
    if msg == getgenv().Prefix .. "shutdown" then
        
        if player.Name ~= getgenv().Username then
            return
        end

        game:Shutdown()
        
    end

    -- ORBIT:
    if msg:sub(1, 6) == getgenv().Prefix .. "orbit" then
        
        if player.Name ~= getgenv().Username then
            return
        end

        local targetPLR = message:sub(8)
        local player = game.Players[targetPLR].Character.HumanoidRootPart
        local lpr = game.Players.LocalPlayer.Character.HumanoidRootPart


        local speed = 8
        local radius = 8
        local eclipse = 1
        local rotation = CFrame.Angles(0,0,0)

        local sin, cos = math.sin, math.cos
        local rotspeed = math.pi*2/speed
        eclipse = eclipse * radius

        local rot = 0
        orbit1 = game:GetService('RunService').Stepped:connect(function(t, dt)
        rot = rot + dt * rotspeed
        lpr.CFrame = rotation * CFrame.new(sin(rot)*eclipse, 0, cos(rot)*radius) + player.Position
        end)
    end

    if msg == getgenv().Prefix .. "unorbit" then

        if player.Name ~= getgenv().Username then
            return
        end

        orbit1:Disconnect()
        
    end

    -- WALKTO:
    if msg:sub(1, 7) == getgenv().Prefix .. "walkto" then
        
        if player.Name ~= getgenv().Username then
            return
        end

        local targetPLR = message:sub(9)

        if game.Players[targetPLR] then
            LocalPLR.Character:FindFirstChild("Humanoid"):MoveTo(game.Players[targetPLR].Character:FindFirstChild("HumanoidRootPart").Position)
        end

    end

    -- SPIN:
    if msg:sub(1, 5) == getgenv().Prefix .. "spin" then
        
        if player.Name ~= getgenv().Username then
            return
        end

        local spinSpeed = msg:sub(7)

        local Spin = Instance.new("BodyAngularVelocity")
	    Spin.Name = "Spinning"
	    Spin.Parent = LocalPLR.Character.HumanoidRootPart
	    Spin.MaxTorque = Vector3.new(0, math.huge, 0)
	    Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)

    end

    if msg == getgenv().Prefix .. "unspin" then
        
        if player.Name ~= getgenv().Username then
            return
        end

        for _, v in pairs(LocalPLR.Character.HumanoidRootPart:GetChildren()) do
            if v.Name == "Spinning" then
                v:Destroy()
            end
        end
    end

    -- BANG:
    if msg:sub(1, 5) == getgenv().Prefix .. "bang" then
        
        if player.Name ~= getgenv().Username then
            return
        end

        local targetPLR = message:sub(7)

        if game.Players[targetPLR] then
            
            bangAnim = Instance.new('Animation')
            bangAnim.AnimationId = 'rbxassetid://148840371'
            plrHum = LocalPLR.Character.Humanoid

            anim = plrHum:LoadAnimation(bangAnim)
            anim:Play()
            anim:AdjustSpeed(10)

            bangLoop = game:GetService("RunService").Stepped:Connect(function()
                wait()
                LocalPLR.Character.HumanoidRootPart.CFrame = game.Players[targetPLR].Character.HumanoidRootPart.CFrame
            end)

        end
    end

    if msg == getgenv().Prefix .. "unbang" then
        
        if player.Name ~= getgenv().Username then
            return
        end

        anim:Stop()
        bangAnim:Destroy()
        bangLoop:Disconnect()

    end

    -- CMDS:
    if msg == getgenv().Prefix .. "cmds" then

        if player.Name ~= getgenv().Username then
            return
        end

        chat("rejoin, jump, reset, sit, chat (message), shutdown, orbit (username)/unorbit, bang (username)/unbang, walkto (username), speed (number), bring")
        wait(0.2)
        chat("spin (number)/unspin")

    end

end

for _, player in pairs(game.Players:GetPlayers()) do
    player.Chatted:Connect(function(message)
        commands(player, message)
    end)
end

game.Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        commands(player, message)
    end)
end)
