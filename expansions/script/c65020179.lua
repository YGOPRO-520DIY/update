--在魔梦夜的偶遇
function c65020179.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c65020179.condition)
	e1:SetTarget(c65020179.target)
	e1:SetOperation(c65020179.activate)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,65020179)
	e2:SetCost(c65020179.cost)
	e2:SetTarget(c65020179.tg)
	e2:SetOperation(c65020179.op)
	c:RegisterEffect(e2)
end
function c65020179.costfil(c)
	return (c:IsSetCard(0x5da7) and c:IsType(TYPE_SPIRIT)) and c:IsAbleToDeckAsCost()
end
function c65020179.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() and Duel.IsExistingMatchingCard(c65020179.costfil,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	local g=Duel.SelectMatchingCard(tp,c65020179.costfil,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.HintSelection(g)
	g:AddCard(e:GetHandler())
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c65020179.filter(c)
	return c:IsSetCard(0x5da7) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c65020179.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65020179.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65020179.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c65020179.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c65020179.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x5da7)
end
function c65020179.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c65020179.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsChainNegatable(ev) and ep~=tp
end
function c65020179.sumfil(c,e)
	return c:IsType(TYPE_SPIRIT) and c:IsSummonable(true,nil)
end
function c65020179.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local e1=Effect.CreateEffect(e:GetHandler())
	Duel.RegisterEffect(e1,tp)
	if chk==0 then 
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_EXTRA_RELEASE_SUM)
		e1:SetTargetRange(0,LOCATION_MZONE)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e1:SetCountLimit(1)
		return aux.nbcon(tp,re) and Duel.IsExistingMatchingCard(c65020179.sumfil,tp,LOCATION_HAND,0,1,nil) and Duel.GetMZoneCount(tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,tp,0)
	e1:Reset()
end
function c65020179.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_RELEASE_SUM)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetCountLimit(1)
	Duel.RegisterEffect(e1,tp)
	if Duel.NegateActivation(ev) and Duel.IsExistingMatchingCard(c65020179.sumfil,tp,LOCATION_HAND,0,1,nil) and Duel.GetMZoneCount(tp)>0 then
		local sg=Duel.SelectMatchingCard(tp,c65020179.sumfil,tp,LOCATION_HAND,0,1,1,nil,e)
		local sgc=sg:GetFirst()
		Duel.Summon(tp,sgc,true,nil)
	end
	e1:Reset()
end