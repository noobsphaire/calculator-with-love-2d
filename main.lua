local num1, num2 = "", "" 
local operator = ""
local result = "" 
local calculating = false 

-- reset
function reset()
    num1, num2, operator, result = "", "", "", ""
end

-- calculate
function calculate()
    local n1 = tonumber(num1)
    local n2 = tonumber(num2)

    if operator == "+" then
        result = tostring(n1 + n2)
    elseif operator == "-" then
        result = tostring(n1 - n2)
    elseif operator == "*" then
        result = tostring(n1 * n2)
    elseif operator == "/" then
        if n2 == 0 then
            result = "Error: Div by 0"
        else
            result = tostring(n1 / n2)
        end
    else
        result = "Error"
    end
end


function love.load()
    love.window.setTitle("noobspharioos ahh calc")
    love.window.setMode(400, 830)
end

function love.textinput(t)
    if calculating then
        reset()
        calculating = false
    end
    if operator == "" then
        num1 = num1 .. t
    else
        num2 = num2 .. t
    end
end

function love.keypressed(key)
    if key == "return" then
        if num1 ~= "" and num2 ~= "" then
            calculate()
            calculating = true
        end
    elseif key == "backspace" then
        if operator == "" then
            num1 = num1:sub(1, -2)
        else
            num2 = num2:sub(1, -2)
        end
    elseif key == "+" or key == "-" or key == "*" or key == "/" then
        if num1 ~= "" then
            operator = key
        end
    elseif key == "escape" then
        reset()
    end
end

function love.draw()
    -- make the background
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    -- make the display
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 50, 50, 300, 80)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(num1 .. operator .. num2, 50, 50, 300, "center")
    
    -- display results
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("fill", 50, 150, 300, 80)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(result, 50, 150, 300, "center")
    
    -- make buttons
    local buttons = {
        { "7", 50, 250 }, { "8", 150, 250 }, { "9", 250, 250 },
        { "4", 50, 350 }, { "5", 150, 350 }, { "6", 250, 350 },
        { "1", 50, 450 }, { "2", 150, 450 }, { "3", 250, 450 },
        { "0", 50, 550 }, { "+", 150, 550 }, { "-", 250, 550 },
        { "*", 50, 650 }, { "/", 150, 650 }, { "C", 250, 650 },
        { "=", 50, 750 }
    }

    for _, btn in ipairs(buttons) do
        love.graphics.setColor(0.8, 0.8, 0.8)
        love.graphics.rectangle("fill", btn[2], btn[3], 80, 80)
        love.graphics.setColor(0, 0, 0)
        love.graphics.printf(btn[1], btn[2], btn[3] + 30, 80, "center")
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        -- button press check
        local buttons = {
            { "7", 50, 250 }, { "8", 150, 250 }, { "9", 250, 250 },
            { "4", 50, 350 }, { "5", 150, 350 }, { "6", 250, 350 },
            { "1", 50, 450 }, { "2", 150, 450 }, { "3", 250, 450 },
            { "0", 50, 550 }, { "+", 150, 550 }, { "-", 250, 550 },
            { "*", 50, 650 }, { "/", 150, 650 }, { "C", 250, 650 },
            { "=", 50, 750 }
        }

        for _, btn in ipairs(buttons) do
            if x >= btn[2] and x <= btn[2] + 80 and y >= btn[3] and y <= btn[3] + 80 then
                if btn[1] == "C" then
                    reset()
                elseif btn[1] == "=" then
                    if num1 ~= "" and num2 ~= "" then
                        calculate()
                        calculating = true
                    end
                elseif btn[1] == "+" or btn[1] == "-" or btn[1] == "*" or btn[1] == "/" then
                    if num1 ~= "" then
                        operator = btn[1]
                    end
                else
                    love.textinput(btn[1])
                end
            end
        end
    end
end
