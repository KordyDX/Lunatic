local part = Instance.new("Part")
part.Size = Vector3.new(1, 1, 1)
part.Anchored = false
part.CanCollide = false
part.Transparency = 1
part.BrickColor = BrickColor.new("Transparent")

local spotlight = Instance.new("SpotLight")
spotlight.Brightness = 1

spotlight.Range = 40
spotlight.Angle = 50
spotlight.Color = Color3.new(1, 1, 1)
spotlight.Parent = part

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
part.Parent = camera

local function updatePart()
	local lookVector = camera.CFrame.LookVector
	local cameraPosition = camera.CFrame.Position
	local rotatedLookVector = Vector3.new(lookVector.X, 0, lookVector.Z).unit
	local partPosition = cameraPosition - rotatedLookVector * 5 

	local pitch = math.asin(-lookVector.Y)
	local offset = Vector3.new(0, 2 * math.tan(pitch), 0)
	partPosition = partPosition + offset

	part.Position = partPosition

	part.CFrame = CFrame.lookAt(partPosition, partPosition + camera.CFrame.LookVector, Vector3.new(0, 1, 0))
end

game:GetService("RunService").RenderStepped:Connect(updatePart)

player.CharacterAdded:Connect(function()
	part:Destroy()
end)