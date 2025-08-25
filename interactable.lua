local interactable = {}


interactable.bed = {
    name = "bed",
    onClick = function() event.startNewDay() end,
    description = "new day",
    x = 107,
    y = 84,
    w = 40,
    h = 15
}


-----------------------------
-- general functions
-----------------------------
function interactable.onClick(I)
    I.onClick()
end


function interactable.draw(I)
    love.graphics.rectangle("line", I.x, I.y, I.w, I.h)
    love.graphics.print(I.description, I.x+3, I.y+3)
end




return interactable