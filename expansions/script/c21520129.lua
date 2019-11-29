--星曜成像-苍龙
function c21520129.initial_effect(c)
--	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c21520129.spcon)
	c:RegisterEffect(e1)
	--cannot special summon
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(c21520129.splimit)
	c:RegisterEffect(e2)
	--hand infinity
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_HAND_LIMIT)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(1,0)
	e3:SetValue(200)
	c:RegisterEffect(e3)
	--damage
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c21520129.condition)
	e4:SetCost(c21520129.cost)
	e4:SetTarget(c21520129.target)
	e4:SetOperation(c21520129.operation)
	c:RegisterEffect(e4)
end
function c21520129.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0x5491)
end
function c21520129.spfilter(c)
	return c:IsSetCard(0x3491) and (not c:IsOnField() or c:IsFaceup())
end
function c21520129.spcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)<=0 then return false end
	local g=Duel.GetMatchingGroup(c21520129.spfilter,c:GetControler(),LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	local ct=g:GetClassCount(Card.GetCode)
	return ct>6
end
function c21520129.condition(e,tp,eg,ep,ev,re,r,rp)
	local sel=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local opp=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	return sel>opp and Duel.GetActivityCount(tp,ACTIVITY_BATTLE_PHASE)==0
end
function c21520129.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCurrentPhase()==PHASE_MAIN1 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c21520129.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sel=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local opp=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	local dam=0
	if sel>=opp then dam=(sel-opp)*500
	else dam=(opp-sel)*500 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c21520129.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local sel=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local opp=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	local dam=0
	if sel>=opp then dam=(sel-opp)*500
	else dam=(opp-sel)*500 end
	Duel.Damage(p,dam,REASON_EFFECT)
end
