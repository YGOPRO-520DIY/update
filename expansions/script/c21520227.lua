--星曜圣装-胃土雉
function c21520227.initial_effect(c)
	c:SetSPSummonOnce(21520227)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(21520227,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c21520227.sprcon)
	e0:SetOperation(c21520227.sprop)
	c:RegisterEffect(e0)
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e01:SetCode(EFFECT_SPSUMMON_CONDITION)
	e01:SetValue(c21520227.splimit)
	c:RegisterEffect(e01)
	--ignition effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520227,1))
	e2:SetCategory(CATEGORY_REMOVE+CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c21520227.igtg)
	e2:SetOperation(c21520227.igop)
	c:RegisterEffect(e2)
end
c21520227.card_code_list={21520117}
function c21520227.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0xa491)
end
function c21520227.spfilter(c)
	return c:IsCode(21520117) and c:IsAbleToRemoveAsCost()
end
function c21520227.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c21520227.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCountFromEx(tp)>0 
end
function c21520227.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local player=e:GetHandlerPlayer()
	local rg=Duel.SelectMatchingCard(player,c21520227.spfilter,player,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520227.igfilter(c,dp)
	return c:IsAbleToRemove() and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,dp,LOCATION_DECK,0,1,nil)
end
function c21520227.igtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21520227.igfilter,tp,LOCATION_GRAVE,0,1,nil,tp) 
		or Duel.IsExistingMatchingCard(c21520227.igfilter,1-tp,LOCATION_GRAVE,0,1,nil,1-tp) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,LOCATION_GRAVE)
end
function c21520227.igop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c21520227.igfilter,tp,LOCATION_GRAVE,0,nil,tp)
	local g2=Duel.GetMatchingGroup(c21520227.igfilter,1-tp,LOCATION_GRAVE,0,nil,1-tp)
	local b1=g1:GetCount()>0
	local b2=g2:GetCount()>0
	if b1 and not b2 then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rg=g1:Select(tp,1,1,nil)
		local dp=tp
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,dp,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(dp,Card.IsAbleToGrave,dp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoGrave(sg,nil,REASON_EFFECT)
	elseif not b1 and b2 then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rg=g2:Select(tp,1,1,nil)
		local dp=1-tp
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,dp,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(dp,Card.IsAbleToGrave,dp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoGrave(sg,nil,REASON_EFFECT)
	elseif b1 and b2 then 
		g1:Merge(g2)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rg=g1:Select(tp,1,1,nil)
		local dp=rg:GetFirst():GetControler()
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,dp,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(dp,Card.IsAbleToGrave,dp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoGrave(sg,nil,REASON_EFFECT)
	end
end
