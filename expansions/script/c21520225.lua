--星曜圣装-奎木狼
function c21520225.initial_effect(c)
	c:SetSPSummonOnce(21520225)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(21520225,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c21520225.sprcon)
	e0:SetOperation(c21520225.sprop)
	c:RegisterEffect(e0)
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e01:SetCode(EFFECT_SPSUMMON_CONDITION)
	e01:SetValue(c21520225.splimit)
	c:RegisterEffect(e01)
	--ignition effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520225,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c21520225.igtg)
	e2:SetOperation(c21520225.igop)
	c:RegisterEffect(e2)
end
c21520225.card_code_list={21520115}
function c21520225.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0xa491)
end
function c21520225.spfilter(c)
	return c:IsCode(21520115) and c:IsAbleToRemoveAsCost()
end
function c21520225.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c21520225.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCountFromEx(tp)>0 
end
function c21520225.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local player=e:GetHandlerPlayer()
	local rg=Duel.SelectMatchingCard(player,c21520225.spfilter,player,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520225.igfilter(c)
	return c:IsAbleToHand() and c:IsSetCard(0x491)
end
function c21520225.igtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,tp,LOCATION_ONFIELD)
end
function c21520225.igop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,0,nil)
	if g:GetCount()>0 then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELF)
		local sg=g:Select(tp,1,g:GetCount(),nil)
		local ct=Duel.Destroy(sg,REASON_EFFECT)
		if ct>0 and Duel.IsExistingMatchingCard(c21520225.igfilter,tp,LOCATION_DECK,0,1,nil) then 
			Duel.BreakEffect()
			local dg=Duel.GetMatchingGroup(c21520225.igfilter,tp,LOCATION_DECK,0,nil)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local thg=dg:Select(tp,1,math.min(ct,dg:GetCount()),nil)
			Duel.SendtoHand(thg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,thg)
		end
	end
end
