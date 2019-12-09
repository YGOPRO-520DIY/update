local m=13520227
local tg={13520200,13520230}
local cm=_G["c"..m]
cm.name="雪之花骑士 山茶花"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Link Summon
	aux.AddLinkProcedure(c,cm.mfilter,3)
	--Base Attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(cm.atkval)
	c:RegisterEffect(e1)
	--Disable Field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE_FIELD)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(cm.disop)
	c:RegisterEffect(e2)
end
function cm.flower(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Link Summon
function cm.mfilter(c)
	return c:IsLinkRace(RACE_PLANT)
end
--Base Attack
function cm.atkfilter(c)
	return cm.flower(c) and c:IsType(TYPE_MONSTER)
end
function cm.atkval(e,c)
	local g=Duel.GetMatchingGroup(cm.atkfilter,c:GetControler(),LOCATION_GRAVE,0,nil)
	return g:GetClassCount(Card.GetCode)*500
end
--Disable Field
function cm.disop(e,tp)
	local c=Duel.GetLocationCount(1-tp,LOCATION_MZONE,PLAYER_NONE,0)
	if c==0 then return end
	local dis1=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,0)
	if c>1 and Duel.SelectYesNo(tp,aux.Stringid(m,0)) then
		local dis2=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,dis1)
		dis1=bit.bor(dis1,dis2)
	end
	return dis1
end