--鹤翼三连
function c22080070.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c22080070.cost)
	e1:SetCondition(c22080070.condition)
	e1:SetTarget(c22080070.target)
	e1:SetOperation(c22080070.activate)
	c:RegisterEffect(e1)
end
c22080070.card_code_list={22000020}
function c22080070.cfilter(c)
	return c:IsCode(22080060) and c:IsDiscardable()
end
function c22080070.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22080070.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c22080070.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c22080070.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c22080070.filter(c)
	return c:IsFaceup() and c:IsCode(22000020) and not c:IsHasEffect(EFFECT_EXTRA_ATTACK)
end
function c22080070.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c22080070.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c22080070.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c22080070.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c22080070.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetCode(EFFECT_CANNOT_ACTIVATE)
		e2:SetTargetRange(0,1)
		e2:SetLabelObject(tc)
		e2:SetValue(c22080070.aclimit)
		e2:SetCondition(c22080070.actcon)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
	end
end
function c22080070.actcon(e)
	return Duel.GetAttacker()==e:GetLabelObject()
end
function c22080070.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
