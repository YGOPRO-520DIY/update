--星曜圣装-朱雀
function c21520160.initial_effect(c)
	c:SetSPSummonOnce(21520160)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(21520160,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c21520160.sprcon)
	e0:SetOperation(c21520160.sprop)
	c:RegisterEffect(e0)
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e01:SetCode(EFFECT_SPSUMMON_CONDITION)
	e01:SetValue(c21520160.splimit)
	c:RegisterEffect(e01)
	--continuous effect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c21520160.fecon)
	e1:SetTarget(c21520160.fetg)
	e1:SetOperation(c21520160.feop)
	c:RegisterEffect(e1)
	local e1_1=e1:Clone()
	e1_1:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e1_1)
	local e1_2=e1:Clone()
	e1_2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e1_2)
	--ignition effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520160,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c21520160.igtg)
	e2:SetOperation(c21520160.igop)
	c:RegisterEffect(e2)
end
c21520160.card_code_list={21520132}
function c21520160.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0xa491)
end
function c21520160.spfilter(c)
	return c:IsCode(21520132) and c:IsAbleToRemoveAsCost()
end
function c21520160.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c21520160.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCountFromEx(tp)>0 
end
function c21520160.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local player=e:GetHandlerPlayer()
	local rg=Duel.SelectMatchingCard(player,c21520160.spfilter,player,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520160.fefilter(c)
	return c:IsSetCard(0x491) and not c:IsSetCard(0xa491)
end
function c21520160.fecon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c21520160.fefilter,1,nil)
end
function c21520160.fetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(600)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,600)
end
function c21520160.feop(e,tp,eg,ep,ev,re,r,rp,c)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Hint(HINT_CARD,1-tp,21520160)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c21520160.igfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x491) and c:IsType(TYPE_MONSTER)
end
function c21520160.igtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c21520160.igfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_SZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,ct,1-tp,LOCATION_SZONE)
end
function c21520160.igop(e,tp,eg,ep,ev,re,r,rp,c)
	local ct=Duel.GetMatchingGroupCount(c21520160.igfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,0,LOCATION_SZONE,nil)
	if g:GetCount()>0 and ct>0 then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local sg=g:Select(tp,1,math.min(ct,g:GetCount()),nil)
		Duel.HintSelection(sg)
		Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
	end
end
