--星曜圣装-斗木獬
function c21520218.initial_effect(c)
	c:SetSPSummonOnce(21520218)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(21520218,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c21520218.sprcon)
	e0:SetOperation(c21520218.sprop)
	c:RegisterEffect(e0)
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e01:SetCode(EFFECT_SPSUMMON_CONDITION)
	e01:SetValue(c21520218.splimit)
	c:RegisterEffect(e01)
	--ignition effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520218,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c21520218.igtg)
	e2:SetOperation(c21520218.igop)
	c:RegisterEffect(e2)
end
c21520218.card_code_list={21520108}
function c21520218.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0xa491)
end
function c21520218.spfilter(c)
	return c:IsCode(21520108) and c:IsAbleToRemoveAsCost()
end
function c21520218.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c21520218.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCountFromEx(tp)>0 
end
function c21520218.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local player=e:GetHandlerPlayer()
	local rg=Duel.SelectMatchingCard(player,c21520218.spfilter,player,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520218.igfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x491) and c:IsType(TYPE_MONSTER)
end
function c21520218.igtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=math.floor(Duel.GetMatchingGroupCount(c21520218.igfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)/2)
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,ct) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c21520218.igop(e,tp,eg,ep,ev,re,r,rp)
	local ct=math.floor(Duel.GetMatchingGroupCount(c21520218.igfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)/2)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,ct,REASON_EFFECT)
end
