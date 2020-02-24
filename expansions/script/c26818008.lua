--命运的指引 卡维
local m=26818008
local cm=_G["c"..m]
xpcall(function() require("expansions/script/c26800000") end,function() require("script/c26800000") end)
function cm.initial_effect(c)
	Amana.Majsoul(c)
	--cannot select battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetValue(cm.atlimit)
	c:RegisterEffect(e1)
end
function cm.atlimit(e,c)
	return c:IsFaceup() and c:IsLevel(9)
end