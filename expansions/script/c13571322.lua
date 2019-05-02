local m=13571322
local cm=_G["c"..m]
cm.name="歪秤 上位恶魔"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3,cm.ovfilter,aux.Stringid(m,0))
	--Double Damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetCondition(cm.damcon)
	e2:SetOperation(cm.damop)
	c:RegisterEffect(e2)
end
function cm.ovfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FIEND) and c:IsType(TYPE_FUSION)
end
--Double Damage
function cm.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and e:GetHandler():GetBattleTarget()~=nil
end
function cm.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end