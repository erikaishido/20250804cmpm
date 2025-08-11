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
    PLANTSELECT = {},
    RESOURCES = {}
}


-----------------------------
-- positional offsets for all plants
-- dictates x and y
-----------------------------
global.PLANTOFFSETS = {
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

global.O2CSP = 10       -- csp stands for "consumption"
global.WATERCSP = 10    -- bad naming. rethink?
global.FOODCSP = 10


-----------------------------
-- list of all plants, used for ui_plantSelect
-- plant.lua has a keyToPlant converter table
-- i really dont like how all this is organized. rethink
-----------------------------
global.ALLPLANTS = {
    "tomato", "lettuce"
}


-----------------------------
-- ian suggestion:
-- using integers to record states,
-- instead of using literal strings
-----------------------------
global.PLANTSTATES = {
    EMPTY = 1,
    SEEDLING = 2,
    JUVENILE = 3,
    MATURE = 4,
    RIPE = 5
}

global.HARVESTTYPES = {
    SINGLE = 1,
    MULTIPLE = 2
}


-----------------------------
-- other stuff
-----------------------------
global.DAYS = 1
global.SELECTEDPLANT = 0



-----------------------------
-- debug variables
-----------------------------
global.debugMsg = "debug message"


return global