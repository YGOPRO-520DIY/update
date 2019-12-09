--高空坠落
function c81005013.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c81005013.condition)
	e1:SetCost(c81005013.cost)
	e1:SetTarget(c81005013.target)
	e1:SetOperation(c81005013.activate)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(c81005013.bcondition)
	e2:SetCost(c81005013.cost)
	e2:SetOperation(c81005013.bactivate)
	c:RegisterEffect(e2)
end
function c81005013.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()>1 and rp==1-tp and Duel.IsChainDisablable(ev)
end
function c81005013.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2500) end
	Duel.PayLPCost(tp,2500)
end
function c81005013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.nbcon(tp,re) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
end
function c81005013.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
	end
end
function c81005013.bcondition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c81005013.bactivate(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	Duel.SkipPhase(turnp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1,1)
	Duel.SkipPhase(turnp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
end
