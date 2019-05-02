--避风加护/战斗撤退1
local m=2047
local cm=_G["c"..m]
function cm.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(function(e,tp) return Duel.GetAttackTarget():IsControler(tp) and Duel.GetAttackTarget():IsFaceup() and Duel.GetAttackTarget():IsSetCard(0x299) end)
	e1:SetOperation(cm.cbop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(cm.cecon)
	e2:SetOperation(cm.cbop)
	c:RegisterEffect(e2)
	--act in hand
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	c:RegisterEffect(e3)	  
end
function cm.cbop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.TossDice(tp,1)
	local b1=e:GetCode()==EVENT_CHAINING 
	local b2=e:GetCode()==EVENT_BE_BATTLE_TARGET or (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE_STEP) 
	if not b1 and not b2 then return end
	if b1 then op=0 end
	if b2 then op=1 end
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(m,0),aux.Stringid(m,1))
	end
	if op==0 then
		if not Duel.NegateActivation(ev) then return end
	else
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
	end
	if d==5 then Duel.Draw(tp,1,REASON_EFFECT) 
	elseif d>=6 and c:IsRelateToEffect(e) and c:IsAbleToHand() then
		c:CancelToGrave()
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
function cm.cecon(e,tp,eg,ep,ev,re,r,rp)
	if e==re or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsLocation(LOCATION_MZONE) and tc:IsFaceup() and tc:IsSetCard(0x299)
end
