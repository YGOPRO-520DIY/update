--折返的旅人 奇诺
function c17510005.initial_effect(c)
	--todeck
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_DECK)
	e1:SetCountLimit(1,17510005)
	e1:SetCondition(c17510005.tdcon)
	e1:SetTarget(c17510005.tdtg)
	e1:SetOperation(c17510005.tdop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,17510006)
	e2:SetTarget(c17510005.sumtg)
	e2:SetOperation(c17510005.sumop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
c17510005.setname="FloWBacK"
function c17510005.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c17510005.spfilter(c)
	return c.setname=="FloWBacK" and c:IsAbleToHand() and c:IsType(TYPE_MONSTER)
end
function c17510005.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17510005.spfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c17510005.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c17510005.spfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c17510005.sumfil(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c17510005.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17510005.sumfil,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingMatchingCard(c17510005.sumfil,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,2,0,LOCATION_ONFIELD+LOCATION_HAND)
end
function c17510005.sumop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.SelectMatchingCard(tp,c17510005.sumfil,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.HintSelection(g1)
		if g1:GetFirst():IsLocation(LOCATION_HAND) then
			Duel.ConfirmCards(1-tp,g1)
		end
		if Duel.SendtoDeck(g1,nil,2,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		local g2=Duel.SelectMatchingCard(tp,c17510005.sumfil,tp,0,LOCATION_ONFIELD,1,1,nil)
		if g2:GetCount()>0 then
			Duel.HintSelection(g2)
			Duel.SendtoDeck(g2,nil,2,REASON_EFFECT)
		end
		end
	end
end

