local plant = {}


-----------------------------
-- constructor function
-- returns a table that will populate/overwrite global.PLANTS[i]
-----------------------------
function plant.new(planterIndex, plantName)

    local T = {}                                       -- make an empty table
    for key, value in pairs(plant.base) do             -- copy base key:value pairs into table
        T[key] = value
    end

    T.x = global.PLANTOFFSETS[planterIndex].x          -- override xy depending on index
    T.y = global.PLANTOFFSETS[planterIndex].y


    if plantName == "" then                       -- RETHINK THIS??????????
        return T
    end

    T.state = 2                                       -- set state to SEEDLING
    T.name = plant.keyToPlant[plantName].name         -- override plant-dependant values

    return T
end


-----------------------------
-- called from main during load
-----------------------------
function plant.initPlantData()

    plant.base = {             -- base stats for plants
        name = "",              -- any specified stats will override these values
        harvestType = 1,
        state = 1,
        waterCount = 0,
        isWatered = false,
        x = 0,
        y = 0,
        w = 174,                -- w/h are same across all plants
        h = 130,
        baseSpr = "res/png/1.png",
        ripeSpr = "res/png/2.png"
    }

    plant.tomato = {           -- specific paramerters for each plant
        name = "Tomato",
        harvestType = 2
    }
    plant.lettuce = {
        name = "Lettuce",
        harvestType = 1
    }

    plant.keyToPlant = {           -- long list of all plants
        tomato = plant.tomato,     -- move all this to global?? consider
        lettuce = plant.lettuce
    }

end


-----------------------------
-- on-click behavior
-----------------------------
function plant.onClick(P)
    if P.state == 1 then                -- if planter is empty
        event.openUI("PLANTSELECT")
    elseif P.state == 5 then
        plant.harvest(P)
    else
        plant.water(P)
    end
end


function plant.water(P)
    if P.isWatered == true then         -- plant already watered today
        return
    elseif global.WATER < 10 then       -- you are out of water
        return
    end

    event.sumResource("water", -10)
    P.isWatered = true
end


function plant.harvest(P)
    P.state = 1
    P.waterCount = 0
    event.sumResource("food", 30)
end


-----------------------------
-- called at start of each day
-- check if watered yesterday + grows/ripens accordingly
-- TODO: wilts when not watered x days
-----------------------------

function plant.checkGrowth(P)
    if not P.isWatered then
        return
    end

    P.waterCount = P.waterCount + 1
    -- the unholy if else train
    if P.state == 2 then
        if P.waterCount >= 1 then
            P.state = 3
        end
    elseif P.state == 3 then
        if P.waterCount >= 2 then
            P.state = 4
        end
    elseif P.state == 4 then
        if P.waterCount >= 2 then
            P.state = 5
        end
    end

    P.isWatered = false
end


-----------------------------
-- ye olde draweth function
-----------------------------

function plant.draw(P)

    if P.state == 1 then
        love.graphics.rectangle("line", P.x, P.y, P.w, P.h)
        love.graphics.print("empty planter", P.x+30, P.y+50)
        return
    end


    local base = love.graphics.newImage(P.baseSpr)
    love.graphics.draw(base, P.x, P.y)

    love.graphics.print(P.name, P.x+30, P.y+80)

    if P.state == 5 then
        local fruit = love.graphics.newImage(P.ripeSpr)
        love.graphics.draw(fruit, P.x, P.y)
    end

    if P.isWatered == true then
        love.graphics.print("watered", (P.x + 50), (P.y - 20) )
    end
end


return plant