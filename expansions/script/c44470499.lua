--寂静的神明之羽
function c44470499.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	--e1:SetCountLimit(1,44470499+EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
	local g=Group.CreateGroup()
	g:KeepAlive()
	--adjust
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetOperation(c44470499.adjustop)
	e2:SetLabelObject(g)
	c:RegisterEffect(e2)
	--act limit
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_FIELD)
	e21:SetRange(LOCATION_ONFIELD)
	e21:SetCode(EFFECT_CANNOT_TRIGGER)
	e21:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e21:SetTarget(c44470499.etarget)
	e21:SetLabelObject(g)
	c:RegisterEffect(e21)
	--cannot attack
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD)
	e22:SetCode(EFFECT_CANNOT_ATTACK)
	e22:SetRange(LOCATION_ONFIELD)
	e22:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e22:SetTarget(c44470499.etarget)
	e22:SetLabelObject(g)
	c:RegisterEffect(e22)
	--Def up
	local e24=Effect.CreateEffect(c)
	e24:SetType(EFFECT_TYPE_FIELD)
	e24:SetRange(LOCATION_ONFIELD)
	e24:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e24:SetCode(EFFECT_UPDATE_DEFENSE)
	e24:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_NORMAL))
	e24:SetValue(1500)
	c:RegisterEffect(e24)
end
function c44470499.adjustop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local preg=e:GetLabelObject()
	if g:GetCount()>0 then
		local ag=g:GetMaxGroup(Card.GetAttack)
		if ag:Equal(preg) then return end
		preg:Clear()
		preg:Merge(ag)
	else
		if preg:GetCount()==0 then return end
		preg:Clear()
	end
	Duel.AdjustInstantly(e:GetHandler())
	Duel.Readjust()
end
function c44470499.etarget(e,c)
	return e:GetLabelObject():IsContains(c)
	--and c:IsType(TYPE_EFFECT)
end
