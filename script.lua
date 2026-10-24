-- ==========================================
-- سكربت TROFY الخاص - Steal An Egg
-- ==========================================

-- 1. تحميل مكتبة الواجهة Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 2. إنشاء الواجهة الرئيسية
local Window = Rayfield:CreateWindow({
   Name = "TROFY HUB | Steal An Egg",
   LoadingTitle = "جاري تحميل سكربت TROFY...",
   LoadingSubtitle = "الرجاء الانتظار",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "TROFY_Hub", 
      FileName = "StealEggConfig"
   },
   KeySystem = false 
})

-- 3. تقسيم الواجهة إلى تبويبات (Tabs)
local MainTab = Window:CreateTab("الرئيسية", 4483362458) -- أيقونة
local PlayerTab = Window:CreateTab("اللاعب", 4483362458) 

-- ==========================================
-- 4. إضافة الميزات (Features)
-- ==========================================

-- ميزة 1: السرقة التلقائية (كمثال تجريبي)
local autoStealEnabled = false
MainTab:CreateToggle({
   Name = "السرقة التلقائية (Auto Steal)",
   CurrentValue = false,
   Flag = "AutoStealToggle",
   Callback = function(Value)
       autoStealEnabled = Value
       -- هنا يتم وضع كود السرقة الفعلي للعبة
       -- (يختلف حسب تغيرات اللعبة)
       if autoStealEnabled then
           print("تم تفعيل السرقة التلقائية")
       end
   end,
})

-- ميزة 2: سرعة اللاعب (WalkSpeed)
PlayerTab:CreateSlider({
   Name = "سرعة اللاعب (WalkSpeed)",
   Range = {16, 200},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider", 
   Callback = function(Value)
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
           game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
       end
   end,
})

-- ميزة 3: الطيران (Fly) - مبسط
local flyEnabled = false
local flyConnection

PlayerTab:CreateToggle({
   Name = "تفعيل الطيران (Fly)",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
       flyEnabled = Value
       local player = game.Players.LocalPlayer
       
       if flyEnabled then
           local char = player.Character or player.CharacterAdded:Wait()
           local hrp = char:WaitForChild("HumanoidRootPart")
           local bodyVelocity = Instance.new("BodyVelocity")
           bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
           bodyVelocity.Velocity = Vector3.new(0,0,0)
           bodyVelocity.Parent = hrp
           
           flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
               if not flyEnabled then return end
               local camera = workspace.CurrentCamera
               local moveDirection = camera.CFrame.LookVector * (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) and 50 or 0)
               bodyVelocity.Velocity = moveDirection + Vector3.new(0, (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) and 50 or 0), 0)
           end)
       else
           if flyConnection then flyConnection:Disconnect() end
           local char = player.Character
           if char and char:FindFirstChild("HumanoidRootPart") then
               local bv = char.HumanoidRootPart:FindFirstChildOfClass("BodyVelocity")
               if bv then bv:Destroy() end
           end
       end
   end,
})

-- ==========================================
-- 5. إشعار عند التحميل
-- ==========================================
Rayfield:Notify({
   Title = "TROFY HUB",
   Content = "تم تحميل السكربت بنجاح!",
   Duration = 5,
   Image = 4483362458,
})
