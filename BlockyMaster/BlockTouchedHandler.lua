-- / Services
local TweenService = game:GetService("TweenService")

-- / Variables
local BlockModel = Workspace.BLOCK 
local Triggers = Workspace.Triggers:GetChildren("Base")
local TriggerGateModels = Workspace:FindFirstChild("Triggers")

-- / Functions
BlockModel.Touched:Connect(function(hit: BasePart)
	if hit:IsDescendantOf(game.Workspace.Triggers) then return end --Checks wheter what touched the trigger is a chikld of the triggers folder
    	--FIRES WHEN THE BLOCK TOUCHES THE TRIGGERS
	local TouchedTrigger = hit
	local ToucehdTriggerDoorModel = hit:GetAttribute("Trigger_Number")  --Get's the Attribute of the gate that's suppose to be opended by the player

	if not TriggerGateModels then return end --If the TriggersGate Model in the Triggers model is found.
				
	for _, part: BasePart in TriggerGateModels:GetDescendants() do
	
		if part.Name ~= "Gate" and ToucehdTriggerDoorModel ~= part:GetAttribute("GateNumber") then continue end
						
		local partOriginalPosition = part.Position
		local offset = Vector3.new(0, 0, 20) -- Adjust the offset as needed
		local newCFrame = part.CFrame * CFrame.new(offset)
						
		local OpenTween = TweenService:Create(part, TweenInfo.new(6), {CFrame = newCFrame})
							
		OpenTween:Play()
		part.Parent.Cross.Base.CanTouch = false
						
		OpenTween.Completed:Wait()
						
		local offset = Vector3.new(0, 0, -20) -- Adjust the offset as needed
		local newCFrame = part.CFrame * CFrame.new(offset)
		local CloseTween = TweenService:Create(part, TweenInfo.new(6), {CFrame = newCFrame})

		CloseTween:Play()
		CloseTween.Completed:Wait()
				
		part.Parent.Cross.Base.CanTouch = true
		
       end
end)
