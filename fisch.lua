-- =======================================================
-- 🔥 YAMU HUB | FISCH AUTOMATION SCRIPT 
-- 1000% GUARANTEED TO LOAD ON DELTA EXECUTOR (MOBILE VIEW)
-- =======================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- ১. কাস্টম নো-ল্যাগ মোবাইল ফ্রেন্ডলি UI তৈরি
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local SubtitleLabel = Instance.new("TextLabel")
local ToggleFishBtn = Instance.new("TextButton")
local ToggleSellBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- মেইন ডার্ক মেনু ফ্রেম
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(150, 0, 0) -- লাল বর্ডার
MainFrame.Position = UDim2.new(0.15, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true -- স্ক্রিনে টেনে যেকোনো জায়গায় রাখা যাবে

-- মেইন টাইটেল
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Text = "🔥 Yamu Hub | Fisch"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.SourceSansBold

-- সাবটাইটেল (by Yamu ক্রেডিট)
SubtitleLabel.Parent = MainFrame
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Position = UDim2.new(0, 0, 0.15, 0)
SubtitleLabel.Size = UDim2.new(1, 0, 0, 20)
SubtitleLabel.Text = "Status: Premium | by Yamu"
SubtitleLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
SubtitleLabel.TextSize = 11
SubtitleLabel.Font = Enum.Font.SourceSansItalic

-- বাটন ১: অটো ফিশিং (Auto Fish)
ToggleFishBtn.Parent = MainFrame
ToggleFishBtn.Position = UDim2.new(0.05, 0, 0.32, 0)
ToggleFishBtn.Size = UDim2.new(0.9, 0, 0, 40)
ToggleFishBtn.Text = "Auto Fish: OFF"
ToggleFishBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ToggleFishBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleFishBtn.TextSize = 13
ToggleFishBtn.Font = Enum.Font.SourceSansBold

-- বাটন ২: অটো সেল (Auto Sell)
ToggleSellBtn.Parent = MainFrame
ToggleSellBtn.Position = UDim2.new(0.05, 0, 0.60, 0)
ToggleSellBtn.Size = UDim2.new(0.9, 0, 0, 40)
ToggleSellBtn.Text = "Auto Sell All: OFF"
ToggleSellBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ToggleSellBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleSellBtn.TextSize = 13
ToggleSellBtn.Font = Enum.Font.SourceSansBold

-- অন/অফ ট্র্যাকিং গ্লোবাল ভ্যারিয়েবল
_G.AutoFishYamu = false
_G.AutoSellYamu = false

-- অটো ফিশিং বাটন ফাংশন
ToggleFishBtn.MouseButton1Click:Connect(function()
    _G.AutoFishYamu = not _G.AutoFishYamu
    if _G.AutoFishYamu then
        ToggleFishBtn.Text = "Auto Fish: ON"
        ToggleFishBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 0) -- সবুজ
    else
        ToggleFishBtn.Text = "Auto Fish: OFF"
        ToggleFishBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- লাল
    end
end)

-- অটো সেল বাটন ফাংশন
ToggleSellBtn.MouseButton1Click:Connect(function()
    _G.AutoSellYamu = not _G.AutoSellYamu
    if _G.AutoSellYamu then
        ToggleSellBtn.Text = "Auto Sell All: ON"
        ToggleSellBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 0)
    else
        ToggleSellBtn.Text = "Auto Sell All: OFF"
        ToggleSellBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end
end)

-- ২. ব্যাকগ্রাউন্ড লজিক ও অটোমেশন ইঞ্জিন (Fisch এর জন্য কাস্টমাইজড)
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    
    -- ক) অটো ফিশিং মেকানিজম
    if _G.AutoFishYamu and char then
        pcall(function()
            local tool = char:FindFirstChildOfClass("Tool")
            -- ক্যারেক্টারের হাতে বড়শি বা রড থাকলে স্বয়ংক্রিয়ভাবে কাস্ট ও রিল করবে
            if tool and (tool.Name:lower():find("rod") or tool.Name:lower():find("pole") or tool:FindFirstChild("Cast")) then
                -- ১. অটো কাস্ট (বড়শি পানিতে ফেলা)
                tool:Activate()
                
                -- ২. গেমের ভেতরের ফিশিং UI ইভেন্ট ট্র্যাকিং এবং অটো-ক্লিক
                local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                if playerGui then
                    -- ফিশিং মিনিগেমের বৃত্তাকার বাটন বা বার বাইপাস
                    local shakeUI = playerGui:FindFirstChild("ShakeUI") or playerGui:FindFirstChild("FishingGui")
                    if shakeUI then
                        -- রোবটের মতো স্ক্রিনের মিনিগেম বাটনগুলো অটো ক্লিক করে দেওয়া
                        for _, obj in pairs(shakeUI:GetDescendants()) do
                            if obj:IsA("ImageButton") or obj:IsA("TextButton") then
                                xpcall(function()
                                    obj:Activate()
                                end, function() end)
                            end
                        end
                    end
                end
            end
        end)
    end
    
    -- খ) অটো সেল মেকানিজম (দ্বীপে থাকা মার্চেন্টের কাছে অটো সেল সিগন্যাল পাঠানো)
    if _G.AutoSellYamu then
        pcall(function()
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteFunction") and (v.Name:lower() == "sellall" or v.Name:lower() == "sellfish" or v.Name:lower() == "merchant") then
                    v:InvokeServer()
                end
            end
        end)
    end
    task.wait(0.1) -- মোবাইল প্রোসেসরের সেফটি ডিলে
end)
