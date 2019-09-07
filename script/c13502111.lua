local m=13502111
local cm=_G["c"..m]
cm.name="真姬狩 炎铠法姆"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Synchro Summon
	aux.AddSynchroMixProcedure(c,cm.mfilter,nil,nil,aux.NonTuner(nil),1,99)
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(cm.descon)
	e1:SetCost(cm.descost)
	e1:SetTarget(cm.destg)
	e1:SetOperation(cm.desop)
	c:RegisterEffect(e1)
end
--Synchro Summon
function cm.mfilter(c)
	return c:IsSynchroType(TYPE_TUNER) or c:IsSynchroType(TYPE_DUAL)
end
--Destroy
function cm.costfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_DUAL)
end
function cm.descon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and ep~=tp and re:IsActiveType(TYPE_MONSTER)
end
function cm.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,cm.costfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,cm.costfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function cm.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,1-tp,LOCATION_ONFIELD)
end
function cm.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,2,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end