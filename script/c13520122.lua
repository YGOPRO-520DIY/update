local m=13520122
local cm=_G["c"..m]
cm.name="机宇导航"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Link Summon
	aux.AddLinkProcedure(c,cm.mfilter,1,1)
	--Extra Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(cm.sumcon)
	e1:SetOperation(cm.sumop)
	c:RegisterEffect(e1)
end
--Link Summon
function cm.mfilter(c)
	return c:IsLinkType(TYPE_DUAL)
end
--Extra Summon
function cm.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function cm.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,m)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_DUAL))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,m,RESET_PHASE+PHASE_END,0,1)
end