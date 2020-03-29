--燃烬的现实
function c26801021.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c26801021.condition)
	e1:SetTarget(c26801021.target)
	e1:SetOperation(c26801021.activate)
	c:RegisterEffect(e1)
end
function c26801021.condition(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return ep~=tp and loc==LOCATION_MZONE and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c26801021.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsAbleToChangeControler() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_CONTROL,eg,1,0,0)
	end
end
function c26801021.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.NegateActivation(ev) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and re:GetHandler():IsRelateToEffect(re) then
	   local tc=eg:GetFirst()
	   Duel.GetControl(tc,tp)
	   Duel.NegateRelatedChain(tc,RESET_TURN_SET)
	   local e2=Effect.CreateEffect(c)
	   e2:SetType(EFFECT_TYPE_SINGLE)
	   e2:SetCode(EFFECT_DISABLE)
	   e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	   tc:RegisterEffect(e2)
	   local e3=Effect.CreateEffect(c)
	   e3:SetType(EFFECT_TYPE_SINGLE)
	   e3:SetCode(EFFECT_DISABLE_EFFECT)
	   e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	   tc:RegisterEffect(e3)
	   local e4=Effect.CreateEffect(c)
	   e4:SetType(EFFECT_TYPE_SINGLE)
	   e4:SetCode(EFFECT_SET_ATTACK_FINAL)
	   e4:SetValue(2500)
	   e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	   tc:RegisterEffect(e4)
	   local e5=Effect.CreateEffect(c)
	   e5:SetType(EFFECT_TYPE_SINGLE)
	   e5:SetCode(EFFECT_CHANGE_CODE)
	   e5:SetValue(26800000)
	   e5:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	   tc:RegisterEffect(e5)
	end
end
