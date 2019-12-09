local m=13520223
local tg={13520200,13520230}
local cm=_G["c"..m]
cm.name="冥界花骑士 茴香"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Fusion Material
	aux.AddFusionProcFun2(c,cm.ffilter1,cm.ffilter2,true)
	--Extra Cost
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(cm.excon)
	e1:SetOperation(cm.exop)
	c:RegisterEffect(e1)
	--Change Effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(cm.cecon)
	e2:SetOperation(cm.ceop)
	c:RegisterEffect(e2)
end
function cm.flower(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Fusion Material
function cm.ffilter1(c)
	return c:IsRace(RACE_PLANT) and c:IsFusionType(TYPE_FUSION)
end
function cm.ffilter2(c)
	return cm.flower(c)
end
--Extra Cost
function cm.excon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function cm.exop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(0x10000000+m)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SUMMON_COST)
	e2:SetTargetRange(0,0xff)
	e2:SetCost(cm.costchk)
	e2:SetOperation(cm.costop)
	e2:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
	Duel.RegisterEffect(e2,tp)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_SPSUMMON_COST)
	Duel.RegisterEffect(e3,tp)
end
function cm.costchk(e,te_or_c,tp)
	local ct=Duel.GetFlagEffect(tp,m)
	return Duel.CheckLPCost(tp,ct*500)
end
function cm.costop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,m)
	Duel.PayLPCost(tp,500)
end
--Change Effect
function cm.cecon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return ep~=tp and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) and g and g:GetCount()>0
end
function cm.ceop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,cm.damop)
end
function cm.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,m)
	Duel.Damage(tp,500,REASON_EFFECT,true)
	Duel.Damage(1-tp,500,REASON_EFFECT,true)
	Duel.RDComplete()
end