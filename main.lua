-- ==================================================
-- Script: ابوو الليث
-- Developer: ابوو الليث
-- ==================================================

collectgarbage("collect")
gg.clearResults()

local SCRIPT_NAME = "ابوو الليث"
local countDaily = 0
local countLevel = 0

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
    -- يبحث عن السطر الخاص بالزر، مثلاً DAILY=ON
    if config:find(buttonKey .. "=OFF") then
        gg.alert("❌ عذراً، ميزة (" .. buttonKey .. ") معطلة حالياً من قبل المطور")
        return false
    end
    return true
end

-- رسالة الترحيب
gg.toast(SCRIPT_NAME)
gg.alert("أهلاً بك في سكربت " .. SCRIPT_NAME)

-- ==================================================
-- [3] الوظائف مع حماية مستقلة لكل زر
-- ==================================================

function searchDailyQuest()
    if not isButtonEnabled("DAILY") then return end -- مفتاح اليوميات
    if countDaily == 0 then
        gg.alert("لازم تظغط مرتين حتى اتفعل")
        countDaily = 1
        return
    end
    countDaily = 0
    gg.toast("⏳ جاري العمل...")
    -- كود اليوميات...
    gg.alert("✅ تم إنهاء المهمات")
end

function cropsMenu()
    if not isButtonEnabled("CROPS") then return end -- مفتاح المزروعات
    local c = gg.choice({"🍅 بندورة", "🐘 بوط", "🌱 فلفل", "🌿 برسيم", "⬅️ رجوع"}, nil, "🌱 المزروعات")
    -- كود المزروعات...
end

function alleMaschinenHack()
    if not isButtonEnabled("SPEED") then return end -- مفتاح التسريع
    gg.toast("بسم الله نبلش")
    -- كود التسريع...
end

function levelUpHack()
    if not isButtonEnabled("LEVEL") then return end -- مفتاح المستوى
    if countLevel == 0 then
        gg.alert("لازم تظغط مرتين حتى اتفعل")
        countLevel = 1
        return
    end
    countLevel = 0
    -- كود المستوى...
end

-- ==================================================
-- [4] القائمة الرئيسية
-- ==================================================
function mainMenu()
    local statusDaily = countDaily == 0 and "🔴 [OFF]" or "🟢 [ON]"
    local statusLevel = countLevel == 0 and "🔴 [OFF]" or "🟢 [ON]"

    local m = gg.choice({
        "🔍 اليوميات " .. statusDaily,
        "🌾 قائمة المزروعات",
        "🤖 تسريع كل شيء",
        "🆙 رفع المستوى " .. statusLevel,
        "❌ خروج"
    }, nil, "🌟 لوحة تحكم " .. SCRIPT_NAME)

    if m == 1 then searchDailyQuest()
    elseif m == 2 then cropsMenu()
    elseif m == 3 then alleMaschinenHack()
    elseif m == 4 then levelUpHack()
    elseif m == 5 then os.exit() end
end

-- ==================================================
-- [5] حلقة التشغيل
-- ==================================================
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        mainMenu()
    end
    gg.sleep(100)
end
