--仙依-铃兰
function c44460050.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460050.matfilter,2)
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460050,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460050.xycon)
	e1:SetCost(c44460050.xycost)
	e1:SetTarget(c44460050.xytg)
	e1:SetOperation(c44460050.xyop)
	c:RegisterEffect(e1)
	--Pos Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_POSITION)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e2)
	--indes
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e11:SetRange(LOCATION_ONFIELD)
	e11:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e11:SetTarget(c44460050.indtg)
	e11:SetValue(1)
	c:RegisterEffect(e11)
	local e12=e11:Clone()
	e12:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e12)
end
function c44460050.matfilter(c)
	return not c:IsLinkType(TYPE_TOKEN)
end
--xy
function c44460050.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460050.filter(c,tp)
	return c:IsFaceup() and (c:IsCode(44460001) or c:IsCode(44460005))
end
function c44460050.xycon(e,tp,eg,ep,ev,re,r,rp)
    if not Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_ONFIELD,0,1,nil,0x679) then return false end
end
function c44460050.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return (tc:IsCode(44460001) or tc:IsCode(44460005)) and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_ONFIELD,0,1,nil,0x679) end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460050.climit)
end
function c44460050.xyop(e,tp,eg,ep,ev,re,r,rp)
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
function c44460050.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--indes
function c44460050.indtg(e,c)
	return c:IsType(TYPE_NORMAL)
end