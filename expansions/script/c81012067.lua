--自在周末·理子
function c81012067.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsRace,RACE_PYRO),1)
	c:EnableReviveLimit()
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1,81012067)
	e1:SetCondition(c81012067.atkcon)
	e1:SetCost(c81012067.atkcost)
	e1:SetOperation(c81012067.atkop)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c81012067.immcon)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_PYRO))
	e2:SetValue(c81012067.efilter)
	c:RegisterEffect(e2)
end
function c81012067.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(1-tp)
end
function c81012067.costfilter(c)
	return bit.band(c:GetType(),0x81)==0x81 and c:IsFaceup() and c:IsAbleToDeckAsCost()
end
function c81012067.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81012067.costfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c81012067.costfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c81012067.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c81012067.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PYRO) and c:IsType(TYPE_PENDULUM) and c:IsType(TYPE_RITUAL) and c:IsLevelAbove(8)
end
function c81012067.immcon(e)
	return Duel.IsExistingMatchingCard(c81012067.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c81012067.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:IsActiveType(TYPE_MONSTER)
end
