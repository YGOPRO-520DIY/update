--龙帝の圣刻印
function c88990282.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2,c88990282.ovfilter,aux.Stringid(88990282,0),2,c88990282.xyzop)
	c:EnableReviveLimit()
	--tograve
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(88990282,0))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,88990282)
	e3:SetCost(c88990282.tgcost)
	e3:SetTarget(c88990282.tgtg)
	e3:SetOperation(c88990282.tgop)
	c:RegisterEffect(e3)
	--spsummon
	local e13=Effect.CreateEffect(c)
	e13:SetDescription(aux.Stringid(88990282,1))
	e13:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e13:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e13:SetCode(EVENT_RELEASE)
	e13:SetTarget(c88990282.sptg)
	e13:SetOperation(c88990282.spop)
	c:RegisterEffect(e13)
end
function c88990282.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x69) and not c:IsCode(88990282)
end
function c88990282.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,88990282)==0 end
	Duel.RegisterFlagEffect(tp,88990282,RESET_PHASE+PHASE_END,0,1)
end
function c88990282.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	c:RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c88990282.tgfilter(c)
	return c:IsSetCard(0x69) and c:IsAbleToGrave()
	 --and c:IsAttribute(ATTRIBUTE_LIGHT))
	 and c:IsType(TYPE_MONSTER)
end
function c88990282.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88990282.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c88990282.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c88990282.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c88990282.spfilter(c,e,tp)
	return (c:IsType(TYPE_NORMAL) and c:IsRace(RACE_DRAGON)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c88990282.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c88990282.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c88990282.spfilter),tp,0x13,0,1,1,nil,e,tp)
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
