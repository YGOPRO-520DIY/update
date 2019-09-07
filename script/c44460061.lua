--神依-创圣凤凰
function c44460061.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x64a),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460061,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460061.xycon)
	e1:SetCost(c44460061.xycost)
	e1:SetTarget(c44460061.xytg)
	e1:SetOperation(c44460061.xyop)
	c:RegisterEffect(e1)
	--sset1
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44460061,1))
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetRange(LOCATION_ONFIELD)
	e11:SetCountLimit(1,44460061)
	e11:SetTarget(c44460061.stg)
	e11:SetOperation(c44460061.sop)
	c:RegisterEffect(e11)
	--summon
	local e21=Effect.CreateEffect(c)
	e21:SetDescription(aux.Stringid(44460061,2))
	e21:SetCountLimit(1,44460061)
	e21:SetCategory(CATEGORY_SUMMON)
	e21:SetType(EFFECT_TYPE_QUICK_O)
	e21:SetCode(EVENT_FREE_CHAIN)
	e21:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e21:SetRange(LOCATION_ONFIELD)
	e21:SetTarget(c44460061.tg)
	e21:SetOperation(c44460061.op)
	e21:SetLabelObject(e11)
	c:RegisterEffect(e21)
end
--sy
function c44460061.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.PayLPCost(tp,1000)
end
function c44460061.filter(c,tp)
	return c:IsFaceup() and c:IsCode(44460004)
end
function c44460061.tfilter(c)
	return c:IsSetCard(0x64b) and c:IsAbleToGrave()
end
function c44460061.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460061.filter,1,nil,tp)
end
function c44460061.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460004)
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-2
        and Duel.IsExistingMatchingCard(c44460061.tfilter,tp,LOCATION_ONFIELD,0,2,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460061.climit)
end
function c44460061.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460061.tfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
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
function c44460061.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--sset
function c44460061.setfilter(c)
	return (c:IsSetCard(0x64a) or c:IsSetCard(0x64b)) and not c:IsForbidden() and c:IsType(TYPE_MONSTER) 
end
function c44460061.stg(e,tp,eg,ep,ev,re,r,rp,chk)

	if chk==0 then return Duel.IsExistingMatchingCard(c44460061.setfilter,tp,LOCATION_MZONE,0,1,nil)
	and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end

end
function c44460061.sop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44460061.setfilter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	end
end
--summon
function c44460061.sfilter(c)
	return (c:IsSetCard(0x64a) or c:IsSetCard(0x64b)) and bit.band(c:GetOriginalType(),TYPE_MONSTER)~=0 
end
function c44460061.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460061.sfilter,tp,LOCATION_SZONE,0,1,nil)
    and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c44460061.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c44460061.sfilter,tp,LOCATION_SZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
     	Duel.Summon(tp,tc,true,nil)
	end
end