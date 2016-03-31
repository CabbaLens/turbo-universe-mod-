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

function getTableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function updateSlider()
	if music.slider.shouldFadeOut==true then
		sliderFadeOut()
	end
	if music.slider.shouldFadeIn==true then
		
	end
	if music.slider.shouldFadeIn==false and music.slider.shouldFadeOut==false then
		--idle
	end
end
function sliderFadeOut()
	if music.slider.isFaded==false then
		music.slider.color.a=70
	end
end

function sliderFadeIn()
	music.slider.color.a=0
	
end

function isTable(id)
	if (id==nil) then
		print("the ID was not found to be a table.")
		return false
	else
		print("the ID was found to be a table.")
		return true
	end
	--if not next(id)==nil then return false else return true end
end

function printMouseCords()
	local mx=love.mouse.getX()
	local my=love.mouse.getY()
	print("X: "..mx)
	print("Y: "..my)
end
function getMouseCords()
	local mx=love.mouse.getX()
	local my=love.mouse.getY()
	return mx,my
end
function report( msg, title )
	love.window.showMessageBox( title, msg, "info", true )
end
function reportErr( msg, typ )
	if typ==true then
		love.window.showMessageBox( "Error", "FATAL ERROR: "..msg, "error", true )
	elseif typ==false then
		love.window.showMessageBox( "Error", msg, "error", true )
	else
		print("reportErr used wrong!")
	end
end
function reportErr( msg )
	love.window.showMessageBox( "Error", "Error: "..msg, "error", true )
end
function compare(id1,op,id2)
	if op=="" or op==nil then
		print("No operation was assigned!")
		
	elseif op=="lessThan" then
		if id1 < id2 then
			return true
		else
			return false
		end
		
	elseif op=="greaterThan" then
		if id1 > id2 then
			return true
		else
			return false
		end
		
	elseif op=="eqTo" or op=="equalTo" then
		if id1==id2 then
			return true
		else
			return false
		end
		
	elseif op=="greaterThanEqTo" or op=="greaterThanEqualTo" or op=="greaterThanOrEqualTo" then
		if id1 >= id2 then
			return true
		else
			return false
		end
	elseif op=="getDiff" then
		if id1 > id2 then
			local outcome=id1-id2
			return outcome
		else
			local outcome=id2-id1
			return outcome
		end
	else
		print("'"..op.."' was not in the registered list!")
	end
	
end