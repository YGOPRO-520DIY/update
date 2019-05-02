--神依-龙刃沧月
function c44460067.initial_effect(c)
	c:SetUniqueOnField(1,0,44460067)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsXyzType,TYPE_NORMAL),1,5)
	c:EnableReviveLimit()
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460067,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460067.xycon)
	e1:SetCost(c44460067.xycost)
	e1:SetTarget(c44460067.xytg)
	e1:SetOperation(c44460067.xyop)
	c:RegisterEffect(e1)
	--
	--local e2=Effect.CreateEffect(c)
	--e2:SetType(EFFECT_TYPE_SINGLE)
	--e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	--e2:SetRange(LOCATION_ONFIELD)
	--e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	--e2:SetCondition(c44460067.indcon)
	--e2:SetValue(1)
	--c:RegisterEffect(e2)
	--local e3=e2:Clone()
	--e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	--c:RegisterEffect(e3)
	--atk up
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD)
	e22:SetCode(EFFECT_UPDATE_ATTACK)
	e22:SetRange(LOCATION_ONFIELD)
	e22:SetTargetRange(LOCATION_MZONE,0)
	e22:SetTarget(c44460067.tg)
	e22:SetValue(c44460067.val)
	c:RegisterEffect(e22)
	--Def up
	local e25=e22:Clone()
	e25:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e25)
end
--sy
function c44460067.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460067.filter(c,tp)
	return c:IsFaceup() and c:IsCode(44460003)
end
function c44460067.tfilter(c)
	return c:IsSetCard(0x679) and c:IsAbleToGrave()
end
function c44460067.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460067.filter,1,nil,tp)
end
function c44460067.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460003)
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-2
        and Duel.IsExistingMatchingCard(c44460067.tfilter,tp,LOCATION_ONFIELD,0,2,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460067.climit)
end
function c44460067.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460067.tfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
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
function c44460067.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--
--function c44460067.indcon(e)
--return Duel.IsExistingMatchingCard(Card.IsSetCard,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil,0x677)
--end
--atk up
function c44460067.tg(e,c)
	return  c:IsFaceup() and (c:GetLevel()==1 or c:GetRank()==1)
end
function c44460067.afilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c44460067.val(e,c)
	return Duel.GetMatchingGroupCount(c44460067.afilter,c:GetControler(),LOCATION_ONFIELD,0,nil)*500
end