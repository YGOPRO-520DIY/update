--九尾神依契约
function c44460055.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,44460059)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,44460055)
	e1:SetCost(c44460055.cost)
	e1:SetTarget(c44460055.target)
	e1:SetOperation(c44460055.op)
	c:RegisterEffect(e1)
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetRange(LOCATION_GRAVE)
	e11:SetCountLimit(1,44460055)
	e11:SetCost(aux.bfgcost)
	e11:SetTarget(c44460055.target)
	e11:SetOperation(c44460055.op)
	c:RegisterEffect(e11)
end
function c44460055.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c44460055.filter(c)
	return c:IsCode(44460059) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c44460055.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460055.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44460055.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44460055.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end