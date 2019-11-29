--badapple 蕾米莉亚·斯卡雷特
function c4003.initial_effect(c)
	--Search2
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,4003)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c4003.cost)
	e1:SetTarget(c4003.tg)
	e1:SetOperation(c4003.op)
	c:RegisterEffect(e1)
	--search1
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(4003,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,4003)
	e2:SetTarget(c4003.shtg)
	e2:SetOperation(c4003.shop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c4003.costfilter(c)
	return c:IsDiscardable()
end
function c4003.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  Duel.IsExistingMatchingCard(c4003.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c4003.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c4003.cfilter(c)
	return c:IsSetCard(0x5907) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c4003.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c4003.cfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c4003.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c4003.cfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c4003.filter(c)
	return (c:IsSetCard(0x877) or c:IsCode(4006)) and c:IsAbleToHand()
end
function c4003.shtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c4003.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c4003.shop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c4003.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
