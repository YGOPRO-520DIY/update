--星曜引力
function c21520142.initial_effect(c)
	--activity
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21520142,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c21520142.target)
	e1:SetOperation(c21520142.operation)
	c:RegisterEffect(e1)
	--power up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520142,1))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCountLimit(1)
	e2:SetCondition(c21520142.pcon)
	e2:SetTarget(c21520142.ptg)
	e2:SetOperation(c21520142.pop)
	c:RegisterEffect(e2)
end
function c21520142.eqfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EQUIP)
end
function c21520142.filter(c)
	return c:IsSetCard(0x491) and c:IsFaceup()
end
function c21520142.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(c21520142.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c21520142.eqfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c21520142.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c21520142.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local g=Duel.GetMatchingGroup(c21520142.eqfilter,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
		local ec=g:GetFirst()
		while ec do
			Duel.Equip(tp,ec,tc,false,true)
			ec=g:GetNext()
		end
		Duel.EquipComplete()
	end
end
function c21520142.pcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,21520146)
end
function c21520142.ptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c21520142.pop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local asum=0
	local dsum=0
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,tc)
	local mc=g:GetFirst()
	while mc do
		asum=asum+mc:GetAttack()
		dsum=dsum+mc:GetDefense()
		mc=g:GetNext()
	end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(asum)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetValue(dsum)
		tc:RegisterEffect(e2)
	end
end
