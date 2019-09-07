--邪神依-魂锁黑龙
function c44460269.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsXyzType,TYPE_NORMAL),10,2)
	c:EnableReviveLimit()
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460269,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460269.xycon)
	e1:SetCost(c44460269.xycost)
	e1:SetTarget(c44460269.xytg)
	e1:SetOperation(c44460269.xyop)
	c:RegisterEffect(e1)
	--tograve
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460269,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,44460269)
	e2:SetCondition(c44460269.scon)
	e2:SetTarget(c44460269.ktg)
	e2:SetOperation(c44460269.kop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
--sy
function c44460269.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1500) end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.PayLPCost(tp,1500)
end
function c44460269.filter(c,tp)
	return c:IsFaceup() and c:IsCode(44460005)
end
function c44460269.tfilter(c)
	return c:IsSetCard(0x64b) and c:IsAbleToGrave()
end
function c44460269.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460269.filter,1,nil,tp)
end
function c44460269.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460005)
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-2
        and Duel.IsExistingMatchingCard(c44460269.tfilter,tp,LOCATION_ONFIELD,0,2,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460269.climit)
end
function c44460269.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460269.tfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
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
function c44460269.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--tograve
function c44460269.sfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) 
end
function c44460269.scon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460269.sfilter,1,nil,tp)
end
function c44460269.rmfilter(c)
	return (c:IsFacedown() or c:IsSetCard(0x64b)) and c:IsAbleToGrave()
	and not c:IsCode(44460269)
end
function c44460269.ktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingMatchingCard(c44460269.rmfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
	and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	local g1=Duel.GetMatchingGroup(c44460269.rmfilter,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPPO)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g1,1,0,0)
end
function c44460269.kop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460269.rmfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	if g:GetCount()>0 then
	Duel.HintSelection(g)
	Duel.SendtoGrave(g,nil,REASON_EFFECT)
	local c=e:GetHandler()
	local g1=Duel.SelectMatchingCard(tp,c44460269.setfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	local tc=g1:GetFirst()
	if tc then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
		local e11=Effect.CreateEffect(c)
		e11:SetType(EFFECT_TYPE_SINGLE)
	    e11:SetProperty(EFFECT_FLAG_OATH)
	    e11:SetCode(EFFECT_CANNOT_ATTACK)
	    e11:SetReset(RESET_EVENT+0xff0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e11,true)
	    local e13=Effect.CreateEffect(c)
	    e13:SetType(EFFECT_TYPE_SINGLE)
	    e13:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
        e13:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
       	e13:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e13,true)
	    local e14=e13:Clone()
	    e14:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	    tc:RegisterEffect(e14,true)
	    local e15=e13:Clone()
	    e15:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	    tc:RegisterEffect(e15,true)
		local e16=e13:Clone()
	    e16:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	    tc:RegisterEffect(e16,true)
		local e17=Effect.CreateEffect(c)
	    e17:SetType(EFFECT_TYPE_SINGLE)
	    e17:SetCode(EFFECT_UNRELEASABLE_SUM)
	    e17:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e17:SetValue(1)
	    e17:SetReset(RESET_EVENT+RESETS_STANDARD)
	    tc:RegisterEffect(e17,true)
	    local e27=e17:Clone()
	    e27:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	    tc:RegisterEffect(e27,true)
	    end
	end
end
