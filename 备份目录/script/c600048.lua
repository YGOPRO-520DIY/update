--树界的呼唤
function c600048.initial_effect(c)
	 --activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600048,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,600048)
	e1:SetCost(c600048.cost)
	e1:SetTarget(c600048.target)
	e1:SetOperation(c600048.activate)
	c:RegisterEffect(e1)  
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600048,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,600048)
	e2:SetCondition(aux.exccon)
	e2:SetCost(c600048.descost)
	e2:SetTarget(c600048.destg)
	e2:SetOperation(c600048.desop)
	c:RegisterEffect(e2)
end
function c600048.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c600048.cfilter(c,tp)
	return c:IsSetCard(0x5115) and c:IsLocation(LOCATION_HAND) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c600048.filter1,tp,LOCATION_DECK,0,1,c,c:GetCode())
		and Duel.IsExistingMatchingCard(c600048.filter2,tp,LOCATION_DECK,0,1,c)
end
function c600048.filter1(c,code)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x5115) and not c:IsCode(code) and c:IsAbleToHand()
end
function c600048.filter2(c)
	return c:IsCode(600044) and c:IsAbleToHand()
end
function c600048.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c600048.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler(),tp)
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c600048.cfilter,tp,LOCATION_HAND,0,1,1,e:GetHandler(),tp)
	e:SetLabelObject(g:GetFirst())
	Duel.SendtoGrave(g,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK)
end
function c600048.activate(e,tp,eg,ep,ev,re,r,rp)
	local sc=e:GetLabelObject()
	local g1=Duel.GetMatchingGroup(aux.NecroValleyFilter(c600048.filter1),tp,LOCATION_DECK,0,sc,sc:GetCode())
	local g2=Duel.GetMatchingGroup(aux.NecroValleyFilter(c600048.filter2),tp,LOCATION_DECK,0,sc)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local gg=g2:Select(tp,1,1,nil)
	g:Merge(gg)
	if g:GetCount()==2 and Duel.SendtoHand(g,nil,REASON_EFFECT)>0 then
		Duel.ConfirmCards(1-tp,g)
		local og=Duel.GetOperatedGroup():Filter(Card.IsSummonable,nil,true,nil)
		if og:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(600048,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
			local sg=og:Select(tp,1,1,nil):GetFirst()
			Duel.Summon(tp,sg,true,nil)
		end
	end
end
function c600048.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c600048.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c600048.thfilter(c)
	return c:IsSetCard(0x5115) and c:IsAbleToHand()
end
function c600048.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c600048.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c600048.desfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler())
		and Duel.IsExistingMatchingCard(c600048.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c600048.desfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c600048.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c600048.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
