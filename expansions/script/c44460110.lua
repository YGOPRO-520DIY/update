--自成仙体-天依·铃兰
function c44460110.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460110.matfilter,2)
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460110,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460110.xycost)
	e1:SetTarget(c44460110.xytg)
	e1:SetOperation(c44460110.xyop)
	c:RegisterEffect(e1)
	--atkdown
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c44460110.atkval)
	c:RegisterEffect(e2)
end
function c44460110.matfilter(c)
	return not c:IsLinkType(TYPE_TOKEN)
end
--xy
function c44460110.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460110.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsSetCard(0x699) and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_ONFIELD,0,1,nil,0x679) end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460110.climit)
end
function c44460110.xyop(e,tp,eg,ep,ev,re,r,rp)
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
function c44460110.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--atkdown
function c44460110.atkfilter(c)
	return c:IsFaceup() and (c:IsCode(44460110) or c:IsCode(44460050))
end
function c44460110.atkval(e,c)
	return Duel.GetMatchingGroupCount(c44460110.atkfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,nil)*-600
end