--光波核心
function c600022.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600022,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c600022.target)
	e2:SetOperation(c600022.activate)
	c:RegisterEffect(e2)  
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(600022,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,600022)
	e3:SetCost(c600022.cost)
	e3:SetTarget(c600022.thtg)
	e3:SetOperation(c600022.thop)
	c:RegisterEffect(e3)  
	--copy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCountLimit(1,6000022)
	e4:SetCondition(c600022.rkcon)
	e4:SetTarget(c600022.rktg)
	e4:SetOperation(c600022.rkop)
	c:RegisterEffect(e4)
end
function c600022.tgfilter(c,tp)
	return c:IsSetCard(0xe5) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
		and Duel.IsExistingMatchingCard(c600022.thfilter,tp,LOCATION_DECK,0,1,c,c:GetCode())
end
function c600022.thfilter(c,code)
	return c:IsCode(code) and c:IsAbleToHand()
end
function c600022.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c600022.tgfilter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c600022.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c600022.tgfilter,tp,LOCATION_DECK,0,1,1,nil,tp)
	local tc=g:GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_GRAVE) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=Duel.SelectMatchingCard(tp,c600022.thfilter,tp,LOCATION_DECK,0,1,1,nil,tc:GetCode())
		if sg:GetCount()>0 then
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
function c600022.cfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSetCard(0xe5) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c600022.thfilter,tp,LOCATION_DECK,LOCATION_DECK,1,nil,c:GetCode())
end
function c600022.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c600022.cfilter,tp,LOCATION_SZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c600022.cfilter,tp,LOCATION_SZONE,0,1,1,e:GetHandler())
	e:SetLabel(g:GetFirst():GetCode())
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_COST,e:GetHandler())
end
function c600022.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c600022.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c600022.thfilter,tp,LOCATION_DECK,0,1,1,nil,e:GetLabel())
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c600022.rkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_SZONE)
end
function c600022.rkfilter(c,tp)
	return c:IsFaceup()
end
function c600022.lvfilter(c,rk)
	return c:IsSetCard(0xe5) and c:IsType(TYPE_MONSTER)
end
function c600022.rktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c600022.rkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c600022.rkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	e:SetLabelObject(g:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c600022.lvfilter,tp,LOCATION_GRAVE,0,1,1,g:GetFirst(),g:GetFirst():GetRank())
end
function c600022.rkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=e:GetLabelObject()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local lc=tg:GetFirst()
	if lc==tc then lc=tg:GetNext() end
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and lc:IsRelateToEffect(e) and lc:IsSetCard(0xe5) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(lc:GetCode())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_ATTACK)
		e2:SetValue(lc:GetAttack())
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2) 
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_SET_DEFENSE)
		e3:SetValue(lc:GetDefense())
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		local e4=Effect.CreateEffect(e:GetHandler())
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_DISABLE)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e4)
		local e5=Effect.CreateEffect(e:GetHandler())
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetCode(EFFECT_DISABLE_EFFECT)
		e5:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e5)
	  end
end