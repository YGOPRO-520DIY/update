--虚无的元素魔法 零
function c17500023.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c17500023.damcon)
	e1:SetCost(c17500023.damcost)
	e1:SetTarget(c17500023.damtg)
	e1:SetOperation(c17500023.damop)
	c:RegisterEffect(e1)
end
c17500023.setname="ElementalSpell"
function c17500023.damfil(c)
	return c:IsCode(17500021) and c:IsFaceup()
end
function c17500023.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17500023.damfil,tp,LOCATION_MZONE,0,1,nil)
end
function c17500023.ftarget(e,c)
	return not c:IsCode(17500021)
end
function c17500023.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_OATH)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c17500023.ftarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c17500023.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)>0 end
	local g=Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,g,0,LOCATION_ONFIELD)
end
function c17500023.damop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end