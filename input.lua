local input = {}


-----------------------------
-- loops through every "object" (which are just tables),
-- to see whether it was clicked/hovered
-----------------------------
function input.update(x, y)
    for i, P in ipairs(global.PLANTS) do                        -- this feels terribly optimized
        plant.checkForHover(P, input.isMouseWithinRect(x, y, P))    -- rethink
    end
end


function input.mousePressed(x, y)

    -- testing: water plant when clicked
    -- should block this out when plantSelect is active
    for i, v in ipairs(global.PLANTS) do
        if input.isMouseWithinRect(x, y, v) then
            plant.onClick(v)
            global.SELECTED_PLANT = i
            global.DEBUG_MSG = "selected plant: " .. global.SELECTED_PLANT
        end
    end

    -- testing: move to new day when bed is clicked
    for i,v in ipairs(global.INTERACTABLES) do
        if input.isMouseWithinRect(x, y, v) then
            interactable.onClick(v)
        end
    end

    for i,v in pairs(global.UIS) do
        if input.isMouseWithinRect(x, y, v) then
            v.onClick(x, y)
        end
    end
end



-----------------------------
-- takes any table (T) as an argument
-- table must have x, y, width, height
-----------------------------
function input.isMouseWithinRect(xMouse, yMouse, T)
    S = global.SCALE

    if xMouse < T.x*S or xMouse > (T.x + T.w)*S then
        return false
    end
    if yMouse < T.y*S or yMouse > (T.y + T.h)*S then
        return false
    end
    return true
end



return input