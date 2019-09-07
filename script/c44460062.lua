--神依-青云双星
function c44460062.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x64a),2)
	c:EnableReviveLimit()
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460062,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c44460062.xycon)
	e1:SetCost(c44460062.xycost)
	e1:SetTarget(c44460062.xytg)
	e1:SetOperation(c44460062.xyop)
	c:RegisterEffect(e1)
	--copy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460062,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,44460062)
	e2:SetTarget(c44460062.cptg)
	e2:SetOperation(c44460062.cpop)
	c:RegisterEffect(e2)
end
--sy
function c44460062.costfilter(c)
	return c:IsSetCard(0x64a)
end
function c44460062.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return
	--Duel.CheckReleaseGroup(tp,c44460062.costfilter,1,nil) and 
	Duel.CheckLPCost(tp,2000) end
	--local g=Duel.SelectReleaseGroup(tp,c44460062.costfilter,1,1,nil)
	--Duel.Release(g,REASON_COST)
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.PayLPCost(tp,2000)
end
function c44460062.filter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x64a)
end
function c44460062.tfilter(c)
	return (c:IsSetCard(0x64b) or c:IsSetCard(0x680)) and c:IsAbleToGrave()
end
function c44460062.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460062.filter,1,nil,tp)
end
function c44460062.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsSetCard(0x64a)
	--and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-1
        and Duel.IsExistingMatchingCard(c44460062.tfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460062.climit)
end
function c44460062.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460062.tfilter,tp,LOCATION_ONFIELD,0,1,99,nil)
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
function c44460062.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--copy
function c44460062.cpfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x64b) or c:IsSetCard(0x680)) 
	and c:IsType(TYPE_MONSTER) and not c:IsCode(44460062)
end
function c44460062.cptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c44460062.cpfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44460062.cpfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44460062.cpfilter,tp,LOCATION_GRAVE,0,1,1,nil)
end
function c44460062.cpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and (not tc:IsLocation(LOCATION_MZONE) or tc:IsFaceup()) then
		local code=tc:GetCode()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(code)
		c:RegisterEffect(e1)
		c:CopyEffect(code,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
	end
end