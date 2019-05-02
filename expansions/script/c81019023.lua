--最初的爱米莉
function c81019023.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,81019023)
	e1:SetCost(c81019023.tscost)
	e1:SetTarget(c81019023.tstg)
	e1:SetOperation(c81019023.tsop)
	c:RegisterEffect(e1)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,81019923)
	e3:SetCondition(c81019023.thcon)
	e3:SetTarget(c81019023.thtg)
	e3:SetOperation(c81019023.thop)
	c:RegisterEffect(e3)
end
function c81019023.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL) and c:IsType(TYPE_PENDULUM) and not c:IsCode(81019023)
end
function c81019023.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c81019023.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c81019023.thfilter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAbleToHand()
end
function c81019023.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c81019023.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c81019023.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c81019023.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c81019023.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c81019023.tscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c81019023.tsfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL) and c:IsAbleToHand()
end
function c81019023.tstg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c81019023.tsfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c81019023.tsfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c81019023.tsfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c81019023.tsop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and Duel.Destroy(c,REASON_EFFECT)~=0 and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
