--文学之风 轻库娘
local m=26818015
local cm=_G["c"..m]
xpcall(function() require("expansions/script/c26800000") end,function() require("script/c26800000") end)
function cm.initial_effect(c)
	Amana.Majsoul(c)
	--double damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(cm.damtg)
	e1:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	c:RegisterEffect(e1)
	--actlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,1)
	e3:SetCondition(cm.actcon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function cm.damtg(e,c)
	return c:IsCode(26818000,26818001) and c:GetBattleTarget()~=nil
end
function cm.cfilter(c,tp)
	return c:IsFaceup() and (aux.IsCodeListed(c,26818000) or aux.IsCodeListed(c,26818001)) and c:IsControler(tp)
end
function cm.actcon(e)
	local tp=e:GetHandlerPlayer()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (a and cm.cfilter(a,tp)) or (d and cm.cfilter(d,tp))
end
