local m=13520150
local tg={13520145}
local cm=_G["c"..m]
cm.name="血狐妖祭"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon
	aux.AddXyzProcedure(c,cm.mfilter,6,2,cm.ovfilter,aux.Stringid(m,0),2,cm.xyzop)
	--Atk & Def Up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(cm.uptg)
	e1:SetValue(cm.upval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
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
--Atk & Def Up
function cm.uptg(e,c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_FIRE)
end
function cm.upval(e,c)
	return Duel.GetOverlayCount(e:GetHandlerPlayer(),1,0)*100
end