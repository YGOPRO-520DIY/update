--狐仙
function c600075.initial_effect(c)
	aux.AddLinkProcedure(c,c600075.lfilter,1,1) 
	c:EnableReviveLimit()   
	--spirit may not return
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPIRIT_MAYNOT_RETURN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	c:RegisterEffect(e1)
	--Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600075,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,600075)
	e2:SetCondition(c600075.sumcon)
	e2:SetCost(c600075.sumcost)
	e2:SetTarget(c600075.sumtg)
	e2:SetOperation(c600075.sumop)
	c:RegisterEffect(e2)
end
function c600075.lfilter(c)
	return c:IsType(TYPE_SPIRIT)
end
function c600075.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==e:GetHandler():GetTurnID()+1
end
function c600075.sumcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),tp,2,REASON_COST)
end
function c600075.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPIRIT)  and c:IsAbleToHand()
end
function c600075.sumtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c600075.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c600075.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c600075.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c600075.sumfilter(c)
	return c:IsType(TYPE_SPIRIT) and c:IsType(TYPE_MONSTER) and c:IsSummonable(true,nil)
end
function c600075.sumop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_HAND) then
		if Duel.IsExistingMatchingCard(c600075.sumfilter,tp,LOCATION_HAND,0,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(600075,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
			local g=Duel.SelectMatchingCard(tp,c600075.sumfilter,tp,LOCATION_HAND,0,1,1,nil)
			Duel.Summon(tp,g:GetFirst(),true,nil)
		end
	end
end