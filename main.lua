require("Player")
require("Block")
function love.load()
  bgcolor = 0
  everythingelsecolor = 1
  gap = 100
  player = Player.new()
  WW = love.graphics.getWidth()
  WH = love.graphics.getHeight()
  love.mouse.setVisible(false)
  speed = 200
  score = 0

  sound = love.audio.newSource("loop.wav", "stream")
  sound:setLooping(true)
  sound:play()

  font = love.graphics.newFont(75)
  textscore = love.graphics.newText(font, score)

  blocks = {}
  for i = 1, 3 do
    local block = Block.new(i * 300)
    table.insert(blocks, block)
  end
  flipper = 1.5

  playing = false
  fontok = love.graphics.newFont(35)
  bigtext = love.graphics.newText(fontok, "space to start")
end

function love.draw()
  love.graphics.print("space to start", 0, 0)
  love.graphics.print("move player by moving cursor", 0, 25)
  love.graphics.print("25 points to win", 0, 50)
  if playing then
    love.graphics.setColor(bgcolor, bgcolor, bgcolor)
    love.graphics.rectangle("fill", 0, 0, WW, WH)
    love.graphics.setColor(everythingelsecolor, everythingelsecolor, everythingelsecolor)
    player.draw()
    for i = 1, 3 do
      blocks[i].draw()
    end
  else
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(bigtext, WW / 2 - bigtext:getWidth() / 2, WH / 2 - bigtext:getHeight() / 2)
  end
  love.graphics.draw(textscore, WW / 2 - textscore:getWidth() / 2, 25)
end

function love.update(dt)
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
  if playing then
    speed = speed + dt * 3.5
    player.update()
    flipper = flipper - dt
    if flipper < 0 then
      if bgcolor == 0 then
        everythingelsecolor = 0
        bgcolor = 1
      else
        everythingelsecolor = 1
        bgcolor = 0
      end
      flipper = 1.5
    end
    for i = 1, 3 do
      blocks[i].update(dt)
    end
  end
  if love.keyboard.isDown("space") and not playing then
    playing = true
    blocks = {}
    for i = 1, 3 do
      local block = Block.new(i * 300)
      table.insert(blocks, block)
    end
    score = 0
    textscore = love.graphics.newText(font, score)
    sound:play()
  end
  if score == 25 then
    playing = false
    bigtext = love.graphics.newText(fontok, "you win!")
    sound:stop()
  end
end
