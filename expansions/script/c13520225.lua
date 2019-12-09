local m=13520225
local tg={13520200,13520230}
local cm=_G["c"..m]
cm.name="魔刃花骑士 棣棠花"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon
	aux.AddXyzProcedure(c,cm.mfilter,7,3,cm.ovfilter,aux.Stringid(m,0))
	--Cannot Attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e1:SetCondition(cm.atkcon)
	c:RegisterEffect(e1)
	--Remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(cm.rmcon)
	e2:SetTarget(cm.rmtg)
	e2:SetOperation(cm.rmop)
	c:RegisterEffect(e2)
end
function cm.flower(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Xyz Summon
function cm.mfilter(c)
	return c:IsRace(RACE_PLANT)
end
function cm.ovfilter(c)
	return c:IsFaceup() and c:IsLevel(7) and cm.flower(c)
end
--Cannot Attack
function cm.cfilter(c)
	return c:IsFaceup() and not c:IsRace(RACE_PLANT)
end
function cm.atkcon(e)
	return Duel.IsExistingMatchingCard(cm.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
--Remove
function cm.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsRace(RACE_PLANT)
end
function cm.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,3,1-tp,LOCATION_DECK)
end
function cm.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(1-tp,3)
	if g:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
	end
end