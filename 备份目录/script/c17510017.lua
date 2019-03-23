--折返的FAG 短剑
function c17510017.initial_effect(c)
	--synchro summon
	aux.AddSynchroMixProcedure(c,c17510017.synfil,aux.NonTuner(c17510017.synfil),nil,c17510017.synfil,0,99)
	c:EnableReviveLimit()
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,17510017)
	e1:SetCondition(c17510017.condition)
	e1:SetTarget(c17510017.target)
	e1:SetOperation(c17510017.activate)
	c:RegisterEffect(e1)
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_DECK)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,17510018)
	e2:SetCondition(c17510017.tdcon)
	e2:SetTarget(c17510017.tdtg)
	e2:SetOperation(c17510017.tdop)
	c:RegisterEffect(e2)
	--Destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetCountLimit(1,17510019)
	e3:SetTarget(c17510017.desreptg)
	c:RegisterEffect(e3)
end
c17510017.setname="FloWBacK"
function c17510017.synfil(c)
	return c.setname=="FloWBacK"
end
function c17510017.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9e)
end
function c17510017.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandlerPlayer()~=tp and Duel.IsChainNegatable(ev)
end
function c17510017.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,1,0,0)
	end
end
function c17510017.activate(e,tp,eg,ep,ev,re,r,rp)
	local ec=re:GetHandler()
	if Duel.NegateActivation(ev) and ec:IsRelateToEffect(re) then
		ec:CancelToGrave()
		Duel.SendtoDeck(ec,nil,2,REASON_EFFECT)
	end
end

function c17510017.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c17510017.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,1,nil) and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_GRAVE)
end
function c17510017.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,1,1,nil)
	local g2=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,0,LOCATION_GRAVE,1,1,nil)
	if g1:GetCount()>0 and g2:GetCount()>0 then
		g1:Merge(g2)
		Duel.HintSelection(g1)
		Duel.SendtoDeck(g1,nil,2,REASON_EFFECT)
	end
end
function c17510017.filter(c)
	return c.setname=="FloWBacK" and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c17510017.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT))
		and Duel.IsExistingMatchingCard(c17510017.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,c17510017.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT+REASON_REPLACE)
		return true
	else return false end
end