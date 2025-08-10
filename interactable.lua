local interactable = {}


interactable.bed = {
    name = "bed",
    onClick = function() event.startNewDay() end,
    description = "start new day",
    x = 300,
    y = 100,
    w = 150,
    h = 80
}


-----------------------------
-- general functions
-----------------------------
function interactable.onClick(I)
    I.onClick()
end


function interactable.draw(I)
    love.graphics.rectangle("line", I.x, I.y, I.w, I.h)
    love.graphics.print(I.description, I.x+30, I.y+20)
end




return interactable