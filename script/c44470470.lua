--星座召唤阵
function c44470470.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44470470,0))
	e11:SetRange(LOCATION_ONFIELD)
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e11:SetCountLimit(1,44470470)
	e11:SetTarget(c44470470.target)
	e11:SetOperation(c44470470.op)
	c:RegisterEffect(e11)
	--to hand
	local e22=Effect.CreateEffect(c)
	e22:SetCategory(CATEGORY_TOHAND)
	e22:SetType(EFFECT_TYPE_IGNITION)
	e22:SetCountLimit(1,44470470)
	e22:SetRange(LOCATION_GRAVE)
	e22:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e22:SetCost(aux.bfgcost)
	e22:SetTarget(c44470470.thtg)
	e22:SetOperation(c44470470.thop)
	c:RegisterEffect(e22)
end
function c44470470.filter(c)
	return c:IsSetCard(0x64f) and c:IsType(TYPE_MONSTER)
end
function c44470470.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470470.filter,tp,LOCATION_DECK,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44470470.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44470470.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	end
end
--to hand
function c44470470.thfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x64f) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c44470470.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_REMOVED) and c44470470.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44470470.thfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c44470470.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c44470470.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
