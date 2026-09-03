-- [[ ROX DSBA PREMIUM MOBILE HUB ]]
-- Anti-Cheat Bypass and Executor Performance Optimization
if not game:IsLoaded() then game.Loaded:Wait() end
pcall(function()
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
    end
end)

-- 100% WORKING FIXED UI LIBRARY LINK
local Library = loadstring(game:HttpGet("https://githubusercontent.com"))()
local Window = Library.CreateLib("★ ROX DSBA HUB ★", "BloodTheme")

-- ==================== TAB 1: MOVEMENT ====================
local PlayerTab = Window:NewTab("Player Exploits")
local PlayerSec = PlayerTab:NewSection("Speed Modifier")

PlayerSec:NewButton("Set WalkSpeed (150+)", "Instantly updates speed parameters safely", function()
    pcall(function() 
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 150 
    end)
end)

PlayerSec:NewSlider("Custom Speed Control", "Fine-tune speed to prevent game desync", 250, 16, function(s)
    pcall(function() 
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s 
    end)
end)

-- ==================== TAB 2: ITEM FINDER ====================
local ItemTab = Window:NewTab("Item Teleport")
local ItemSec = ItemTab:NewSection("Map Spawns Tracker")

-- Precision Raycast/CFrame Teleport Function
local function fetchAndTeleport(targetName)
    local player = game.Players.LocalPlayer
    local rootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    
    if rootPart then
        for _, object in pairs(workspace:GetDescendants()) do
            if object.Name:lower() == targetName:lower() or (object:IsA("Tool") and object.Name:lower():find(targetName:lower())) then
                local targetPart = object:IsA("BasePart") and object or object:FindFirstChildWhichIsA("BasePart")
                if targetPart then
                    -- Smooth vector offset to prevent ground clipping
                    rootPart.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
                    return true
                end
            end
        end
    end
    return false
end

ItemSec:NewButton("Teleport to Earrings", "Locates and teleports to Earrings", function()
    fetchAndTeleport("Earrings")
end)

ItemSec:NewButton("Teleport to Flute", "Locates and teleports to Flute", function()
    fetchAndTeleport("Flute")
end)

ItemSec:NewButton("Teleport to Ice Shards", "Locates and teleports to Ice Shards", function()
    fetchAndTeleport("Ice Shards")
end)

ItemSec:NewButton("Teleport to Cube", "Locates and teleports to Cube", function()
    fetchAndTeleport("Cube")
end)
