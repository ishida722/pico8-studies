pico-8 cartridge // http://www.pico-8.com
version 32
__lua__

ground = 100

Actor = {}

function Actor.new(x, y, gid)
    local a = {
        x = x,
        y = ground - 8,
        width = 8,
        height = 8,
        gid = gid,
    }
    a.move = function(self) end
    a.draw = function(self) draw_actor(self) end
    a.actor_ground = ground - a.height
    return a
end

Player = {}

function Player.new(x, y, gid)
    local obj = Actor.new(x, y, gid)
    obj.move = function(self) move_by_controller(self) end
    return obj
end

Enemy = {}

function Enemy.new(x, y, gid)
    local obj = Actor.new(x, y, gid)
    obj.direction = 1
    obj.move =
    function(self)
        self.x += self.direction
        if self.x < 10 then
            self.direction = 1
        end
        if self.x > 110 then
            self.direction = -1
        end
    end
    return obj
end

function draw_actor(a)
    spr(a.gid, a.x, a.y)
end

function move_by_controller(a)
    if btn(0) then 
        a.x -= 1 
    end
    if btn(1) then 
        a.x += 1 
    end
    if btn(2) then 
        a.y-=0 
    end
    if btn(3) then 
        a.y+=0 
    end
    -- if btn(4) then 
    --     a.y-=1
    -- else
    --     a.y+=1 
    -- end
    -- if a.y >= a.actor_ground then
    --     y = a.actor_ground
    -- end
end

function check_hit(a1, a2):
end

p = Player.new(10, 0, 1)
e = Enemy.new(100, 0, 0)

function _update()
    p:move()
    e:move()
end

function _draw()
    rectfill(0, 0, 127, 127, 12)
    rectfill(0, 100, 127, 127, 8)
    p:draw()
    e:draw()
end


__gfx__
00000000000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009999000008880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700099999900888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000098998908888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000099999900888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700099999900088888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000099999900008880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999990000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
