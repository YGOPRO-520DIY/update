--古夕幻历-西洲林海
function c44460078.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,44460078)
	e2:SetCondition(c44460078.condition)
	e2:SetTarget(c44460078.target)
	e2:SetOperation(c44460078.operation)
	c:RegisterEffect(e2)
	--draw
	local e22=Effect.CreateEffect(c)
	e22:SetCategory(CATEGORY_DRAW)
	e22:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e22:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e22:SetCode(EVENT_SUMMON_SUCCESS)
	e22:SetRange(LOCATION_FZONE)
	e22:SetCountLimit(1,44460078)
	e22:SetCondition(c44460078.condition2)
	e22:SetTarget(c44460078.target2)
	e22:SetOperation(c44460078.operation2)
	c:RegisterEffect(e22)
end
function c44460078.filter(c,tp)
	return c:IsSetCard(0x677) and c:IsControler(tp)
end
function c44460078.filter2(c,tp)
	return c:IsControler(1-tp)
end
function c44460078.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460078.filter,1,nil,tp)
end
function c44460078.condition2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460078.filter2,1,nil,tp)
end
function c44460078.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c44460078.operation(e,tp,eg,ep,ev,re,r,rp)

	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c44460078.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c44460078.operation2(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end