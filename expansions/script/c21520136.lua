--星曜直列
function c21520136.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21520136,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c21520136.condition)
	e1:SetTarget(c21520136.target)
	e1:SetOperation(c21520136.activate)
	c:RegisterEffect(e1)
end
function c21520136.dfilter(c)
	return (c:IsSetCard(0x491) and not c:IsSetCard(0x5491) and not c:IsSetCard(0xa491)) and c:IsType(TYPE_MONSTER)
end
function c21520136.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c21520136.dfilter,tp,LOCATION_GRAVE,0,nil)
	local ct=g:GetClassCount(Card.GetCode)
	return ct>6
end
function c21520136.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c21520136.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local ct=Duel.Draw(p,d,REASON_EFFECT)
	if ct==0 then return end
	local g=Duel.GetMatchingGroup(c21520136.thfilter,p,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(p,aux.Stringid(21520136,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_ATOHAND)
		local g1=g:FilterSelect(p,c21520136.thfilter,1,1,nil)
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-p,g1)
	end
end
function c21520136.thfilter(c)
	return c:IsSetCard(0x5491) and c:IsAbleToHand()
end