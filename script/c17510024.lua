--折·反
function c17510024.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,17510024+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c17510024.cost)
	e1:SetTarget(c17510024.target)
	e1:SetOperation(c17510024.activate)
	c:RegisterEffect(e1)
end
c17510024.setname="FloWBacK"
function c17510024.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local n1=Duel.GetMatchingGroupCount(Card.IsAbleToDeckOrExtraAsCost,tp,LOCATION_HAND,0,e:GetHandler())
	local n2=Duel.GetMatchingGroupCount(Card.IsAbleToDeckOrExtraAsCost,tp,LOCATION_GRAVE,0,nil)
	local n3=Duel.GetMatchingGroupCount(Card.IsAbleToDeckOrExtraAsCost,tp,LOCATION_ONFIELD,0,e:GetHandler())
	local n4=Duel.GetMatchingGroupCount(Card.IsAbleToDeckOrExtraAsCost,tp,LOCATION_REMOVED,0,nil)
	local n5=Duel.GetMatchingGroupCount(Card.IsAbleToDeckOrExtraAsCost,tp,0,LOCATION_HAND,nil)
	local n6=Duel.GetMatchingGroupCount(Card.IsAbleToDeckOrExtraAsCost,tp,0,LOCATION_GRAVE,nil)
	local n7=Duel.GetMatchingGroupCount(Card.IsAbleToDeckOrExtraAsCost,tp,0,LOCATION_ONFIELD,nil)
	local n8=Duel.GetMatchingGroupCount(Card.IsAbleToDeckOrExtraAsCost,tp,0,LOCATION_REMOVED,nil)
	local n11=Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_HAND,0,e:GetHandler())
	local n21=Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)
	local n31=Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_ONFIELD,0,e:GetHandler())
	local n41=Duel.GetFieldGroupCount(tp,LOCATION_REMOVED,0)
	local n51=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	local n61=Duel.GetFieldGroupCount(tp,0,LOCATION_GRAVE)
	local n71=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
	local n81=Duel.GetFieldGroupCount(tp,0,LOCATION_REMOVED)
	if chk==0 then return (n1>0 and n1==n11) and (n2>0 and n2==n21) and (n3>0 and n3==n31) and (n4>0 and n4==n41) and (n5>0 and n5==n51) and (n6>0 and n6==n61) and (n7>0 and n7==n71) and (n8>0 and n8==n81) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD+LOCATION_REMOVED,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD+LOCATION_REMOVED,e:GetHandler())
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c17510024.spfil(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c.setname=="FloWBacK" 
end
function c17510024.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17510024.spfil,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA)
	Duel.SetChainLimit(c17510024.chlimit)
end
function c17510024.chlimit(e,ep,tp)
	return tp==ep
end
function c17510024.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c17510024.spfil,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetTargetRange(1,0)
	Duel.RegisterEffect(e2,tp)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_SUMMON)
	Duel.RegisterEffect(e3,tp)
end