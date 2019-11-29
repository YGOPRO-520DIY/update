--苍星曜兽-心月狐
function c21520105.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_RELEASE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c21520105.condition)
	e1:SetTarget(c21520105.target)
	e1:SetOperation(c21520105.operation)
	c:RegisterEffect(e1)
end
function c21520105.filter(c)
	return c:IsSetCard(0x491) and c:IsType(TYPE_MONSTER)
end
function c21520105.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c21520105.filter,1,e:GetHandler())
end
function c21520105.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(900)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,900)
end
function c21520105.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
