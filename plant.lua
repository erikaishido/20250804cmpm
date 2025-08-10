local plant = {}


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
    if P.isWatered == false then
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