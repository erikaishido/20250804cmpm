local plant = {}


-----------------------------
-- constructor function
-- returns a table that will populate/overwrite global.PLANTS[i]
-----------------------------
function plant.new(planterIndex, plantName)

    local P = {}                                       -- make an empty table
    for key, value in pairs(plant.base) do             -- copy base key:value pairs into table
        P[key] = value
    end

    P.x = global.PLANT_OFFSETS[planterIndex].x         -- override xy based on planterIndex
    P.y = global.PLANT_OFFSETS[planterIndex].y


    if plantName == "" then                            -- when setting an empty planter.
        return P                                       -- maybe rethink this 
    end

    P.state = global.PLANT_STATES.SEEDLING             -- set state to SEEDLING
    P.name = plant.keyToPlant[plantName].name          -- override plant-dependant values
    P.harvestType = plant.keyToPlant[plantName].harvestType

    return P
end


-----------------------------
-- called from main during load
-----------------------------
function plant.initPlantData()

    plant.base = {              -- base stats for plants
        name = "",              -- any specified stats will override these values
        harvestType = global.HARVEST_TYPES.SINGLE,
        state = global.PLANT_STATES.EMPTY,
        waterCount = 0,
        isWatered = false,
        x = 0,
        y = 0,
        w = 174,                -- w/h are same across all plants
        h = 130,
        baseSpr = "res/png/1.png",
        ripeSpr = "res/png/2.png"
    }

    plant.tomato = {            -- specific paramerters for each plant
        name = "Tomato",
        harvestType = global.HARVEST_TYPES.MULTIPLE
    }
    plant.lettuce = {
        name = "Lettuce",
        harvestType = global.HARVEST_TYPES.SINGLE
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
    if P.state == global.PLANT_STATES.EMPTY then       -- if planter is empty
        event.openUI("PLANT_SELECT")
    elseif P.state == global.PLANT_STATES.RIPE then
        plant.harvest(P)
    else
        plant.water(P)
    end
end


function plant.water(P)
    if P.isWatered then                 -- plant already watered today
        return
    elseif global.WATER < 10 then       -- you are out of water
        return
    end

    event.sumResource("water", -10)
    P.isWatered = true
end


function plant.harvest(P)
    P.state = global.PLANT_STATES.EMPTY
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
    if P.state == global.PLANT_STATES.SEEDLING then
        if P.waterCount >= 1 then
            P.state = global.PLANT_STATES.JUVENILE
        end
    elseif P.state == global.PLANT_STATES.JUVENILE then
        if P.waterCount >= 2 then
            P.state = global.PLANT_STATES.MATURE
        end
    elseif P.state == global.PLANT_STATES.MATURE then
        if P.waterCount >= 2 then
            P.state = global.PLANT_STATES.RIPE
        end
    end

    P.isWatered = false
end


-----------------------------
-- ye olde draweth function
-----------------------------

function plant.draw(P)

    if P.state == global.PLANT_STATES.EMPTY then
        love.graphics.rectangle("line", P.x, P.y, P.w, P.h)
        love.graphics.print("empty planter", P.x+30, P.y+50)
        return
    end


    local base = love.graphics.newImage(P.baseSpr)
    love.graphics.draw(base, P.x, P.y)

    love.graphics.print(P.name, P.x+30, P.y+80)

    if P.state == global.PLANT_STATES.RIPE then
        local fruit = love.graphics.newImage(P.ripeSpr)
        love.graphics.draw(fruit, P.x, P.y)
    end

    if P.isWatered then
        love.graphics.print("watered", (P.x + 50), (P.y - 20) )
    end
end


return plant