--古夕幻历-诀断誓约
function c44460075.initial_effect(c)
	--Activate1
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c44460075.condition)
	e1:SetTarget(c44460075.target)
	e1:SetOperation(c44460075.activate)
	c:RegisterEffect(e1)
	--Activate2
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e11:SetType(EFFECT_TYPE_ACTIVATE)
	e11:SetCode(EVENT_SUMMON)
	e11:SetCondition(c44460075.condition)
	e11:SetTarget(c44460075.target2)
	e11:SetOperation(c44460075.activate2)
	c:RegisterEffect(e11)
	local e21=e11:Clone()
	e21:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e21)
	local e31=e11:Clone()
	e31:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e31)
	--act in hand
	local e25=Effect.CreateEffect(c)
	e25:SetType(EFFECT_TYPE_SINGLE)
	e25:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e25:SetCondition(c44460075.handcon)
	c:RegisterEffect(e25)
end
--Activate1
function c44460075.cfilter(c)
	return c:IsFaceup() and c:IsCode(44460050)
end
function c44460075.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44460075.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
end
function c44460075.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,1,0,0)
	end
end
function c44460075.desfilter(c)
	return c:IsFaceup() and c:IsCode(44460050)
end
function c44460075.activate(e,tp,eg,ep,ev,re,r,rp)
	local ec=re:GetHandler()
	if Duel.NegateActivation(ev) and ec:IsRelateToEffect(re) then
		ec:CancelToGrave()
		if Duel.SendtoDeck(ec,nil,2,REASON_EFFECT)~=0 and ec:IsLocation(LOCATION_DECK+LOCATION_EXTRA) then
			local g=Duel.GetMatchingGroup(c44460075.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
			if g:GetCount()>0 then
				Duel.BreakEffect()
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	            local sg=Duel.GetMatchingGroup(c44460075.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	            Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
			end
		end
	end
end
--Activate2
function c44460075.filter(c)
	return c:IsFaceup() and c:IsCode(44460054)
end
function c44460075.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44460075.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD0,1,nil)
		and Duel.GetCurrentChain()==0
end
function c44460075.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460075.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,eg:GetCount(),0,0)
end
function c44460075.activate2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.SendtoDeck(eg,nil,2,REASON_EFFECT)
	local g=Duel.GetMatchingGroup(c44460075.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	    local sg=Duel.GetMatchingGroup(c44460075.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	    Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
	end
end
--act in hand
function c44460075.handcon(e)
	return Duel.IsExistingMatchingCard(c44460075.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
    and Duel.IsExistingMatchingCard(c44460075.filter,e:GetHandlerPlayer(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end