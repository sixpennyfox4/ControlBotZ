local module = {}

local localplr = game.Players.LocalPlayer
local localhum = localplr.Character:FindFirstChild("Humanoid")

local currentHealth = localhum.Health

function module.BypassText(text: string, method: number)
    if method == 1 then
        local function modifyText(input)
            local modifiedText = ""
            for i = 1, #input do
                modifiedText = modifiedText .. string.sub(input, i, i) .. ">"
            end

            return modifiedText
        end

        return modifyText(text)
    elseif method == 2 then
        local function addAccents(word)
            local accents = {
                a = "ǎ",
                b = "ḃ",
                c = "ć",
                d = "d́",
                e = "ě",
                f = "ḟ",
                g = "ġ",
                h = "ḣ",
                i = "í",
                j = "j́",
                k = "ḱ",
                l = "ĺ",
                m = "ḿ",
                n = "n̋",
                o = "ō",
                p = "ṕ",
                q = "q́",
                r = "ŕ",
                s = "ś",
                t = "t̋",
                u = "ū",
                v = "v̇",
                w = "ẃ",
                x = "x́",
                y = "ý",
                z = "ź"
            }

            local minifiedWord = ""
            for i = 1, #word do
                local letter = word:sub(i, i):lower()
                if accents[letter] then
                    minifiedWord = minifiedWord .. accents[letter]
                else
                    minifiedWord = minifiedWord .. letter
                end
            end

            return minifiedWord
        end

        local function minifyString(input)
            local words = {}
            for word in string.gmatch(input, "%S+") do
                table.insert(words, addAccents(word))
            end
            return table.concat(words, " ")
        end

        return minifyString(text)
    else
        warn("xploitModule: Bypass method not found!")
    end
end

function module.GetExecutor()
    return identifyexecutor() or "unknown"
end

function module.Player()

    return {

        Humanoid = localhum,

        Kill = function()
            if localhum then
                localhum.Health = 0
            else
                warn("xploitModule: Humanoid not found!")
            end
        end,

        GetLocalPLR = localplr,

        CurrentWalkSpeed = function()
            if localhum then

                return {

                    Value = localhum.WalkSpeed,
                    Change = function(newSpeed: number)
                        if newSpeed >= 0 then
                            localhum.WalkSpeed = newSpeed
                        else
                            warn("xploitModule: Could not change player speed under 0!")
                        end
                    end

                }

            else

                warn("xploitModule: Humanoid not found!")

            end

            return nil
        end,

        CurrentHealth = function()
            if localhum then

                return {

                    Value = localhum.Health,
                    Change = function(newHealth: number)
                        localhum.Health = newHealth
                    end

                }

            else
                warn("xploitModule: Humanoid not found!")
            end
        end,

        Gravity = function()

            return {

                Value = workspace.Gravity,
                Change = function(newGravity: number)
                    workspace.Gravity = newGravity
                end

            }

        end,

        OnDeath = function(callback)
            localhum.Died:Connect(callback)
        end,

        OnJump = function(callback)
            if localhum then
                local lastJumpTime = 0
                local jumpCooldown = 0.5

                localhum:GetPropertyChangedSignal("Jump"):Connect(function()
                    if localhum.Jump and (os.clock() - lastJumpTime > jumpCooldown) then
                        lastJumpTime = os.clock()
                        callback()
                    end
                end)
            else
                warn("xploitModule: Humanoid not found!")
            end
        end,

        OnDamage = function(callback)
            if localhum then
                localhum.HealthChanged:Connect(function()
                    if localhum.Health < currentHealth then
                        currentHealth = localhum.Health

                        callback()
                    end
                end)
            else
                warn("xploitModule: Humanoid not found!")
            end
        end,

        RejoinServer = function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, localplr)
        end,

        Chat = function(msg: string)

            if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
                game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(msg)
            else
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
            end

        end

    }

end

return module
