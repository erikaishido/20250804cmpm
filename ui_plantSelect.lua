local UI_plantSelect = {}


UI_plantSelect.table = {
    name = "plantSelect",
    isActive = false,
    pageIndex = 1,
    draw = function() UI_plantSelect.draw() end,
    onClick = function(x, y) UI_plantSelect.onClick(x, y) end,

    x = 800,
    y = 120,
    w = 200,
    h = 200
}


UI_plantSelect.buttons = {         -- add this to plantSelect.table?
    prev = {                    -- or just keep it as its own thing??
        func = function() UI_plantSelect.flipPage(-1) end,
        text = "<-",
        x = 830, y = 270, w = 30, h = 30
    },
    next = {
        func = function() UI_plantSelect.flipPage(1) end,
        text = "->",
        x = 930, y = 270, w = 30, h = 30
    },
    plant = {
        func = function()
                event.plantSeed() end,
        text = "plant seed",
        x = 860, y = 230, w = 100, h = 30
    },
    close = {
        func = function() event.closeUI("PLANT_SELECT") end,
        text = "x",
        x = 790, y = 110, w = 30, h = 30
    }
}


-----------------------------
-- on-click behaviour
-----------------------------
function UI_plantSelect.onClick(x, y)
    if not global.UIS.PLANT_SELECT.isActive then
        return
    end

    for i,button in pairs(UI_plantSelect.buttons) do
        if input.isMouseWithinRect(x, y, button) then
            button.func()
        end
    end
end


function UI_plantSelect.flipPage(dir)                   -- called from prev/next buttons
    local page = global.UIS.PLANT_SELECT.pageIndex       -- readability
    if page+dir <= 0 or page+dir > #global.ALL_PLANTS then
        return
    end

    global.UIS.PLANT_SELECT.pageIndex = page + dir
end


-----------------------------
-- draw
-----------------------------
function UI_plantSelect.draw()
    if not global.UIS.PLANT_SELECT.isActive then
        return
    end

    local PS = global.UIS.PLANT_SELECT
    love.graphics.rectangle("line", PS.x, PS.y, PS.w, PS.h)


    -- draw buttons
    for i,B in pairs(UI_plantSelect.buttons) do
        love.graphics.rectangle("line", (B.x), (B.y), B.w, B.h)
        love.graphics.print(B.text, (B.x + (B.w/3)), (B.y + (B.h/3)))
    end
    -- draw page index 
    love.graphics.print(PS.pageIndex .. "/" .. #global.ALL_PLANTS, 880, 275)
    -- draw plant name that you're selecting
    plantName = global.ALL_PLANTS[PS.pageIndex]
    love.graphics.print(plantName, 880, 170)
end


return UI_plantSelect