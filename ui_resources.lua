local UI_resources = {}


UI_resources.table = {
    name = "resources",
    isActive = true,
    draw = function() UI_resources.draw() end,
    onClick = function() return end,

    x = 800,
    y = 400,
    w = 0,
    h = 0,
    yMarg = 30
}


-----------------------------
-- draw
-----------------------------
function UI_resources.draw()
    if not global.UIS.RESOURCES.isActive then
        return
    end

    R = global.UIS.RESOURCES
    love.graphics.print("Day " .. global.DAYS, R.x, R.y)
    love.graphics.print("Oxygen: " .. global.O2, R.x, (R.y + R.yMarg*1))
    love.graphics.print("Water: " .. global.WATER, R.x, (R.y + R.yMarg*2))
    love.graphics.print("Food: " .. global.FOOD, R.x, (R.y + R.yMarg*3))
end


return UI_resources