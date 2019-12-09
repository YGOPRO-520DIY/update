--三形金字塔的巨神兵
function c600073.initial_effect(c)  
	aux.AddLinkProcedure(c,c600073.lfilter,3,3) 
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600073,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,600073)
	e1:SetCondition(c600073.descon1)
	e1:SetTarget(c600073.destg)
	e1:SetOperation(c600073.desop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCondition(c600073.descon2)
	c:RegisterEffect(e2) 
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(600073,1))
	e3:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,6000073)
	e3:SetTarget(c600073.sptg)
	e3:SetOperation(c600073.spop)
	c:RegisterEffect(e3) 
	--link summon rule
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(600073,2))
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SPSUMMON_PROC)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_EXTRA)
	e4:SetCondition(c600073.linkcon)
	e4:SetOperation(c600073.linkop)
	c:RegisterEffect(e4)
end
function c600073.lfilter(c)
	return c:IsRace(RACE_ROCK)
end
function c600073.descfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FIELD)
end
function c600073.descon1(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c600073.descfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
end
function c600073.descon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c600073.descfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
end
function c600073.desfilter(c)
	return c:IsFaceup()
end
function c600073.thfilter(c)
	return c:IsSetCard(0xe2) and c:IsAbleToHand()
end
function c600073.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c600073.desfilter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c600073.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler())
		and Duel.IsExistingMatchingCard(c600073.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c600073.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c600073.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c600073.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
function c600073.spfilter(c,ft)
	return c:IsSetCard(0xe2) and c:IsType(TYPE_FIELD) and c:IsAbleToDeck()
end
function c600073.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ft=Duel.GetLocationCount(tp,LOCATION_GRAVE)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c600073.spfilter(chkc,ft) end
	if chk==0 then return Duel.IsExistingTarget(c600073.spfilter,tp,LOCATION_GRAVE,0,1,nil,ft)
		and ft>-1 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c600073.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,ft)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c600073.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)~=0 and c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c600073.actlimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c600073.actlimit(e,re,rp)
	local rc=re:GetHandler()
	return re:IsActiveType(TYPE_MONSTER) and not rc:IsRace(RACE_ROCK)
end
function c600073.spfilter1(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_ROCK) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c600073.spfilter2,tp,LOCATION_ONFIELD,0,1,c)
end
function c600073.spfilter2(c)
	return c:IsFaceup() and c:IsCode(600074) and c:IsAbleToGraveAsCost()
end
function c600073.cnfilter(c)
	return c:GetSequence()>=5
end
function c600073.linkcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCountFromEx(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c600073.spfilter1,tp,LOCATION_MZONE,0,2,nil,tp) and not Duel.IsExistingMatchingCard(c600073.cnfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c600073.linkop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_LMATERIAL)
	local g1=Duel.SelectMatchingCard(tp,c600073.spfilter1,tp,LOCATION_MZONE,0,2,2,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_LMATERIAL)
	local g2=Duel.SelectMatchingCard(tp,c600073.spfilter2,tp,LOCATION_SZONE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	c:SetMaterial(g1)
	Duel.SendtoGrave(g1,REASON_MATERIAL+REASON_LINK)
end