local m=13520224
local tg={13520200,13520230}
local cm=_G["c"..m]
cm.name="太刀花骑士 枳"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Synchro Summon
	aux.AddSynchroMixProcedure(c,aux.Tuner(nil),aux.Tuner(nil),nil,aux.NonTuner(cm.flower),1,1)
	--Release
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_RELEASE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1,m)
	e1:SetCondition(cm.rscon)
	e1:SetTarget(cm.rstg)
	e1:SetOperation(cm.rsop)
	c:RegisterEffect(e1)
end
function cm.flower(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Release
function cm.rscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function cm.rstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsReleasable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(Card.IsReleasable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_RELEASE,g,g:GetCount(),0,0)
end
function cm.rsop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsReleasable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	if g:GetCount()>0 then
		Duel.Release(g,REASON_EFFECT)
		local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
		if ct>0 then Duel.SetLP(1-tp,Duel.GetLP(1-tp)-ct*1000) end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end