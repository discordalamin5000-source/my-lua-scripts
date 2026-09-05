-- CUSTOM INTERNAL MOBILE UI AUTO BLOCK
-- 100% Guaranteed to Load on Delta Executor

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- ১. ডেল্টার নিজস্ব স্ক্রিন টেক্সট (কোনো বাহ্যিক লাইব্রেরি ছাড়া কাস্টম UI)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 130)
MainFrame.Active = true
MainFrame.Draggable = true -- স্ক্রিনে আঙুল দিয়ে সরানো যাবে

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "Yamu Hub | DS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14

ToggleBtn.Parent = MainFrame
ToggleBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 45)
ToggleBtn.Text = "Auto Block: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 12

-- অন/অফ ট্র্যাকিং ভ্যারিয়েবল
local _G_AutoBlock = false

-- বাটনে ক্লিক করলে যা হবে
ToggleBtn.MouseButton1Click:Connect(function()
    _G_AutoBlock = not _G_AutoBlock
    if _G_AutoBlock then
        ToggleBtn.Text = "Auto Block: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        ToggleBtn.Text = "Auto Block: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        -- বাটন ছেড়ে দেওয়া
        pcall(function()
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
        end)
    end
end)

-- ২. ব্যাকগ্রাউন্ড কোর মেকানিজম লুপ
RunService.Heartbeat:Connect(function()
    if _G_AutoBlock then
        pcall(function()
            local myChar = LocalPlayer.Character
            local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
            
            if myHum and myHum.Health > 0 then
                -- সরাসরি রবলক্সের কোর ইনপুট দিয়ে F (Block) বাটন চেপে ধরা
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                
                -- গেমের ইন্টারনাল ভ্যালু ফোর্স ব্যাকআপ
                local blockNames = {"Blocking", "IsBlocking", "BlockState", "Guard"}
                for _, name in pairs(blockNames) do
                    local blockVal = myChar:FindFirstChild(name) or (myChar:FindFirstChild("CombatValues") and myChar.CombatValues:FindFirstChild(name))
                    if blockVal and blockVal:IsA("BoolValue") then
                        blockVal.Value = true
                    end
                end
            end
        end)
    end
    task.wait(0.01)
end)
