local util = {}

-----------------------------
-- returns the sum of all numbers, from a given table
-- currently only handles all-num tables
-- TODO: type handling
-----------------------------
function util.sumTable(T)
    local i = 1
    local sum = 0
    while i <= #T do
        sum = sum + T[i]
        i = i + 1
    end
    return sum
end


return util