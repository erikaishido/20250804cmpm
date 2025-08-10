local resources = {}


resources.table = {
    name = "resources",
    isActive = true,
    draw = function() resources.draw() end,
    onClick = function() return end,

    x = 800,
    y = 400,
    w = 0,
    h = 0,
    ymarg = 30
}


-----------------------------
-- draw
-----------------------------
function resources.draw()
    if global.UIS.resources.isActive == false then
        return
    end

    R = global.UIS.resources
    love.graphics.print("Day " .. global.DAYS, R.x, R.y)
    love.graphics.print("Oxygen: " .. global.O2, R.x, (R.y + R.ymarg*1))
    love.graphics.print("Water: " .. global.WATER, R.x, (R.y + R.ymarg*2))
    love.graphics.print("Food: " .. global.FOOD, R.x, (R.y + R.ymarg*3))
end


return resources