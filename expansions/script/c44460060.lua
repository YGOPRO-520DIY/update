--神依-青龙邀月
function c44460060.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x677),2)
	c:EnableReviveLimit()
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460060,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460060.xycon)
	e1:SetCost(c44460060.xycost)
	e1:SetTarget(c44460060.xytg)
	e1:SetOperation(c44460060.xyop)
	c:RegisterEffect(e1)
	--disable1
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44460060,1))
	e11:SetCategory(CATEGORY_DISABLE)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetCountLimit(1,44460060)
	e11:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e11:SetRange(LOCATION_MZONE)
	e11:SetTarget(c44460060.target)
	e11:SetOperation(c44460060.operation)
	c:RegisterEffect(e11)
	--disable2
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(44460060,2))
	e12:SetCategory(CATEGORY_DISABLE)
	e12:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e12:SetType(EFFECT_TYPE_QUICK_O)
	e12:SetCode(EVENT_FREE_CHAIN)
	e12:SetCountLimit(1,44460060)
	e12:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e12:SetRange(LOCATION_SZONE)
	e12:SetTarget(c44460060.target2)
	e12:SetOperation(c44460060.operation2)
	c:RegisterEffect(e12)
end
--sy
function c44460060.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460060.filter(c,tp)
	return c:IsFaceup() and c:IsCode(44460001)
end
function c44460060.tfilter(c)
	return c:IsSetCard(0x679) and c:IsAbleToGrave()
end
function c44460060.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460060.filter,1,nil,tp)
end
function c44460060.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460001)
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-2
        and Duel.IsExistingMatchingCard(c44460060.tfilter,tp,LOCATION_ONFIELD,0,2,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460060.climit)
end
function c44460060.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460060.tfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
	if g:GetCount()>0 then
	Duel.SendtoGrave(g,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,c)
		local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    c:RegisterEffect(e1)
	end
end
function c44460060.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--disable1
function c44460060.disfilter(c)
	return c:IsFaceup() and not c:IsDisabled()
end
function c44460060.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and c44460060.disfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44460060.disfilter,tp,0,LOCATION_ONFIELD,1,nil)
	and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c44460060.disfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c44460060.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsDisabled() and tc:IsControler(1-tp) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		Duel.BreakEffect()
	    if not c:IsRelateToEffect(e) then return end
	    if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,c)
		local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    c:RegisterEffect(e1)
	end
end
--disable2
function c44460060.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and c44460060.disfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44460060.disfilter,tp,0,LOCATION_ONFIELD,1,nil)
	and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,true) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c44460060.disfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c44460060.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsDisabled() and tc:IsControler(1-tp) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		Duel.BreakEffect()

	    if not c:IsRelateToEffect(e) then return end
	    Duel.SpecialSummon(c,0,tp,tp,true,true,POS_FACEUP)
	end
end