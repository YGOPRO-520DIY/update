--雪暴猎鹰的前兆
function c43694487.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c43694487.cost)
	e1:SetOperation(c43694487.operation)
	c:RegisterEffect(e1)
end
function c43694487.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local costg=Duel.GetMatchingGroup(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,nil)
	local costnum=costg:GetCount()
	if chk==0 then return costnum>0 and costnum==Duel.GetFieldGroupCount(tp,LOCATION_HAND,0) end
	Duel.SendtoGrave(costg,REASON_COST)
	e:SetLabelObject(costg)
end
function c43694487.fil(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsRace(RACE_WINDBEAST)
end
function c43694487.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if g:IsExists(c43694487.fil,1,nil) then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,tp)
	end
end