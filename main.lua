gg.alert("🆕 NEUE VERSION\n" .. os.time())

-- =========================================
-- Script: FamilyFarm / Daily Quest
-- Online-Version
-- =========================================

collectgarbage("collect")
gg.clearResults()

gg.toast("FamilyFarm gestartet")

-- ==============================
-- ONLINE ON / OFF CHECK
-- ==============================
function isOnlineEnabled()
    local r = gg.makeRequest(
        "https://raw.githubusercontent.com/yamin210/FamilyFarm/main/daily.txt"
    )
    if r and r.content then
        return r.content:find("ON") ~= nil
    end
    return false
end

-- ==============================
-- 🐘 ELEFANT HACK
-- ==============================
function elefantHack()
    if not isOnlineEnabled() then
        gg.alert("❌ Script ist online deaktiviert")
        return
    end

    gg.clearResults()
    gg.toast("🐘 Elefant: Suche startet")

    gg.searchNumber("200422", gg.TYPE_DWORD)
    local res = gg.getResults(9999)

    if #res == 0 then
        gg.alert("❌ Elefant: Wert nicht gefunden")
        return
    end

    for _, v in ipairs(res) do
        v.value = 7046
        v.flags = gg.TYPE_DWORD
    end

    gg.setValues(res)
    gg.alert("✅ Elefant geändert auf 7046\nTreffer: " .. #res)
end

function falfelHack()
    gg.clearResults()
    gg.toast("🌱 falfel: Suche startet")

    gg.searchNumber("200422", gg.TYPE_DWORD)
    local res = gg.getResults(9999)

    if #res == 0 then
        gg.alert("❌ falfel: Wert nicht gefunden")
        return
    end

    for _, v in ipairs(res) do
        v.value = 5107
        v.flags = gg.TYPE_DWORD
    end

    gg.setValues(res)
    gg.alert("✅ falfel geändert auf 5107\nTreffer: " .. #res)
end

function tomatenHack()
    gg.clearResults()
    gg.toast("🍅 Tomaten: Suche startet")

    gg.searchNumber("7024", gg.TYPE_DWORD)
    local res = gg.getResults(9999)

    if #res == 0 then
        gg.alert("❌ Tomaten: Wert nicht gefunden")
        return
    end

    for _, v in ipairs(res) do
        v.value = 7048
        v.flags = gg.TYPE_DWORD
    end

    gg.setValues(res)
    gg.alert("✅ Tomaten geändert auf 7048\nTreffer: " .. #res)
end

function barsimHack()
    gg.clearResults()
    gg.toast("🌿 barsim: Suche startet")

    gg.searchNumber("200422", gg.TYPE_DWORD)
    local res = gg.getResults(9999)

    if #res == 0 then
        gg.alert("❌ barsim: Wert nicht gefunden")
        return
    end

    for _, v in ipairs(res) do
        v.value = 5101
        v.flags = gg.TYPE_DWORD
    end

    gg.setValues(res)
    gg.alert("✅ barsim geändert auf 5101\nTreffer: " .. #res)
end




-- ==============================
-- DAILY QUEST
-- ==============================
local numbers = {1, 2000, 30, 6, 20, 12, 10, 3, 2, 5}

function searchDailyQuest()
    if not isOnlineEnabled() then
        gg.alert("❌ Script ist online deaktiviert")
        return
    end

    gg.clearResults()
    gg.searchNumber("27000~27099;1~2000", gg.TYPE_DOUBLE)
    gg.toast("Erste Suche fertig")

    gg.refineNumber("1~2000", gg.TYPE_DOUBLE)
    gg.toast("Refine fertig")

    local base = gg.getResults(9999)
    if #base == 0 then
        gg.alert("❌ Keine Werte gefunden")
        return
    end

    local total = 0

    for _, num in ipairs(numbers) do
        gg.loadResults(base)
        gg.refineNumber(tostring(num), gg.TYPE_DOUBLE)
        local res = gg.getResults(9999)

        for _, v in ipairs(res) do
            v.value = 0
            v.flags = gg.TYPE_DOUBLE
        end

        gg.setValues(res)
        total = total + #res
    end

    gg.alert("✅ Daily Quest fertig\nGeändert: " .. total)
end

-- ==============================
-- 🌾 مزروعات متنوعة
-- ==============================
function cropsMenu()
    local c = gg.choice({
        "🍅 Tomaten",
        "🐘 بوط",
        "🌱 falfel",
        "🌿 barsim",
        "⬅️ Zurück"
    }, nil, "مزروعات متنوعة")

    if c == nil or c == 5 then
        return
    elseif c == 1 then
    tomatenHack()
    elseif c == 2 then
        elefantHack()
    elseif c == 3 then
    falfelHack()
   elseif c == 4 then
    barsimHack()
    end
end

-- ==============================
-- HAUPTMENÜ
-- ==============================
function mainMenu()
    local m = gg.choice({
        "🔍 Daily Quest",
        "🌾 مزروعات متنوعة",
        "❌ Beenden"
    }, nil, "FamilyFarm")

    if m == nil then return end

    if m == 1 then
        searchDailyQuest()
    elseif m == 2 then
        cropsMenu()
    elseif m == 3 then
        os.exit()
    end
end

-- ==============================
-- LOOP (GG Button)
-- ==============================
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        mainMenu()
    end
end
