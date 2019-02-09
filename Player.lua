Player = {}

Player.new = function()
  local self = {}

  self.x = 100
  self.y = 130
  self.l = 50

  self.draw = function()
    love.graphics.rectangle("fill", self.x - self.l / 2, self.y - self.l / 2, self.l, self.l)
  end

  self.update = function()
    self.x = love.mouse.getX()
  end

  return self
end
