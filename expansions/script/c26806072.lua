--绮·凝·盏
function c26806072.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c26806072.condition)
	e1:SetTarget(c26806072.target)
	e1:SetOperation(c26806072.activate)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,26806072)
	e2:SetCondition(c26806072.immcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c26806072.immtg)
	e2:SetOperation(c26806072.immop)
	c:RegisterEffect(e2)
end
function c26806072.cfilter(c)
	return c:IsFaceup() and ((c:IsAttack(2200) and c:IsDefense(600)) or (c:IsAttack(3200) and c:IsType(TYPE_LINK)))
end
function c26806072.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c26806072.cfilter,tp,LOCATION_MZONE,0,1,nil)
	and rp==1-tp and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_GRAVE+LOCATION_REMOVED,1,nil,re:GetHandler():GetCode())
		and Duel.IsChainNegatable(ev)
end
function c26806072.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c26806072.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c26806072.immcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsActiveType(TYPE_MONSTER)
end
function c26806072.immfilter(c)
	return c:IsFaceup() and c:IsAttack(2200) and c:IsDefense(600) and not c:IsSummonableCard()
end
function c26806072.immtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26806072.immfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c26806072.immop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c26806072.immfilter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(c26806072.efilter)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c26806072.efilter(e,te,c)
	return te:GetOwner()~=c
end
