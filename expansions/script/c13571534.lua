local m=13571534
local cm=_G["c"..m]
cm.name="歪秤 分叉赤虫"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Link
	aux.AddLinkProcedure(c,cm.mfilter,1,1)
	--Attack Limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_COST)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCost(cm.atcost)
	e1:SetOperation(cm.atop)
	c:RegisterEffect(e1)
	--Draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCondition(aux.bdocon)
	e2:SetTarget(cm.target)
	e2:SetOperation(cm.operation)
	c:RegisterEffect(e2)
end
--Link
function cm.mfilter(c)
	return c:IsSummonType(SUMMON_TYPE_NORMAL)
end
--Attack Limit
function cm.atcost(e,c,tp)
	return Duel.GetFlagEffect(tp,m)==0
end
function cm.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(tp,m,0,0,1)
end
--Draw
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end