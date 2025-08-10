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
        if input.isMouseWithinRect(x, y, v) == true then
            plant.onClick(v)
            global.SELECTEDPLANT = i
            global.debugMsg = "selected plant: " .. global.SELECTEDPLANT
        end
    end

    -- testing: move to new day when bed is clicked
    for i,v in ipairs(global.INTERACTABLES) do
        if input.isMouseWithinRect(x, y, v) == true then
            interactable.onClick(v)
        end
    end

    for i,v in pairs(global.UIS) do
        if input.isMouseWithinRect(x, y, v) == true then
            v.onClick(x, y)
        end
    end
end



-----------------------------
-- takes any table (T) as an argument
-- table must have x, y, width, height
-----------------------------
function input.isMouseWithinRect(xmouse, ymouse, T)
    if xmouse < T.x or xmouse > (T.x + T.w) then
        return false
    end
    if ymouse < T.y or ymouse > (T.y + T.h) then
        return false
    end
    return true
end



return input