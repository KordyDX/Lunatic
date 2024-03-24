local run = game:GetService'RunService'
local uis = game:GetService'UserInputService'

local cam = workspace.Camera
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local mult = 180/math.pi
local clamp = math.clamp

local current = Vector2.zero
local targetX, targetY = 0, 0

local speed = 10
local sensitivity = 0.75

uis.MouseDeltaSensitivity = 0.01
cam.CameraType = Enum.CameraType.Custom

run:BindToRenderStep("SmoothCam", Enum.RenderPriority.Camera.Value-1, function(dt)
	local delta = uis:GetMouseDelta()*sensitivity*100
	targetX += delta.X
	targetY = clamp(targetY+delta.Y,-80,80)
	current = current:Lerp(Vector2.new(targetX,targetY), dt*speed)
	cam.CFrame = CFrame.fromOrientation(-current.Y/mult,-current.X/mult,0)
end)