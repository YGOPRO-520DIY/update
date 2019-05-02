--神依-白垩苍龙
function c44460069.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSynchroType,TYPE_NORMAL),2)
	c:EnableReviveLimit()
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460069,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460069.xycon)
	e1:SetCost(c44460069.xycost)
	e1:SetTarget(c44460069.xytg)
	e1:SetOperation(c44460069.xyop)
	c:RegisterEffect(e1)
	--atk up
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD)
	e22:SetCode(EFFECT_UPDATE_ATTACK)
	e22:SetRange(LOCATION_ONFIELD)
	e22:SetTargetRange(LOCATION_MZONE,0)
	e22:SetTarget(c44460069.tg)
	e22:SetValue(1500)
	c:RegisterEffect(e22)
	--set
	local e24=Effect.CreateEffect(c)
	e24:SetDescription(aux.Stringid(44460069,1))
	e24:SetType(EFFECT_TYPE_IGNITION)
	e24:SetRange(LOCATION_ONFIELD)
	e24:SetCountLimit(1,44460069)
	e24:SetTarget(c44460069.stg)
	e24:SetOperation(c44460069.sop)
	c:RegisterEffect(e24)
end
--sy
function c44460069.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1500) end
	Duel.PayLPCost(tp,1500)
end
function c44460069.filter(c,tp)
	return c:IsFaceup() and c:IsCode(44460003)
end
function c44460069.tfilter(c)
	return c:IsSetCard(0x679) and c:IsAbleToGrave()
end
function c44460069.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460069.filter,1,nil,tp)
end
function c44460069.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460003)
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-3
        and Duel.IsExistingMatchingCard(c44460069.tfilter,tp,LOCATION_ONFIELD,0,3,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460069.climit)
end
function c44460069.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460069.tfilter,tp,LOCATION_ONFIELD,0,3,3,nil)
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
function c44460069.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--atk up
function c44460069.tg(e,c)
	return  c:IsFaceup() and  c:IsSetCard(0x677)
end
--set
function c44460069.sfilter(c)
	return not c:IsForbidden()
end
function c44460069.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460069.sfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
	and Duel.GetLocationCount(tp,LOCATION_SZONE)>-1 
	and Duel.IsExistingMatchingCard(c44460069.tfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
end
function c44460069.sop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460069.tfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	if g:GetCount()>0 then
	Duel.SendtoGrave(g,REASON_EFFECT)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44460069.sfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
		end
	end
end