-- ==================================================
-- Script: ابوو الليث & المطورين
-- Developer: ابوو الليث (Kombiniert & Optimiert)
-- ==================================================

collectgarbage("collect")

local SCRIPT_NAME = "ابوو الليث"
local config_content = ""

-- Konfiguration für den Bypass
local CONFIG = {
    SCAN_INTERVAL_MS = 500,
    MAX_WAIT_SECONDS = 180,
    OLD_NAME = "app_version_",
    NEW_NAME = "app_version_valid"
}

-- [1] وظيفة جلب الإعدادات من GitHub
function loadConfig()
    local r = gg.makeRequest("https://raw.githubusercontent.com/yamin210/FamilyFarm/main/daily.txt")
    if r and r.content then
        config_content = r.content
        return true
    end
    gg.toast("⚠️ تعذر الاتصال بالسيرفر")
    return false
end

-- [2] وظيفة فحص حالة الزر (ON/OFF)
function isButtonEnabled(buttonKey)
    if config_content:find(buttonKey .. "=OFF") then
        gg.alert("❌ معطلة ")
        return false
    end
    return true
end

-- تشغيل الإعدادات عند البدء
loadConfig()
gg.toast(SCRIPT_NAME)
gg.alert("هلوووووو")

-- ==================================================
-- [3] الوظائف الأساسية (من السكربت الأول والثاني)
-- ==================================================

-- 🔥 3.1 تشغيل المعدلة (Bypass)
function auto_bypass()
    local startTime = os.time()
    local patched_once = false
    while true do
        local elapsed = os.time() - startTime
        if elapsed > CONFIG.MAX_WAIT_SECONDS then return false end
        if gg.isVisible() then gg.setVisible(false) end
        
        gg.clearResults()
        gg.setRanges(gg.REGION_BAD | gg.REGION_CODE_APP | gg.REGION_CODE_SYS | gg.REGION_OTHER | gg.REGION_ASHMEM)
        gg.searchNumber(':' .. CONFIG.OLD_NAME)
        local found = gg.getResultsCount()
        
        if found > 0 and not patched_once then
            gg.processPause()
            -- Hier wird die UpdatePass-Logik vereinfacht ausgeführt
            local a = gg.getResults(10000)
            if #a > 0 then
                for i = 1, #a do a[i].value = CONFIG.NEW_NAME end
                gg.setValues(a)
                patched_once = true
                gg.alert("مع تحيات فريق المطورين 🚀 تم تسجيل الدخول بنجاح")
                return true
            end
            gg.processResume()
        end
        gg.sleep(CONFIG.SCAN_INTERVAL_MS)
    end
end

-- 🔍 3.2 إنهاء اليوميات (Kombinierte Version für maximale Leistung)
function searchDailyQuest()
    if not isButtonEnabled("DAILY") then return end 
    
    gg.toast("⏳ جاري إنهاء المهمات...")
    gg.setVisible(false)
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("27000~27099;1.0~2000", gg.TYPE_DOUBLE)
    
    local r = gg.getResults(100000)
    local ref = {1, 2, 3, 5, 6, 10, 12, 20, 30, 100, 250, 2000}
    
    for _, v in ipairs(ref) do
        gg.loadResults(r)
        gg.refineNumber(tostring(v), gg.TYPE_DOUBLE)
        local res = gg.getResults(100000)
        for _, item in ipairs(res) do 
            item.value = 0 
            item.flags = gg.TYPE_DOUBLE 
        end
        gg.setValues(res)
    end
    gg.clearResults()
    gg.alert("✅ تم إنهاء وفتح جميع صناديق المهمات اليومية")
end

-- 💰 3.3 شراء الدنانير
function buyDinars()
    gg.alert("💰 جلب 86 دينار")
    local w = gg.prompt({"وقت الانتظار:"}, {30}, {"number"})
    if not w then return end
    
    gg.clearResults()
    gg.searchNumber('7000;55000~55043;6000~6210;2000~2112;5562~5600;10050~10130', gg.TYPE_DWORD)
    if gg.getResultsCount() == 0 then
        gg.searchNumber('7000;55000~55043;6000~6210;2000~2112;5562~5600;1000~1131', gg.TYPE_DWORD)
    end
    if gg.getResultsCount() == 0 then
        gg.alert("⚠️ لا توجد نتائج")
        return
    end
    
    local results = gg.getResults(10000)
    if #results > 0 then
        for i = 1, 15 do
            for j = 1, #results do results[j].value = 1000 end
            gg.setValues(results)
            gg.toast("👉 محاولة " .. i)
            gg.sleep(w[1] * 1000)
        end
        gg.alert("✅ اكتمل")
    end
    gg.clearResults()
end

-- 🎲 3.4 تفعيل الحظ
function luckOn()
    gg.unrandomizer(1, 0, 1.0, 0.0)
    gg.alert("🎲 تم تفعيل الحظ")
end

-- 💔 3.5 إلغاء الحظ
function luckOff()
    gg.unrandomizer(nil, nil, nil, nil)
    gg.alert("💔 تم إلغاء الحظ")
end

-- 🆙 3.6 رفع المستوى
function levelUpHack()
    if not isButtonEnabled("LEVEL") then return end
    
    gg.toast("⏳ جاري التعديل...")
    gg.setRanges(gg.REGION_ANONYMOUS)

    gg.clearResults()
    gg.searchNumber("':size_y'", gg.TYPE_BYTE)
    local res1 = gg.getResults(9999)
    if #res1 > 0 then
        for _, v in ipairs(res1) do v.value = "0" end
        gg.setValues(res1)
    end

    gg.sleep(500)

    gg.clearResults() 
    gg.searchNumber("':size_x'", gg.TYPE_BYTE)
    local res2 = gg.getResults(9999)
    if #res2 > 0 then
        for _, v in ipairs(res2) do v.value = "0" end
        gg.setValues(res2)
    end
    gg.alert("🚀 تم رفع المستوى بنجاح")
end

-- 🤖 3.7 تسريع كل شيء
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

-- 🌾 3.8 قائمة المزروعات
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
-- [4] القائمة الرئيسية (Kombiniertes Menü)
-- ==================================================
function mainMenu()
    local m = gg.choice({
        "🔥 تشغيل المعدلة",      -- Neu aus Script 2
        "📝 أكمال المهام اليومية", -- Zusammengefasst
        "💰 شراء الدنانير",      -- Neu aus Script 2
        "🎲 تفعيل الحظ",        -- Neu aus Script 2
        "💔 إلغاء الحظ",        -- Neu aus Script 2
        "🌾 قائمة المزروعات",
        "🤖 تسريع كل شيء",
        "🆙 رفع المستوى",
        "🔄 تحديث الإعدادات",
        "❌ خروج"
    }, nil, "🌟 لوحة تحكم " .. SCRIPT_NAME)

    if m == 1 then auto_bypass()
    elseif m == 2 then searchDailyQuest()
    elseif m == 3 then buyDinars()
    elseif m == 4 then luckOn()
    elseif m == 5 then luckOff()
    elseif m == 6 then cropsMenu()
    elseif m == 7 then alleMaschinenHack()
    elseif m == 8 then levelUpHack()
    elseif m == 9 then loadConfig() gg.toast("✅ تم التحديث")
    elseif m == 10 then os.exit() end
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
