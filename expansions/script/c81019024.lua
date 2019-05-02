--美国·圣地亚鸽
function c81019024.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c81019024.target)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	c:RegisterEffect(e3)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCondition(c81019024.descon)
	e2:SetTarget(c81019024.destg)
	e2:SetOperation(c81019024.desop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=aux.AddRitualProcGreaterCode(c,81019025)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCode(0)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(aux.bfgcost)
end
function c81019024.target(e,c)
	return c:IsType(TYPE_NORMAL) and c:IsType(TYPE_PENDULUM)
end
function c81019024.cfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsType(TYPE_PENDULUM) and c:IsControler(tp)
end
function c81019024.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c81019024.cfilter,1,nil,tp)
end
function c81019024.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c81019024.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
