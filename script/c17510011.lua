--折返的白玉楼二人组
function c17510011.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,c17510011.synfil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--todeck
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_DECK)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,17510011)
	e1:SetCondition(c17510011.tdcon)
	e1:SetTarget(c17510011.tdtg)
	e1:SetOperation(c17510011.tdop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,17510012)
	e2:SetTarget(c17510011.sumtg)
	e2:SetOperation(c17510011.sumop)
	c:RegisterEffect(e2)
end
c17510011.setname="FloWBacK"
function c17510011.synfil(c)
	return c.setname=="FloWBacK"
end
function c17510011.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c17510011.spfilter(c)
	return c.setname=="FloWBacK" and c:IsAbleToHand()
end
function c17510011.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17510011.spfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_REMOVED)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_REMOVED)
end
function c17510011.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c17510011.spfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		local tc=g:GetFirst()
		if tc:IsType(TYPE_MONSTER) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.SelectYesNo(tp,aux.Stringid(17510011,0)) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.SendtoHand(tc,tp,REASON_EFFECT)
		end
	end
end
function c17510011.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_GRAVE+LOCATION_REMOVED,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,2,0,LOCATION_GRAVE+LOCATION_REMOVED)
end
function c17510011.sumop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.HintSelection(g1) 
		if Duel.SendtoDeck(g1,nil,2,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		local g2=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,0,LOCATION_GRAVE+LOCATION_REMOVED,1,1,nil)
		if g2:GetCount()>0 then
			Duel.HintSelection(g2)
			Duel.SendtoDeck(g2,nil,2,REASON_EFFECT)
		end
		end
	end
end