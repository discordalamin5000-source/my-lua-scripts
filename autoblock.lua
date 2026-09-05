-- NO-LAG HIGH PROTECTION AUTO BLOCK 
-- Optimized for Mobile Delta Executor

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- স্ক্রিন নোটিফিকেশন (স্ক্রিপ্ট চালু হলে স্ক্রিনে মেসেজ দেখাবে)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "YaMU Hub",
    Text = "Auto Block Loaded! No Lag.",
    Duration = 5
})

local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- ল্যাগ কমানোর জন্য RenderStepped পরিবর্তন করে Heartbeat ব্যবহার এবং স্প্যাম কন্ট্রোল
RunService.Heartbeat:Connect(function()
    pcall(function()
        local character = getCharacter()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if humanoid and humanoid.Health > 0 then
            -- ১. ইন-গেমে ব্লকিং ভ্যালু অন করা
            local blockingVal = character:FindFirstChild("Blocking") or character:FindFirstChild("IsBlocking")
            if blockingVal then
                blockingVal.Value = true
            end
            
            -- M1 হ্যাক বা ল্যাগ ফিক্স করার জন্য স্প্যামিং কমানো হয়েছে
            -- নির্দিষ্ট ২-৩টি রিমোট ইভেন্ট যা শুধু ব্লকিং হ্যান্ডেল করে
            for _, v in pairs(character:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name:lower():find("block") or v.Name:lower():find("guard")) then
                    v:FireServer(true)
                end
            end
            
            -- ২. স্টান প্রোটেকশন (যাতে ক্যারেক্টার অবশ না হয়)
            local stunVal = character:FindFirstChild("Stun") or character:FindFirstChild("Stunned")
            if stunVal then
                stunVal.Value = false
            end
        end
    end)
end)
