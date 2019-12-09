--鱼禁止上岸人禁止下水
function c26801009.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c26801009.actcon)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c26801009.target)
	e2:SetValue(0)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_SET_DEFENSE_FINAL)
	c:RegisterEffect(e3)
	--Pos Change
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_SET_POSITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTarget(c26801009.target)
	e5:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e5:SetValue(POS_FACEUP_DEFENSE)
	c:RegisterEffect(e5)
end
function c26801009.cfilter(c)
	return c:IsRace(RACE_FISH)
end
function c26801009.actcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c26801009.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c26801009.target(e,c)
	return c:IsRace(RACE_FISH)
end
