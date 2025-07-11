local plr = game:GetService("Players").LocalPlayer
local user = plr.Name
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.fromOffset(60, 60)
btn.Position = UDim2.new(1, -70, 1, -70)
btn.Text = "ТП"
btn.TextScaled = true
btn.Font = Enum.Font.GothamBold
btn.BackgroundColor3 = Color3.new()
btn.TextColor3 = Color3.new(1, 1, 1)
btn.BorderSizePixel = 0
btn.AutoButtonColor = false

local corner = Instance.new("UICorner", btn)
corner.CornerRadius = UDim.new(1, 0)

local stroke = Instance.new("UIStroke", btn)
stroke.Thickness = 3
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Color = Color3.fromRGB(255, 0, 0)

task.spawn(function()
	local h = 0
	while true do
		h = (h + 1) % 360
		stroke.Color = Color3.fromHSV(h / 360, 1, 1)
		task.wait(0.05)
	end
end)

local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

btn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = btn.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

btn.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

local function getTarget()
	local w = workspace
	local b = w:FindFirstChild("Bases")
	if not b then return end
	local p = b:FindFirstChild("Players")
	if not p then return end
	local me = p:FindFirstChild(user)
	if not me then return end
	local ext = me:FindFirstChild("Extractors")
	if not ext then return end
	local mdl = ext:FindFirstChild("1")
	return mdl
end

btn.MouseButton1Click:Connect(function()
	local mdl = getTarget()
	if not mdl then return end
	local cf, size = mdl:GetBoundingBox()
	local pos = cf.Position + Vector3.new(0, size.Y / 2 + 5, 0)
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = CFrame.new(pos)
	end
end)
