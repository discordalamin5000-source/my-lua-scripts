-- [[ ROX DSBA NATIVE PREMIUM MOBILE HUB ]]
-- 100% Independent Script - No External UI Libraries Required (Anti-Block)

repeat task.wait() until game:IsLoaded()

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- 1. Create Native Core Graphical User Interface
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local ButtonLayout = Instance.new("UIListLayout")

ScreenGui.Name = "RoxDsbaHubGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Main Premium Box Design (Nocturnal Dark Matte Style)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(163, 0, 0) -- Crimson Red Border
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true -- Allows moving the menu on mobile screen

-- Title Bar
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "★ ROX DSBA HUB v3 ★"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 20

-- Layout Container for Buttons
ButtonLayout.Parent = MainFrame
ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
ButtonLayout.Padding = UDim.new(0, 8)

-- Helper Function to Create Sleek Interactive Buttons
local function createMenuButton(text, layoutOrder, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    btn.Size = UDim2.new(0, 260, 0, 45)
    btn.Position = UDim2.new(0, 10, 0, 0) -- Adjusted via Layout
    btn.Font = Enum.Font.SourceSans
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.TextSize = 16
    btn.BorderSizePixel = 0
    btn.LayoutOrder = layoutOrder
    
    -- Mobile Click Event
    btn.MouseButton1Click:Connect(callback)
    
    -- Round Corners Style
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
end

-- Teleport Logic Function (Tween Mode)
local function safeTween(itemName)
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if root then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:lower() == itemName:lower() or (obj:IsA("Tool") and obj.Name:lower():find(itemName:lower())) then
                local target = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if target then
                    local dist = (target.Position - root.Position).Magnitude
                    local tweenInfo = TweenInfo.new(dist / 160, Enum.EasingStyle.Linear)
                    local tween = TweenService:Create(root, tweenInfo, {CFrame = target.CFrame + Vector3.new(0, 3, 0)})
                    tween:Play()
                    return
                end
            end
        end
    end
end

-- 2. Inject Buttons into the Interface
createMenuButton("Speed Hack: 150+", 1, function()
    pcall(function() player.Character.Humanoid.WalkSpeed = 150 end)
end)

createMenuButton("Tween → Flute", 2, function()
    safeTween("Flute")
end)

createMenuButton("Tween → Earrings", 3, function()
    safeTween("Earrings")
end)

createMenuButton("Tween → Ice Shards", 4, function()
    safeTween("Ice Shards")
end)

createMenuButton("Tween → Cube", 5, function()
    safeTween("Cube")
end)

-- Minimize Button Feature
createMenuButton("Hide Menu", 6, function()
    MainFrame.Visible = false
    -- Floating restore icon logic could be added here
end)
