function c2035.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0)
	e1:SetCondition(c2035.condition)
	e1:SetTarget(c2035.target)
	e1:SetOperation(c2035.activate)
	c:RegisterEffect(e1)
end
function c2035.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3903) 
end
function c2035.filter2(c)
	return c:IsFaceup() and (c:IsSetCard(0x6904) or c:IsSetCard(0x5904))
end
function c2035.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c2035.filter,tp,LOCATION_ONFIELD,0,1,nil)
	and Duel.IsExistingMatchingCard(c2035.filter2,tp,LOCATION_MZONE,0,1,nil)
end
function c2035.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c2035.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c2035.filter2,tp,LOCATION_MZONE,0,1,nil)
	and  Duel.GetLocationCount(tp,LOCATION_SZONE)>=2 
	and  Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_EXTRA,0,3,nil,0x3903)	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c2035.filter2,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c2035.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_EXTRA,0,nil,0x3903)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=1 then return end
	if g:GetCount()>=3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local sg=g:Select(tp,3,3,nil)
		Duel.ConfirmCards(1-tp,sg)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_EQUIP)
		local tg=sg:RandomSelect(1-tp,2,2,nil)
		local cg=tg:GetFirst()
		while cg do
		if cg and tc:IsFaceup() and tc:IsRelateToEffect(e)  then 
		Duel.Equip(tp,cg,tc)
		--Add Equip limit
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c2035.eqlimit)
		cg:RegisterEffect(e1)
		else Duel.SendtoGrave(cg,REASON_EFFECT) 
		end
		cg=tg:GetNext()
		end
	end
end
function c2035.eqlimit(e,c)
	return  c:GetControler()==e:GetHandlerPlayer() or e:GetHandler():GetEquipTarget()==c
end