local UI_resources = {}


UI_resources.table = {
    name = "resources",
    isActive = true,
    draw = function() UI_resources.draw() end,
    onClick = function() return end,

    x = 6,
    y = 6,
    w = 0,
    h = 0,
    yMarg = 15
}


-----------------------------
-- draw
-----------------------------
function UI_resources.draw()
    if not global.UIS.RESOURCES.isActive then
        return
    end

    R = global.UIS.RESOURCES
    love.graphics.print("day " .. global.DAYS, R.x, R.y)
    love.graphics.print("oxygen: " .. global.O2, R.x, (R.y + R.yMarg*1))
    love.graphics.print("water: " .. global.WATER, R.x, (R.y + R.yMarg*2))
    love.graphics.print("food: " .. global.FOOD, R.x, (R.y + R.yMarg*3))
end


return UI_resources