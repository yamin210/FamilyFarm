-- ==================================================
-- Script: ابوو الليث
-- Developer: ابوو الليث (Tägliche Aufgaben Fix V2)
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
-- [3] Hilfsfunktionen für Text-Schreiben im Speicher
-- ==================================================
local function CopyFile(playername, editname)
    local t = gg.getResults(gg.getResultsCount())
    local replaceString = {}
    local stringSize = {}
    local str = {}
    gg.clearResults()
    
    for i = 1, #editname do 
        str[i] = string.sub(editname, i, i) 
    end
    
    for i = 1, #t do
        stringSize[#stringSize + 1] = {
            address = t[i].address - 0x4,
            flags = gg.TYPE_WORD
        }
        for charCount = 1, #editname do
            replaceString[#replaceString + 1] = {
                address = t[i].address,
                flags = gg.TYPE_WORD,
                value = string.byte(str[charCount])
            }
            t[i].address = t[i].address + 1
        end
    end
    
    stringSize = gg.getValues(stringSize)
    for i, v in ipairs(stringSize) do
        if v.value == #playername then 
            v.value = #editname 
        end
    end
    gg.setValues(stringSize)
    gg.setValues(replaceString)
end

local function UpdatePass(oldName, newName)
    gg.searchNumber(':' .. oldName)
    local a = gg.getResults(gg.getResultsCount())
    if #a == 0 then return false, 0 end
    
    local limited = {}
    local limit = math.min(10000, #a)
    for i = 1, limit do 
        limited[i] = a[i] 
    end
    gg.loadResults(limited)
    
    local stringLength = #oldName
    for i = 1, stringLength do
        gg.refineNumber(':' .. string.sub(oldName, 1, stringLength))
        stringLength = stringLength - 1
    end
    
    local final_count = gg.getResultsCount()
    CopyFile(oldName, newName)
    return true, final_count
end

-- ==================================================
-- [4] الوظائف الأساسية
-- ==================================================

-- 🔥 4.1 تشغيل المعدلة (Bypass)
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
            local ok, count = UpdatePass(CONFIG.OLD_NAME, CONFIG.NEW_NAME)
            gg.processResume()
            
            if ok and count > 0 then
                patched_once = true
                gg.alert("مع تحيات ابوو الليث تم تسجيل الدخول بنجاح")
                return true
            end
        end
        gg.sleep(CONFIG.SCAN_INTERVAL_MS)
    end
end

-- 📝 4.2 أكمال المهام اليومية (Garantierte Version)
-- 📝 4.2 أكمال المهام اليومية (Maximale Reichweite & korrekte Filterung)
function searchDailyQuest()
    if not isButtonEnabled("DAILY") then return end 

    gg.toast("⏳ جاري البحث عن المهام اليومية...")
    gg.clearResults()
    
    -- Regionen erweitern, falls ANONYMOUS alleine nicht reicht
    gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_BAD | gg.REGION_OTHER)
    
    -- Wir erhöhen den maximalen Abstand (Offset) zwischen den Zahlen auf 256 Bytes (wie im Original)
    gg.searchNumber("13;200422::256", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
    
    local count = gg.getResultsCount()
    if count == 0 then
        -- Falls das nicht klappt, versuchen wir das zweite Muster mit der 10
        gg.searchNumber("13;200422;10::256", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        count = gg.getResultsCount()
    end
    
    if count == 0 then
        -- Letzter Versuch: Einzelplatz-Suche nach der ID, um zu sehen ob sie existiert
        gg.searchNumber("200422", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        count = gg.getResultsCount()
    end
    
    if count == 0 then
        gg.alert("⚠️ لم يتم العثور على قيم المهام اليومية.\nتأكد من فتح قائمة المهام في اللعبة أولاً!")
        return
    end
    
    -- Jetzt gezielt die "13" oder den Status-Wert verfeinern
    gg.refineNumber("13", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
    local finalCount = gg.getResultsCount()
    
    if finalCount > 0 then
        local r = gg.getResults(finalCount)
        local freezeList = {}
        for i = 1, #r do
            freezeList[i] = {
                address = r[i].address,
                flags = gg.TYPE_DWORD,
                value = 0,
                freeze = true
            }
        end
        gg.setValues(freezeList)
        gg.addListItems(freezeList)
        gg.clearResults()
        gg.alert("✅ تم تشغيل ميزة المهام اليومية الجديدة بنجاح")
    else
        -- Falls die 13 nicht im Paket war, modifizieren wir die gefundenen Basis-Werte direkt
        local r = gg.getResults(100)
        for i = 1, #r do
            if r[i].value == 13 then
                r[i].value = 0
                r[i].freeze = true
            end
        end
        gg.setValues(r)
        gg.clearResults()
        gg.alert("✅ تم التعديل المباشر للمهام اليومية")
    end
end


-- 💰 4.3 شراء الدنانير
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

-- 🎲 4.4 تفعيل الحظ
function luckOn()
    gg.unrandomizer(1, 0, 1.0, 0.0)
    gg.alert("🎲 تم تفعيل الحظ")
end

-- 💔 4.5 إلغاء الحظ
function luckOff()
    gg.unrandomizer(nil, nil, nil, nil)
    gg.alert("💔 تم إلغاء الحظ")
end

-- 🆙 4.6 رفع المستوى
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

-- 🤖 4.7 تسريع كل شيء
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

-- 🌾 4.8 قائمة المزروعات
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
-- [5] القائمة الرئيسية
-- ==================================================
function mainMenu()
    local m = gg.choice({
        "🔥 تشغيل المعدلة",      
        "📝 أكمال المهام اليومية", 
        "💰 شراء الدنانير",      
        "🎲 تفعيل الحظ",        
        "💔 إلغاء الحظ",        
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
-- [6] الحلقة الدائمة
-- ==================================================
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        mainMenu()
    end
    gg.sleep(100)
end
