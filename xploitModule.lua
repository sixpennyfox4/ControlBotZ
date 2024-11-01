local module = {}

local localplr = game.Players.LocalPlayer
local localhum = localplr.Character:FindFirstChild("Humanoid")

local currentHealth = localhum.Health

function module.BypassText(text: string, method: number)
    if method == 1 then
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
                z = "ź",
                A = "Ǎ",
                B = "Ḃ",
                C = "Ć",
                D = "D́",
                E = "Ě",
                F = "Ḟ",
                G = "Ġ",
                H = "Ḣ",
                I = "Í",
                J = "J́",
                K = "Ḱ",
                L = "Ĺ",
                M = "Ḿ",
                N = "N̋",
                O = "Ō",
                P = "Ṕ",
                Q = "Q́",
                R = "Ŕ",
                S = "Ś",
                T = "T̋",
                U = "Ū",
                V = "V̇",
                W = "Ẃ",
                X = "X́",
                Y = "Ý",
                Z = "Ź"
            }

            local bypassedWord = ""
            for i = 1, #word do
                local letter = word:sub(i, i)
                if accents[letter] then
                    bypassedWord = bypassedWord .. accents[letter]
                else
                    bypassedWord = bypassedWord .. letter
                end
            end

            return bypassedWord
        end

        local function bypassString(input)
            local words = {}
            for word in string.gmatch(input, "%S+") do
                table.insert(words, addAccents(word))
            end
            return table.concat(words, " ")
        end

        return bypassString(text)
    elseif method == 2 then
        local function addAccents2(word)
            local accents2 = {
                a = "ạ̲",
                b = "ḅ̲",
                c = "с̲",
                d = "ḍ̲",
                e = "ẹ̲",
                f = "f̲",
                g = "ɡ̲",
                h = "ḥ̲",
                i = "ị̲",
                j = "ј̲",
                k = "ḳ̲",
                l = "ḷ̲",
                m = "ṃ̲",
                n = "ṇ̲",
                o = "ọ̲",
                p = "р̲",
                q = "q̲",
                r = "ṛ̲",
                s = "ṣ̲",
                t = "ṭ̲",
                u = "ụ̲",
                v = "ṿ̲",
                w = "ẉ̲",
                x = "х̲",
                y = "ỵ̲",
                z = "ẓ̲",
                A = "Ạ̲",
                B = "Ḅ̲",
                C = "С̲",
                D = "Ḍ̲",
                E = "Ẹ̲",
                F = "F̲",
                G = "Ɡ̲",
                H = "Ḥ̲",
                I = "Ị̲",
                J = "Ј̲",
                K = "Ḳ̲",
                L = "Ḷ̲",
                M = "Ṃ̲",
                N = "Ṇ̲",
                O = "Ọ̲",
                P = "Р̲",
                Q = "Q̲",
                R = "Ṛ̲",
                S = "Ṣ̲",
                T = "Ṭ̲",
                U = "Ụ̲",
                V = "Ṿ̲",
                W = "Ẉ̲",
                X = "Х̲",
                Y = "Ỵ̲",
                Z = "Ẓ̲"
            }

            local bypassedWord = ""
            for i = 1, #word do
                local letter = word:sub(i, i)
                if accents2[letter] then
                    bypassedWord = bypassedWord .. accents2[letter]
                else
                    bypassedWord = bypassedWord .. letter
                end
            end

            return bypassedWord
        end

        local function bypassString(input)
            local words = {}
            for word in string.gmatch(input, "%S+") do
                table.insert(words, addAccents2(word))
            end
            return table.concat(words, " ")
        end

        return bypassString(text)
    elseif method == 3 then
        local function modifyText(input)
            local modifiedText = ""
            for i = 1, #input do
                modifiedText = modifiedText .. string.sub(input, i, i) .. ">"
            end

            return modifiedText
        end

        return modifyText(text)
    else
        warn("xploitModule: Bypass method not found!")
    end
end

function module.GetExecLevel()
    return printidentity()
end

function module.GetExecutor()
    return identifyexecutor() or "unknown"
end

function module.Player()

    return {

        Humanoid = localhum,

        Kill = function()
            if localhum and localhum.Health > 0 then
                localhum.Health = 0
            else
                warn("xploitModule: Humanoid not found or humanoid health is under or equal to 0!")
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

        Kick = function(reason: string)
            if reason then
                localplr:Kick(reason)
            else
                localplr:Kick()
            end
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
