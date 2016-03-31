--[[
Copyright (c) 2016 Ayden Williams

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

   1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.

   2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.

   3. This notice may not be removed or altered from any source
   distribution.
--]]

function love.conf(t)
t.identity=nil
t.version="0.10.0"
t.console=true
TU={v="A00.43",t="Turbo-Universe (With mods)"}
t.window.title=TU.t
t.window.icon=nil
t.window.width=900
t.window.height=600
t.window.borderless=false
t.window.resizable=false
t.window.minwidth=700
t.window.minheight=500
t.window.fullscreen=false
t.window.fullscreentype="desktop"
t.window.vsync=true
t.window.fsaa=1
t.window.display=1
t.window.highdpi=true
t.window.srgb=false
t.window.x=350
t.window.y=400
t.modules.audio=true
t.modules.event=true
t.modules.graphics=true
t.modules.image=true
t.modules.joystick=true
t.modules.keyboard=true
t.modules.math=true
t.modules.mouse=true
t.modules.physics=true
t.modules.sound=true
t.modules.system=true
t.modules.timer=true
t.modules.window=true
t.modules.thread=true
end