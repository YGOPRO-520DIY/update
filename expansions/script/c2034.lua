--并非为了己身的荣光
function c2034.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c2034.target)
	e1:SetOperation(c2034.activate)
	c:RegisterEffect(e1)
end
function c2034.tgfilter(c)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c2034.cfilter,c:GetControler(),LOCATION_DECK,0,1,nil,c) and c:IsSetCard(0x5903)
end
function c2034.cfilter(c,tc)
	return c:IsSetCard(0x5903) and not c:IsCode(tc:GetCode()) and c:IsAbleToGrave() and c:IsType(TYPE_MONSTER)
end
function c2034.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c2034.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c2034.tgfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c2034.tgfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c2034.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c2034.cfilter,tp,LOCATION_DECK,0,1,1,nil,tc)
	if g:GetCount()>0 then
		local gc=g:GetFirst()
		if Duel.SendtoGrave(gc,REASON_EFFECT)~=0 and gc:IsLocation(LOCATION_GRAVE) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_CODE)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
			e1:SetValue(gc:GetCode())
			tc:RegisterEffect(e1)
		end
	elseif Duel.IsPlayerCanDiscardDeck(tp,1) then
		local cg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
		Duel.ConfirmCards(1-tp,cg)
		Duel.ConfirmCards(tp,cg)
		Duel.ShuffleDeck(tp)
	end
end