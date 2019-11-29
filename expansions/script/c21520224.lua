--星曜圣装-壁水獝
function c21520224.initial_effect(c)
	c:SetSPSummonOnce(21520224)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(21520224,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c21520224.sprcon)
	e0:SetOperation(c21520224.sprop)
	c:RegisterEffect(e0)
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e01:SetCode(EFFECT_SPSUMMON_CONDITION)
	e01:SetValue(c21520224.splimit)
	c:RegisterEffect(e01)
	--ignition effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520224,1))
	e2:SetCategory(CATEGORY_DECKDES+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c21520224.igtg)
	e2:SetOperation(c21520224.igop)
	c:RegisterEffect(e2)
end
c21520224.card_code_list={21520114}
function c21520224.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0xa491)
end
function c21520224.spfilter(c)
	return c:IsCode(21520114) and c:IsAbleToRemoveAsCost()
end
function c21520224.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c21520224.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCountFromEx(tp)>0 
end
function c21520224.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local player=e:GetHandlerPlayer()
	local rg=Duel.SelectMatchingCard(player,c21520224.spfilter,player,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520224.igfilter(c)
	return not c:IsPublic() and c:IsSetCard(0x491)
end
function c21520224.tgfilter(c)
	return c:IsAbleToGrave()
end
function c21520224.igtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21520224.igfilter,tp,LOCATION_HAND,0,1,nil) 
		and Duel.IsExistingMatchingCard(c21520224.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c21520224.igop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local g=Duel.GetMatchingGroup(c21520224.igfilter,p,LOCATION_HAND,0,nil)
	local dg=Duel.GetMatchingGroup(c21520224.tgfilter,p,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and dg:GetCount()>0 then 
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_CONFIRM)
		local pg=g:Select(p,1,g:GetCount(),nil)
		Duel.ConfirmCards(1-p,pg)
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TOGRAVE)
		d=pg:GetCount()
		local tdg=dg:Select(p,1,d,nil)
		if Duel.SendtoGrave(tdg,REASON_EFFECT)>0 and Duel.SelectYesNo(1-p,aux.Stringid(21520224,2)) then 
			d=Duel.GetOperatedGroup():FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)
			Duel.Draw(1-p,d,REASON_EFFECT)
		end
	end
end
