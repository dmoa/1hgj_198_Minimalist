Block = {}

Block.new = function(y)
  local self = {}

  self.gonePast = false
  self.x1 = 0
  self.w = 200
  self.y = y
  self.x2 = self.x1 + self.w + gap
  self.w2 = WW - self.x2
  self.h = 50

  self.draw = function()
    love.graphics.rectangle("fill", self.x1, self.y, self.w, self.h)
    love.graphics.rectangle("fill", self.x2, self.y, self.w2, self.h)
  end

  self.update = function(dt)
    self.y = self.y - dt * speed
    if self.y < - 50 then
      self.y = WH + 250
      self.w = love.math.random(25, 550)
      self.x2 = self.x1 + self.w + gap
      self.w2 = WW - self.x2
      self.gonePast = false
    end
    if self.y < player.y and not self.gonePast then
      score = score + 1
      self.gonePast = true
      textscore = love.graphics.newText(font, score)
    end
    if player.y + player.l > self.y and player.y < self.y + self.h then
      if (player.x + player.l / 2 > self.x1 and player.x < self.x1 + self.w) or (player.x + player.l / 2 > self.x2 and player.x < self.x2 + self.w2) then
        playing = false
        bigtext = love.graphics.newText(fontok, "space to try again")
        speed = 200
        sound:stop()
      end
    end
  end

  return self
end
