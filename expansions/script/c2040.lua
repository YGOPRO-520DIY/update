--Fgo/Assassin 尺酱哈桑
local m=2040
local cm=_G["c"..m]
function cm.initial_effect(c)
	--immue
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(cm.efilter)
	c:RegisterEffect(e1)
	--asdasdasdasdasdasd
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DICE)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(3)
	e2:SetCondition(function(e,tp) return tp~=Duel.GetTurnPlayer() end)
	e2:SetOperation(cm.diceop1)
	c:RegisterEffect(e2)
	--asdasdasdasdasdasd
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DICE)
	e3:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(function(e) return Duel.GetAttackTarget() end)
	e3:SetOperation(cm.diceop2)
	c:RegisterEffect(e3)
	--cannot be target
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e7:SetRange(LOCATION_MZONE)
	e7:SetValue(aux.imval1)
	c:RegisterEffect(e7)
	local e8=e7:Clone()
	e8:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e8:SetValue(aux.tgoval)
	c:RegisterEffect(e8)	
end
function cm.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP)
end
function cm.diceop1(e,tp)
	local ac=Duel.GetAttacker()
	if not ac:IsRelateToBattle() then return end
	local d=Duel.TossDice(1)
	if d>=5 then
		Duel.NegateAttack()
	end
end
function cm.diceop2(e,tp)
	local c=e:GetHandler()
	local bc=Duel.GetAttackTarget()
	if not c:IsRelateToBattle() then return end
	if not bc:IsRelateToBattle() then return end
	local d=Duel.TossDice(tp,1)
	local atk=bc:GetAttack()
	if d>=1 and d<=3 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(atk/2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		bc:RegisterEffect(e1)
	else
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(atk)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e2)		
	end
end
