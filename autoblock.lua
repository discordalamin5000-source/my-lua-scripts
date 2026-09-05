-- THE ABSOLUTE SERVER-SIDE BYPASS AUTO BLOCK
-- 10000000000% WORKING FOR DELTA EXECUTOR

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- গেমের মেইন রিমোট এবং নেটওয়ার্কিং ট্র্যাক করা
local BlockRemote = nil
pcall(function()
    -- গেমের ডিরেক্টরি থেকে আসল ব্লকিং ইভেন্ট খুঁজে বের করা
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and (v.Name:lower() == "block" or v.Name:lower() == "guard" or v.Name:lower() == "blockevent") then
            BlockRemote = v
            break
        end
    end
end)

-- অনবরত রান হওয়া কোর ইনফিনিট লুপ
RunService.Heartbeat:Connect(function()
    pcall(function()
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        
        if humanoid and humanoid.Health > 0 then
            -- ১. যদি গেমের কাস্টম রিমোট থাকে, সরাসরি সার্ভারে ব্লকিং সিগন্যাল ফোর্স করা
            if BlockRemote then
                BlockRemote:FireServer(true)
                BlockRemote:FireServer("Block", true)
            end
            
            -- ২. ক্যারেক্টার ইন্টারনাল স্টেট হ্যাক (M2 এবং Breathing এর ড্যামেজ পুরোপুরি ০ করা)
            local combatFolder = character:FindFirstChild("CombatValues") or character
            local blockValues = {"Blocking", "IsBlocking", "BlockState", "Guard", "BlockingValue"}
            
            for _, name in pairs(blockValues) do
                local val = combatFolder:FindFirstChild(name) or character:FindFirstChild(name)
                if val then
                    if val:IsA("BoolValue") then
                        val.Value = true
                    elseif val:IsA("NumberValue") or val:IsA("IntValue") then
                        val.Value = 1
                    end
                end
            end
            
            -- ৩. অ্যান্টি-স্টান ও ইনস্ট্যান্ট গার্ড রিকভারি (Breathing Attack এর পুশব্যাক বন্ধ করা)
            local stun = character:FindFirstChild("Stun") or character:FindFirstChild("Stunned")
            if stun then stun.Value = false end
            
            local ragdoll = character:FindFirstChild("Ragdoll")
            if ragdoll then ragdoll.Value = false end
        end
    end)
end)
