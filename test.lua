local module = {}

module.LocalPLR = game.Players.LocalPlayer
module.CurrentWalkSpeed = module.LocalPLR.Character.Humanoid.WalkSpeed

return module
