local event = {}


-----------------------------
-- events
-- anything here can be called from anywhere
--
-- events are an alternative to directly changing globals??
-- ask chris
-----------------------------


function event.startNewDay()
    global.DAYS = global.DAYS + 1
    global.O2 = global.O2 - global.O2_CONSUMPTION
    global.WATER = global.WATER - global.WATER_CONSUMPTION
    global.FOOD = global.FOOD - global.FOOD_CONSUMPTION

    for i,v in ipairs(global.PLANTS) do
        plant.checkGrowth(v)
    end

    global.DEBUG_MSG = ""

    if global.FOOD <= 0 or global.O2 <= 0 or global.WATER <= 0 then
        global.DEBUG_MSG = "rip you ran out of resources"
    end

    if global.DAYS == 20 then
        global.DEBUG_MSG = "you survived for 20 days!"
    end
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


function event.plantSeed()
    local i = global.SELECTED_PLANT                 -- readability stuff
    local page = global.UIS.PLANT_SELECT.pageIndex

    global.PLANTS[i] = plant.new(i, global.ALL_PLANTS[page])
    event.closeUI("PLANT_SELECT")
end


return event