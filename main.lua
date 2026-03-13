-- ==================================================
-- Script: ابوو الليث
-- Developer: ابوو الليث
-- ==================================================

-- [1] الإعدادات العامة
collectgarbage("collect")
gg.clearResults()

local SCRIPT_NAME = "ابوو الليث"

gg.toast(SCRIPT_NAME)
gg.alert("هلوووووووو")

-- ==================================================
-- [2] فحص الاتصال (تم التعديل ليعمل دائماً)
-- ==================================================
function isOnlineEnabled()
    return true 
end

-- ==================================================
-- [3] وظيفة: رفع المستوى
-- ==================================================
function levelUpHack()
    -- الرسالة التي طلبتها تظهر هنا فوراً
    gg.alert("لازم تظغط مرتين حتى اتفعل")

    gg.toast("⏳ جاري البحث عن القيم...")

    -- البحث الأول: :size_y
    gg.clearResults()
    gg.searchNumber("':size_y'", gg.TYPE_BYTE)
    local res1 = gg.getResults(9999)
    if #res1 > 0 then
        for _, v in ipairs(res1) do v.value = "0" end
        gg.setValues(res1)
        gg.toast("✅ تم تصفير :size_y")
    else
        gg.toast("⚠️ لم يتم العثور على :size_y")
    end

    gg.sleep(600) 

    -- البحث الثاني: :size_x
    gg.clearResults()
    gg.searchNumber("':size_x'", gg.TYPE_BYTE)
    local res2 = gg.getResults(9999)
    if #res2 > 0 then
        for _, v in ipairs(res2) do v.value = "0" end
        gg.setValues(res2)
        gg.toast("✅ تم تصفير :size_x")
    else
        gg.toast("⚠️ لم يتم العثور على :size_x")
    end

    gg.alert("🚀 تم التعديل بنجاح")
end

-- ==================================================
-- [4] وظيفة: تسريع كل شيء
-- ==================================================
function alleMaschinenHack()
    gg.toast("بسم الله نبلش")

    gg.clearResults()
    gg.searchNumber("30;2049;45~900", gg.TYPE_DWORD)
    local g1 = gg.getResults(9999)
    if #g1 > 0 then
        local t1 = {45, 50, 60, 70, 75, 80, 90, 100, 110, 120, 900}
        for _, v in ipairs(t1) do
            gg.loadResults(g1)
            gg.refineNumber(tostring(v), gg.TYPE_DWORD)
            local found = gg.getResults(9999)
            if #found > 0 then
                for _, item in ipairs(found) do item.value = "0" end
                gg.setValues(found)
            end
        end
    end

    gg.sleep(200)

    gg.clearResults()
    gg.searchNumber("10;2049;50~600", gg.TYPE_DWORD)
    local g2 = gg.getResults(9999)
    if #g2 > 0 then
        local t2 = {55, 60, 70, 72, 75, 80, 90, 100, 110, 120, 150, 180, 600}
        for _, v in ipairs(t2) do
            gg.loadResults(g2)
            gg.refineNumber(tostring(v), gg.TYPE_DWORD)
            local found = gg.getResults(9999)
            if #found > 0 then
                for _, item in ipairs(found) do item.value = "0" end
                gg.setValues(found)
            end
        end
    end
    gg.alert("✅ تم تسريع كل شيء بنجاح")
end

-- ==================================================
-- [5] وظائف المزروعات واليوميات
-- ==================================================
function elefantHack()
    gg.clearResults()
    gg.searchNumber("200422", gg.TYPE_DWORD)
    local res = gg.getResults(9999)
    for _, v in ipairs(res) do v.value = 7046 v.flags = gg.TYPE_DWORD end
    gg.setValues(res)
    gg.alert("✅ تم التعديل")
end

function falfelHack()
    gg.clearResults()
    gg.searchNumber("200422", gg.TYPE_DWORD)
    local res = gg.getResults(9999)
    for _, v in ipairs(res) do v.value = 5107 v.flags = gg.TYPE_DWORD end
    gg.setValues(res)
    gg.alert("✅ تم التعديل")
end

function tomatenHack()
    gg.clearResults()
    gg.searchNumber("7024", gg.TYPE_DWORD)
    local res = gg.getResults(9999)
    for _, v in ipairs(res) do v.value = 7048 v.flags = gg.TYPE_DWORD end
    gg.setValues(res)
    gg.alert("✅ تم التعديل")
end

function barsimHack()
    gg.clearResults()
    gg.searchNumber("200422", gg.TYPE_DWORD)
    local res = gg.getResults(9999)
    for _, v in ipairs(res) do v.value = 5101 v.flags = gg.TYPE_DWORD end
    gg.setValues(res)
    gg.alert("✅ تم التعديل")
end

function searchDailyQuest()
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

-- ==================================================
-- [6] القوائم
-- ==================================================
function cropsMenu()
    local c = gg.choice({"🍅 بندورة", "🐘 بوط", "🌱 فلفل هاينان", "🌿 اوراق برسيم", "⬅️ رجوع"}, nil, "🌱 المزروعات")
    if c == nil or c == 5 then return end
    if c == 1 then tomatenHack()
    elseif c == 2 then elefantHack()
    elseif c == 3 then falfelHack()
    elseif c == 4 then barsimHack() end
end

function mainMenu()
    local m = gg.choice({
        "🔍 إنهاء اليوميات",
        "🌾 قائمة المزروعات",
        "🤖 تسريع كل شيء",
        "🆙 رفع المستوى",
        "❌ خروج"
    }, nil, "🌟 سكربت " .. SCRIPT_NAME)

    if m == 1 then searchDailyQuest()
    elseif m == 2 then cropsMenu()
    elseif m == 3 then alleMaschinenHack()
    elseif m == 4 then levelUpHack()
    elseif m == 5 then os.exit() end
end

-- ==================================================
-- [7] الحلقة التكرارية
-- ==================================================
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        mainMenu()
    end
    gg.sleep(100)
end
