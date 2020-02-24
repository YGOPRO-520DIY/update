--璀璨之晶月魔印
function c65020073.initial_effect(c)
	 --xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--act qp/trap in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetTarget(c65020073.handtg)
	e2:SetCondition(c65020073.handcon)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(65020073)
	c:RegisterEffect(e3)
	--activate cost
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_ACTIVATE_COST)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(1,0)
	e4:SetTarget(c65020073.costtg)
	e4:SetCost(c65020073.costchk)
	e4:SetOperation(c65020073.costop)
	c:RegisterEffect(e4)
	--negate activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,65020073)
	e1:SetCondition(c65020073.condition)
	e1:SetCost(c65020073.cost)
	e1:SetTarget(c65020073.target)
	e1:SetOperation(c65020073.operation)
	c:RegisterEffect(e1)
end
function c65020073.handcon(e)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer() and e:GetHandler():GetOverlayCount()~=0
end
function c65020073.handtg(e,c)
	return c:IsSetCard(0x9da3) and c:IsType(TYPE_CONTINUOUS)
end
function c65020073.costtg(e,te,tp)
	local tc=te:GetHandler()
	e:SetLabelObject(tc)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer()
		and tc:IsLocation(LOCATION_HAND) and tc:GetEffectCount(65020073)>0
		and (tc:GetEffectCount(EFFECT_TRAP_ACT_IN_HAND)<=tc:GetEffectCount(65020073) and tc:IsType(TYPE_TRAP))
end
function c65020073.costchk(e,te_or_c,tp)
	return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT)
end
function c65020073.costop(e,tp,eg,ep,ev,re,r,rp)
	 Duel.Hint(HINT_CARD,0,65020073)
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
	local tc=e:GetLabelObject()
	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetTargetRange(1,0)
		e1:SetValue(c65020073.aclimit)
		e1:SetLabelObject(tc)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
end
function c65020073.aclimit(e,re,tp)
	local c=re:GetHandler()
	local tc=e:GetLabelObject()
	return c:IsOriginalCodeRule(tc:GetOriginalCodeRule()) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c65020073.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp
		and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function c65020073.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	c:RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c65020073.setfil(c)
	return c:IsSSetable() and c:IsType(TYPE_TRAP) and c:IsType(TYPE_CONTINUOUS) and c:IsSetCard(0x9da3)
end
function c65020073.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c65020073.setfil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c65020073.setfil,tp,LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	local g=Duel.SelectTarget(tp,c65020073.setfil,tp,LOCATION_GRAVE,0,1,1,nil)
end
function c65020073.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		Duel.SSet(tp,tc)
		Duel.ConfirmCards(1-tp,tc)
	end
end