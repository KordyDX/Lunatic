local TweenService = game:GetService("TweenService")

local doorParent = script.Parent
local doorModel = script.Parent.Door
local hinge = doorParent.HingeWeldPart
local prompt = doorModel.ProximityPrompt

local soundUnlocked = script.Parent.unlocked
local soundLocked = script.Parent.locked
local soundMove = script.Parent.move
local soundStop = script.Parent.stop

local goalOpen1 = {CFrame = hinge.CFrame * CFrame.Angles(0, math.rad(80), 0)}
local goalOpen2 = {CFrame = hinge.CFrame * CFrame.Angles(0, math.rad(-80), 0)}
local goalClose = {CFrame = hinge.CFrame * CFrame.Angles(0, 0, 0)}
local canInteract = true

local tweenInfo = TweenInfo.new(1)
local tweenOpen1 = TweenService:Create(hinge, tweenInfo, goalOpen1)
local tweenOpen2 = TweenService:Create(hinge, tweenInfo, goalOpen2)
local tweenClose = TweenService:Create(hinge, tweenInfo, goalClose)

local keyName = doorParent:GetAttribute("keyName")

local function isPositionInFront(position)
	return position.Unit:Dot(doorModel.CFrame.LookVector)
end

prompt.Triggered:Connect(function(player)
	local isUnlocked = doorParent:GetAttribute("isUnlocked")
	local playerHasKey = player.Backpack:FindFirstChild(keyName)

	if isUnlocked or (not isUnlocked and playerHasKey) then
		if prompt.ActionText == "Close" then
			canInteract = false
			tweenClose:Play()
			
			script.Parent.doorMoving:Play()
			wait(0.8)
			script.Parent.stop:Play()

			prompt.ActionText = "Open"
			canInteract = true
		else
			if (playerHasKey and not isUnlocked) then
				doorParent:SetAttribute("isUnlocked", true)
				playerHasKey:Destroy()
				script.Parent.unlocked:Play()
			end
			
			
			local playerPosition = player.Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector
			if isPositionInFront(playerPosition) < 0 then
				tweenOpen1:Play()
			else
				tweenOpen2:Play()
			end

			script.Parent.doorMoving:Play()
			wait(0.8)
			script.Parent.stop:Play()

			prompt.ActionText = "Close"
		end
	end
end)