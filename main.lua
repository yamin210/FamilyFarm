collectgarbage("collect")
gg.clearResults()
gg.toast("ابوو الليث")
gg.alert("🆕 NEUE VERSION\n" .. os.time())

-- ==================================================
-- ONLINE ON / OFF CHECK
-- ==================================================
function isOnlineEnabled()
    local r = gg.makeRequest("https://raw.githubusercontent.com/yamin210/FamilyFarm/main/daily.txt")
    if r and r.content then
        return r.content:find("ON") ~= nil
    end
    return false
end

-- ==================================================
-- 🤖 NEUE FUNKTION: ALLE MASCHINEN
-- ==================================================
function alleMaschinenHack()
    gg.toast("Starte Maschinen Hack (Gruppen-Filter)...")

    -- --- GRUPPE 1 BEARBEITEN ---
    gg.clearResults()
    gg.searchNumber("30;2049;45~900", gg.TYPE_DWORD)
    local gruppe1 = gg.getResults(9999)

    if #gruppe1 > 0 then
        local targets1 = {45, 50, 60, 70, 75, 90, 100, 110, 120, 900}
        for _, v in ipairs(targets1) do
            gg.loadResults(gruppe1) -- Lädt NUR die Ergebnisse der Gruppe 1
            gg.refineNumber(tostring(v), gg.TYPE_DWORD) -- Filtert den Wert aus der Gruppe
            local found = gg.getResults(9999)
            if #found > 0 then
                for _, item in ipairs(found) do item.value = "0" end
                gg.setValues(found)
            end
        end
        gg.toast("Gruppe 1 fertig!")
    else
        gg.toast("Gruppe 1 nicht gefunden")
    end

    -- --- GRUPPE 2 BEARBEITEN ---
    gg.clearResults()
    gg.searchNumber("10;2049;50~600", gg.TYPE_DWORD)
    local gruppe2 = gg.getResults(9999)

    if #gruppe2 > 0 then
        local targets2 = {55, 60, 70, 72, 75, 90, 100, 110, 120, 150, 180, 600}
        for _, v in ipairs(targets2) do
            gg.loadResults(gruppe2) -- Lädt NUR die Ergebnisse der Gruppe 2
            gg.refineNumber(tostring(v), gg.TYPE_DWORD) -- Filtert den Wert aus der Gruppe
            local found = gg.getResults(9999)
            if #found > 0 then
                for _, item in ipairs(found) do item.value = "0" end
                gg.setValues(found)
            end
        end
        gg.toast("Gruppe 2 fertig!")
    else
        gg.toast("Gruppe 2 nicht gefunden")
    end
    
    gg.alert("✅ Alle Werte innerhalb der Gruppen auf 0 gesetzt!")
end

-- ==================================================
-- 🐘 ELEFANT / 🌱 FALFEL / 🍅 TOMATEN / 🌿 BARSIM (Bestehend)
-- ==================================================
function elefantHack()
    if not isOnlineEnabled() then gg.alert("❌ Script ist online deaktiviert") return end
    gg.clearResults()
    gg.searchNumber("200422", gg.TYPE_DWORD)
    local res = gg.getResults(9999)
    for _, v in ipairs(res) do v.value = 7046 v.flags = gg.TYPE_DWORD end
    gg.setValues(res)
    gg.alert("✅ Elefant geändert")
end

function falfelHack()
    gg.clearResults()
    gg.searchNumber("200422", gg.TYPE_DWORD)
    local res = gg.getResults(9999)
    for _, v in ipairs(res) do v.value = 5107 v.flags = gg.TYPE_DWORD end
    gg.setValues(res)
    gg.alert("✅ falfel geändert")
end

function tomatenHack()
    gg.clearResults()
    gg.searchNumber("7024", gg.TYPE_DWORD)
    local res = gg.getResults(9999)
    for _, v in ipairs(res) do v.value = 7048 v.flags = gg.TYPE_DWORD end
    gg.setValues(res)
    gg.alert("✅ Tomaten geändert")
end

function barsimHack()
    gg.clearResults()
    gg.searchNumber("200422", gg.TYPE_DWORD)
    local res = gg.getResults(9999)
    for _, v in ipairs(res) do v.value = 5101 v.flags = gg.TYPE_DWORD end
    gg.setValues(res)
    gg.alert("✅ barsim geändert")
end

-- ==================================================
-- 🔍 DAILY QUEST (Bestehend)
-- ==================================================
function searchDailyQuest()
    if not isOnlineEnabled() then gg.alert("❌ Script ist online deaktiviert") return end
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
    gg.alert("✅ Daily Quest fertig")
end

-- ==================================================
-- 🌾 MENÜS
-- ==================================================
function cropsMenu()
    local c = gg.choice({"🍅 بندورة", "🐘 بوط", "🌱 فلفل هاينان", "🌿 اوراق برسيم الاربعة", "⬅️ Zurück"}, nil, "مزروعات متنوعة")
    if c == 1 then tomatenHack() elseif c == 2 then elefantHack() elseif c == 3 then falfelHack() elseif c == 4 then barsimHack() end
end

function mainMenu()
    local m = gg.choice({
        "🔍 يوميات (Daily)",
        "🌾 مزروعات (Crops)",
        "🤖 alle Maschinen", -- DEIN NEUER KNOPF
        "❌ Beenden"
    }, nil, "FamilyFarm")

    if m == 1 then searchDailyQuest()
    elseif m == 2 then cropsMenu()
    elseif m == 3 then alleMaschinenHack() -- AUFRUF DER NEUEN FUNKTION
    elseif m == 4 then os.exit() end
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
