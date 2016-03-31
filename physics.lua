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

physics={

	pMath={
		gUnit="m/s^2",
		earthG=9.80665,
		moonG=1.622,
		marsG=3.711,
		mercG=3.7,
		jupitG=24.79,
		pi=3.14159265359,
		ln=2.718281828459
	},
	
}

--math.abs   math.acos  math.asin  math.atan math.atan2 math.ceil
--math.cos   math.cosh  math.deg   math.exp  math.floor math.fmod
--math.frexp math.huge  math.ldexp math.log  math.log10 math.max
--math.min   math.modf  math.pow   math.rad  math.random
--math.randomseed       math.sin   math.sinh math.sqrt  math.tanh
--math.tan
function getTriangleHypot(a,b) -- Works!
	a2 = math.pow(a,2) --a^2 + b^2 = c^2
	b2 = math.pow(b,2)
	c2 = a2 + b2
	c = math.sqrt(c2)
	print("un-sqaured: "..c2)
	print("Sqaured: "..c)
	return c
end
function getExhaustVelocity(isp,g)
	eV = isp*g
	print("Got Exhaust Velocity: "..eV)
	return eV
end
function getTwr(f,m,g)
        TWR = f / (m * g)
        print("Got TWR: "..TWR)
        return TWR
end
function getDeltaV(m0,m1,isp,g) -- m0 is the initial total mass, including propellant and cargo. | OR | The current mass.
        dv=physics.math.ln*(m0/m1)*isp*g    -- m1 is the final total mass without propellant and cargo. | OR | Mass after the burn.
        print("Got DV: "..dv)
        return dv
end
function getCombinedIsp(f1,f2,f3,isp1,isp2,isp3) -- cIsp = ( F1 + F2 + ... ) / ( ( F1 / Isp1 ) + ( F2 / Isp2 ) + ... )
        fAdd=f1+f2+f3
        cIsp = fAdd / ( (f1/ips1) + (f2/isp2) + (f3/isp3) )
        print("Got cIsp: "..cIsp)
        return cIsp
end
function getCombinedIsp(f1,f2,f3,f4,isp1,isp2,isp3,isp4)
        fAdd=f1+f2+f3+f4
        cIsp = fAdd / ( (f1/ips1) + (f2/isp2) + (f3/isp3) + (f4/isp4))
        print("Got cIsp: "..cIsp)
        return cIsp
end
function getCombinedIsp(f1,f2,f3,f4,f5,isp1,isp2,isp3,isp4,isp5)
        fAdd=f1+f2+f3+f4+f5
        cIsp = fAdd / ( (f1/ips1) + (f2/isp2) + (f3/isp3) + (f4/isp4) + (f5/isp5))
        print("Got cIsp: "..cIsp)
        return cIsp
end