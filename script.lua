-- ==========================================
-- TROFY HUB | موزع السكربتات الذكي
-- ==========================================

-- نضع رسالة في الكونسول لتأكيد التشغيل
print("TROFY HUB: جاري التعرف على اللعبة...")

-- روابط السكربتات (يمكنك استبدالها بروابطك مستقبلاً)
local SAE = "https://raw.githubusercontent.com/tienkhanh1/Chilli-Hub-Script/refs/heads/main/StealAnEggg"
local RAP = "https://api.luarmor.net/files/v4/loaders/0dbcaa9e992477523d38a8284d7dbdef.lua"
local JFA = "https://raw.githubusercontent.com/tienkhanh1/Chilli-Hub-Script/refs/heads/main/JumpForAnimals"
local SAB = "https://raw.githubusercontent.com/tienkhanh1/spicy/refs/heads/main/Steal-a-Brainrot"
local MM2 = "https://api.luarmor.net/files/v4/loaders/2bf348894416e1d3deee40be756d42ff.lua"
local BROOK = "https://api.luarmor.net/files/v4/loaders/89190a03fd337349cef140d576357ba3.lua"

-- جدول التعرف على الألعاب عبر Game ID
local byGameId = {
    [10563114921] = SAE,     -- Steal An Egg
    [10035204815] = RAP,     -- RAP
    [10690360998] = JFA,     -- Jump For Animals
    [7709344486] = SAB,      -- Steal a Brainrot
    [66654135] = MM2,        -- Murder Mystery 2
    [1686885941] = BROOK,    -- Brookhaven
}

-- جدول التعرف على الألعاب عبر Place ID
local byPlaceId = {
    [107778070777162] = SAE,
    [124216119978534] = RAP,
    [126870639873289] = JFA,
    [109983668079237] = SAB,
    [142823291] = MM2,
    [4924922222] = BROOK,
}

-- التحقق من الـ ID الخاص باللعبة
local gameId = game.GameId
while gameId == 0 and game.PlaceId == 0 do
    task.wait()
    gameId = game.GameId
end

-- اختيار السكربت المناسب
local url = byGameId[gameId] or byPlaceId[game.PlaceId]

-- إذا كانت اللعبة غير مدعومة
if not url then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "TROFY HUB",
        Text = "عذراً، هذه اللعبة غير مدعومة حالياً.",
        Duration = 5
    })
    return
end

-- محاولة تحميل السكربت (3 محاولات)
for i = 1, 3 do
    local ok, source = pcall(game.HttpGet, game, url)
    if ok and type(source) == "string" and source ~= "" then
        local chunk = loadstring(source)
        if chunk then
            -- إشعار بنجاح التحميل
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "TROFY HUB",
                Text = "تم التعرف على اللعبة بنجاح! جاري فتح السكربت...",
                Duration = 5
            })
            chunk()
        end
        return
    end
    task.wait(0.5)
end

-- إذا فشل التحميل
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "TROFY HUB",
    Text = "فشل في تحميل السكربت، تحقق من اتصالك بالإنترنت.",
    Duration = 5
})
