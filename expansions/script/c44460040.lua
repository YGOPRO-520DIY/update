--仙依-青荷姬
function c44460040.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_NORMAL),1,1)
	c:EnableReviveLimit()
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460040,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460040.xycon)
	e1:SetCost(c44460040.xycost)
	e1:SetTarget(c44460040.xytg)
	e1:SetOperation(c44460040.xyop)
	c:RegisterEffect(e1)
	--Cost Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_LPCOST_CHANGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetTargetRange(1,0)
	e2:SetValue(c44460040.costchange)
	c:RegisterEffect(e2)
end
function c44460040.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c44460040.filter(c,tp)
	return c:IsFaceup() and c:GetLevel()==1 
end
function c44460040.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460040.filter,1,nil,tp)
end
function c44460040.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:GetLevel()==1 and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460040.climit)
end
function c44460040.xyop(e,tp,eg,ep,ev,re,r,rp)
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
function c44460040.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--Cost Change
function c44460040.costchange(e,re,rp,val)
	if re and (re:GetHandler():IsSetCard(0x679) or re:GetHandler():IsSetCard(0x680)) then
		return 0
	else
		return val
	end
end