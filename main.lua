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
-- DAILY QUEST LOGIK
-- ==============================
local numbers = {1, 2000, 30, 6, 20, 12, 10, 3, 2, 5}

function searchDailyQuest()
    if not isOnlineEnabled() then
        gg.alert("❌ Script ist online deaktiviert")
        return
    end

    gg.searchNumber("27000~27099;1~2000", gg.TYPE_DOUBLE)
    gg.toast("Erste Suche fertig")

    gg.refineNumber("1~2000", gg.TYPE_DOUBLE)
    gg.toast("Refine fertig")

    local base = gg.getResults(9999)
    if #base == 0 then
        gg.alert("Keine Werte gefunden")
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

    gg.alert("Fertig ✅\nGeändert: " .. total)
end

-- ==============================
-- 🌾 مزروعات متنوعة
-- ==============================
function cropsMenu()
    local c = gg.choice({
        "🍅 Tomaten",
        "🐘 Elefant",
        "🌱 falfel",
        "🌿 barsim",
        "⬅️ Zurück"
    }, nil, "مزروعات متنوعة")

    if c == 1 then
        gg.toast("Tomaten gewählt")
    elseif c == 2 then
        gg.toast("Elefant gewählt")
    elseif c == 3 then
        gg.toast("falfel gewählt")
    elseif c == 4 then
        gg.toast("barsim gewählt")
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
