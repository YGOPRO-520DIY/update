--纯白之恋 纱凪
function c34511160.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,c34511160.matfilter,4,2) 
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(34511130,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,34511160)
	e2:SetTarget(c34511160.ptg)
	e2:SetOperation(c34511160.pop)
	c:RegisterEffect(e2)
------------------------------   
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(34511170,3))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,34511160)
	e3:SetCondition(c34511170.spcon)
	e3:SetTarget(c34511170.sptg1)
	e3:SetOperation(c34511170.spop1)
	c:RegisterEffect(e3)
end
function c34511160.matfilter(c)
	return c:IsXyzType(TYPE_PENDULUM)
end
function c34511160.pfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function c34511160.ptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c34511160.pfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
	local g2=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g2,1,0,0)
end
function c34511160.pop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c34511160.pfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	if Duel.SelectYesNo(tp,aux.Stringid(34511160,2)) then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_ONFIELD,0,1,1,nil)
	if g2:GetCount()>0 then
		Duel.BreakEffect()
		Duel.HintSelection(g2)
		Duel.Destroy(g2,REASON_EFFECT)
		end
	end
end
function c34511160.spcfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsType(TYPE_PENDULUM)
end
function c34511160.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c34511160.spcfilter,1,nil,tp)
end
-----------------------
function c34511160.thfilter(c)
	return c:IsSetCard(0xac5) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c34511160.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c34511160.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c34511160.spop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c34511160.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end