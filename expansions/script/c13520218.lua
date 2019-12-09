local m=13520218
local tg={13520200,13520230}
local cm=_G["c"..m]
cm.name="花骑士 菊芋"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon
	aux.AddXyzProcedureLevelFree(c,cm.mfilter,cm.xyzcheck,2,2)
	--Overlay
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,m)
	e1:SetCost(cm.matcost)
	e1:SetTarget(cm.mattg)
	e1:SetOperation(cm.matop)
	c:RegisterEffect(e1)
end
function cm.flower(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Xyz Summon
function cm.mfilter(c,xyzc)
	return cm.flower(c) and c:IsLevelAbove(1)
end
function cm.xyzcheck(g)
	return g:GetClassCount(Card.GetLevel)==1
end
--Overlay
function cm.matcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function cm.mattg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_EXTRA,1,nil) end
end
function cm.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_EXTRA,nil)
	if c:IsRelateToEffect(e) and g:GetCount()>0 then
		local tc=g:RandomSelect(tp,1)
		Duel.Overlay(c,tc)
		Duel.ShuffleExtra(1-tp)
	end
end