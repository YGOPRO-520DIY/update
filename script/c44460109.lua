--古夕幻历-仙依神依
function c44460109.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460109,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44460109+EFFECT_COUNT_CODE_OATH)
	--e1:SetCondition(c44460109.condition)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c44460109.target)
	e1:SetOperation(c44460109.activate)
	c:RegisterEffect(e1)
	--remain field
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e3)
end
function c44460109.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsDamageCalculated()
end
function c44460109.filter(c)
	return c:IsSetCard(0x64a) and c:IsFaceup() and c:IsPosition(POS_FACEUP_ATTACK)
end
function c44460109.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c44460109.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44460109.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	Duel.SelectTarget(tp,c44460109.filter,tp,LOCATION_MZONE,0,1,1,nil)
	e:GetHandler():SetTurnCounter(0)
	--destroy
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c44460109.descon)
	e1:SetOperation(c44460109.desop)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	e:GetHandler():RegisterEffect(e1)
	e:GetHandler():RegisterFlagEffect(1082946,RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,2)
	c44460109[e:GetHandler()]=e1
end
function c44460109.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsPosition(POS_FACEUP_ATTACK)
        and tc:IsControler(tp) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		--secard
	    local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_ADD_SETCODE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	    e1:SetRange(LOCATION_MZONE)
	    e1:SetValue(0x64b)
	    tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetValue(0x64c)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_IMMUNE_EFFECT)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetValue(c44460109.efilter)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e3:SetOwnerPlayer(tp)
		tc:RegisterEffect(e3)
		local e22=Effect.CreateEffect(c)
		e22:SetType(EFFECT_TYPE_SINGLE)
		e22:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e22:SetValue(1)
		e22:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e22)
	end
end
function c44460109.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
--destroy
function c44460109.descon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c44460109.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==2 then
		Duel.Destroy(c,REASON_RULE)
		c:ResetFlagEffect(1082946)
	end
end