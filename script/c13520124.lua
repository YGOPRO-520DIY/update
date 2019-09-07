local m=13520124
local cm=_G["c"..m]
cm.name="机宇训练师"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Link Summon
	aux.AddLinkProcedure(c,cm.mfilter,2,2)
	--Dual Status
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DUAL_STATUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(cm.dstg)
	c:RegisterEffect(e1)
	--Atk Up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(cm.atktg)
	e2:SetValue(cm.atkval)
	c:RegisterEffect(e2)
end
--Link Summon
function cm.mfilter(c)
	return c:IsLinkRace(RACE_CYBERSE)
end
--Dual Status
function cm.dstg(e,c)
	return c:IsFaceup() and c:IsRace(RACE_CYBERSE) and c:IsType(TYPE_DUAL)
end
--Atk Up
function cm.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK)
end
function cm.atktg(e,c)
	return c:IsFaceup() and c:IsType(TYPE_LINK)
end
function cm.atkval(e,c)
	local g=Duel.GetMatchingGroup(cm.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)
	return g:GetSum(Card.GetLink)*200
end