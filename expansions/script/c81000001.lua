--大崎甘奈 & 大崎甜花
local m=81000001
local cm=_G["c"..m]
xpcall(function() require("expansions/script/c81000000") end,function() require("script/c81000000") end)
function cm.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,81000000,26800000,true,true)
end
