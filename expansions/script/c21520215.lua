--星曜圣装-心月狐
function c21520215.initial_effect(c)
	c:SetSPSummonOnce(21520215)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(21520215,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c21520215.sprcon)
	e0:SetOperation(c21520215.sprop)
	c:RegisterEffect(e0)
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e01:SetCode(EFFECT_SPSUMMON_CONDITION)
	e01:SetValue(c21520215.splimit)
	c:RegisterEffect(e01)
	--trigger effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520215,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c21520215.igcon)
	e2:SetCost(c21520215.igcost)
	e2:SetTarget(c21520215.igtg)
	e2:SetOperation(c21520215.igop)
	c:RegisterEffect(e2)
end
c21520215.card_code_list={21520105}
function c21520215.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0xa491)
end
function c21520215.spfilter(c)
	return c:IsCode(21520105) and c:IsAbleToRemoveAsCost()
end
function c21520215.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c21520215.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCountFromEx(tp)>0 
end
function c21520215.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local player=e:GetHandlerPlayer()
	local rg=Duel.SelectMatchingCard(player,c21520215.spfilter,player,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520215.igfilter(c)
	return c:IsReleasable() and c:IsSetCard(0x491) and c:IsType(TYPE_MONSTER) 
end
function c21520215.igcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c21520215.igcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21520215.igfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local rg=Duel.SelectMatchingCard(tp,c21520215.igfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.Release(rg,REASON_COST)
	rg:KeepAlive()
	e:SetLabelObject(rg)
end
function c21520215.igtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetLabelObject():GetFirst():GetBaseAttack()
	if dam <0 then dam =0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c21520215.igop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
