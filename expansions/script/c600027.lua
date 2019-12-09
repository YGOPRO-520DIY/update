--光波复制魔术
function c600027.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(0,0x1e0+TIMING_DRAW)
	c:RegisterEffect(e1)   
	--copy trap
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600027,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetHintTiming(0,0x11e0)
	e2:SetCountLimit(1,600027)
	e2:SetCost(c600027.cost)
	e2:SetTarget(c600027.target)
	e2:SetOperation(c600027.operation)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(600027,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,5450057)
	e3:SetTarget(c600027.thtg)
	e3:SetOperation(c600027.thop)
	c:RegisterEffect(e3)
end
function c600027.filter(c)
	return c:GetType()==TYPE_TRAP and c:IsAbleToGraveAsCost() and c:CheckActivateEffect(true,true,false)~=nil
end
function c600027.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c600027.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		local te=e:GetLabelObject()
		local tg=te:GetTarget()
		return tg(e,tp,eg,ep,ev,re,r,rp,0,chkc)
	end
	if chk==0 then
		if e:GetLabel()==0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c600027.filter,tp,LOCATION_DECK,0,1,nil)
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c600027.filter,tp,LOCATION_DECK,0,1,1,nil)
	local te=g:GetFirst():CheckActivateEffect(true,true,false)
	e:SetLabelObject(te)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_COST)
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	local tg=te:GetTarget()
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c600027.operation(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
function c600027.thfilter(c,tp)
	return c:IsSetCard(0xe5) and c:IsType(TYPE_CONTINUOUS) and c:IsType(TYPE_SPELL) and (c:IsAbleToHand() or (c:GetActivateEffect():IsActivatable(tp) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0))
end
function c600027.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c600027.thfilter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c600027.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(600027,3))
	local g=Duel.SelectMatchingCard(tp,c600027.thfilter,tp,LOCATION_DECK,0,1,1,nil,tp)
	local tc=g:GetFirst()
	if tc then
		local b1=tc:IsAbleToHand()
		local b2=tc:GetActivateEffect():IsActivatable(tp) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		if b1 and (not b2 or Duel.SelectYesNo(tp,aux.Stringid(600027,2))) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
		end
	end
end
