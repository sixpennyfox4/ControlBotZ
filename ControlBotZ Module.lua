local module = {}

module.Username = ""
module.Prefix = ""
module.Admins = {}
module.Whitelist = {}
module.Bots = {}

-- VARS:
local TextChatService = game:GetService("TextChatService")
local plrs = game:GetService("Players")
local LocalPLR = plrs.LocalPlayer

-- FUNCTIONS:
function module:firstBotDo(callback)

    if module:GetIndex() == 1 then
        callback()
    end

end

function module:addAdmin(name)

    if not table.find(module.Admins, name) then
        table.insert(module.Admins, name)
    end

end

function module:removeAdmin(name)

    for i, adminUser in pairs(module.Admins) do
        if adminUser == name then
            table.remove(module.Admins, i)
        end
    end

end

function module:getFullPlayerName(name)

    for _, plr in pairs(plrs:GetPlayers()) do
        if string.find(plr.Name, name) then
            return plr.Name
        end
    end

end

function module:isR15(returnValTrue, returnValFalse)

    if LocalPLR.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
        if returnValTrue then
            return returnValTrue
        else
            return true
        end
    elseif LocalPLR.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
        if returnValFalse then
            return returnValFalse
        else
            return false
        end
    end

end

function module:IsABot()

    if LocalPLR.Name == module.Username then
        return false
    end

    return true
end

function module:GetIndex()
    local index
    for i, bot in pairs(module.Bots) do
        if LocalPLR.Name == bot then
            index = i
        end
    end

    return index
end

function module:Chat(message)

    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync(message)
    else
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
    end

end

function module:GetArgs(start)

    local args = {}
    for arg in start:match("^%s*(.-)%s*$"):gmatch("%S+") do
        table.insert(args, arg)
    end

    return args
end

function module:addWhitelist(name)

    if not table.find(module.Whitelist, name) then
        table.insert(module.Whitelist, name)
    end

end

function module:removeWhitelist(name)

    for i, whitelistedUser in pairs(module.Whitelist) do
        if whitelistedUser == name then
            table.remove(module.Whitelist, i)
        end
    end

end

function module:isOwnerOrAdmin(name)

    for _, adminUser in pairs(module.Admins) do
        if name == adminUser or name == module.Username then
            return true
        end
    end

    return false
end

function module:isWhitelisted(name)

    if table.find(module.Whitelist, name) then
        return true
    end

    return false
end

function module:Init(callback)

    for _, player in pairs(plrs:GetPlayers()) do
        player.Chatted:Connect(function(message)
            callback(player, message)
        end)
    end

    plrs.PlayerAdded:Connect(function(player)
        player.Chatted:Connect(function(message)
            callback(player, message)
        end)
    end)

end

function module:dynamicBotSystem(newIndexValue)

    plrs.PlayerRemoving:Connect(function(player)
        for i, bot in pairs(module.Bots) do
            if player.Name == bot then
                table.remove(module.Bots, i)
                newIndexValue = module:GetIndex()

                if newIndexValue == 1 then
                    module:Chat("Bot " .. i .. " left the game!")
                end
            end
        end
    end)

end

function module:specifyBots(argTable, tableStartIndex, callback)

    local botArgs = {}
    for i = tableStartIndex, #argTable do
        table.insert(botArgs, argTable[i])
    end

    if #botArgs == 0 then
        callback()
    else
        for _, botArg in ipairs(botArgs) do
            if module:GetIndex() == tonumber(botArg) then
                callback()
            end
        end
    end

end

return module
