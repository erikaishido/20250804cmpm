local global = {}


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
-- positional offsets for all plants
-- dictates x and y
-----------------------------
global.PLANT_OFFSETS = {
    {x= 200, y=300},             -- position for plant 1
    {x= 400, y=300},             -- position for plant 2
    {x= 600, y=300}               -- and so on..
}


-----------------------------
-- resources to manage
-----------------------------
global.O2 = 100
global.WATER = 2000
global.FOOD = 100

global.O2_CONSUMPTION = 10
global.WATER_CONSUMPTION = 10
global.FOOD_CONSUMPTION = 10


-----------------------------
-- list of all plants, used for ui_plantSelect
-- plant.lua has a keyToPlant converter table
-- i really dont like how all this is organized. rethink
-----------------------------
global.ALL_PLANTS = {
    "tomato", "lettuce"
}


-----------------------------
-- ian suggestion:
-- using global vars to record states
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
    MULTIPLE = 2
}


-----------------------------
-- other stuff
-----------------------------
global.DAYS = 1
global.SELECTED_PLANT = 0



-----------------------------
-- debug variables
-----------------------------
global.debugMsg = "debug message"


return global