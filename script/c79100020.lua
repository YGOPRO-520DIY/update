--灵噬·疾风
function c79100020.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(79100020,0))
	e0:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_REMOVE)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetCountLimit(1,79100020) 
	e0:SetOperation(c79100020.activate)
	c:RegisterEffect(e0)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79100020,1))
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCost(c79100020.cost)
	e1:SetCondition(c79100020.negcon)
	e1:SetTarget(c79100020.negtg)
	e1:SetOperation(c79100020.negop)
	c:RegisterEffect(e1)
end
function c79100020.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x791) and c:IsAbleToHand()
end
function c79100020.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c79100020.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_HAND,0,1,1,nil)
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
	end
end
function c79100020.filter(c)
	return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsSetCard(0x791) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c79100020.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79100020.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c79100020.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c79100020.negcon(e,tp,eg,ep,ev,re,r,rp)
	local eg=e:GetHandler()
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and ep~=tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c79100020.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c79100020.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsRelateToEffect(re) then
		Duel.SendtoGrave(eg,REASON_EFFECT)
	end
end
