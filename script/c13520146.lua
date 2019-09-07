local m=13520146
local tg={13520141}
local cm=_G["c"..m]
cm.name="血狐妖忍"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon
	aux.AddXyzProcedure(c,cm.mfilter,6,2,cm.ovfilter,aux.Stringid(m,0),2,cm.xyzop)
	--Attack Twice
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
cm.card_code_list=tg
--Xyz Summon
function cm.mfilter(c)
	return c:IsAttribute(ATTRIBUTE_FIRE)
end
function cm.ovfilter(c)
	return c:IsFaceup() and c:IsCode(tg[1])
end
function cm.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,m)==0 end
	Duel.RegisterFlagEffect(tp,m,RESET_PHASE+PHASE_END,0,1)
end