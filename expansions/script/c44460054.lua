--仙依-丁香
function c44460054.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460054.matfilter,2)
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460054,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460054.xycon)
	e1:SetCost(c44460054.xycost)
	e1:SetTarget(c44460054.xytg)
	e1:SetOperation(c44460054.xyop)
	c:RegisterEffect(e1)
	--act limit
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e11:SetCode(EFFECT_CANNOT_ACTIVATE)
	e11:SetRange(LOCATION_ONFIELD)
	e11:SetTargetRange(1,1)
	e11:SetValue(c44460054.aclimit)
	c:RegisterEffect(e11)
	--avoid battle damage
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_FIELD)
	e21:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e21:SetRange(LOCATION_ONFIELD)
	e21:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e21:SetTargetRange(1,0)
	e21:SetCondition(c44460054.damcon)
	c:RegisterEffect(e21)
	--reduce
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD)
	e22:SetCode(EFFECT_CHANGE_DAMAGE)
	e22:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e22:SetRange(LOCATION_ONFIELD)
	e22:SetTargetRange(1,0)
	e22:SetCondition(c44460054.damcon)
	e22:SetValue(c44460054.damval)
	c:RegisterEffect(e22)
	local e32=e22:Clone()
	e32:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	c:RegisterEffect(e32)
end
function c44460054.matfilter(c)
	return not c:IsLinkType(TYPE_TOKEN)
end
--xy
function c44460054.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460054.filter(c,tp)
	return c:IsFaceup() and (c:IsCode(44460001) or c:IsCode(44460005))
end
function c44460054.xycon(e,tp,eg,ep,ev,re,r,rp)
    if not Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_ONFIELD,0,1,nil,0x679) then return false end
	return eg:IsExists(c44460054.filter,1,nil,tp)
end
function c44460054.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return (tc:IsCode(44460001) or tc:IsCode(44460005)) and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_ONFIELD,0,1,nil,0x679) end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460054.climit)
end
function c44460054.xyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,c)
		local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    c:RegisterEffect(e1)
end
function c44460054.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_MONSTER) 
end
--disable
function c44460054.disable(e,c)
	return (c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT) and c:IsPosition(POS_FACEUP_ATTACK)
end
--avoid damage
function c44460054.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44460054.cfilter,tp,LOCATION_MZONE,0,1,nil)
	 and Duel.IsExistingMatchingCard(c44460054.cfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c44460054.cfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK)
end
function c44460054.damcon(e)
	return Duel.IsExistingMatchingCard(c44460054.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
	 and Duel.IsExistingMatchingCard(c44460054.cfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c44460054.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0 end
	return val
end
function c44460054.aclimit(e,re,tp)
    local c=re:GetHandler()
	return re:IsActiveType(TYPE_MONSTER) and c:IsLocation(LOCATION_MZONE) and c:IsPosition(POS_FACEUP_ATTACK)
end
