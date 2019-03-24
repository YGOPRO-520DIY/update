--光波扩散
function c600028.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c600028.target)
	e1:SetOperation(c600028.activate)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c600028.reptg)
	e2:SetValue(c600028.repval)
	e2:SetOperation(c600028.repop)
	c:RegisterEffect(e2)
end
function c600028.filter1(c)
	return c:IsFaceup() and c:GetAttack()>=3000 and c:IsSetCard(0xe5) 
end
function c600028.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0xe5) 
end
function c600028.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c600028.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c600028.filter1,tp,LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(52128900,0))
	local g1=Duel.SelectTarget(tp,c600028.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(52128900,1))
	local g2=Duel.SelectTarget(tp,c600028.filter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	e:SetLabelObject(g1:GetFirst())
	
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetProperty(EFFECT_FLAG_OATH)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c600028.ftarget)
	e2:SetLabel(g2:GetFirst():GetFieldID())
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c600028.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc1=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc2=g:GetFirst()
	if tc1==tc2 then tc2=g:GetNext() end
	if tc1:IsRelateToEffect(e) and tc1:IsFaceup() and tc2:IsRelateToEffect(e) and tc2:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc2:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(0)
		tc1:RegisterEffect(e2)
	end
end
function c600028.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c600028.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xe5) and c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_MZONE)
		and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE)
end
function c600028.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c600028.repfilter,1,nil,tp) end
	return Duel.SelectYesNo(tp,aux.Stringid(600028,0))
end
function c600028.repval(e,c)
	return c600028.repfilter(c,e:GetHandlerPlayer())
end
function c600028.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
