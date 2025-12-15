--=========================================================
-- Script: daily_quest
--=========================================================

-- =========================
-- ONLINE CHECK (GitHub)
-- =========================
function isOnlineEnabled()
    local r = gg.makeRequest("https://raw.githubusercontent.com/yamin210/FamilyFarm/refs/heads/main/daily.txt")
    if r and r.content then
        return r.content:find("ON") ~= nil
    end
    return false
end

gg.toast("ابوو الليث")

-- Zahlen für Daily Quest
local numbers = {1, 2000, 30, 6, 20, 12, 10, 3, 2, 5}

--=========================================================
-- DAILY QUEST
--=========================================================
function searchDailyQuest()

    if not isOnlineEnabled() then
        gg.alert("❌ Script ist online deaktiviert")
        return
    end

    gg.searchNumber("27000~27099;1~2000", gg.TYPE_DOUBLE)
    gg.toast("Erste Suche fertig...")

    gg.refineNumber("1~2000", gg.TYPE_DOUBLE)
    gg.toast("Refine 1~2000 fertig...")

    local base = gg.getResults(9999)
    if #base == 0 then
        gg.alert("Keine Werte nach refine gefunden.")
        return
    end

    local totalChanged = 0

    for _, num in ipairs(numbers) do
        gg.loadResults(base)
        gg.refineNumber(tostring(num), gg.TYPE_DOUBLE)

        local results = gg.getResults(9999)
        if #results > 0 then
            for _, v in ipairs(results) do
                v.value = 0
                v.flags = gg.TYPE_DOUBLE
            end
            gg.setValues(results)
            totalChanged = totalChanged + #results
        end
    end

    gg.alert("✅ Gesamt geändert: " .. totalChanged)
end

--=========================================================
-- UNTERMENÜ: مزروعات متنوعة
--=========================================================
function variedCropsMenu()

    if not isOnlineEnabled() then
        gg.alert("❌ Script ist online deaktiviert")
        return
    end

    local menu = gg.choice({
        "🍅 Tomaten",
        "🐘 Elefant",
        "🌿 falfel",
        "🌾 barsim",
        "⬅️ Zurück"
    }, nil, "مزروعات متنوعة")

    if menu == 1 then
        cropTomaten()
    elseif menu == 2 then
        cropElefant()
    elseif menu == 3 then
        cropFalfel()
    elseif menu == 4 then
        cropBarsim()
    end
end

--=========================================================
-- FUNKTIONEN DER 4 BUTTONS
--=========================================================
function cropTomaten()
    gg.alert("🍅 Tomaten\n\nFunktion bereit")
end

function cropElefant()
    gg.alert("🐘 Elefant\n\nFunktion bereit")
end

function cropFalfel()
    gg.alert("🌿 falfel\n\nFunktion bereit")
end

function cropBarsim()
    gg.alert("🌾 barsim\n\nFunktion bereit")
end

--=========================================================
-- HAUPTMENÜ
--=========================================================
function mainMenu()
    local menu = gg.choice({
        "🔍 Daily Quest starten",
        "🌱 مزروعات متنوعة",
        "❌ Beenden"
    }, nil, "daily_quest")

    if menu == 1 then
        searchDailyQuest()
    elseif menu == 2 then
        variedCropsMenu()
    elseif menu == nil or menu == 3 then
        os.exit()
    end
end

--=========================================================
-- LOOP
--=========================================================
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        mainMenu()
    end
end
