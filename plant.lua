local plant = {}


-----------------------------
-- constructor function
-- returns a table that will populate/overwrite global.PLANTS[i]
-----------------------------
function plant.new(planterIndex, plantType)

    local T = {}                                       -- make an empty table
    for key, value in pairs(plant.base) do            -- copy base key:value pairs into table
        T[key] = value
    end

    T.x = global.PLANTOFFSETS[planterIndex].x          -- override xy depending on index
    T.y = global.PLANTOFFSETS[planterIndex].y


    if plantType == "" then                       -- RETHINK THIS??????????
        return T
    end

    T.state = "seedling"
    T.name = plant.keyToPlant[plantType].name         -- override plant-dependant values

    return T
end


-----------------------------
-- called from main during load
-----------------------------
function plant.initPlantData()

    plant.base = {             -- base stats for plants
        name = "",              -- any specified stats will override these values
        harvestType = "",
        state = "empty",
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
        harvestType = "multiple"
    }
    plant.lettuce = {
        name = "Lettuce",
        harvestType = "single"
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
    if P.state == "empty" then          -- if no plant
        event.openUI("plantSelect")
    elseif P.state == "ripe" then
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
    P.state = "empty"
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
    if P.state == "seedling" then
        if P.waterCount >= 1 then
            P.state = "juvenile"
        end
    elseif P.state == "juvenile" then
        if P.waterCount >= 2 then
            P.state = "mature"
        end
    elseif P.state == "mature" then
        if P.waterCount >= 2 then
            P.state = "ripe"
        end
    end

    P.isWatered = false
end


-----------------------------
-- ye olde draweth function
-----------------------------

function plant.draw(P)

    if P.state == "empty" then
        love.graphics.rectangle("line", P.x, P.y, P.w, P.h)
        love.graphics.print("empty planter", P.x+30, P.y+50)
        return
    end


    local base = love.graphics.newImage(P.baseSpr)
    love.graphics.draw(base, P.x, P.y)

    love.graphics.print(P.name, P.x+30, P.y+80)

    if P.state == "ripe" then
        local fruit = love.graphics.newImage(P.ripeSpr)
        love.graphics.draw(fruit, P.x, P.y)
    end

    if P.isWatered == true then
        love.graphics.print("watered", (P.x + 50), (P.y - 20) )
    end
end


return plant