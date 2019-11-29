--星曜圣装-张月鹿
function c21520236.initial_effect(c)
	c:SetSPSummonOnce(21520236)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(21520236,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c21520236.sprcon)
	e0:SetOperation(c21520236.sprop)
	c:RegisterEffect(e0)
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e01:SetCode(EFFECT_SPSUMMON_CONDITION)
	e01:SetValue(c21520236.splimit)
	c:RegisterEffect(e01)
	--ignition effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520236,1))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_COIN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c21520236.igtg)
	e2:SetOperation(c21520236.igop)
	c:RegisterEffect(e2)
end
c21520236.card_code_list={21520126}
function c21520236.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0xa491)
end
function c21520236.spfilter(c)
	return c:IsCode(21520126) and c:IsAbleToRemoveAsCost()
end
function c21520236.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c21520236.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCountFromEx(tp)>0 
end
function c21520236.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local player=e:GetHandlerPlayer()
	local rg=Duel.SelectMatchingCard(player,c21520236.spfilter,player,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520236.pfilter(c)
	return not c:IsPublic()
end
function c21520236.igtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_DECK,0,1,nil) 
		and Duel.IsExistingMatchingCard(Card.IsAbleToHand,1-tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c21520236.igop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c21520236.pfilter,tp,LOCATION_HAND,0,nil)
	local g2=Duel.GetMatchingGroup(c21520236.pfilter,1-tp,LOCATION_HAND,0,nil)
	local dg=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_DECK,LOCATION_DECK,nil)
	local val1,val2=0,0
	local pg=Group.CreateGroup()
	if g1:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(21520236,2)) then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg=g1:Select(tp,1,1,nil)
		pg:Merge(sg)
		val1=sg:GetFirst():GetAttack()+sg:GetFirst():GetDefense()
	end
	if g2:GetCount()>0 and Duel.SelectYesNo(1-tp,aux.Stringid(21520236,2)) then 
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_CONFIRM)
		local sg=g2:Select(1-tp,1,1,nil)
		pg:Merge(sg)
		val2=sg:GetFirst():GetAttack()+sg:GetFirst():GetDefense()
	end
	if (val1<=0 and val2<=0) then return end
	Duel.ConfirmCards(tp,pg)
	Duel.ConfirmCards(1-tp,pg)
	if val1==val2 then return end
	local coin=Duel.TossCoin(tp,1)
	if coin==0 then	
		if val1<val2 and dg:FilterCount(Card.IsControler,nil,tp)>0 and Duel.SelectYesNo(tp,aux.Stringid(21520236,3)) then 
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=dg:FilterSelect(tp,Card.IsControler,1,1,nil,tp)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		elseif val1>val2 and dg:FilterCount(Card.IsControler,nil,1-tp)>0 and Duel.SelectYesNo(1-tp,aux.Stringid(21520236,3)) then 
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
			local sg=dg:FilterSelect(1-tp,Card.IsControler,1,1,nil,1-tp)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(tp,sg)
		end
	else 
		if val1>val2 and dg:FilterCount(Card.IsControler,nil,tp)>0 and Duel.SelectYesNo(tp,aux.Stringid(21520236,3)) then 
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=dg:FilterSelect(tp,Card.IsControler,1,1,nil,tp)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		elseif val1<val2 and dg:FilterCount(Card.IsControler,nil,1-tp)>0 and Duel.SelectYesNo(1-tp,aux.Stringid(21520236,3)) then 
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
			local sg=dg:FilterSelect(1-tp,Card.IsControler,1,1,nil,1-tp)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(tp,sg)
		end
	end
end
