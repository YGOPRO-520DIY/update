--神依-角月青麟
function c44460205.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,99,c44460205.lcheck)
	c:EnableReviveLimit()
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460205,3))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460205.xycost)
	e1:SetTarget(c44460205.xytg)
	e1:SetOperation(c44460205.xyop)
	c:RegisterEffect(e1)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460205,1))
	e2:SetCategory(CATEGORY_RECOVER+CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1)
	e2:SetTarget(c44460205.rectg)
	e2:SetOperation(c44460205.recop)
	c:RegisterEffect(e2)
end
function c44460205.lcheck(g,lc)
	return g:IsExists(Card.IsLinkCode,1,nil,44460019)
end
--sy
function c44460205.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.PayLPCost(tp,1000)
end
function c44460205.tfilter(c)
	return c:IsSetCard(0x64b) and c:IsAbleToGrave()
end
function c44460205.tfilter1(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGrave()
end
function c44460205.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460019)
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-1
		and Duel.IsExistingMatchingCard(c44460205.tfilter,tp,LOCATION_ONFIELD,0,1,nil)
        and Duel.IsExistingMatchingCard(c44460205.tfilter1,tp,0,LOCATION_ONFIELD,1,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460205.climit)
end
function c44460205.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460205.tfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	local g1=Duel.SelectMatchingCard(tp,c44460205.tfilter1,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 and g1:GetCount()>0 then
	Duel.SendtoGrave(g,REASON_EFFECT)
	Duel.SendtoGrave(g1,REASON_EFFECT)
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
function c44460205.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--recover
function c44460205.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL)
	and c:IsAttribute(ATTRIBUTE_WIND) and c:IsLevel(1)
end
function c44460205.rectg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(c44460205.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44460205.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c44460205.recop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(2500)
		tc:RegisterEffect(e1)
		local atk=tc:GetAttack()
		if atk<0 then atk=0 end
		Duel.Recover(tp,atk,REASON_EFFECT)
	end
end