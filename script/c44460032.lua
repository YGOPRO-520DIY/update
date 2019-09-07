--仙依-林波先代
function c44460032.initial_effect(c)
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460032,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1,44460032)
	e1:SetCost(c44460032.atkcost)
	e1:SetTarget(c44460032.xytg)
	e1:SetOperation(c44460032.xyop)
	c:RegisterEffect(e1)
end
function c44460032.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.PayLPCost(tp,500)
end
function c44460032.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.SetChainLimit(c44460032.climit)
end
function c44460032.xyop(e,tp,eg,ep,ev,re,r,rp)
    Duel.NegateAttack()
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,c)
		local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    c:RegisterEffect(e1)
end
function c44460032.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end