--审判的神明之羽
function c44470497.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	--e1:SetCountLimit(1,44470497+EFFECT_COUNT_CODE_OATH)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c44470497.con)
	e1:SetCost(c44470497.cost)
	e1:SetTarget(c44470497.tg)
	e1:SetOperation(c44470497.activate)
	c:RegisterEffect(e1)
	--sset
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_QUICK_O)
	e22:SetCode(EVENT_FREE_CHAIN)
	e22:SetHintTiming(0,TIMING_END_PHASE)
	e22:SetRange(LOCATION_GRAVE)
	e22:SetCountLimit(1,44470497)
	--e22:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e22:SetCondition(c44470497.condition)
	e22:SetCost(aux.bfgcost)
	e22:SetTarget(c44470497.stg)
	e22:SetOperation(c44470497.sop)
	c:RegisterEffect(e22)
end
--activate
function c44470497.con(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.IsChainNegatable(ev) or Duel.IsChainDisablable(ev)) 
	--and re:GetHandlerPlayer()~=tp
end
function c44470497.tfilter(c)
	return c:IsAbleToHandAsCost() and c:IsType(TYPE_NORMAL) and not c:IsType(TYPE_TOKEN)
	--and (c:GetLevel()>4 or c:GetLevel()<4)
end
function c44470497.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470497.tfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c44470497.tfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoHand(g,nil,REASON_COST)
end

function c44470497.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	end
end
function c44470497.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	Duel.NegateEffect(ev)
	--if re:GetHandler():IsRelateToEffect(re) then
		
	--end
end
--sset
function c44470497.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c44470497.filter(c)
	return c:IsSetCard(0x140) and c:IsType(TYPE_MONSTER)
end
function c44470497.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470497.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44470497.sop(e,tp,eg,ep,ev,re,r,rp)
	--if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44470497.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	end
end