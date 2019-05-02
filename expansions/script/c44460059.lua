--神依-青丘九尾
function c44460059.initial_effect(c)
	c:EnableReviveLimit()
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460059,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460059.xycon)
	e1:SetCost(c44460059.xycost)
	e1:SetTarget(c44460059.xytg)
	e1:SetOperation(c44460059.xyop)
	c:RegisterEffect(e1)
	--disable spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetTarget(c44460059.sumlimit)
	c:RegisterEffect(e2)
end
--sy
function c44460059.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460059.filter(c,tp)
	return c:IsFaceup() and c:IsCode(44460004)
end
function c44460059.tfilter(c)
	return c:IsSetCard(0x679) and c:IsAbleToGrave()
end
function c44460059.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460059.filter,1,nil,tp)
end
function c44460059.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460004)
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-2
        and Duel.IsExistingMatchingCard(c44460059.tfilter,tp,LOCATION_ONFIELD,0,2,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460059.climit)
end
function c44460059.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460059.tfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
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
function c44460059.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--disable spsummon
function c44460059.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsType(TYPE_EFFECT)
end