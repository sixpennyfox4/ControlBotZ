local module = {}

local localplr = game.Players.LocalPlayer
local localhum = localplr.Character:FindFirstChild("Humanoid")

module.LocalPLR = localplr
module.LocalHum = localhum


function module.CurrentWalkSpeed()
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

    end

    return nil
end

return module
