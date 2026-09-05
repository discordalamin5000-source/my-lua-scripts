-- Rayfield UI Library Loader
local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

-- মেইন উইন্ডো তৈরি (by Yamu ক্রেডিট যুক্ত)
local Window = Rayfield:CreateWindow({
   Name = "🔥 Lennon Hub | Demon Slayer",
   LoadingTitle = "Lennon Hub Loading...",
   LoadingSubtitle = "by Yamu",
   ConfigurationSaving = { Enabled = false }
})

-- কাস্টম ট্যাব তৈরি
local Tab = Window:CreateTab("🛡️ Combat", 4483362458) -- Combat Tab Icon

-- গ্লোবাল ভ্যারিয়েবল (অন/অফ ট্র্যাক করার জন্য)
_G.AutoBlock = false

-- UI-তে টগল বাটন তৈরি
Tab:CreateToggle({
   Name = "Auto Block M2 & Breathing",
   CurrentValue = false,
   Flag = "AutoBlockToggle",
   Callback = function(Value)
      _G.AutoBlock = Value
      if Value then
          Rayfield:Notify({
             Title = "Auto Block",
             Content = "Activated successfully by Yamu!",
             Duration = 3,
             Image = 4483362458,
          })
      end
   end,
})

-- ব্যাকগ্রাউন্ড অটো-ব্লক লুপ (যখন টগল অন থাকবে তখনই কাজ করবে)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

RunService.Heartbeat:Connect(function()
    if _G.AutoBlock then
        pcall(function()
            local myChar = LocalPlayer.Character
            local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
            
            if myHum and myHum.Health > 0 then
                -- কোর গেম স্টেট ও মেটাস্টেট হ্যাক
                local blockNames = {"Blocking", "IsBlocking", "BlockState", "Guard", "IsGuarding"}
                for _, name in pairs(blockNames) do
                    local blockVal = myChar:FindFirstChild(name) or (myChar:FindFirstChild("CombatValues") and myChar.CombatValues:FindFirstChild(name))
                    if blockVal then
                        if blockVal:IsA("BoolValue") then
                            blockVal.Value = true
                        end
                    end
                end
                
                -- প্রক্সিমিটি ডিস্টেন্স চেক (কাছাকাছি এনিমি থাকলে রিমোট ফায়ার)
                for _, enemy in pairs(Players:GetPlayers()) do
                    if enemy ~= LocalPlayer then
                        local enemyChar = enemy.Character
                        if enemyChar and enemyChar:FindFirstChild("HumanoidRootPart") and myChar:FindFirstChild("HumanoidRootPart") then
                            local distance = (myChar.HumanoidRootPart.Position - enemyChar.HumanoidRootPart.Position).Magnitude
                            if distance <= 12 then
                                for _, v in pairs(game:GetDescendants()) do
                                    if v:IsA("RemoteEvent") and (v.Name:lower():find("block") or v.Name:lower():find("guard")) then
                                        v:FireServer(true)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)
