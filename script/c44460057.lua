--神依-百花弥芳
function c44460057.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSynchroType,TYPE_SYNCHRO),aux.NonTuner(Card.IsSynchroType,TYPE_NORMAL),1)
	c:EnableReviveLimit()
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460057,3))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460057.xycost)
	e1:SetTarget(c44460057.xytg)
	e1:SetOperation(c44460057.xyop)
	c:RegisterEffect(e1)
	--sset
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1,44460057)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCondition(c44460057.condition2)
	e2:SetTarget(c44460057.stg)
	e2:SetOperation(c44460057.sop)
	c:RegisterEffect(e2)
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e22:SetRange(LOCATION_ONFIELD)
	e22:SetCountLimit(1,44460057)
	e22:SetCode(EVENT_SUMMON_SUCCESS)
	e22:SetTarget(c44460057.stg)
	e22:SetOperation(c44460057.sop)
	c:RegisterEffect(e22)
end
--sy
function c44460057.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.PayLPCost(tp,1000)
end
function c44460057.tfilter(c)
	return c:IsSetCard(0x64b) and c:IsAbleToGrave()
end
function c44460057.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460001)
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-2
        and Duel.IsExistingMatchingCard(c44460057.tfilter,tp,LOCATION_ONFIELD,0,2,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460057.climit)
end
function c44460057.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460057.tfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
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
function c44460057.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--sset
function c44460057.condition2(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER)
end
function c44460057.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_FZONE,0,1,nil,TYPE_FIELD) then return false end
end
function c44460057.setfilter1(c)
	return c:IsSetCard(0x64a) and not c:IsForbidden() and c:IsType(TYPE_CONTINUOUS)
end
function c44460057.setfilter2(c)
	return c:IsSetCard(0x64a) and not c:IsForbidden() and c:IsType(TYPE_FIELD)
end
function c44460057.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460057.setfilter1,tp,LOCATION_DECK,0,1,nil)
		or Duel.IsExistingMatchingCard(c44460057.setfilter2,tp,LOCATION_DECK,0,1,nil) end
end
function c44460057.sop(e,tp,eg,ep,ev,re,r,rp)
	local op=0
	local b1=Duel.IsExistingMatchingCard(c44460057.setfilter1,tp,LOCATION_DECK,0,1,nil)
	local b2=Duel.IsExistingMatchingCard(c44460057.setfilter2,tp,LOCATION_DECK,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,0)
	if b1 and b2 then op=Duel.SelectOption(tp,aux.Stringid(44460057,0),aux.Stringid(44460057,1))
	elseif b1 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then op=Duel.SelectOption(tp,aux.Stringid(44460057,0))
	elseif b2 then Duel.SelectOption(tp,aux.Stringid(44460057,1)) op=1
	else return end
	if op==0 then
	    local g1=Duel.SelectMatchingCard(tp,c44460057.setfilter1,tp,LOCATION_DECK,0,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	    local tc=g1:GetFirst()
	    if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
		end
	else
		local g2=Duel.SelectMatchingCard(tp,c44460057.setfilter2,tp,LOCATION_DECK,0,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local tc=g2:GetFirst()
	    if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,tc)
		end
	end
end