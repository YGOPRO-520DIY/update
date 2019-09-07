--星空，迷茫与折返
function c17510032.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,17510032)
	e1:SetCondition(c17510032.condition)
	e1:SetTarget(c17510032.target)
	e1:SetOperation(c17510032.activate)
	c:RegisterEffect(e1)
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_DECK)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,17510031)
	e2:SetCondition(c17510032.tdcon)
	e2:SetTarget(c17510032.tdtg)
	e2:SetOperation(c17510032.tdop)
	c:RegisterEffect(e2)
end
c17510032.setname="FloWBacK"
function c17510032.cfilter(c)
	return c:IsFaceup() and c.setname=="FloWBacK" and c:IsAbleToDeck()
end
function c17510032.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17510032.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsChainNegatable(ev) and rp~=tp
end
function c17510032.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,1,0,0)
	end
end
function c17510032.activate(e,tp,eg,ep,ev,re,r,rp)
	local ec=re:GetHandler()
	if Duel.NegateActivation(ev) and ec:IsRelateToEffect(re) then
		ec:CancelToGrave()
		if Duel.SendtoDeck(ec,nil,2,REASON_EFFECT)~=0 and ec:IsLocation(LOCATION_DECK+LOCATION_EXTRA) then
			local g=Duel.GetMatchingGroup(c17510032.cfilter,tp,LOCATION_ONFIELD,0,aux.ExceptThisCard(e))
			if g:GetCount()>0 then
				Duel.BreakEffect()
				local sg=g:Select(tp,1,1,nil)
				Duel.HintSelection(sg)
				Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
			end
		end
	end
end

function c17510032.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) 
end
function c17510032.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	 if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c17510032.tdop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),1-tp,REASON_EFFECT)
	end
end