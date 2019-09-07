--雪暴猎鹰的崩坏
function c43694489.initial_effect(c)
   --damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c43694489.damtg)
	e1:SetOperation(c43694489.damop)
	c:RegisterEffect(e1)
end
function c43694489.damfil(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER) and c:IsRace(RACE_WINDBEAST)
end
function c43694489.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c43694489.damfil,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	local dam=0
	while tc do
		local daam=tc:GetAttack()-tc:GetBaseAttack()
		if daam>0 then dam=dam+daam end
		tc=g:GetNext()
	end
	if chk==0 then return dam>0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c43694489.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end