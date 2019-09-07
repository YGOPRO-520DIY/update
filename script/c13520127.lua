local m=13520127
local tg={13520120,13520131}
local cm=_G["c"..m]
cm.name="机宇核心 潘多拉"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Link Summon
	aux.AddLinkProcedure(c,cm.mfilter,2)
	--Base Atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(cm.atkval)
	c:RegisterEffect(e1)
	--Change Effect Type
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(m)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,0)
	c:RegisterEffect(e2)
end
function cm.isset(c)
	return c:GetCode()>tg[1] and c:GetCode()<tg[2]
end
--Link Summon
function cm.mfilter(c)
	return cm.isset(c)
end
--Base Atk
function cm.atkfilter(c)
	return c:IsFaceup() and cm.isset(c) and c:GetBaseAttack()>0
end
function cm.atkval(e,c)
	local g=Duel.GetMatchingGroup(cm.atkfilter,c:GetControler(),LOCATION_MZONE,0,nil)
	return g:GetSum(Card.GetBaseAttack)
end