--Emiya-无限剑制
function c2005.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--tomove
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetTarget(c2005.target)
	e2:SetOperation(c2005.operation)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,2005)
	c:RegisterEffect(e2)
	--to grave
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetOperation(c2005.regop)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_PHASE+PHASE_END)
	e6:SetRange(LOCATION_GRAVE)
	e6:SetCountLimit(1,2005)
	e6:SetCondition(c2005.thcon)
	e6:SetTarget(c2005.thtg)
	e6:SetOperation(c2005.thop)
	c:RegisterEffect(e6)

end
function c2005.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x3903) and c:IsAbleToGrave()
end
function c2005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2005.tgfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_EXTRA)
end
function c2005.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c2005.tgfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
	local e2=Effect.CreateEffect(e:GetHandler())	   
	e2:SetType(EFFECT_TYPE_FIELD)   
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE) 
	e2:SetRange(LOCATION_SZONE) 
	e2:SetTargetRange(LOCATION_MZONE,0)  
	e2:SetTarget(c2005.indtg) 
	e2:SetReset(RESET_PHASE+PHASE_END,2) 
	e2:SetValue(1)
	Duel.RegisterEffect(e2,tp)
	--Atk
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c2005.tg)
	e3:SetValue(700)
	e3:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e3,tp)
end
function c2005.tg(e,c)
	return c:IsSetCard(0xc904)
end
function c2005.indfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsOnField() and c:IsReason(REASON_EFFECT)
		and c:IsSetCard(0xc904)
end
function c2005.indtg(e,c)
	return c:IsSetCard(0xc904)
end
----
function c2005.indval(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
-----
function c2005.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsReason(REASON_RETURN) then
		c:RegisterFlagEffect(2005,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c2005.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(2005)>0
end
function c2005.thfilter(c)
	return c:IsSetCard(0x5903) and c:IsAbleToHand()
end
function c2005.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2005.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c2005.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c2005.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end