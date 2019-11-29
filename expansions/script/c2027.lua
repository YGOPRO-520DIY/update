--从者召唤
function c2027.initial_effect(c)
   --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c2027.condition)
	e1:SetTarget(c2027.target)
	e1:SetCountLimit(1,2027)
	e1:SetOperation(c2027.activate)
	c:RegisterEffect(e1) 
end
function c2027.cfilter(c)
	return c:IsSetCard(0x5903) and c:IsType(TYPE_NORMAL)
end
function c2027.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c2027.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c2027.filter(c,e,tp)
	return c:IsSetCard(0x5903) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c2027.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c2027.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c2027.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c2027.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
		Duel.Draw(tp,1,REASON_EFFECT)
end