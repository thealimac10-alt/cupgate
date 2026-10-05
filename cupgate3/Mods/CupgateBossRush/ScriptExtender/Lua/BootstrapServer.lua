-- Cupgate: Cuphead-style boss fights for Baldur's Gate 3. UNTESTED scaffold.
-- Values mirror design/grades.json; change the sheet first, then this file.
local GRADES = { {3,"S"}, {5,"A"}, {8,"B"}, {9999,"C"} }
local rounds = {}

local function banner(text)
    local host = Osi.GetHostCharacter()
    if host then pcall(Osi.ShowNotification, host, text) end
end

local function gradeFor(n)
    for _, g in ipairs(GRADES) do if n <= g[1] then return g[2] end end
    return "C"
end

Ext.Osiris.RegisterListener("CombatStarted", 1, "after", function(combat)
    rounds[combat] = 0
    banner("WALLOP!")
end)

Ext.Osiris.RegisterListener("CombatRoundStarted", 2, "after", function(combat, round)
    rounds[combat] = round
end)

Ext.Osiris.RegisterListener("CombatEnded", 1, "after", function(combat)
    local n = rounds[combat] or 0
    banner("KNOCKOUT!  Rank: " .. gradeFor(n) .. "  (" .. n .. " rounds)")
    rounds[combat] = nil
end)
