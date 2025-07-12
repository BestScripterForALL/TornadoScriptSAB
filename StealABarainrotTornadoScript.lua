local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local RootGui = Instance.new("ScreenGui")
RootGui.Name = "TornadoScriptsGui"
RootGui.ResetOnSpawn = false
RootGui.Parent = PlayerGui

local function makeDraggable(w)
    local d,di,ds,sp
    local function u(i)
        local dt = i.Position - ds
        w.Position = UDim2.new(sp.X.Scale, sp.X.Offset + dt.X, sp.Y.Scale, sp.Y.Offset + dt.Y)
    end
    w.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            d = true
            ds = i.Position
            sp = w.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then d = false end
            end)
        end
    end)
    w.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement then di = i end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if d and i == di then u(i) end
    end)
end

local TpButton = Instance.new("TextButton")
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
Instance.new("UICorner", TpButton).CornerRadius = UDim.new(1, 0)
local TpStroke = Instance.new("UIStroke", TpButton)
TpStroke.Thickness = 3
TpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
task.spawn(function() local h=0 while true do h=(h+1)%360 TpStroke.Color=Color3.fromHSV(h/360,1,1) task.wait(0.05) end end)
makeDraggable(TpButton)

local function getExtractorTarget()
    local b = workspace:FindFirstChild("Bases")
    if not b then return end
    local pf = b:FindFirstChild("Players")
    if not pf then return end
    local me = pf:FindFirstChild(LocalPlayer.Name)
    if not me then return end
    local ex = me:FindFirstChild("Extractors")
    if not ex then return end
    return ex:FindFirstChild("1")
end

local function teleportToExtractor()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local t = getExtractorTarget()
    if t then
        local cf,s = t:GetBoundingBox()
        hrp.CFrame = CFrame.new(cf.Position + Vector3.new(0, s.Y/2 + 5, 0))
    end
end

TpButton.MouseButton1Click:Connect(teleportToExtractor)

local MenuToggleButton = Instance.new("TextButton")
MenuToggleButton.Size = UDim2.fromOffset(60, 60)
MenuToggleButton.Position = UDim2.new(0, 10, 1, -70)
MenuToggleButton.Text = "≡"
MenuToggleButton.TextScaled = true
MenuToggleButton.Font = Enum.Font.GothamBold
MenuToggleButton.BackgroundColor3 = Color3.new()
MenuToggleButton.TextColor3 = Color3.new(1,1,1)
MenuToggleButton.BorderSizePixel = 0
MenuToggleButton.AutoButtonColor = false
MenuToggleButton.Parent = RootGui
Instance.new("UICorner", MenuToggleButton).CornerRadius = UDim.new(1,0)
local MenuStroke = Instance.new("UIStroke", MenuToggleButton)
MenuStroke.Thickness = 3
MenuStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
task.spawn(function() local h=0 while true do h=(h+1)%360 MenuStroke.Color=Color3.fromHSV(h/360,1,1) task.wait(0.05) end end)
makeDraggable(MenuToggleButton)

local MenuFrame = Instance.new("Frame")
MenuFrame.Size = UDim2.new(0,300,0,250)
MenuFrame.Position = UDim2.fromScale(0.5,0.5)
MenuFrame.AnchorPoint = Vector2.new(0.5,0.5)
MenuFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MenuFrame.BackgroundTransparency = 0.1
MenuFrame.Visible = false
MenuFrame.Parent = RootGui
makeDraggable(MenuFrame)
local fs = Instance.new("UIStroke", MenuFrame)
fs.Thickness = 4
fs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
task.spawn(function() local h=0 while true do h=(h+1)%360 fs.Color=Color3.fromHSV(h/360,1,1) task.wait(0.05) end end)
Instance.new("UICorner", MenuFrame).CornerRadius = UDim.new(0,12)
local tl = Instance.new("TextLabel", MenuFrame)
tl.Size = UDim2.new(1,0,0,40)
tl.BackgroundTransparency = 1
tl.Text = "Tornado Scripts"
tl.Font = Enum.Font.GothamBlack
tl.TextScaled = true
tl.TextColor3 = Color3.new(1,1,1)

local NoclipButton = Instance.new("TextButton", MenuFrame)
NoclipButton.Size = UDim2.new(0,260,0,40)
NoclipButton.Position = UDim2.new(0.5,0,0,60)
NoclipButton.AnchorPoint = Vector2.new(0.5,0)
NoclipButton.Text = "Noclip: OFF"
NoclipButton.TextScaled = true
NoclipButton.Font = Enum.Font.GothamBold
NoclipButton.BackgroundColor3 = Color3.fromRGB(150,0,0)
NoclipButton.TextColor3 = Color3.new(1,1,1)
NoclipButton.BorderSizePixel = 0
Instance.new("UICorner", NoclipButton).CornerRadius = UDim.new(0,8)

local NoclipActive = false
local function setNoclip(s)
    NoclipActive = s
    NoclipButton.Text = s and "Noclip: ON" or "Noclip: OFF"
    NoclipButton.BackgroundColor3 = s and Color3.fromRGB(0,150,0) or Color3.fromRGB(150,0,0)
end
NoclipButton.MouseButton1Click:Connect(function() setNoclip(not NoclipActive) end)

RunService.Stepped:Connect(function()
    if NoclipActive then
        local c = LocalPlayer.Character
        if c then
            for _,p in pairs(c:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    end
end)

local KillAuraButton = Instance.new("TextButton", MenuFrame)
KillAuraButton.Size = UDim2.new(0,260,0,40)
KillAuraButton.Position = UDim2.new(0.5,0,0,110)
KillAuraButton.AnchorPoint = Vector2.new(0.5,0)
KillAuraButton.Text = "KillAura: OFF"
KillAuraButton.TextScaled = true
KillAuraButton.Font = Enum.Font.GothamBold
KillAuraButton.BackgroundColor3 = Color3.fromRGB(150,0,0)
KillAuraButton.TextColor3 = Color3.new(1,1,1)
KillAuraButton.BorderSizePixel = 0
Instance.new("UICorner", KillAuraButton).CornerRadius = UDim.new(0,8)

local KillAuraActive = false
local KillAuraThread

local function findTarget()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local closest,dist
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local d = (hrp.Position - plr.Character.HumanoidRootPart.Position).Magnitude
            if d <= 200 and (not dist or d < dist) then
                closest = plr
                dist = d
            end
        end
    end
    return closest
end

local function attackTarget(tplr)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local thrp = tplr.Character and tplr.Character:FindFirstChild("HumanoidRootPart")
    if not hrp or not thrp then return end
    local behind = thrp.CFrame * CFrame.new(0,0,3)
    hrp.CFrame = CFrame.new(behind.Position, thrp.Position)
    VIM:SendMouseButtonEvent(0,0,0,true,game,0)
    task.wait(0.05)
    VIM:SendMouseButtonEvent(0,0,0,false,game,0)
end

local function startKillAura()
    if KillAuraThread then return end
    KillAuraThread = task.spawn(function()
        while KillAuraActive do
            local tgt = findTarget()
            if tgt then attackTarget(tgt) end
            task.wait(0.2)
        end
        KillAuraThread = nil
    end)
end

KillAuraButton.MouseButton1Click:Connect(function()
    KillAuraActive = not KillAuraActive
    KillAuraButton.Text = KillAuraActive and "KillAura: ON" or "KillAura: OFF"
    KillAuraButton.BackgroundColor3 = KillAuraActive and Color3.fromRGB(0,150,0) or Color3.fromRGB(150,0,0)
    if KillAuraActive then startKillAura() end
end)

MenuToggleButton.MouseButton1Click:Connect(function()
    MenuFrame.Visible = not MenuFrame.Visible
end)
