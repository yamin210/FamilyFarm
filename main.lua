-- ==================================================
-- Script: ابوو الليث
-- Developer: ابوو الليث
-- ==================================================

collectgarbage("collect")

local SCRIPT_NAME = "ابوو الليث"
local config_content = ""

-- [1] جلب الإعدادات من GitHub
function loadConfig()
    local r = gg.makeRequest("https://raw.githubusercontent.com/yamin210/FamilyFarm/main/daily.txt")
    if r and r.content then
        config_content = r.content
        return true
    end
    return false
end

-- [2] فحص حالة الزر (ON/OFF)
function isButtonEnabled(buttonKey)
    if config_content:find(buttonKey .. "=OFF") then
        gg.alert("❌ عذراً، ميزة (" .. buttonKey .. ") معطلة حالياً")
        return false
    end
    return true
end

-- تشغيل أول مرة
loadConfig()
gg.toast(SCRIPT_NAME)

-- ==================================================
-- [3] الوظائف الأساسية
-- ==================================================

-- 🆙 رفع المستوى (مطابق للصور تماماً)
function levelUpHack()
    if not isButtonEnabled("LEVEL") then return end
    
    gg.setRanges(gg.REGION_ANONYMOUS) -- البحث في Anonymous كما في الصور

    -- البحث عن :size_y
    gg.clearResults()
    gg.toast("🔍 جاري البحث عن :size_y")
    gg.searchNumber("':size_y'", gg.TYPE_BYTE) -- UTF-8 Search
    
    local res1 = gg.getResults(9999)
    if #res1 > 0 then
        for _, v in ipairs(res1) do v.value = "0" end
        gg.setValues(res1)
        gg.toast("✅ تم تصفير :size_y")
    end

    gg.sleep(400)

    -- البحث عن :size_x (الصورة الثانية)
    gg.clearResults() 
    gg.toast("🔍 جاري البحث عن :size_x")
    gg.searchNumber("':size_x'", gg.TYPE_BYTE) -- UTF-8 Search
    
    local res2 = gg.getResults(9999)
    if #res2 > 0 then
        for _, v in ipairs(res2) do v.value = "0" end
        gg.setValues(res2)
        gg.toast("✅ تم تصفير :size_x")
    end

    gg.alert("🚀 تم رفع المستوى بنجاح")
end

-- 🔍 إنهاء اليوميات
function searchDailyQuest()
    if not isButtonEnabled("DAILY") then return end 
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
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

-- 🤖 تسريع كل شيء
function alleMaschinenHack()
    if not isButtonEnabled("SPEED") then return end
    gg.toast("🤖 جاري التسريع...")
    gg.clearResults()
    gg.searchNumber("30;2049;45~900", gg.TYPE_DWORD)
    local g1 = gg.getResults(9999)
    if #g1 > 0 then
        local t1 = {45, 50, 60, 70, 75, 80, 90, 100, 110, 120, 900}
        for _, v in ipairs(t1) do
            gg.loadResults(g1)
            gg.refineNumber(tostring(v), gg.TYPE_DWORD)
            local found = gg.getResults(9999)
            for _, item in ipairs(found) do item.value = "0" end
            gg.setValues(found)
        end
    end
    gg.alert("✅ تم التسريع بنجاح")
end

-- 🌾 قائمة المزروعات
function cropsMenu()
    if not isButtonEnabled("CROPS") then return end
    local c = gg.choice({"🍅 بندورة", "🐘 بوط", "🌱 فلفل هاينان", "🌿 أوراق برسيم", "⬅️ رجوع"}, nil, "🌱 قائمة المزروعات")
    if c == nil or c == 5 then return end
    
    gg.clearResults()
    gg.searchNumber("200422", gg.TYPE_DWORD)
    local res = gg.getResults(9999)
    
    if c == 1 then
        gg.clearResults()
        gg.searchNumber("7024", gg.TYPE_DWORD)
        local resT = gg.getResults(9999)
        for _, v in ipairs(resT) do v.value = 7048 end
        gg.setValues(resT)
    elseif c == 2 then for _, v in ipairs(res) do v.value = 7046 end
    elseif c == 3 then for _, v in ipairs(res) do v.value = 5107 end
    elseif c == 4 then for _, v in ipairs(res) do v.value = 5101 end
    end
    gg.setValues(res)
    gg.alert("✅ تم التعديل")
end

-- ==================================================
-- [4] القائمة الرئيسية
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
-- [5] الحلقة الدائمة
-- ==================================================
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        mainMenu()
    end
    gg.sleep(100)
end
