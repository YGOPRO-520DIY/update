--圣刻龙女仆-九神
function c88990348.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),2,99,c88990348.lcheck)
	c:EnableReviveLimit()
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88990348,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,88990348)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCost(c88990348.spcost)
	--e2:SetCondition(c88990348.spcon)
	e2:SetTarget(c88990348.sptg)
	e2:SetOperation(c88990348.spop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(88990348,2))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCode(EVENT_RELEASE)
	e3:SetTarget(c88990348.sptg2)
	e3:SetOperation(c88990348.spop2)
	c:RegisterEffect(e3)
end
function c88990348.lcheck(g,lc)
	return g:IsExists(Card.IsLinkType,1,nil,TYPE_NORMAL)
	and g:IsExists(Card.IsLinkRace,1,nil,RACE_DRAGON)
end
--special summon
function c88990348.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,Card.IsRace,1,RACE_DRAGON) end
	local g=Duel.SelectReleaseGroupEx(tp,Card.IsRace,1,1,RACE_DRAGON)
	Duel.Release(g,REASON_COST)
	
end
function c88990348.spfilter(c,e,tp)
	return c:IsSetCard(0x69) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c88990348.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c88990348.spfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA+LOCATION_GRAVE)
end
function c88990348.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c88990348.spfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then

		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
		e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e3:SetValue(1)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
		Duel.SpecialSummonComplete()
		
		local c=e:GetHandler()
	    local cg=Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_ONFIELD,nil,TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)
	    if cg:GetCount()>0 and tc:IsType(TYPE_XYZ) and Duel.SelectYesNo(tp,aux.Stringid(88990348,3)) then
		  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		  local xg=cg:Select(tp,1,1,nil)
		     if not xg:GetFirst():IsImmuneToEffect(e) then
			 Duel.Overlay(tc,xg) 
		     end   
	    end
	end
end
--spsummon
function c88990348.spfilter2(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsSetCard(0x69) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c88990348.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c88990348.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c88990348.spfilter2),tp,0x13,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if not tc then return end
	if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(3000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE)
		tc:RegisterEffect(e2)
		local e21=Effect.CreateEffect(e:GetHandler())
		e21:SetType(EFFECT_TYPE_SINGLE)
		e21:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e21:SetRange(LOCATION_MZONE)
		e21:SetCode(EFFECT_IMMUNE_EFFECT)
		e21:SetValue(c88990348.efilter)
		--e21:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e21:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e21)
		Duel.SpecialSummonComplete()
	end
end
function c88990348.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end




