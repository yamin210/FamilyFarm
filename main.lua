-- ==================================================
-- Script: ابوو الليث
-- Developer: ابوو الليث
-- ==================================================

collectgarbage("collect")
gg.clearResults()

local SCRIPT_NAME = "ابوو الليث"

-- [1] وظيفة قراءة الإعدادات من GitHub
function getRemoteConfig()
    local r = gg.makeRequest("https://raw.githubusercontent.com/yamin210/FamilyFarm/main/daily.txt")
    if r and r.content then
        return r.content
    end
    return ""
end

-- [2] وظيفة التحقق من زر معين
function isButtonEnabled(buttonKey)
    local config = getRemoteConfig()
    if config:find(buttonKey .. "=OFF") then
        gg.alert("❌ عذراً، ميزة (" .. buttonKey .. ") معطلة حالياً من قبل المطور")
        return false
    end
    return true
end

gg.toast(SCRIPT_NAME)
gg.alert("أهلاً بك في سكربت " .. SCRIPT_NAME)

-- ==================================================
-- [3] الوظائف الأساسية (تعمل الآن من أول ضغطة)
-- ==================================================

function searchDailyQuest()
    if not isButtonEnabled("DAILY") then return end 
    
    gg.toast("⏳ جاري العمل...")
    gg.clearResults()
    gg.searchNumber("27000~27099;1~2000", gg.TYPE_DOUBLE)
    gg.refineNumber("1~2000", gg.TYPE_DOUBLE)
    local base = gg.getResults(9999)
    local numbers = {1, 2000, 30, 6, 20, 12, 10, 3, 2, 5}
    for _, num in ipairs(numbers) do
        gg.loadResults(base)
        gg.refineNumber(tostring(num), gg.TYPE_DOUBLE)
        local res = gg.getResults(9999)
        for _, v in ipairs(res) do v.value = 0 v.flags = gg.TYPE_DOUBLE end
        gg.setValues(res)
    end
    gg.alert("✅ تم إنهاء المهمات")
end

function levelUpHack()
    if not isButtonEnabled("LEVEL") then return end
    
    gg.toast("⏳ جاري البحث عن القيم...")
    -- Suche nach :size_y
    gg.clearResults()
    gg.searchNumber("':size_y'", gg.TYPE_BYTE)
    local res1 = gg.getResults(9999)
    if #res1 > 0 then
        for _, v in ipairs(res1) do v.value = "0" end
        gg.setValues(res1)
        gg.toast("✅ تم تصفير :size_y")
    end
    
    gg.sleep(600)
    
    -- Suche nach :size_x
    gg.clearResults()
    gg.searchNumber("':size_x'", gg.TYPE_BYTE)
    local res2 = gg.getResults(9999)
    if #res2 > 0 then
        for _, v in ipairs(res2) do v.value = "0" end
        gg.setValues(res2)
        gg.toast("✅ تم تصفير :size_x")
    end
    gg.alert("🚀 تم التعديل بنجاح")
end

-- ==================================================
-- [4] بقية الوظائف
-- ==================================================

function alleMaschinenHack()
    if not isButtonEnabled("SPEED") then return end
    gg.toast("بسم الله نبلش")
    -- (Hier dein Speed-Hack Code einfügen)
    gg.alert("✅ تم التسريع")
end

function cropsMenu()
    if not isButtonEnabled("CROPS") then return end
    local c = gg.choice({"🍅 بندورة", "🐘 بوط", "🌱 فلفل", "🌿 برسيم", "⬅️ رجوع"}, nil, "🌱 المزروعات")
    if c == nil or c == 5 then return end
    -- (Hier dein Crops-Hack Code einfügen)
    gg.alert("✅ تم التعديل")
end

-- ==================================================
-- [5] القائمة الرئيسية
-- ==================================================
function mainMenu()
    local m = gg.choice({
        "🔍 إنهاء اليوميات",
        "🌾 قائمة المزروعات",
        "🤖 تسريع كل شيء",
        "🆙 رفع المستوى",
        "❌ خروج"
    }, nil, "🌟 لوحة تحكم " .. SCRIPT_NAME)

    if m == 1 then searchDailyQuest()
    elseif m == 2 then cropsMenu()
    elseif m == 3 then alleMaschinenHack()
    elseif m == 4 then levelUpHack()
    elseif m == 5 then os.exit() end
end

-- ==================================================
-- [6] حلقة التشغيل
-- ==================================================
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        mainMenu()
    end
    gg.sleep(100)
end
