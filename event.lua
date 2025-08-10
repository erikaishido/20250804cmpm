local event = {}


-----------------------------
-- events
-- anything here can be called from anywhere
--
-- events are an alternative to directly changing globals??????
-- ask chris
-----------------------------


function event.startNewDay()
    global.DAYS = global.DAYS + 1
    global.O2 = global.O2 - global.O2CSP
    global.WATER = global.WATER - global.WATERCSP
    global.FOOD = global.FOOD - global.FOODCSP

    for i,v in ipairs(global.PLANTS) do
        plant.checkGrowth(v)
    end

    global.debugMsg = "start new day!"
end


function event.sumResource(resource, amount)
    if resource == "o2" then                    -- ugly but idk how else to do this
        global.O2 = global.O2 + amount
    elseif resource == "water" then
        global.WATER = global.WATER + amount
    elseif resource == "food" then
        global.FOOD = global.FOOD + amount
    else
        -- figure out how to raise errors
        return
    end
end


-----------------------------
-- ui events
-----------------------------

function event.openUI(U)
    global.UIS[U].isActive = true
end


function event.closeUI(U)
    global.UIS[U].isActive = false
end


function event.plantSeed(pageIndex)
    local i = global.SELECTEDPLANT
    global.PLANTS[i] = plantC.new(i, global.ALLPLANTS[pageIndex])
    event.closeUI("plantSelect")
end


return event