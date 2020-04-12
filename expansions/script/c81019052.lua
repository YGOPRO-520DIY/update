--宫水静香·改变
local m=81019052
local cm=_G["c"..m]
function cm.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,cm.mfilter,2,99,cm.lcheck)
	c:EnableReviveLimit()
end
function cm.mfilter(c)
	return c:IsLinkType(TYPE_MONSTER) and not c:IsLinkType(TYPE_EFFECT)
end
function cm.lcheck(g,lc)
	return g:IsExists(cm.mzfilter,1,nil)
end
function cm.mzfilter(c)
	return c:IsLinkType(TYPE_MONSTER) and not c:IsLinkType(TYPE_TOKEN)
end
