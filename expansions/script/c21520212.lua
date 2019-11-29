--星曜圣装-亢金龙
function c21520212.initial_effect(c)
	c:SetSPSummonOnce(21520212)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(21520212,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c21520212.sprcon)
	e0:SetOperation(c21520212.sprop)
	c:RegisterEffect(e0)
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e01:SetCode(EFFECT_SPSUMMON_CONDITION)
	e01:SetValue(c21520212.splimit)
	c:RegisterEffect(e01)
	--ignition effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520212,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c21520212.igtg)
	e2:SetOperation(c21520212.igop)
	c:RegisterEffect(e2)
end
c21520212.card_code_list={21520102}
function c21520212.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0xa491)
end
function c21520212.spfilter(c)
	return c:IsCode(21520102) and c:IsAbleToRemoveAsCost()
end
function c21520212.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c21520212.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCountFromEx(tp)>0 
end
function c21520212.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local player=e:GetHandlerPlayer()
	local rg=Duel.SelectMatchingCard(player,c21520212.spfilter,player,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520212.igtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) 
		and Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_ONFIELD)
end
function c21520212.igop(e,tp,eg,ep,ev,re,r,rp)
	local hg=Duel.GetMatchingGroup(Card.IsDiscardable,tp,LOCATION_HAND,0,nil)
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if hg:GetCount()<=0 or g:GetCount()<=0 then return end
	local ct=Duel.DiscardHand(tp,Card.IsDiscardable,1,Duel.GetFieldGroupCount(tp,LOCATION_HAND,0),REASON_COST+REASON_DISCARD,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local sg=g:Select(tp,1,math.min(ct,g:GetCount()),nil)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end
