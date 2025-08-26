local global = {}


function global.load()

    -----------------------------
    -- stuff that exists in the main room atm
    -- remember, all "stuff" are just tables
    -- not classes!!!!!
    -----------------------------
    global.PLANTS = {
        {},                 -- plant 1
        {},                 -- plant 2 ..
        {}
    }
    global.INTERACTABLES = {}
    global.UIS = {
        PLANT_SELECT = {},
        RESOURCES = {}
    }


    -----------------------------
    -- positional offsets for all plants (dictates x and y)
    -- quads for planter sprites
    -----------------------------
    global.PLANT_OFFSETS = {
        {x= 66, y= 46},             -- position for plant 1
        {x=107, y= 42},             -- position for plant 2
        {x=150, y= 46}               -- and so on..
    }
    global.PLANTER_SPRITE = love.graphics.newImage("res/png/planters.png")
    global.PLANTER_QUAD = {
        textureAtlas.getQuad(global.PLANTER_SPRITE, 48, 32, 2, 1),
        textureAtlas.getQuad(global.PLANTER_SPRITE, 48, 32, 1, 1),
        textureAtlas.getQuad(global.PLANTER_SPRITE, 48, 32, 4, 1)
    }
    global.PLANTER_QUAD_HOVER = {
        textureAtlas.getQuad(global.PLANTER_SPRITE, 48, 32, 2, 2),
        textureAtlas.getQuad(global.PLANTER_SPRITE, 48, 32, 1, 2),
        textureAtlas.getQuad(global.PLANTER_SPRITE, 48, 32, 4, 2)
    }



    -----------------------------
    -- resources to manage
    -----------------------------
    global.O2 = 300
    global.WATER = 500
    global.FOOD = 100

    global.O2_CONSUMPTION = 10          -- consumption per day
    global.WATER_CONSUMPTION = 10
    global.FOOD_CONSUMPTION = 10


    -----------------------------
    -- list of all plants, used in ui_plantSelect
    -- plant.lua has a keyToPlant converter table
    -- i really dont like how all this is organized. rethink
    -----------------------------
    global.ALL_PLANTS = {
        "tomato", "lettuce", "bokChoy"
    }


    -----------------------------
    -- ian suggestion:
    -- using global vars to keep track of states
    -- the integers are just placeholders, not meant to be used
    --
    -- kinda similar to enums??
    -- ensuring a state can only be one of x types
    -----------------------------
    global.PLANT_STATES = {
        EMPTY = 1,
        SEEDLING = 2,
        JUVENILE = 3,
        MATURE = 4,
        RIPE = 5
    }

    global.HARVEST_TYPES = {
        SINGLE = 1,
        MULTIPLE = 2,
        COME_AGAIN = 3
    }


    -----------------------------
    -- other stuff
    -- break into smaller categories in the future
    -----------------------------
    global.SCALE = 5            -- sprite size multiplier
    global.DAYS = 1
    global.SELECTED_PLANT = nil


    -----------------------------
    -- graphics stuff
    -- rethink where to place them
    -----------------------------
    global.BG_SPRITE = love.graphics.newImage("res/png/bg_1.png")
    global.BG_COLOR = {16/255, 18/255, 32/255}
    global.UI_COLOR = {30/255, 255/255, 197/255}
    global.FONT1 = love.graphics.newImageFont("res/font/font1.png",
        " abcdefghijklmnopqrstuvwxyz" ..
        "0123456789.,!?-+/▷◁:…" )

    global.ALL_ICONS = love.graphics.newImage("res/png/ui_icons.png")
    global.WATERED_ICON = textureAtlas.getQuad(global.ALL_ICONS, 16, 16, 6, 1)
    global.NOT_WATERED_ICON = textureAtlas.getQuad(global.ALL_ICONS, 16, 16, 5, 1)


    -----------------------------
    -- debug variables
    -----------------------------
    global.DEBUG_MSG = ""


end


return global