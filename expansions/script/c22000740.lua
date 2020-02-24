--星之从者 莫扎特
function c22000740.initial_effect(c)
	c:SetUniqueOnField(1,0,22000740)
	--link summon
	aux.AddLinkProcedure(c,c22000740.matfilter,1,1)
	c:EnableReviveLimit()
	--special summon (LL)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22000740,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCondition(c22000740.spcon)
	e2:SetTarget(c22000740.sptg)
	e2:SetOperation(c22000740.spop)
	c:RegisterEffect(e2)
end
function c22000740.matfilter(c)
	return c:IsLinkSetCard(0xfff) and not c:IsLinkSetCard(0x1fff)
end
function c22000740.spfilter(c,e,tp)
	return c:IsSetCard(0xfff) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c22000740.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c22000740.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c22000740.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c22000740.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c22000740.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
