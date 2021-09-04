pico-8 cartridge // http://www.pico-8.com
version 32
__lua__

ground = 100

Actor = {}

function Actor.new(x, y, gid)
    local a = {
        x = x,
        y = ground - 8,
        y_prev = ground - 8,
        width = 8,
        height = 8,
        gid = gid,
        hitbox = {
            left = 0,
            top = 0,
            right = 0,
            bottom = 0
        },
        can_jump = true,
        jump_frames = 0,
        F = -1
    }
    a.update_hitbox = function(self)
        self.hitbox.left = self.x
        self.hitbox.top = self.y
        self.hitbox.right = self.x + self.width
        self.hitbox.bottom = self.y + self.height
        end
    a.move = function(self) end
    a.draw = function(self) draw_actor(self) end
    a.actor_ground = ground - a.height
    return a
end

Player = {}

function Player.new(x, y, gid)
    local obj = Actor.new(x, y, gid)
    obj.move = function(self) 
        move_by_controller(self) 
        end
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

function jump_update(a)
    if a.can_jump then
        return
    end

    y_tmp = a.y
    a.y += (a.y - a.y_prev) + a.F
    a.y_prev = y_tmp
    a.F = -1

    if a.y > ground then
        a.y = ground
        a.can_jump = True
    end
end

function move_by_controller(a)
    if btn(0) then 
        a.x -= 1 
        if a.x < 0 then
            a.x = 0
        end
    end
    if btn(1) then 
        a.x += 1 
        if a.x > 128 - 8 then
            a.x = 128 - 8
        end
    end
    if btn(2) then 
        a.y_prev = a.y
        a.y -= 0 
    end
    if btn(3) then 
        a.y_prev = a.y
        a.y += 0 
    end
    if btn(4) then 
        if a.can_jump then
            a.can_jump = false
            a.F = -3
        end
    end
    jump_update(a)
end

function distance(x1,y1,x2,y2)
 return sqrt((x1-x2)^2+(y1-y2)^2)
end

function collision(a1, a2)
 if distance(a1.x, a1.y, a2.x, a2.y) < 4 then
  return true
 else
  return false
 end
end

p = Player.new(10, 0, 1)
e = Enemy.new(100, 0, 0)

function _update()
    p:move()
    e:move()
    if collision(p, e) then
        sfx(0)
    end
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
__sfx__
000100000f0501a0501f0502305023050230502205021050200501f0501d0501b05015050130500f0500905007050000000000000000000000000000000000000000000000000000000000000000000000000000
