--圣刻龙女仆-舒
function c88990334.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_DRAGON),2,2,c88990334.lcheck)
	
	--sp
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88990334,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,88990334)
	e1:SetCost(c88990334.thcost)
	e1:SetTarget(c88990334.thtg)
	e1:SetOperation(c88990334.thop)
	c:RegisterEffect(e1)
	--spsummon
	local e31=Effect.CreateEffect(c)
	e31:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e31:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e31:SetCode(EVENT_RELEASE)
	e31:SetTarget(c88990334.sptg)
	e31:SetOperation(c88990334.spop)
	c:RegisterEffect(e31)
end
--sp
function c88990334.lcheck(g,lc)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0x69)
	or g:IsExists(Card.IsLinkSetCard,1,nil,0x133)
end
function c88990334.thcfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsReleasable()
	and (c:IsSetCard(0x69) or c:IsSetCard(0x133))
end
function c88990334.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88990334.thcfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,c88990334.thcfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,1,tp)
	Duel.Release(g,REASON_COST)
end
function c88990334.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c88990334.spfilter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c88990334.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c88990334.spfilter1),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)

		local dg=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_SZONE,1,1,nil)
		if dg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(88990334,1)) then
		    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			Duel.BreakEffect()
			Duel.HintSelection(dg)
			Duel.Destroy(dg,REASON_EFFECT)

		end

	end
end
function c88990334.spfilter1(c,e,tp)
	return c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
--spsummon
function c88990334.spfilter(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c88990334.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c88990334.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c88990334.spfilter),tp,0x13,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if not tc then return end
	if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE)
		tc:RegisterEffect(e2)
		Duel.SpecialSummonComplete()
	end
end


