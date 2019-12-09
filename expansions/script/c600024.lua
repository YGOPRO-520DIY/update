--光波干涉
function c600024.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCondition(c600024.atkcon)
	e2:SetCountLimit(1,600024)
	e2:SetTarget(c600024.atktg)
	e2:SetOperation(c600024.atkop)
	c:RegisterEffect(e2) 
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,6000024)
	e3:SetCondition(c600024.thcon)
	e3:SetTarget(c600024.thtg)
	e3:SetOperation(c600024.thop)
	c:RegisterEffect(e3)
end
function c600024.filter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c600024.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if Duel.IsDamageCalculated() then return false end
	local tc=Duel.GetAttacker()
	if not tc then return false end
	if tc:IsControler(1-tp) then 
		tc=Duel.GetAttackTarget()
	end
	e:SetLabelObject(tc)
	return tc and tc:IsFaceup() and tc:IsSetCard(0xe5) and tc:IsRelateToBattle()
	and Duel.IsExistingMatchingCard(c600024.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,tc,tc:GetCode())
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c600024.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=e:GetLabelObject()
	if chkc then return chkc==tc end
	if chk==0 then return tc and tc:IsOnField() and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tc)
end
function c600024.atkop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc or not tc:IsRelateToBattle() or tc:IsFacedown() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	e1:SetValue(tc:GetAttack()*2)
	tc:RegisterEffect(e1)
end
function c600024.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_SZONE)
end
function c600024.thfilter(c)
	return c:IsSetCard(0xe5) and c:IsAbleToHand() and not c:IsCode(600024)
end
function c600024.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c600024.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c600024.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=Duel.SelectTarget(tp,c600024.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
end
function c600024.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end