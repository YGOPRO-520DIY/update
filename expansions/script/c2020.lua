--英灵殿
function c2020.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetDescription(aux.Stringid(2020,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCost(c2020.cost)
	e2:SetTarget(c2020.target1)
	e2:SetOperation(c2020.operation1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetDescription(aux.Stringid(2020,2))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e3:SetCost(c2020.cost)
	e3:SetTarget(c2020.target2)
	e3:SetOperation(c2020.operation2)
	c:RegisterEffect(e3)
	--cannot disable effect
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_DISEFFECT)
	e4:SetProperty(EFFECT_FLAG_IGNORE_RANGE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetValue(c2020.effectfilter)
	c:RegisterEffect(e4)
	local e4_1=Effect.CreateEffect(c)
	e4_1:SetType(EFFECT_TYPE_FIELD)
	e4_1:SetCode(EFFECT_CANNOT_DISABLE)
	e4_1:SetProperty(EFFECT_FLAG_IGNORE_RANGE)
	e4_1:SetRange(LOCATION_SZONE)
	e4_1:SetTarget(c2020.effectfilter2)
	c:RegisterEffect(e4_1)
	--Draw
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCategory(CATEGORY_DECKDES+CATEGORY_DRAW)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetCondition(c2020.descon)
	e5:SetTarget(c2020.target)
	e5:SetOperation(c2020.operation)
	e5:SetCountLimit(1,20200)
	c:RegisterEffect(e5)
end
function c2020.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c2020.filter1(c)
	return c:IsLevelBelow(4) and c:IsSetCard(0x5903) and c:IsAbleToHand()
end
function c2020.filter2(c)
	return c:IsRace(RACE_ALL) and c:IsAbleToGrave()
end
function c2020.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2020.filter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c2020.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2020.filter2,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_EXTRA)
end
function c2020.operation1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c2020.filter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c2020.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c2020.filter2,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c2020.effectfilter(e,ct)
	local p=e:GetHandlerPlayer()
	local te,tp,loc=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER,CHAININFO_TRIGGERING_LOCATION)
	local tc=te:GetHandler()
	return tc:IsSetCard(0x5903)
end
function c2020.effectfilter2(e,c)
	return c:IsSetCard(0x5903) and c:IsType(TYPE_MONSTER)
end
function c2020.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_EXTRA) and c:GetPreviousControler()==tp and c:IsSetCard(0x3903)
end
function c2020.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c2020.cfilter,1,nil,tp)
end
function c2020.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c2020.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end