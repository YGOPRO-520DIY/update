--tricoro·乙仓悠贵·SIRIUS
function c81019012.initial_effect(c)
	c:EnableReviveLimit()
	--to hand
	local e0=Effect.CreateEffect(c)
	e0:SetCategory(CATEGORY_TOHAND)
	e0:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e0:SetCode(EVENT_BATTLE_DAMAGE)
	e0:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e0:SetCountLimit(1,81019012)
	e0:SetCondition(c81019012.thcon)
	e0:SetTarget(c81019012.thtg)
	e0:SetOperation(c81019012.thop)
	c:RegisterEffect(e0)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c81019012.ctop)
	c:RegisterEffect(e2)
end
function c81019012.addc(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp then
		Duel.Hint(HINT_CARD,0,81019012)
		Duel.Damage(1-tp,200,REASON_EFFECT)
	end
end
function c81019012.thcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c81019012.thfilter(c)
	return c:IsSetCard(0xfb) and c:IsFaceup() and c:IsAbleToHand()
end
function c81019012.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_REMOVED) and c81019012.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c81019012.thfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c81019012.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c81019012.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c81019012.ctop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttacker():IsControler(1-tp) then
		Duel.Hint(HINT_CARD,0,81019012)
		Duel.Damage(1-tp,200,REASON_EFFECT)
	end
end