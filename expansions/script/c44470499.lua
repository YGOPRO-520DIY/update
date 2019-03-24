--寂静的神明之羽
function c44470499.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	--e1:SetCountLimit(1,44470499+EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
	local g=Group.CreateGroup()
	g:KeepAlive()
	--adjust
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetOperation(c44470499.adjustop)
	e2:SetLabelObject(g)
	c:RegisterEffect(e2)
	--act limit
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_FIELD)
	e21:SetRange(LOCATION_ONFIELD)
	e21:SetCode(EFFECT_CANNOT_TRIGGER)
	e21:SetTargetRange(0,LOCATION_MZONE)
	e21:SetTarget(c44470499.etarget)
	e21:SetLabelObject(g)
	c:RegisterEffect(e21)
	--cannot attack
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD)
	e22:SetCode(EFFECT_CANNOT_ATTACK)
	e22:SetRange(LOCATION_ONFIELD)
	e22:SetTargetRange(0,LOCATION_MZONE)
	e22:SetTarget(c44470499.etarget)
	e22:SetLabelObject(g)
	c:RegisterEffect(e22)
	--sset
	local e24=Effect.CreateEffect(c)
	e24:SetType(EFFECT_TYPE_QUICK_O)
	e24:SetCode(EVENT_FREE_CHAIN)
	e24:SetRange(LOCATION_GRAVE)
	e24:SetHintTiming(0,TIMING_END_PHASE)
	e24:SetCountLimit(1,44470499)
	e24:SetCondition(c44470499.condition)
	e24:SetCost(aux.bfgcost)
	e24:SetTarget(c44470499.stg)
	e24:SetOperation(c44470499.sop)
	c:RegisterEffect(e24)
end
function c44470499.adjustop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local preg=e:GetLabelObject()
	if g:GetCount()>0 then
		local ag=g:GetMaxGroup(Card.GetAttack)
		if ag:Equal(preg) then return end
		preg:Clear()
		preg:Merge(ag)
	else
		if preg:GetCount()==0 then return end
		preg:Clear()
	end
	Duel.AdjustInstantly(e:GetHandler())
	Duel.Readjust()
end
function c44470499.etarget(e,c)
	return e:GetLabelObject():IsContains(c)
	--and c:IsType(TYPE_EFFECT)
end
--sset
function c44470499.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c44470499.filter(c)
	return c:IsType(TYPE_MONSTER)
end
function c44470499.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470499.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44470499.sop(e,tp,eg,ep,ev,re,r,rp)
	--if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44470499.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	end
end