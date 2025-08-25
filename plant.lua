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

    if P.isInitiated == false then                     -- only runs at load (rethink?)
        P.x = global.PLANT_OFFSETS[planterIndex].x     -- override xy based on planterIndex
        P.y = global.PLANT_OFFSETS[planterIndex].y
        P.baseQuad = global.PLANTER_QUAD[planterIndex]      -- override sprite data
        P.baseHoverQuad = global.PLANTER_QUAD_HOVER[planterIndex]
        P.isInitiated = true
    end

    if plantName == "" then                            -- when setting an empty planter.
        return P                                       -- maybe rethink this 
    end

    P.state = global.PLANT_STATES.SEEDLING             -- set state to SEEDLING
    P.name = plant.keyToPlant[plantName].name          -- override plant-dependant values
    P.harvestType = plant.keyToPlant[plantName].harvestType

    P.spr = plant.keyToPlant[plantName].spr
    P.seedlingSpr = {}
    table.insert(P.seedlingSpr, textureAtlas.getQuad(P.spr, 32, 32, 1, 1))
    table.insert(P.seedlingSpr, textureAtlas.getQuad(P.spr, 32, 32, 1, 2))
    P.juvenileSpr = {}
    table.insert(P.juvenileSpr, textureAtlas.getQuad(P.spr, 32, 32, 2, 1))
    table.insert(P.juvenileSpr, textureAtlas.getQuad(P.spr, 32, 32, 2, 2))
    P.matureSpr = {}
    table.insert(P.matureSpr, textureAtlas.getQuad(P.spr, 32, 32, 3, 1))
    table.insert(P.matureSpr, textureAtlas.getQuad(P.spr, 32, 32, 3, 2))
    P.ripeSpr = {}
    table.insert(P.ripeSpr, textureAtlas.getQuad(P.spr, 32, 32, 4, 1))
    table.insert(P.ripeSpr, textureAtlas.getQuad(P.spr, 32, 32, 4, 2))



    return P
end


-----------------------------
-- called from main during load
-----------------------------
function plant.initPlantData()

    plant.base = {              -- base stats for plants
        isInitiated = false,
        name = "",              -- any specified stats will override these values
        spr = "",
        harvestType = global.HARVEST_TYPES.SINGLE,
        state = global.PLANT_STATES.EMPTY,
        waterCount = 0,
        isWatered = false,
        isHovered = false,
        x = 0,
        y = 0,
        w = 32,                -- w/h are same across all plants
        h = 25,
        baseSpr = "res/png/1.png",
        --ripeSpr = "res/png/2.png",
        baseQuad = "",
        baseHoverQuad = "",

        seedlingSpr = {},
        juvenileSpr = {},
        matureSpr = {},
        ripeSpr = {}
    }

    plant.tomato = {            -- specific paramerters for each plant
        name = "Tomato",
        spr = love.graphics.newImage("res/png/tomato.png"),
        harvestType = global.HARVEST_TYPES.MULTIPLE
    }
    plant.lettuce = {
        name = "Lettuce",
        spr = love.graphics.newImage("res/png/tomato.png"),
        harvestType = global.HARVEST_TYPES.SINGLE
    }

    plant.keyToPlant = {           -- long list of all plants
        tomato = plant.tomato,     -- move all this to global?? consider
        lettuce = plant.lettuce
    }

end


-----------------------------
-- check for mouse hover
-----------------------------
function plant.checkForHover(P, condition)
    P.isHovered = condition
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

--[[     if P.state == global.PLANT_STATES.EMPTY then
        love.graphics.rectangle("line", P.x, P.y, P.w, P.h)
        love.graphics.print("empty planter", P.x+30, P.y+50)
        return
    end ]]

    if P.isHovered then                                 -- draw outlined plant
        if P.state == global.PLANT_STATES.SEEDLING then
            love.graphics.draw(P.spr, P.seedlingSpr[2], P.x+2, P.y-20)
        elseif P.state == global.PLANT_STATES.JUVENILE then
            love.graphics.draw(P.spr, P.juvenileSpr[2], P.x+2, P.y-20)
        elseif P.state == global.PLANT_STATES.MATURE then
            love.graphics.draw(P.spr, P.matureSpr[2], P.x+2, P.y-20)
        elseif P.state == global.PLANT_STATES.RIPE then
            love.graphics.draw(P.spr, P.ripeSpr[2], P.x+2, P.y-20)
        end
    end

    local allPlanters = global.PLANTER_SPRITE           -- draw planter base
    if P.isHovered then
        love.graphics.draw(allPlanters, P.baseHoverQuad, P.x, P.y)
    else
        love.graphics.draw(allPlanters, P.baseQuad, P.x, P.y)
    end


    if P.state == global.PLANT_STATES.SEEDLING then
        love.graphics.draw(P.spr, P.seedlingSpr[1], P.x+2, P.y-20)
    elseif P.state == global.PLANT_STATES.JUVENILE then
        love.graphics.draw(P.spr, P.juvenileSpr[1], P.x+2, P.y-20)
    elseif P.state == global.PLANT_STATES.MATURE then
        love.graphics.draw(P.spr, P.matureSpr[1], P.x+2, P.y-20)
    elseif P.state == global.PLANT_STATES.RIPE then
        love.graphics.draw(P.spr, P.ripeSpr[1], P.x+2, P.y-20)
    end


    if P.isWatered and P.state ~= global.PLANT_STATES.EMPTY then
        love.graphics.draw(global.ALL_ICONS, global.WATERED_ICON, P.x+3, P.y-7)
    elseif not P.isWateted and P.state ~= global.PLANT_STATES.EMPTY then
        love.graphics.draw(global.ALL_ICONS, global.NOT_WATERED_ICON, P.x+3, P.y-7)
    end
end


return plant