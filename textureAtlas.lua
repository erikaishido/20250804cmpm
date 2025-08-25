local textureAtlas = {}

-----------------------------
-- returns a quad at given row/col position
-- update: are row/col reversed??????
--
-- takes any table (T) as an argument
-- table must contain atlas, width, height
-- position (row, col) passed as arguments??
-----------------------------
function textureAtlas.getQuad(img, w, h, row, col)
    local quad = love.graphics.newQuad(w*(row-1), h*(col-1), w, h, img:getDimensions())
    return quad
end

-----------------------------
-- directly calls newQuad more or less
-- used to get a quad that's e.g. two regular quads long
-- ugly solution, rethink this later
-----------------------------
function textureAtlas.getIrregularQuad(img, x, y, w, h)
    local quad = love.graphics.newQuad(x, y, w, h, img)
    return quad
end






return textureAtlas