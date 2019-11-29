--霞光的欺诈
function c33330741.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c33330741.condition)
	e1:SetTarget(c33330741.target)
	e1:SetOperation(c33330741.activate)
	c:RegisterEffect(e1)	
end
function c33330741.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsFaceup() and tc:IsSetCard(0x555)
end
function c33330741.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,5) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(5)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,5)
end
function c33330741.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	if Duel.DiscardDeck(tp,5,REASON_EFFECT)~=0 then
	   Duel.BreakEffect()
	   local turnp=Duel.GetTurnPlayer()
	   Duel.SkipPhase(turnp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
	   Duel.SkipPhase(turnp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1,1)
	   Duel.SkipPhase(turnp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
	end
end
