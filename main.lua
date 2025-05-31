-- Click the Balls Game in Love2D
-- By ChatGPT — Well-commented to help you learn!

-- Ball settings
local balls = {}              -- Table to hold all active balls
local ballRadius = 20         -- Radius of each ball
local ballLifetime = 2        -- How long each ball lasts (in seconds)
local spawnInterval = 1       -- Time between spawning new balls

-- Game settings
local score = 0               -- Player's score
local timer = 0               -- Timer to track ball spawning

function love.load()
    love.window.setTitle("Click the Balls!")
    love.window.setMode(800, 600)
    font = love.graphics.newFont(32)
    love.graphics.setFont(font)
end

function love.update(dt)
    -- Update the spawn timer
    timer = timer + dt
    if timer >= spawnInterval then
        timer = 0
        spawnBall()  -- Add a new ball
    end

    -- Update each ball's lifetime
    for i = #balls, 1, -1 do
        local ball = balls[i]
        ball.time = ball.time - dt

        if ball.time <= 0 then
            -- Ball expired: remove it and subtract a point
            table.remove(balls, i)
            score = score - 1
        end
    end
end

function love.draw()
    -- Draw the score at the top center
    love.graphics.printf("Score: " .. score, 0, 10, love.graphics.getWidth(), "center")

    -- Draw all balls
    for _, ball in ipairs(balls) do
        love.graphics.setColor(ball.r, ball.g, ball.b)
        love.graphics.circle("fill", ball.x, ball.y, ballRadius)
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then -- left mouse button
        for i = #balls, 1, -1 do
            local ball = balls[i]
            local dx = x - ball.x
            local dy = y - ball.y
            local distance = math.sqrt(dx * dx + dy * dy)

            if distance <= ballRadius then
                -- Ball clicked: remove it and increase score
                table.remove(balls, i)
                score = score + 1
                break -- Only remove one ball per click
            end
        end
    end
end

-- Function to spawn a new ball at a random location with a random color
function spawnBall()
    local ball = {
        x = math.random(ballRadius, love.graphics.getWidth() - ballRadius),
        y = math.random(ballRadius + 50, love.graphics.getHeight() - ballRadius), -- leave space for score
        r = math.random(),
        g = math.random(),
        b = math.random(),
        time = ballLifetime
    }
    table.insert(balls, ball)
end
