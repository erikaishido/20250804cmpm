local plantC = {}


-----------------------------
-- C stands for constructor
-- this is a constructor function i think
-----------------------------
function plantC.new(planterIndex, plantType)

    local T = {}                                       -- make an empty table
    for key, value in pairs(plantC.base) do            -- copy base key:value pairs into table
        T[key] = value
    end

    T.x = global.PLANTOFFSETS[planterIndex].x          -- override xy depending on index
    T.y = global.PLANTOFFSETS[planterIndex].y


    if plantType == "" then                       -- RETHINK THIS??????????
        return T
    end

    T.state = "seedling"
    T.name = plantC.keyToPlant[plantType].name         -- override plant-dependant values

    return T
end


-----------------------------
-- called from main
-----------------------------
function plantC.initPlantData()

    plantC.base = {             -- base stats for plants
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


    plantC.tomato = {           -- specific paramerters for each plant
        name = "Tomato",
        harvestType = "multiple"
    }
    plantC.lettuce = {
        name = "Lettuce",
        harvestType = "single"
    }


    plantC.keyToPlant = {           -- long list of all plants
        tomato = plantC.tomato,     -- move all this to global?? consider
        lettuce = plantC.lettuce
    }

end





return plantC