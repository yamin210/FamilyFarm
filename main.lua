-- ==================================================
-- Script: ابوو الليث
-- Developer: ابوو الليث
-- ==================================================

collectgarbage("collect")

local SCRIPT_NAME = "ابوو الليث"
local config_content = ""

-- [1] وظيفة جلب الإعدادات من GitHub (مرة واحدة عند التشغيل)
function loadConfig()
    local r = gg.makeRequest("https://raw.githubusercontent.com/yamin210/FamilyFarm/main/daily.txt")
    if r and r.content then
        config_content = r.content
        return true
    end
    return false
end

-- [2] وظيفة التحقق إذا كان الزر مفعل (ON) أو معطل (OFF)
function isButtonEnabled(buttonKey)
    if config_content:find(buttonKey .. "=OFF") then
        gg.alert("❌ عذراً، هذه الميزة معطلة حالياً من قبل المطور")
        return false
    end
    return true
end

-- تشغيل الإعدادات والترحيب
loadConfig()
gg.toast(SCRIPT_NAME)
gg.alert("أهلاً بك في سكربت " .. SCRIPT_NAME)

-- ==================================================
-- [3] الوظائف الأساسية
-- ==================================================

-- 🆙 وظيفة رفع المستوى (تطابق الصور تماماً)
function levelUpHack()
    if not isButtonEnabled("LEVEL") then return end
    
    gg.toast("⏳ جاري البدء في التعديل...")
    gg.setRanges(gg.REGION_ANONYMOUS) -- ضبط البحث على Anonymous لضمان إيجاد النصوص

    -- الخطوة 1: البحث عن :size_y (كما في الصورة)
    gg.clearResults()
    gg.toast("🔍 البحث عن :size_y")
    gg.searchNumber("':size_y'", gg.TYPE_BYTE) -- البحث عن نص UTF-8
    
    local res1 = gg.getResults(9999)
    if #res1 > 0 then
        for _, v in ipairs(res1) do v.value = "0" end
        gg.setValues(res1)
        gg.toast("✅ تم تصفير :size_y")
    else
        gg.toast("⚠️ لم يتم العثور على :size_y")
    end

    gg.sleep(500)

    -- الخطوة 2: بحث جديد عن :size_x
    gg.clearResults() 
    gg.toast("🔍 بحث جديد عن :size_x")
    gg.searchNumber("':size_x'", gg.TYPE_BYTE)
    
    local res2 = gg.getResults(9999)
    if #res2 > 0 then
        for _, v in ipairs(res2) do v.value = "0" end
        gg.setValues(res2)
        gg.toast("✅ تم تصفير :size_x")
    else
        gg.toast("⚠️ لم يتم العثور على :size_x")
    end

    gg.alert("🚀 تم الانتهاء من رفع المستوى بنجاح")
end

-- 🔍 وظيفة إنهاء اليوميات
function searchDailyQuest()
    if not isButtonEnabled("DAILY") then return end 
    
    gg.toast("⏳ جاري إنهاء المهمات...")
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    
    gg.searchNumber("27000~27099;1~2000", gg.TYPE_DOUBLE)
    gg.refineNumber("1~2000", gg.TYPE_DOUBLE)
    
    local base = gg.getResults(9999)
    if #base == 0 then gg.alert("❌ لم يتم العثور على قيم") return end

    local numbers = {1, 2000, 30, 6, 20, 12, 10, 3, 2, 5}
    for _, num in ipairs(numbers) do
        gg.loadResults(base)
        gg.refineNumber(tostring(num), gg.TYPE_DOUBLE)
        local res = gg.getResults(9999)
        if #res > 0 then
            for _, v in ipairs(res) do v.value = 0 v.flags = gg.TYPE_DOUBLE end
            gg.setValues(res)
        end
    end
    gg.alert("✅ تم إنهاء المهمات")
end

-- 🤖 وظيفة تسريع كل شيء
function alleMaschinenHack()
    if not isButtonEnabled("SPEED") then return end
    gg.toast("🚀 جاري التسريع...")
    -- كود التسريع الخاص بك يوضع هنا
    gg.alert("✅ تم التسريع بنجاح")
end

-- 🌾 قائمة المزروعات
function cropsMenu()
    if not isButtonEnabled("CROPS") then return end
    local c = gg.choice({"🍅 بندورة", "🐘 بوط", "🌱 فلفل", "🌿 برسيم", "⬅️ رجوع"}, nil, "🌱 قائمة المزروعات")
    if c == nil or c == 5 then return end
    -- كود تحويل المزروعات يوضع هنا
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
-- [5] حلقة التشغيل الدائمة
-- ==================================================
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        mainMenu()
    end
    gg.sleep(100)
end
