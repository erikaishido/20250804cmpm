local input = {}


-----------------------------
-- loops through every "object" (which are just tables),
-- to see whether it was clicked/hovered
-----------------------------


function input.update(x, y)
end


function input.mousePressed(x, y)

    -- testing: water plant when clicked
    -- should block this out when plantSelect is active
    for i, v in ipairs(global.PLANTS) do
        if input.isMouseWithinRect(x, y, v) then
            plant.onClick(v)
            global.SELECTED_PLANT = i
            global.debugMsg = "selected plant: " .. global.SELECTED_PLANT
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
    if xMouse < T.x or xMouse > (T.x + T.w) then
        return false
    end
    if yMouse < T.y or yMouse > (T.y + T.h) then
        return false
    end
    return true
end



return input