--[[
Copyright (c) 2016 Ayden Williams

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:
 https://durham.elearningontario.ca : ayden.williams : iwboj13
   1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.

   2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.

   3. This notice may not be removed or altered from any source
   distribution.
--]]
--[[ 
	Things to fix:
	
		Star moves as fast as the ostars.
		Make it so the song playing bar fades in and out. - and song stops @ 40 @ 60
	
	Things to do:
	
		Make it so the sfo & sf1 are tiled (seamlessly) and repea indefinitly.
		
		Make slider on bottom of screen showing currently playing song -DONE
--]]


require("physics") --Solo
require("extras") -- Solo
require("world") -- Needs physics.lua & extras.lua to function
require("supplies") -- Solo
require("camera") -- Solo


function love.load()
	print("Beginning love.load().\n")
    gamestate="Loading"
	
	windowWidth=love.graphics.getWidth()
	windowHeight=love.graphics.getHeight()
	
	print("H: "..windowHeight..", W: "..windowWidth)
	
    d,v,t,device=love.graphics.getRendererInfo()
    if device=="" or device==nil then
		os.execute("cscript scripts/err/err-00x002.vbs")
		errorRep="noDeviceDetected"
		love.event.quit()
	end
	
	neb=createNewWorld("space",neb)
    ship1=love.graphics.newImage("textures/ship1.png")
    ss1=love.graphics.newImage("textures/spaceStation1.png")
    sf1=love.graphics.newImage("textures/starfield1.png")
    sf2=love.graphics.newImage("textures/starfield2.png")
    sf3=love.graphics.newImage("textures/starfield3.png")
    sfo=love.graphics.newImage("textures/starfieldOverlay1.png")
    hud=love.graphics.newImage("textures/HUD~1.png")
    ast1=love.graphics.newImage("textures/Asteroid~3.png")
	crion=love.graphics.newImage("textures/Crion - HalfQuarterRes.png")
	star1=love.graphics.newImage("textures/Star1.png")
	
	eikona=love.audio.newSource("audio/ambience/EikonaYaM.wav")
	tomday=love.audio.newSource("audio/ambience/TomDayWWWTB.wav")
	uppermost=love.audio.newSource("audio/ambience/UppermostBL.wav")
	
    ast1XSpeed=love.math.random(5)
    ast1YSpeed=love.math.random(5)
	
	--Declare (global) Values--
	
	ast={
		ast1={x=0,y=0,xvel=0,yvel=0,rot=0,rotspeed=0}
	}
	
	music={
	
		playing="It doesn't matter, you will forget about it later anyways.",
		isSongPlaying=false,
		amount=2,
		songNumberPlaying=0,
		playSource=eikona,
		
		slider={
		
			pos={x=-10,y=570},
			speed=2,
			dimensions={h=20,w=1000},
			fadeOut=false,
			fadeRate=0.5,
			
			color={
			
				r=255,
				g=0,
				b=255,
				a=70
				
			},
			
			text={
			
				x=-200,
				y=573,
				
				color={
				
					r=255,
					g=255,
					b=255
					
				}
				
			}
			
		}
		
	}
	
	frames=0
	sfX=-960
	sfY=-540
	sfoX=sfX
	sfoY=sfY
	frDips=0
	cSpeed=2
	crionX=200
	crionY=200
	crionRotation=0
	crionRotationRate=0.001
	planetParalaxScale=50
	starParalaxScale=1
	star1X=200
	star1Y=200
	star1Rotation=0
	star1RotationRate=0.0001
	timer1=0
	sfParalaxScale=0.0005
	
	--Declare (global) Values--
	
	-- init values --
	
	crionY=crionY+50*cSpeed sfY=sfY+cSpeed sfoY=sfY*sfParalaxScale
	crionX=crionX+50*cSpeed sfX=sfX+cSpeed sfoX=sfX*sfParalaxScale
	
	-- init values --
	
	-- Start playing audio --
	
	love.audio.play(eikona)
	music.isSongPlaying=true

	-- Start playing audio --
	gamestate="Idle"
	
	print("Done love.load().\n")
end

function love.update(dt)

	--Camera && Paralax movement--
	
	if love.keyboard.isDown("w") then
	
		crionY=crionY+planetParalaxScale*dt*cSpeed
		star1Y=star1Y+starParalaxScale*dt*cSpeed
		sfY=sfY+cSpeed*dt
		paralax(sfoY,sfY,sfParalaxScale,dt)
		
	end
	
	if love.keyboard.isDown("a") then
	
		crionX=crionX+planetParalaxScale*dt*cSpeed
		star1X=star1X+starParalaxScale*dt*cSpeed
		sfX=sfX+cSpeed*dt
		paralax(sfoX,sfX,sfParalaxScale,dt)
	
	end
	
	if love.keyboard.isDown("s") then 
	
		crionY=crionY-planetParalaxScale*dt*cSpeed
		star1Y=star1Y-starParalaxScale*dt*cSpeed
		sfY=sfY-cSpeed*dt
		paralax(sfoY,sfY,sfParalaxScale,dt)
	
	end
	
	if love.keyboard.isDown("d") then
	
		crionX=crionX-planetParalaxScale*dt*cSpeed
		star1X=star1X-starParalaxScale*dt*cSpeed
		sfX=sfX-cSpeed*dt
		paralax(sfoX,sfX,sfParalaxScale,dt)
		
	end
	
	if love.keyboard.isDown(".") then cSpeed=cSpeed+0.5 end
	if love.keyboard.isDown(",") then cSpeed=cSpeed-0.5 end
	
	--Camera && Paralax movement--
	
	--Starfield repeat--
	
	--Starfield repeat--

	frames=frames+1
	crionRotation=crionRotation+crionRotationRate
	star1Rotation=star1Rotation+star1RotationRate
	deltaT=dt
	
	-- Slider --
	
	if music.playing=="" then music.playing="No song playing." end
	if music.isSongPlaying==false then love.audio.stop() else love.audio.play(eikona) end
	if music.slider.text.x > 1500 then
		music.slider.text.x=-500
	else
		music.slider.text.x=music.slider.text.x+music.slider.speed
	end
	
	if music.slider.fadeOut==true and music.slider.color.a > 0 then music.slider.color.a=music.slider.color.a-music.slider.fadeRate end
	if music.slider.color.a==0 then music.isSongPlaying=false else music.isSongPlaying=true end
	
	-- Slider --
end
 
function love.draw()
	
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	
	ship1X=width/2
	ship1Y=height/2
	
	love.graphics.draw(sf1,sfX,sfY,0,1.5,1.7)
	love.graphics.draw(sfo,sfoX,sfoY,0,1.5,1.7)
	love.graphics.draw(star1,star1X,star1Y,star1Rotation,2,2,125,125)
	love.graphics.draw(crion,crionX,crionY,crionRotation,1,1,125,125)
	
	
		
	camera:set()
	love.graphics.draw(ast1,ast.ast1.x,ast.ast1.y,ast.ast1.rot,1,1,64,64)
	-- Slider --
	if music.isSongPlaying==true then
		love.graphics.setColor(music.slider.color.r,music.slider.color.g,music.slider.color.b,music.slider.color.a)
		love.graphics.rectangle("fill",music.slider.pos.x,music.slider.pos.y,music.slider.dimensions.w,music.slider.dimensions.h,5,5)
		love.graphics.setColor(255,255,255)
		love.graphics.setColor(music.slider.text.color.r,music.slider.text.color.g,music.slider.text.color.b)
		love.graphics.print("Song: "..music.playing,music.slider.text.x,music.slider.text.y)
		love.graphics.setColor(255,255,255)
	end
	-- Slider --
	
	camera:unset()
	
	if deltaT < 0.015 then love.graphics.setColor(255,0,0) frDips=frDips+1 else love.graphics.setColor(0,255,0) end
	
	love.graphics.print("Total Drawn Frames: "..frames.." | Total FrameRate Dips: "..frDips,1,0)
	love.graphics.setColor(255,255,255)
	love.graphics.print("Gamestate: "..gamestate..", Game Version: "..TU.v..", ".._VERSION,1,15)
	love.graphics.print("Camera Speed: "..cSpeed,1,30)
	
end

function love.keypressed(key)
	if key=="t" then
		if music.slider.fadeOut==false then
			music.slider.fadeOut=true
		else
			music.slider.fadeOut=false
		end
	end
	
	if key=="`" then print("Type 'cont' to exit console mode.") debug.debug() end
	--if key=="g" then createNewBody("moon",physics.pMath.moonG) updateBodyDraw("moon","tex","textures/Crion - HalfQuarterRes.png") end
	--if key=="h" then createNewBody("mars",physics.pMath.marsG) updateBodyDraw("mars","tex","textures/NVME03 - HalfQuarterRes.png") updateBodyDraw( "mars", "x",200) end
    if (key == "escape" or key == "x") then
        love.event.quit()
    end
    if (key=="p") then
        printMouseCords()
    end
end

function love.quit()
	print("Beginning quit() queue.\n")
	love.audio.stop()
    if errorRep=="" or errorRep==nil then
		errorRep="No Error occurred."
    end
	os.execute("ECHO ------------------ >> report.txt")
    os.execute("ECHO Date/Time: %date%_%time% >> report.txt")
    os.execute("ECHO Error: "..errorRep.." >> report.txt")
    os.execute("ECHO Video Card/Chip: "..device.." >> report.txt")
    os.execute("ECHO Renderer: "..d.." >> report.txt")
    os.execute("ECHO ------------------ >> report.txt")
	print("Done quit()... Exiting.\n")
end
