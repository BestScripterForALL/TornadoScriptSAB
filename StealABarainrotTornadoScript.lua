local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local RootGui = Instance.new("ScreenGui")
RootGui.Name = "TornadoScriptsGui"
RootGui.ResetOnSpawn = false
RootGui.Parent = PlayerGui

local function makeDraggable(widget)
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local function update(input)
        local delta = input.Position - dragStart
        widget.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    widget.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = widget.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    widget.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            update(input)
        end
    end)
end

local TpButton = Instance.new("TextButton")
TpButton.Name = "TpButton"
TpButton.Size = UDim2.fromOffset(60, 60)
TpButton.Position = UDim2.new(1, -70, 1, -70)
TpButton.Text = "ТП"
TpButton.TextScaled = true
TpButton.Font = Enum.Font.GothamBold
TpButton.BackgroundColor3 = Color3.new()
TpButton.TextColor3 = Color3.new(1, 1, 1)
TpButton.BorderSizePixel = 0
TpButton.AutoButtonColor = false
TpButton.Parent = RootGui

local TpCorner = Instance.new("UICorner", TpButton)
TpCorner.CornerRadius = UDim.new(1, 0)

local TpStroke = Instance.new("UIStroke", TpButton)
TpStroke.Thickness = 3
TpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
TpStroke.Color = Color3.new(1, 0, 0)

task.spawn(function()
    local hue = 0
    while true do
        hue = (hue + 1) % 360
        TpStroke.Color = Color3.fromHSV(hue / 360, 1, 1)
        task.wait(0.05)
    end
end)

makeDraggable(TpButton)

local function getExtractorTarget()
    local Bases = workspace:FindFirstChild("Bases")
    if not Bases then return nil end

    local PlayersFolder = Bases:FindFirstChild("Players")
    if not PlayersFolder then return nil end

    local MeFolder = PlayersFolder:FindFirstChild(LocalPlayer.Name)
    if not MeFolder then return nil end

    local Extractors = MeFolder:FindFirstChild("Extractors")
    if not Extractors then return nil end

    local Model = Extractors:FindFirstChild("1")
    return Model
end

local function teleportToTarget()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local extractorTarget = getExtractorTarget()
    if extractorTarget then
        local cf, size = extractorTarget:GetBoundingBox()
        local pos = cf.Position + Vector3.new(0, size.Y / 2 + 5, 0)
        hrp.CFrame = CFrame.new(pos)
    end
end

TpButton.MouseButton1Click:Connect(teleportToTarget)

local MenuToggleButton = Instance.new("TextButton")
MenuToggleButton.Name = "MenuToggleButton"
MenuToggleButton.Size = UDim2.fromOffset(60, 60)
MenuToggleButton.Position = UDim2.new(0, 10, 1, -70)
MenuToggleButton.Text = "≡"
MenuToggleButton.TextScaled = true
MenuToggleButton.Font = Enum.Font.GothamBold
MenuToggleButton.BackgroundColor3 = Color3.new()
MenuToggleButton.TextColor3 = Color3.new(1, 1, 1)
MenuToggleButton.BorderSizePixel = 0
MenuToggleButton.AutoButtonColor = false
MenuToggleButton.Parent = RootGui

local MenuCorner = Instance.new("UICorner", MenuToggleButton)
MenuCorner.CornerRadius = UDim.new(1, 0)

local MenuStroke = Instance.new("UIStroke", MenuToggleButton)
MenuStroke.Thickness = 3
MenuStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MenuStroke.Color = Color3.new(1, 0, 0)

task.spawn(function()
    local hue = 0
    while true do
        hue = (hue + 1) % 360
        MenuStroke.Color = Color3.fromHSV(hue / 360, 1, 1)
        task.wait(0.05)
    end
end)

makeDraggable(MenuToggleButton)

local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "TornadoMenu"
MenuFrame.Size = UDim2.new(0, 300, 0, 250)
MenuFrame.Position = UDim2.fromScale(0.5, 0.5)
MenuFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MenuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MenuFrame.BackgroundTransparency = 0.1
MenuFrame.Visible = false
MenuFrame.Parent = RootGui

makeDraggable(MenuFrame)

local FrameStroke = Instance.new("UIStroke", MenuFrame)
FrameStroke.Thickness = 4
FrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
FrameStroke.Color = Color3.new(1, 0, 0)

task.spawn(function()
    local hue = 0
    while true do
        hue = (hue + 1) % 360
        FrameStroke.Color = Color3.fromHSV(hue / 360, 1, 1)
        task.wait(0.05)
    end
end)

local FrameCorner = Instance.new("UICorner", MenuFrame)
FrameCorner.CornerRadius = UDim.new(0, 12)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "Tornado Scripts"
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextScaled = true
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Parent = MenuFrame

local NoclipButton = Instance.new("TextButton")
NoclipButton.Name = "NoclipButton"
NoclipButton.Size = UDim2.new(0, 260, 0, 40)
NoclipButton.Position = UDim2.new(0.5, 0, 0, 60)
NoclipButton.AnchorPoint = Vector2.new(0.5, 0)
NoclipButton.Text = "Noclip: OFF"
NoclipButton.TextScaled = true
NoclipButton.Font = Enum.Font.GothamBold
NoclipButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
NoclipButton.TextColor3 = Color3.new(1, 1, 1)
NoclipButton.BorderSizePixel = 0
NoclipButton.Parent = MenuFrame

local NoclipCorner = Instance.new("UICorner", NoclipButton)
NoclipCorner.CornerRadius = UDim.new(0, 8)

local NoclipActive = false

MenuToggleButton.MouseButton1Click:Connect(function()
    MenuFrame.Visible = not MenuFrame.Visible
end)

local function setNoclip(state)
    NoclipActive = state
    NoclipButton.Text = state and "Noclip: ON" or "Noclip: OFF"
    NoclipButton.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end

NoclipButton.MouseButton1Click:Connect(function()
    setNoclip(not NoclipActive)
end)

RunService.Stepped:Connect(function()
    if NoclipActive then
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

local AutoLockBaseActive = false

local AutoLockBaseButton = Instance.new("TextButton")
AutoLockBaseButton.Name = "AutoLockBaseButton"
AutoLockBaseButton.Size = UDim2.new(0, 260, 0, 40)
AutoLockBaseButton.Position = UDim2.new(0.5, 0, 0, 110)
AutoLockBaseButton.AnchorPoint = Vector2.new(0.5, 0)
AutoLockBaseButton.Text = "Auto Lock Base: OFF"
AutoLockBaseButton.TextScaled = true
AutoLockBaseButton.Font = Enum.Font.GothamBold
AutoLockBaseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
AutoLockBaseButton.TextColor3 = Color3.new(1, 1, 1)
AutoLockBaseButton.BorderSizePixel = 0
AutoLockBaseButton.Parent = MenuFrame

local AutoLockBaseCorner = Instance.new("UICorner", AutoLockBaseButton)
AutoLockBaseCorner.CornerRadius = UDim.new(0, 8)

local AutoLockBaseThread = nil

local function AutoLockBaseCheck()
    local bases = workspace:FindFirstChild("Bases")
    if not bases then return false end

    local playersFolder = bases:FindFirstChild("Players")
    if not playersFolder then return false end

    for _, base in ipairs(playersFolder:GetChildren()) do
        if base:IsA("Model") then
            local owner = base:FindFirstChild("Owner")
            if owner and owner:IsA("StringValue") and owner.Value == LocalPlayer.Name then
                local data = base:FindFirstChild("Data")
                if not data then return false end

                local locked = data:FindFirstChild("Locked")
                if not locked or not locked:IsA("NumberValue") then return false end

                if locked.Value <= 1 then
                    local lockTouch = base:FindFirstChild("LockTouch")
                    if lockTouch then
                        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local cf, size = lockTouch:GetBoundingBox()
                            local pos = cf.Position + Vector3.new(0, size.Y / 2 + 5, 0)
                            hrp.CFrame = CFrame.new(pos)
                            return true
                        end
                    end
                end
            end
        end
    end

    return false
end

local function startAutoLockBase()
    if AutoLockBaseThread then return end
    AutoLockBaseThread = task.spawn(function()
        while AutoLockBaseActive do
            AutoLockBaseCheck()
            task.wait(0.5)
        end
        AutoLockBaseThread = nil
    end)
end

local function stopAutoLockBase()
    AutoLockBaseActive = false
end

AutoLockBaseButton.MouseButton1Click:Connect(function()
    AutoLockBaseActive = not AutoLockBaseActive

    if AutoLockBaseActive then
        AutoLockBaseButton.Text = "Auto Lock Base: ON"
        AutoLockBaseButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        startAutoLockBase()
    else
        AutoLockBaseButton.Text = "Auto Lock Base: OFF"
        AutoLockBaseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        stopAutoLockBase()
    end
end)
