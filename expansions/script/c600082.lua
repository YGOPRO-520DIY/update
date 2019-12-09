--龙战士 混沌战士
function c600082.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,8,2,c600082.ovfilter,aux.Stringid(600082,0),99,c600082.xyzop)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600082,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,600082)
	e1:SetCost(c600082.linkcost)
	e1:SetTarget(c600082.linktg)
	e1:SetOperation(c600082.linkop)
	c:RegisterEffect(e1) 
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600082,3))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,6000082)
	e2:SetCondition(c600082.spcon)
	e2:SetTarget(c600082.sptg)
	e2:SetOperation(c600082.spop)
	c:RegisterEffect(e2)
end
function c600082.ovfilter(c)
	if Duel.GetMatchingGroupCount(Card.IsCode,c:GetControler(),LOCATION_ONFIELD,0,nil,40089744)~=1 then return false end
	return c:IsFaceup() and c:IsCode(66889139)
end
function c600082.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,600082)==0 end
	Duel.RegisterFlagEffect(tp,600082,RESET_PHASE+PHASE_END,0,1)
end
function c600082.linkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	local t=c:GetOverlayCount()
	e:GetHandler():RemoveOverlayCard(tp,t,t,REASON_COST)
end
function c600082.lkfilter(c,mc)
	return c:IsSetCard(0x10cf) and c:IsLinkSummonable(nil,mc)
end
function c600082.spfilter(c,e,tp)
	return c:IsSetCard(0xbd) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c600082.lkfilter,tp,LOCATION_EXTRA,0,1,nil,c)
end
function c600082.linktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,2)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c600082.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_EXTRA)
end
function c600082.linkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c600082.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if not tc or not Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then return end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	tc:RegisterEffect(e2)
	Duel.SpecialSummonComplete()
	local tg=Duel.GetMatchingGroup(c600082.lkfilter,tp,LOCATION_EXTRA,0,nil,tc)
	if tg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=tg:Select(tp,1,1,nil)
		local sc=sg:GetFirst()
		Duel.LinkSummon(tp,sc,nil,tc)
		local e3=Effect.CreateEffect(c)
		e3:SetDescription(aux.Stringid(600082,2))
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e3:SetValue(1)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD)
		sc:RegisterEffect(e3)
	end
end
function c600082.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_XYZ)
end
function c600082.spfilter2(c,e,tp)
	return c:IsSetCard(0xbd) or (c:IsRace(RACE_DRAGON) and c:IsType(TYPE_FUSION)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c600082.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCountFromEx(tp)>0
		and Duel.IsExistingMatchingCard(c600082.spfilter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c600082.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCountFromEx(tp)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c600082.spfilter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
