--失络自掘者
function c65030107.initial_effect(c)
	 c:EnableReviveLimit()
	--link summon
	aux.AddLinkProcedure(c,c65030107.linkfilter,1,1)
	--splimit
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_SPSUMMON_COST)
	e0:SetCost(c65030107.spcost)
	c:RegisterEffect(e0)
	--zisu
	 local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SUMMON)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(1,1)
		e1:SetTarget(c65030107.splimit)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		c:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CANNOT_MSET)
		c:RegisterEffect(e3)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CANNOT_ACTIVATE)
		e4:SetValue(c65030107.aclimit)
		c:RegisterEffect(e4)
	--tohand
	 local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCost(c65030107.cost)
	e5:SetTarget(c65030107.target)
	e5:SetOperation(c65030107.activate)
	c:RegisterEffect(e5)
	--self destroy
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_SELF_DESTROY)
	e6:SetCondition(c65030107.sdcon)
	c:RegisterEffect(e6)
	--
	Duel.AddCustomActivityCounter(65030107,ACTIVITY_CHAIN,c65030107.chainfilter)
end
function c65030107.linkfilter(c)
	return not c:IsLinkType(TYPE_LINK)
end
function c65030107.sdcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetMatchingGroupCount(Card.IsSetCard,tp,LOCATION_GRAVE,0,nil,0xada9)>=3
end
function c65030107.chainfilter(re,tp,cid)
	return false
end
function c65030107.spcost(e,c,tp,st)
	if bit.band(st,SUMMON_TYPE_LINK)~=SUMMON_TYPE_LINK then return true end
	return Duel.GetCustomActivityCount(65030107,tp,ACTIVITY_CHAIN)==0
end
function c65030107.splimit(e,c)
	return c:GetSummonPlayer()==e:GetHandlerPlayer()
end
function c65030107.aclimit(e,re)
	return not re:GetHandler():IsCode(65030107) and re:GetOwnerPlayer()==e:GetHandlerPlayer()
end
function c65030107.costfil(c)
	return c:IsSetCard(0xada9) and c:IsAbleToGraveAsCost()
end
function c65030107.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65030107.costfil,tp,LOCATION_DECK,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,c65030107.costfil,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c65030107.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65030107.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end