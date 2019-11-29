--星曜圣装-玄龟
function c21520158.initial_effect(c)
	c:SetSPSummonOnce(21520158)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(21520158,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c21520158.sprcon)
	e0:SetOperation(c21520158.sprop)
	c:RegisterEffect(e0)
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e01:SetCode(EFFECT_SPSUMMON_CONDITION)
	e01:SetValue(c21520158.splimit)
	c:RegisterEffect(e01)
	--continuous effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetTarget(c21520158.fetg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e1_1=e1:Clone()
	e1_1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	c:RegisterEffect(e1_1)
	--ignition effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520158,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c21520158.igtg)
	e2:SetOperation(c21520158.igop)
	c:RegisterEffect(e2)
end
c21520158.card_code_list={21520130}
function c21520158.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0xa491)
end
function c21520158.spfilter(c)
	return c:IsCode(21520130) and c:IsAbleToRemoveAsCost()
end
function c21520158.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c21520158.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCountFromEx(tp)>0 
end
function c21520158.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local player=e:GetHandlerPlayer()
	local rg=Duel.SelectMatchingCard(player,c21520158.spfilter,player,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520158.fetg(e,c)
	return c:IsStatus(STATUS_SUMMON_TURN+STATUS_FLIP_SUMMON_TURN+STATUS_SPSUMMON_TURN) and c:IsSetCard(0x491) and not c:IsSetCard(0xa491)
end
function c21520158.igtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_ONFIELD,0,1,nil) 
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,2,0,LOCATION_ONFIELD)
end
function c21520158.igop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,0,nil)
	local g2=Duel.GetMatchingGroup(aux.TRUE,1-tp,LOCATION_ONFIELD,0,nil)
	if g1:GetCount()>0 and g2:GetCount()>0 then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DESTROY)
		local sg2=g2:Select(1-tp,1,1,nil)
		sg1:Merge(sg2)
		Duel.HintSelection(sg1)
		Duel.Destroy(sg1,REASON_EFFECT)
	end
end
