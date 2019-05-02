--神依-八重樱
function c44460056.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSynchroType,TYPE_NORMAL),1)
	c:EnableReviveLimit()
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460056,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460056.xycon)
	e1:SetCost(c44460056.xycost)
	e1:SetTarget(c44460056.xytg)
	e1:SetOperation(c44460056.xyop)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c44460056.disable)
	e2:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e2)
	--Atk
	--local e4=Effect.CreateEffect(c)
	--e4:SetType(EFFECT_TYPE_FIELD)
	--e4:SetCode(EFFECT_UPDATE_ATTACK)
	--e4:SetRange(LOCATION_ONFIELD)
	--e4:SetTargetRange(LOCATION_MZONE,0)
	--e4:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x677))
	--e4:SetValue(200)
	--c:RegisterEffect(e4)
	--Def
	--local e5=e4:Clone()
	--e5:SetCode(EFFECT_UPDATE_DEFENSE)
	--e5:SetValue(200)
	--c:RegisterEffect(e5)
	--Atk
	--local e22=Effect.CreateEffect(c)
	--e22:SetType(EFFECT_TYPE_FIELD)
	--e22:SetCode(EFFECT_UPDATE_ATTACK)
	--e22:SetRange(LOCATION_ONFIELD)
	--e22:SetTargetRange(LOCATION_MZONE,0)
	--e22:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x679))
	--e22:SetValue(200)
	--c:RegisterEffect(e22)
	--Def
	--local e32=e22:Clone()
	--e32:SetCode(EFFECT_UPDATE_DEFENSE)
	--e32:SetValue(200)
	--c:RegisterEffect(e32)
end
--sy
function c44460056.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460056.filter(c,tp)
	return c:IsFaceup() and (c:IsCode(44460001) or c:IsCode(44460011) or c:IsCode(44460012))
end
function c44460056.tfilter(c)
	return c:IsSetCard(0x679) and c:IsAbleToGrave()
end
function c44460056.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460056.filter,1,nil,tp)
end
function c44460056.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return (tc:IsCode(44460001) or tc:IsCode(44460011) or tc:IsCode(44460012))
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-2
        and Duel.IsExistingMatchingCard(c44460056.tfilter,tp,LOCATION_ONFIELD,0,2,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460056.climit)
end
function c44460056.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460056.tfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
	if g:GetCount()>0 then
	Duel.SendtoGrave(g,REASON_EFFECT)
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
end
function c44460056.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--disable
function c44460056.disable(e,c)
	return (c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT)
	and c:IsSummonType(SUMMON_TYPE_SPECIAL) and not c:IsCode(44460056)
end