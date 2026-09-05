-- ADVANCED HIGH-PROTECTION AUTO BLOCK
-- Optimized for Delta Executor & DS: Burning Ashes

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- প্লেয়ার এবং ক্যারেক্টার লোড হওয়া নিশ্চিত করা
local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- ব্যাকগ্রাউন্ড লুপিং (হাই স্পিড প্রোটেকশন)
RunService.RenderStepped:Connect(function()
    pcall(function()
        local character = getCharacter()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if humanoid and humanoid.Health > 0 then
            -- ১. গেমের ইন্টারনাল ভ্যালু হ্যাক (সার্ভার লেভেল ডিফেন্স)
            local blockingVal = character:FindFirstChild("Blocking") or character:FindFirstChild("IsBlocking") or character:FindFirstChild("Block")
            if blockingVal then
                blockingVal.Value = true
            end
            
            -- ২. রিমোট ইভেন্ট স্প্যামার (Breathing Attack & M2 ইনস্ট্যান্ট ব্লক)
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name:lower():find("block") or v.Name:lower():find("guard") or v.Name:lower():find("defend")) then
                    v:FireServer(true) -- অনবরত সার্ভারে ব্লকিং ডাটা পাঠানো
                end
            end
            
            -- ৩. ইউনিভার্সাল টুল ডিফেন্স
            local tool = character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate() -- তরবারি বা শ্বাসক্রিয়ার টুল থাকলে তা গার্ড পজিশনে রাখবে
            end
            
            -- ৪. অ্যান্টি-নকব্যাক ও স্টান প্রোটেকশন (হাই প্রোটেকশন)
            -- এর ফলে বড় কোনো অ্যাটাকে আপনার ক্যারেক্টার ছিটকে যাবে না বা অবশ হবে点 না
            local stunVal = character:FindFirstChild("Stun") or character:FindFirstChild("Stunned")
            if stunVal then
                stunVal.Value = false
            end
        end
    end)
end)
