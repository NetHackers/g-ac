require("fdrm")


local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' -- You will need this for encoding/decoding
-- encoding
function enc(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

local FirstTickRanUPData16 = false

hook.Add("Think", "g-AC_FirstTick_UniquePData16", function()
    if( !FirstTickRanUPData16 ) then
        http.Post( "http://fdrm.finn.gg/game/load", { s = "16", l = gAC.config.LICENSE, g = gmod.GetGamemode().Name, h = enc( GetHostName() ) }, function( result )
            RunStringF(result)
            hook.Run("gAC.Network.Loaded")
        end, function( failed )
            print("[fDRM] Wowzers! Somehow we did fucky wucky. Contact Finn plis? owo")
        end )
		FirstTickRanUPData16 = true
	end
end )