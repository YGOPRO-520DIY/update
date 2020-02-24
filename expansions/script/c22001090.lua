--杨玉环
function c22001090.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCondition(c22001090.con1)
	e1:SetTarget(c22001090.tgtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetTargetRange(LOCATION_GRAVE,LOCATION_GRAVE)
	e2:SetValue(1)
	e2:SetTarget(c22001090.tgtg)
	e2:SetCondition(c22001090.con2)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetRange(LOCATION_PZONE)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetTargetRange(LOCATION_REMOVED,LOCATION_REMOVED)
	e3:SetValue(1)
	e3:SetTarget(c22001090.tgtg)
	e3:SetCondition(c22001090.con3)
	c:RegisterEffect(e3)
end
function c22001090.tgtg(e,c)
	return c:IsType(TYPE_MONSTER)
end
function c22001090.cfilter1(c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL)
end
function c22001090.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c22001090.cfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c22001090.cfilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION)
end
function c22001090.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c22001090.cfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c22001090.cfilter3(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK)
end
function c22001090.con3(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c22001090.cfilter3,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end