--屏东四天王
function c44470207.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44470207,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCountLimit(1,44470207+EFFECT_COUNT_CODE_OATH)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c44470207.spcost)
	e1:SetTarget(c44470207.sptg)
	e1:SetOperation(c44470207.spop)
	c:RegisterEffect(e1)
end
function c44470207.costfilter(c)
	return c:IsDiscardable()
end
function c44470207.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470207.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c44470207.costfilter,4,4,REASON_COST+REASON_DISCARD,nil)
end
function c44470207.filter(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c44470207.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=3
		and Duel.IsExistingTarget(c44470207.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,44470221,e,tp)
		and Duel.IsExistingTarget(c44470207.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,44470220,e,tp)
		and Duel.IsExistingTarget(c44470207.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,44470222,e,tp)
	    and Duel.IsExistingTarget(c44470207.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,44470219,e,tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c44470207.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,44470221,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c44470207.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,44470220,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g3=Duel.SelectTarget(tp,c44470207.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,44470222,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g4=Duel.SelectTarget(tp,c44470207.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,44470219,e,tp)
	g1:Merge(g2)
	g1:Merge(g3)
	g1:Merge(g4)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,4,0,0)
end
function c44470207.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<4 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g:FilterCount(Card.IsRelateToEffect,nil,e)~=4 then return end
	--Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	local tc=g:GetFirst()
	while tc do
	if Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
	    e1:SetValue(TYPE_NORMAL+TYPE_MONSTER)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	    local e2=e1:Clone()
	    e2:SetCode(EFFECT_CHANGE_LEVEL)
	    e2:SetValue(1)
	    tc:RegisterEffect(e2)
	    local e4=e1:Clone()
	    e4:SetCode(EFFECT_CHANGE_RACE)
	    e4:SetValue(RACE_AQUA)
	    tc:RegisterEffect(e4)
	    local e5=e1:Clone()
	    e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	    e5:SetValue(ATTRIBUTE_WATER)
	    tc:RegisterEffect(e5)
		local e6=e1:Clone()
	    e6:SetCode(EFFECT_SET_BASE_ATTACK)
	    e6:SetValue(0)
	    tc:RegisterEffect(e6)
		local e7=e1:Clone()
	    e7:SetCode(EFFECT_SET_BASE_DEFENSE)
	    e7:SetValue(0)
	    tc:RegisterEffect(e7)
        tc=g:GetNext()
		end
	end
	Duel.SpecialSummonComplete()
end