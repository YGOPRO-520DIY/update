--神装-死告天使
local m=2053
local cm=_G["c"..m]
function cm.initial_effect(c)
	rsfv.GraveRemovefun(c)
	rsfv.EquipFun(c)
	--dice
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_ATKCHANGE+CATEGORY_DAMAGE+CATEGORY_DICE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(function(e) return Duel.GetAttacker()==e:GetHandler():GetEquipTarget() end)
	e2:SetOperation(cm.desop)
	c:RegisterEffect(e2)	
end
function cm.desop(e,tp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	local tc=Duel.GetAttackTarget()
	local d=Duel.TossDice(tp,1)
	local atk=0
	if d==3 or d==4 then
		if not ec or not ec:IsRelateToBattle() then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END,2)
		ec:RegisterEffect(e1)
	elseif d==5 then
		if not tc or not tc:IsRelateToBattle() then return end
		if Duel.Destroy(tc,REASON_EFFECT)<=0 then return end
		atk=tc:GetBaseAttack()
	elseif d>=6 then
		if not tc or not tc:IsRelateToBattle() then return end
		atk=tc:GetAttack()
		if Duel.Destroy(tc,REASON_EFFECT)<=0 then return end
	end
	if atk>0 then 
		Duel.BreakEffect()
		Duel.Damage(1-tp,atk,REASON_EFFECT)
	end
end

