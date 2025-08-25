local UI_plantSelect = {}


-----------------------------
-- load (initialize?) variables
-----------------------------

function UI_plantSelect.load()

    UI_plantSelect.table = {
        name = "plantSelect",
        isActive = false,
        pageIndex = 1,
        baseSpr = love.graphics.newImage("res/png/ui_psBox.png"),
        iconSpr = love.graphics.newImage("res/png/ui_icons.png"),
        draw = function() UI_plantSelect.draw() end,
        onClick = function(x, y) UI_plantSelect.onClick(x, y) end,

        x = 167,
        y = 15,
        w = 64,
        h = 80
    }


    UI_plantSelect.buttons = {         -- add this to plantSelect.table?
        prev = {                    -- or just keep it as its own thing??
            func = function() UI_plantSelect.flipPage(-1) end,
            text = "<-",
            x = 177, y = 80, w = 11, h = 11,
            quad = textureAtlas.getQuad(UI_plantSelect.table.iconSpr, 16, 16, 2, 1)
        },
        next = {
            func = function() UI_plantSelect.flipPage(1) end,
            text = "->",
            x = 213, y = 80, w = 11, h = 11,
            quad = textureAtlas.getQuad(UI_plantSelect.table.iconSpr, 16, 16, 2, 1),
            isFlipped = true
        },
        plant = {
            func = function() event.plantSeed() end,
            text = "plant seed",
            x = 185, y = 66, w = 32, h = 13,
            --quad = textureAtlas.getQuad(UI_plantSelect.table.iconSpr, 16, 16, 3, 1)
            quad = textureAtlas.getIrregularQuad(UI_plantSelect.table.iconSpr, 32, 0, 32, 16)
        },
        close = {
            func = function() event.closeUI("PLANT_SELECT") end,
            text = "x",
            x = 167, y = 15, w = 11, h = 11,
            quad = textureAtlas.getQuad(UI_plantSelect.table.iconSpr, 16, 16, 1, 1)
        }
    }

end


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
    --love.graphics.rectangle("line", PS.x, PS.y, PS.w, PS.h)
    love.graphics.draw(PS.baseSpr, PS.x, PS.y)


    -- draw buttons
    for i,B in pairs(UI_plantSelect.buttons) do
        love.graphics.draw(PS.iconSpr, B.quad, B.x, B.y)
    end

    love.graphics.setColor(global.UI_COLOR)
    -- draw page index
    love.graphics.print(PS.pageIndex .. "/" .. #global.ALL_PLANTS, 194, 83)
    -- draw plant name that you're selecting
    plantName = global.ALL_PLANTS[PS.pageIndex]
    love.graphics.print(plantName, 187, 26)
    love.graphics.setColor(1, 1, 1)
end


return UI_plantSelect