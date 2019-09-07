--灵噬·寒幕
function c79100018.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(79100018,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,79100018)
	e2:SetCost(c79100018.cost)
	e2:SetTarget(c79100018.damtg)
	e2:SetOperation(c79100018.damop)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,79100019)
	e3:SetTarget(c79100018.reptg)
	e3:SetValue(c79100018.repval)
	c:RegisterEffect(e3)
	--Search
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(79100018,2))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_REMOVE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1,79100018)
	e4:SetCondition(c79100018.thcon)
	e4:SetTarget(c79100018.thtg)
	e4:SetOperation(c79100018.thop)
	c:RegisterEffect(e4)
end
function c79100018.filter(c)
	return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsSetCard(0x791) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c79100018.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79100018.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c79100018.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c79100018.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c79100018.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c79100018.thcfilter(c,tp)
	return c:IsSetCard(0x791) and c:IsType(TYPE_MONSTER) and c:GetPreviousControler()==tp
end
function c79100018.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c79100018.thcfilter,1,nil,tp)
end
function c79100018.thfilter(c)
	return c:IsSetCard(0x791) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c79100018.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c79100018.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c79100018.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c79100018.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_ONFIELD) and c:IsSetCard(0x791) and c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c79100018.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c79100018.repfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,2,nil) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,2,2,nil)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT+REASON_REPLACE)
		return true
	end
	return false
end
function c79100018.repval(e,c)
	return c79100018.repfilter(c,e:GetHandlerPlayer())
end
