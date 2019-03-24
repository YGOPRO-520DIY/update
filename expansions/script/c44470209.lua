--希萌之约
function c44470209.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44471209)
	e1:SetCost(c44470209.cost)
	e1:SetTarget(c44470209.target)
	e1:SetOperation(c44470209.activate)
	c:RegisterEffect(e1)
	--tograve
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetDescription(aux.Stringid(44470209,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,44470209)
	e2:SetCondition(c44470209.con1)
	e2:SetTarget(c44470209.target1)
	e2:SetOperation(c44470209.operation1)
	c:RegisterEffect(e2)
	--tograve2
	local e22=Effect.CreateEffect(c)
	e22:SetCategory(CATEGORY_TOGRAVE)
	e22:SetDescription(aux.Stringid(44470209,2))
	e22:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e22:SetProperty(EFFECT_FLAG_DELAY)
	e22:SetCode(EVENT_SPSUMMON_SUCCESS)
	e22:SetRange(LOCATION_SZONE)
	e22:SetCountLimit(1,44470209)
	e22:SetCondition(c44470209.con2)
	e22:SetTarget(c44470209.target2)
	e22:SetOperation(c44470209.operation2)
	c:RegisterEffect(e22)
	--Release
	local e23=Effect.CreateEffect(c)
	--e23:SetCategory(CATEGORY_TOGRAVE)
	e23:SetDescription(aux.Stringid(44470209,3))
	e23:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e23:SetProperty(EFFECT_FLAG_DELAY)
	e23:SetCode(EVENT_SPSUMMON_SUCCESS)
	e23:SetRange(LOCATION_SZONE)
	e23:SetCountLimit(1,44470209)
	e23:SetCondition(c44470209.con3)
	e23:SetTarget(c44470209.target3)
	e23:SetOperation(c44470209.operation3)
	c:RegisterEffect(e23)
	--tograve
	local e24=Effect.CreateEffect(c)
	e24:SetCategory(CATEGORY_DRAW)
	e24:SetDescription(aux.Stringid(44470209,4))
	e24:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e24:SetProperty(EFFECT_FLAG_DELAY)
	e24:SetCode(EVENT_SPSUMMON_SUCCESS)
	e24:SetRange(LOCATION_SZONE)
	e24:SetCountLimit(1,44470209)
	e24:SetCondition(c44470209.con4)
	e24:SetTarget(c44470209.target4)
	e24:SetOperation(c44470209.operation4)
	c:RegisterEffect(e24)
end
--Activate
function c44470209.filter(c)
	return c:IsCode(44470221,44470220,44470222,44470219) 
	and c:IsAbleToHand()
end
function c44470209.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470209.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44470209.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44470209.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c44470209.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:GetSummonPlayer()==tp and tc:IsFaceup()
	and tc:IsCode(44470221) 
end
function c44470209.con2(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:GetSummonPlayer()==tp and tc:IsFaceup()
	and tc:IsCode(44470220) 
end
function c44470209.con3(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:GetSummonPlayer()==tp and tc:IsFaceup()
	and tc:IsCode(44470222) 
end
function c44470209.con4(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:GetSummonPlayer()==tp and tc:IsFaceup()
	and tc:IsCode(44470219) 
end
--cost
function c44470209.costfilter(c)
	return c:IsDiscardable()
end
function c44470209.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470209.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c44470209.costfilter,1,1,REASON_COST+REASON_DISCARD,nil)
end
--tograve
function c44470209.sfilter(c)
	return c:IsType(TYPE_CONTINUOUS) and c:IsAbleToGrave()
end
function c44470209.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470209.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c44470209.operation1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44470209.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
--tograve2
function c44470209.filter2(c)
	return c:IsAbleToGrave()
end
function c44470209.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470209.filter2,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_REMOVED)
end
function c44470209.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44470209.filter2,tp,LOCATION_REMOVED,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
--Release
function c44470209.rfilter(c,tp)
	return c:IsReleasable()
end
function c44470209.target3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c44470209.rfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c44470209.rfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	Duel.SelectTarget(tp,c44470209.rfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil,tp)
end
function c44470209.operation3(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Release(tc,REASON_EFFECT)>0 then

	end
end
--draw
function c44470209.target4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c44470209.operation4(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end