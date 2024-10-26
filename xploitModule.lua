local module = {}

local localplr = game.Players.LocalPlayer
local localhum = localplr.Character:FindFirstChild("Humanoid")

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
        GetLocalPLR = function()
            return localplr
        end,
        CurrentWalkSpeed = function()
            if localhum then

                return {

                    Value = localhum.WalkSpeed,
                    Change = function(newSpeed)
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
        end

    }

end

return module
