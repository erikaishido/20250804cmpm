-----------------------------
-- global modules
-----------------------------
global = require("global")                  -- stores all global values
plant = require("plant")                    -- all plant stuff
input = require("input")                    -- reads user input
event = require("event")                    -- events
interactable = require("interactable")      -- bed, computer, npc etc.
resources = require("resources")            -- UI. displays oxygen, water, food
plantSelect = require("plantSelect")        -- UI. lets you select a seed to plant


-----------------------------
-- booting up the bad boy
-----------------------------
function love.load()

    plant.initPlantData()

    global.PLANTS[1] = plant.new(1, "tomato")              -- populate plants at init
    global.PLANTS[2] = plant.new(2, "tomato")
    global.PLANTS[3] = plant.new(3, "")

    table.insert(global.INTERACTABLES, interactable.bed)    -- only 1 interactable for now

    global.UIS.resources = resources.table                  -- populate ui tables
    global.UIS.plantSelect = plantSelect.table
end


-----------------------------
-- user input handling
-----------------------------
function love.update()
    local xmouse, ymouse = love.mouse.getPosition()
    input.update(xmouse, ymouse)
end


function love.mousepressed(x, y, button)
    if button ~= 1 then           --block out non-left clicks
        return
    end
    input.mousePressed(x, y)
end


-----------------------------
-- ye olde draw
-----------------------------
function love.draw()

    for i,v in ipairs(global.PLANTS) do
        plant.draw(v)
    end

    for i,v in ipairs(global.INTERACTABLES) do
        interactable.draw(v)
    end

    for i,v in pairs(global.UIS) do
        v.draw()
    end


    -- debug stuff
    love.graphics.print(global.debugMsg, 100, 50)
    -- plant 1 stats (for debug)
    local i = 1
    for k, v in pairs(global.PLANTS[1]) do
        love.graphics.print(k .. ": " .. tostring(v), 40, 100+i)
        i = i + 30
    end


end