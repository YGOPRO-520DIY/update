--繁华之晶月魔印
function c65020074.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--act qp/trap in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SSET)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c65020074.stcon)
	e2:SetCost(c65020074.stcost)
	e2:SetOperation(c65020074.stop)
	c:RegisterEffect(e2)
	--negate activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,65020074)
	e1:SetCondition(c65020074.condition)
	e1:SetCost(c65020074.cost)
	e1:SetTarget(c65020074.target)
	e1:SetOperation(c65020074.operation)
	c:RegisterEffect(e1)
end
function c65020074.stconfil(c,tp)
	return c:IsSetCard(0x9da3) and c:GetReasonPlayer()==tp and c:IsType(TYPE_TRAP) and c:IsType(TYPE_CONTINUOUS) and c:IsReason(REASON_EFFECT)
end
function c65020074.stcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c65020074.stconfil,1,nil,tp) and eg:FilterCount(c65020074.stconfil,nil,tp)==1
end
function c65020074.stcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c65020074.stop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:Filter(c65020074.stconfil,nil,tp):GetFirst()
	local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
			e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
end

function c65020074.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp
		and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function c65020074.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	c:RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c65020074.setfil(c)
	return c:IsAbleToHand() and c:IsType(TYPE_TRAP) and c:IsType(TYPE_CONTINUOUS) and c:IsSetCard(0x9da3)
end
function c65020074.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c65020074.setfil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c65020074.setfil,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.SelectTarget(tp,c65020074.setfil,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c65020074.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
