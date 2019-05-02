local m=13571432
local cm=_G["c"..m]
cm.name="歪秤精灵 璐璐"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Fusion Material
	aux.AddFusionProcFunRep(c,cm.mfilter,3,true)
	--Fusion Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(cm.spcon)
	e1:SetOperation(cm.spop)
	e1:SetValue(SUMMON_TYPE_FUSION)
	c:RegisterEffect(e1)
	--To Hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(cm.condition)
	e2:SetTarget(cm.target)
	e2:SetOperation(cm.operation)
	c:RegisterEffect(e2)
end
--Fusion Material
function cm.mfilter(c)
	return c:IsFusionAttribute(ATTRIBUTE_LIGHT)
end
--Fusion Summon
function cm.matfilter(c,fc)
	return cm.mfilter(c) and c:IsCanBeFusionMaterial(fc) and c:IsAbleToRemoveAsCost()
end
function cm.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCountFromEx(tp)>0
		and Duel.IsExistingMatchingCard(cm.matfilter,tp,LOCATION_GRAVE,0,3,nil,c)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,cm.matfilter,tp,LOCATION_GRAVE,0,3,3,nil,c)
	c:SetMaterial(g)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
--To Hand
function cm.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToHand()
end
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and cm.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(cm.filter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,cm.filter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,3,tp,LOCATION_DECK)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 then
		local g=Duel.GetDecktopGroup(tp,3)
		if g:FilterCount(Card.IsAbleToRemove,nil)>0 then
			Duel.BreakEffect()
			Duel.DisableShuffleCheck()
			Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		end
	end
end