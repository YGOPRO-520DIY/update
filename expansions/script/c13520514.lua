local m=13520514
local list={13520510,13520530,13520501,13520502,13520504}
local cm=_G["c"..m]
cm.name="血式少女 爱丽丝"
function cm.initial_effect(c)
	aux.AddCodeList(c,list[5])
	--Pay LP
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_LVCHANGE+CATEGORY_ATKCHANGE+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(cm.plcon)
	e1:SetOperation(cm.plop)
	c:RegisterEffect(e1)
end
function cm.isset(c)
	return c:GetCode()>=list[1] and c:GetCode()<=list[2]
end
--Pay LP
function cm.lpcost(tp)
	local field=list[4]
	if Duel.IsPlayerAffectedByEffect(tp,field) then return (_G["c"..field]).baseCost
	else return 600 end
end
function cm.thfilter(c)
	return c:IsCode(list[5]) and c:IsAbleToHand()
end
function cm.plcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)>=cm.lpcost(tp)
end
function cm.plop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cost=cm.lpcost(tp)
	local t={}
	if Duel.CheckLPCost(tp,1*cost) and c:IsFaceup() and c:IsRelateToEffect(e) then
		table.insert(t,1)
	end
	if Duel.CheckLPCost(tp,2*cost) and c:IsFaceup() and c:IsRelateToEffect(e) then
		table.insert(t,2)
	end
	if Duel.CheckLPCost(tp,3*cost) and Duel.IsExistingMatchingCard(cm.thfilter,tp,LOCATION_DECK,0,1,nil) then
		table.insert(t,3)
	end
	local field=list[3]
	if Duel.IsPlayerAffectedByEffect(tp,field) and (_G["c"..field]).checkCost(c,e,tp,cost) then
		table.insert(t,(_G["c"..field]).extCost)
	end
	if #t==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(m,1))
	local lp=Duel.AnnounceNumber(tp,table.unpack(t))
	e:SetType(0)
	Duel.PayLPCost(tp,lp*cost)
	e:SetType(EFFECT_TYPE_IGNITION)
	if lp==2 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_TYPE)
		e1:SetValue(TYPE_TUNER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	elseif lp==3 then
		local tc=Duel.GetFirstMatchingCard(cm.thfilter,tp,LOCATION_DECK,0,nil)
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	elseif lp>1 then
		(_G["c"..field]).payCost(c,e,tp)
	end
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(lp)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end