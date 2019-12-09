--圣诞礼物 玩具小恶魔
function c600059.initial_effect(c)
	--be target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600059,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c600059.condition)
	e1:SetCost(c600059.cost)
	e1:SetTarget(c600059.target)
	e1:SetOperation(c600059.operation)
	c:RegisterEffect(e1)
	--flip 
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600059,1))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetTarget(c600059.atktg)
	e2:SetOperation(c600059.atkop)
	c:RegisterEffect(e2)  
end
function c600059.condition(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg:IsContains(e:GetHandler()) and e:GetHandler():IsFacedown()
end
function c600059.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE)
end
function c600059.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0)
end
function c600059.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
function c600059.filter(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c600059.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c600059.filter,tp,0,LOCATION_MZONE,1,nil) end
end
function c600059.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c600059.filter,tp,0,LOCATION_MZONE,nil)
	local tc,c=g:GetFirst(),e:GetHandler()
	while tc do
		  local e1=Effect.CreateEffect(e:GetHandler())
		  e1:SetType(EFFECT_TYPE_SINGLE)
		  e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		  e1:SetValue(0)
		  e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		  tc:RegisterEffect(e1)
		  tc=g:GetNext()
	end
	if g:IsExists(aux.FilterEqualFunction(Card.GetAttack,0),1,nil) and c:IsCanTurnSet() and Duel.SelectYesNo(tp,aux.Stringid(600059,2)) then
	   Duel.BreakEffect()
	   Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	   local sg=Duel.GetMatchingGroup(c600059.ssfilter,tp,LOCATION_MZONE,0,nil)
	   Duel.ShuffleSetCard(sg)
	end
end
function c600059.ssfilter(c)
	return c:IsFacedown() and c:GetSequence()<5
end