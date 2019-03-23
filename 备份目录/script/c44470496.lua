--圣光的神明之羽
function c44470496.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(c44470496.condition)
	e1:SetCost(c44470496.cost)
	e1:SetTarget(c44470496.target)
	e1:SetOperation(c44470496.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)
	--tohand
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_QUICK_O)
	e22:SetCode(EVENT_FREE_CHAIN)
	e22:SetHintTiming(0,TIMING_END_PHASE)
	e22:SetRange(LOCATION_GRAVE)
	e22:SetCountLimit(1,44470496)
	--e22:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e22:SetCondition(c44470496.condition1)
	e22:SetCost(aux.bfgcost)
	e22:SetTarget(c44470496.stg)
	e22:SetOperation(c44470496.sop)
	c:RegisterEffect(e22)
end
function c44470496.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0
end
function c44470496.tfilter(c)
	return c:IsAbleToHandAsCost() and c:IsType(TYPE_NORMAL) and not c:IsType(TYPE_TOKEN)
end
function c44470496.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470496.tfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c44470496.tfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoHand(g,nil,REASON_COST)
end
function c44470496.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,eg,eg:GetCount(),0,0)
end
function c44470496.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.SendtoHand(eg,nil,REASON_EFFECT)
end
--tohand
function c44470496.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c44470496.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c44470496.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c44470496.filter,tp,LOCATION_ONFIELD,0,1,c) end
	local sg=Duel.GetMatchingGroup(c44470496.filter,tp,LOCATION_ONFIELD,0,c)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
end
function c44470496.sop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c44470496.filter,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end