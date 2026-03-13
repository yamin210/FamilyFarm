-- ==================================================
-- Script: ابوو الليث
-- Developer: ابوو الليث
-- ==================================================

collectgarbage("collect")

local SCRIPT_NAME = "ابوو الليث"
local config_content = ""

-- [1] Funktion: Konfiguration einmalig laden (spart Traffic und Zeit)
function loadConfig()
    local r = gg.makeRequest("https://raw.githubusercontent.com/yamin210/FamilyFarm/main/daily.txt")
    if r and r.content then
        config_content = r.content
        return true
    end
    gg.toast("⚠️ تعذر الاتصال بالسيرفر - سيتم استخدام الإعدادات الافتراضية")
    return false
end

-- [2] Funktion: Status prüfen
function isButtonEnabled(buttonKey)
    if config_content:find(buttonKey .. "=OFF") then
        gg.alert("❌ معطلة  ")
        return false
    end
    return true
end

-- Start
loadConfig()
gg.toast(SCRIPT_NAME)
gg.alert(" هلووووو ")

-- ==================================================
-- [3] الوظائف الأساسية
-- ==================================================

function searchDailyQuest()
    if not isButtonEnabled("DAILY") then return end 
    
    gg.toast("⏳ جاري إنهاء المهمات...")
    gg.clearResults()
    
    -- Suche Optimierung: Wir setzen den Speicherbereich auf Anonymous
    gg.setRanges(gg.REGION_ANONYMOUS)
    
    gg.searchNumber("27000~27099;1~2000", gg.TYPE_DOUBLE)
    gg.refineNumber("1~2000", gg.TYPE_DOUBLE)
    
    local base = gg.getResults(9999)
    if #base == 0 then 
        gg.alert("❌ لم يتم العثور على قيم المهمات")
        return 
    end

    local numbers = {1, 2000, 30, 6, 20, 12, 10, 3, 2, 5}
    for _, num in ipairs(numbers) do
        gg.loadResults(base)
        gg.refineNumber(tostring(num), gg.TYPE_DOUBLE)
        local res = gg.getResults(9999)
        if #res > 0 then
            for _, v in ipairs(res) do 
                v.value = 0 
                v.flags = gg.TYPE_DOUBLE 
            end
            gg.setValues(res)
        end
    end
    gg.alert("✅ تم إنهاء المهمات بنجاح")
end

function levelUpHack()
    if not isButtonEnabled("LEVEL") then return end
    
    gg.toast("⏳ جاري البدء...")
    gg.setRanges(gg.REGION_ANONYMOUS) -- Wichtig für Textsuche

    -- --- الخطوة الأولى: :size_y ---
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

    gg.sleep(500)

    -- --- الخطوة الثانية: بحث جديد تماماً عن :size_x ---
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

    gg.alert("🚀 تم رفع المستوى بنجاح!")
end

function alleMaschinenHack()
    if not isButtonEnabled("SPEED") then return end
    gg.toast("⏳ جاري تسريع الآلات...")
    
    -- Hier deinen vollständigen Speed-Code einfügen (wie in den vorherigen Schritten)
    -- Beispielhaft:
    gg.clearResults()
    gg.searchNumber("30;2049;45~900", gg.TYPE_DWORD)
    -- ... Rest des Codes ...
    
    gg.alert("✅ تم التسريع")
end

function cropsMenu()
    if not isButtonEnabled("CROPS") then return end
    local c = gg.choice({
        "🍅 بندورة", 
        "🐘 بوط", 
        "🌱 فلفل هاينان", 
        "🌿 أوراق برسيم", 
        "🔄 تحديث الإعدادات من السيرفر",
        "⬅️ رجوع"
    }, nil, "🌱 قائمة المزروعات")
    
    if c == nil or c == 6 then return end
    if c == 5 then loadConfig() return end -- Manuelles Update der GitHub-Settings

    -- Hier dein Crops-Code einfügen
    gg.alert("✅ تم تعديل المزروعات")
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
-- [5] الحلقة التكرارية
-- ==================================================
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        mainMenu()
    end
    gg.sleep(100)
end
