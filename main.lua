-- ==================================================
-- Script: FamilyFarm / Daily Quest & Speed
-- Version: Optimized Online Version
-- ==================================================

collectgarbage("collect")
gg.clearResults()
gg.toast("ابوو الليث")
gg.alert("🆕 NEUE VERSION\n" .. os.date("%Y-%m-%d %H:%M:%S"))

-- ==================================================
-- ONLINE ON / OFF CHECK
-- ==================================================
function isOnlineEnabled()
    local r = gg.makeRequest("https://raw.githubusercontent.com/yamin210/FamilyFarm/main/daily.txt")
    if r and r.content then
        return r.content:find("ON") ~= nil
    end
    -- Falls der Link nicht erreichbar ist, standardmäßig false (Sicherheit)
    return false
end

-- ==================================================
-- 🆙 FUNKTION: رفع المستوى (Text-Suche :size_y)
-- ==================================================
function levelUpHack()
    gg.toast("⏳ جاري البحث عن نص :size_y...")

    -- 1. Suche nach dem Text ":size_y" (UTF-8)
    gg.clearResults()
    -- Wir suchen nach dem Text-String. In Lua-Scripts für GG 
    -- schreibt man den Text einfach in die Suche und nutzt TYPE_BYTE.
    gg.searchNumber(":size_y", gg.TYPE_BYTE)
    
    local res1 = gg.getResults(9999)
    if #res1 > 0 then
        -- Wir setzen die gefundenen Werte auf 0
        -- Hinweis: Bei Text-Strings setzt das "Nullen" den Text technisch auf leere Zeichen
        for _, v in ipairs(res1) do
            v.value = "0"
        end
        gg.setValues(res1)
        gg.toast("✅ تم تصفير البحث الأول")
    else
        gg.toast("⚠️ لم يتم العثور على البحث الأول")
    end

    gg.sleep(600) -- Kurze Pause zur Sicherheit

    -- 2. Zweite (neue) Suche nach :size_x
    gg.clearResults()
    gg.searchNumber(":size_x", gg.TYPE_BYTE)
    
    local res2 = gg.getResults(9999)
    if #res2 > 0 then
        for _, v in ipairs(res2) do
            v.value = "0"
        end
        gg.setValues(res2)
        gg.toast("✅ تم تصفير البحث الثاني")
    else
        gg.toast("⚠️ لم يتم العثور على البحث الثاني")
    end

    gg.alert("🚀 تم الانتهاء من تعديل بنجاح")
end

-- ==================================================
-- 🤖 FUNKTION: تسريع كلشي (Einzel-Refine Logik)
-- ==================================================
function alleMaschinenHack()
    gg.toast("يلا بسم الله نبلش")

    -- --- ERSTE SUCHE ---
    gg.clearResults()
    gg.searchNumber("30;2049;45~900", gg.TYPE_DWORD)
    local g1 = gg.getResults(9999)

    if #g1 > 0 then
        local t1 = {45, 50, 60, 70, 75, 80, 90, 100, 110, 120, 900}
        for _, v in ipairs(t1) do
            gg.loadResults(g1) -- Lädt die Ergebnisse der ersten Gruppensuche
            gg.refineNumber(tostring(v), gg.TYPE_DWORD) -- Einzel-Refine
            local found = gg.getResults(9999)
            if #found > 0 then
                for _, item in ipairs(found) do item.value = "0" end
                gg.setValues(found)
            end
        end
        gg.toast("يلا باقي شوي")
    else
        gg.toast("❌ Gruppe 1 nicht gefunden")
    end

    gg.sleep(200) -- Kurze Pause für die Stabilität
    gg.toast(" خلصنا 1")

    -- --- ZWEITE SUCHE ---
    gg.clearResults()
    gg.searchNumber("10;2049;50~600", gg.TYPE_DWORD)
    local g2 = gg.getResults(9999)

    if #g2 > 0 then
        local t2 = {55, 60, 70, 72, 75, 80, 90, 100, 110, 120, 150, 180, 600}
        for _, v in ipairs(t2) do
            gg.loadResults(g2) -- Lädt die Ergebnisse der zweiten Gruppensuche
            gg.refineNumber(tostring(v), gg.TYPE_DWORD) -- Einzel-Refine
            local found = gg.getResults(9999)
            if #found > 0 then
                for _, item in ipairs(found) do item.value = "0" end
                gg.setValues(found)
            end
        end
        gg.toast("خلصناااا 2")
    else
        gg.toast("❌ Gruppe 2 nicht gefunden")
    end
    
    gg.alert("✅ تم تسريع كلشي بنجاح")
end

-- ==================================================
-- 🐘 ELEFANT / 🌱 FALFEL / 🍅 TOMATEN / 🌿 BARSIM
-- ==================================================
function elefantHack()
    if not isOnlineEnabled() then gg.alert("❌ Script ist online deaktiviert") return end
    gg.clearResults()
    gg.searchNumber("200422", gg.TYPE_DWORD)
    local res = gg.getResults(9999)
    if #res == 0 then gg.alert("❌ Wert nicht gefunden") return end
    for _, v in ipairs(res) do v.value = 7046 v.flags = gg.TYPE_DWORD end
    gg.setValues(res)
    gg.alert("✅ Elefant geändert auf 7046")
end

function falfelHack()
    gg.clearResults()
    gg.searchNumber("200422", gg.TYPE_DWORD)
    local res = gg.getResults(9999)
    if #res == 0 then gg.alert("❌ Wert nicht gefunden") return end
    for _, v in ipairs(res) do v.value = 5107 v.flags = gg.TYPE_DWORD end
    gg.setValues(res)
    gg.alert("✅ falfel geändert auf 5107")
end

function tomatenHack()
    gg.clearResults()
    gg.searchNumber("7024", gg.TYPE_DWORD)
    local res = gg.getResults(9999)
    if #res == 0 then gg.alert("❌ Wert nicht gefunden") return end
    for _, v in ipairs(res) do v.value = 7048 v.flags = gg.TYPE_DWORD end
    gg.setValues(res)
    gg.alert("✅ Tomaten geändert auf 7048")
end

function barsimHack()
    gg.clearResults()
    gg.searchNumber("200422", gg.TYPE_DWORD)
    local res = gg.getResults(9999)
    if #res == 0 then gg.alert("❌ Wert nicht gefunden") return end
    for _, v in ipairs(res) do v.value = 5101 v.flags = gg.TYPE_DWORD end
    gg.setValues(res)
    gg.alert("✅ barsim geändert auf 5101")
end

-- ==================================================
-- 🔍 DAILY QUEST
-- ==================================================
function searchDailyQuest()
    if not isOnlineEnabled() then gg.alert("❌ Script ist online deaktiviert") return end
    gg.clearResults()
    gg.searchNumber("27000~27099;1~2000", gg.TYPE_DOUBLE)
    gg.refineNumber("1~2000", gg.TYPE_DOUBLE)
    local base = gg.getResults(9999)
    if #base == 0 then gg.alert("❌ Keine Werte gefunden") return end
    
    local numbers = {1, 2000, 30, 6, 20, 12, 10, 3, 2, 5}
    local total = 0
    for _, num in ipairs(numbers) do
        gg.loadResults(base)
        gg.refineNumber(tostring(num), gg.TYPE_DOUBLE)
        local res = gg.getResults(9999)
        for _, v in ipairs(res) do v.value = 0 v.flags = gg.TYPE_DOUBLE end
        gg.setValues(res)
        total = total + #res
    end
    gg.alert("✅ Daily Quest fertig\nGeändert: " .. total)
end

-- ==================================================
-- 🌾 MENÜS
-- ==================================================
function cropsMenu()
    local c = gg.choice({
        "🍅 بندورة", 
        "🐘 بوط", 
        "🌱 فلفل هاينان", 
        "🌿 اوراق برسيم الاربعة", 
        "⬅️ Zurück"
    }, nil, "مزروعات متنوعة")

    if c == nil or c == 5 then return end

    -- Spezifische Nachricht für Tomaten (Option 1)
    if c == 1 then
        gg.alert("حددت على برسيم حجازي؟")
    end

    -- Nachricht für Auswahl 2, 3 und 4
    if c == 2 or c == 3 or c == 4 then
        gg.alert("حددت على الشوفان؟")
    end

    if c == 1 then tomatenHack()
    elseif c == 2 then elefantHack()
    elseif c == 3 then falfelHack()
    elseif c == 4 then barsimHack() end
end

function mainMenu()
    local m = gg.choice({
        "🔍 اليوميات",
        "🌾 مزروعات ",
        "🤖 تسريع كل الالات والحيوانات",
        "🆙 رفع المستوى",
        "❌ انهاء"
    }, nil, "FamilyFarm")

    if m == 1 then searchDailyQuest()
    elseif m == 2 then cropsMenu()
    elseif m == 3 then alleMaschinenHack()
    elseif m == 4 then levelUpHack()
    elseif m == 5 then os.exit() end
end

-- ==================================================
-- 🔁 LOOP
-- ==================================================
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        mainMenu()
    end
    gg.sleep(100)
end
