--树界的灵兽 庇护狮
function c600045.initial_effect(c)
	--Damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600045,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,600045)
	e1:SetCondition(c600045.indcon)
	e1:SetCost(c600045.recost)
	e1:SetTarget(c600045.retg)
	e1:SetOperation(c600045.reop)
	c:RegisterEffect(e1)  
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600045,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,6000045)
	e2:SetCondition(c600045.thcon)
	e2:SetTarget(c600045.thtg)
	e2:SetOperation(c600045.thop)
	c:RegisterEffect(e2)   
end
function c600045.indcon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,600044)
end
function c600045.recost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
end
function c600045.filter(c)
	return c:IsCode(600044)
end
function c600045.retg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c600045.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_GRAVE)
end
function c600045.reop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c600045.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		 Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
	Duel.BreakEffect()
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c) end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c600045.damval)
	e1:SetReset(RESET_PHASE+PHASE_END,1)
	Duel.RegisterEffect(e1,tp)
end
function c600045.damval(e,re,val,r,rp,rc)
	return val/2
end
function c600045.ntfilter(c)
	return c:IsCode(600044)
end
function c600045.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp 
	   and Duel.IsExistingMatchingCard(c600045.ntfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c600045.thfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c600045.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c600045.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c600045.thfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c600045.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c600045.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local def=tc:GetBaseDefense()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_RETURN)
		Duel.Recover(tp,def,REASON_EFFECT)
	end
end
