-- ORION UI LIBRARY LOADER (NO-LAG & MOBILE FRIENDLY)
local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()

-- মেইন উইন্ডো তৈরি
local Window = OrionLib:MakeWindow({
    Name = "🔥 Lennon Hub | Demon Slayer", 
    HidePremium = false, 
    SaveConfig = false, 
    IntroText = "by Yamu"
})

-- কাস্টম Combat ট্যাব তৈরি
local CombatTab = Window:MakeTab({
    Name = "🛡️ Combat",
    Icon = "rbxassetid://4483362458",
    Premium = false
})

-- গ্লোবাল ভ্যারিয়েবল অন/অফ ট্র্যাক করার জন্য
_G.AutoBlock = false

-- UI-তে টগল বাটন তৈরি
CombatTab:AddToggle({
    Name = "Auto Block M2 & Breathing",
    Default = false,
    Callback = function(Value)
        _G.AutoBlock = Value
        if Value then
            OrionLib:MakeNotification({
                Name = "Auto Block",
                Content = "Activated successfully by Yamu!",
                Image = "rbxassetid://4483362458",
                Time = 3
            })
        end
    end    
})

-- ব্যাকগ্রাউন্ড ইউনিভার্সাল ইনপুট লুপ (যা সার্ভার ডিটেকশন বাইপাস করবে)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

RunService.Heartbeat:Connect(function()
    if _G.AutoBlock then
        pcall(function()
            local myChar = LocalPlayer.Character
            local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
            
            if myHum and myHum.Health > 0 then
                -- ১. ভার্চুয়াল কী-প্রেস (সরাসরি রবলক্স ইঞ্জিনে F Key ইনপুট পাঠানো)
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                
                -- ২. গেমের ইন্টারনাল ভ্যালু ফোর্স ব্যাকআপ
                local blockNames = {"Blocking", "IsBlocking", "BlockState", "Guard"}
                for _, name in pairs(blockNames) do
                    local blockVal = myChar:FindFirstChild(name) or (myChar:FindFirstChild("CombatValues") and myChar.CombatValues:FindFirstChild(name))
                    if blockVal and blockVal:IsA("BoolValue") then
                        blockVal.Value = true
                    end
                end
            end
        end)
    else
        -- টগল অফ থাকলে বাটন ছেড়ে দেবে
        pcall(function()
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
        end)
    end
    task.wait(0.01)
end)

OrionLib:Init()
