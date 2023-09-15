io.stdout:setvbuf( "no" )

function love.load()
    love.window.setFullscreen(true)
    -- local gridXCount = 20
    -- local gridYCount = 15
    cellSize = 15
    gridXCount = love.graphics.getWidth() / cellSize
    gridYCount = love.graphics.getHeight() / cellSize
    
    snakeSegments = {
        {x = 3, y = 1},
        {x = 2, y = 1},
        {x = 1, y = 1},
    }
    
    timer = 0
    
    direction = {'right'}
end

function love.update(dt)
    timer = timer + dt
    
    if timer > 0.15 then
        timer = 0
        print('tick')
        
        if #direction > 1 then
            table.remove(direction, 1)
        end
        
        local nextXPosition = snakeSegments[1].x
        local nextYPosition = snakeSegments[1].y
        
        if direction[1] == 'right' then
            nextXPosition = nextXPosition + 1
            if nextXPosition > gridXCount then
                nextXPosition = 1
            end
        elseif direction[1] == 'left' then
            nextXPosition = nextXPosition - 1
            if nextXPosition < 1 then
                nextXPosition = gridXCount
            end
        elseif direction[1] == 'down' then
            nextYPosition = nextYPosition + 1
            if nextYPosition > gridYCount then
                nextYPosition = 1
            end
        elseif direction[1] == 'up' then
            nextYPosition = nextYPosition - 1
            if nextYPosition < 1 then
                nextYPosition = gridYCount
            end
        end
        
        table.insert(snakeSegments, 1, {
            x = nextXPosition,
            y = nextYPosition
        })
        table.remove(snakeSegments)
    end
end

function love.draw()
    
    love.graphics.setColor(.28, .28, .28)
    love.graphics.rectangle(
        'fill',
        0,
        0,
        gridXCount * cellSize,
        gridYCount * cellSize
    )
    
    for segmentIndex, segment in ipairs(snakeSegments) do
        love.graphics.setColor(.6, 1, .32)
        love.graphics.rectangle(
            'fill',
            (segment.x - 1) * cellSize,
            (segment.y - 1) * cellSize,
            cellSize - 1,
            cellSize - 1
        )
    end
    
    --Debug
    for dirIdx, dir in ipairs(direction) do
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(
            'direction['..dirIdx..']: '..dir, 15, 15 * dirIdx
        )
    end
end

function love.keypressed(key)
    if key == 'right'
    and direction[#direction] ~= 'right'
    and direction[#direction] ~= 'left' then
        table.insert(direction, 'right')
    
    elseif key == 'left'
    and direction[#direction] ~= 'left'
    and direction[#direction] ~= 'right' then
        table.insert(direction, 'left')
    
    elseif key == 'down'
    and direction[#direction] ~= 'down'
    and direction[#direction] ~= 'up' then
        table.insert(direction, 'down')
        
    elseif key == 'up'
    and direction[#direction] ~= 'up'
    and direction[#direction] ~= 'down' then
        table.insert(direction, 'up')
    end
end