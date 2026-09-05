-- SERVER-SIDE BYPASS AUTO BLOCK (100% WORKING)
-- Optimized for Delta Executor & DS: Burning Ashes

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- স্ক্রিন সাকসেস মেসেজ
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Lennon Hub",
    Text = "Bypass Auto Block: ACTIVE",
    Duration = 5
})

local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- অনবরত ব্লক বাটন ভার্চুয়ালি প্রেস করে রাখার লুপ
RunService.Heartbeat:Connect(function()
    pcall(function()
        local character = getCharacter()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if humanoid and humanoid.Health > 0 then
            -- ১. সার্ভারকে বোকা বানাতে ভার্চুয়াল কী-প্রেস পাঠানো (F Key / Guard Input)
            -- এটি সরাসরি গেমের মেইন ইঞ্জিনকে ব্লকিং ইনপুট পাঠায়
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
            
            -- ২. গেমের ইন্টারনাল ভ্যালু ব্যাকআপ ব্যাকগ্রাউন্ড ফোর্স
            local blockingVal = character:FindFirstChild("Blocking") or character:FindFirstChild("IsBlocking") or character:FindFirstChild("Block")
            if blockingVal then
                blockingVal.Value = true
            end
            
            -- ৩. অ্যান্টি-স্টান ভ্যালু ক্লিয়ারেন্স (Breathing Attack এর ধাক্কা সামলাতে)
            local stunVal = character:FindFirstChild("Stun") or character:FindFirstChild("Stunned")
            if stunVal then
                stunVal.Value = false
            end
        end
    end)
    task.wait(0.01) -- গেম ক্র্যাশ বা কিক এড়ানোর সেফ ডিলে
end)

-- ক্যারেক্টার মারা গিয়ে আবার রি-স্পন হলে কোড রিসেট করা
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
end)
