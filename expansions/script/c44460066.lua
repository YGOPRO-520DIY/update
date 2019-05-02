--神依-紫瑞祥云
function c44460066.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x677),3,99,false)
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460066,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460066.xycon)
	e1:SetCost(c44460066.xycost)
	e1:SetTarget(c44460066.xytg)
	e1:SetOperation(c44460066.xyop)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460066,1))
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1,44460066)
	e2:SetTarget(c44460066.destg)
	e2:SetValue(c44460066.value)
	e2:SetOperation(c44460066.desop)
	c:RegisterEffect(e2)
	--destroy replace2
	local e22=Effect.CreateEffect(c)
	e22:SetDescription(aux.Stringid(44460066,2))
	e22:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e22:SetCode(EFFECT_DESTROY_REPLACE)
	e22:SetRange(LOCATION_ONFIELD)
	e22:SetCountLimit(1,44460066)
	e22:SetTarget(c44460066.destg2)
	e22:SetValue(c44460066.value)
	e22:SetOperation(c44460066.desop2)
	c:RegisterEffect(e22)
end
--sy
function c44460066.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460066.filter(c,tp)
	return c:IsFaceup() and c:IsCode(44460004)
end
function c44460066.tfilter(c)
	return c:IsSetCard(0x679) and c:IsAbleToGrave()
end
function c44460066.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460066.filter,1,nil,tp)
end
function c44460066.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460004)
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-2
        and Duel.IsExistingMatchingCard(c44460066.tfilter,tp,LOCATION_ONFIELD,0,2,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460066.climit)
end
function c44460066.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460066.tfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
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
function c44460066.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--destroy replace
function c44460066.dfilter(c,tp)
	return c:IsControler(tp)
end
function c44460066.repfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToGrave()
end
function c44460066.repfilter2(c)
	return c:IsType(TYPE_TRAP) and c:IsAbleToGrave()
end
function c44460066.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c44460066.dfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(c44460066.repfilter,tp,LOCATION_ONFIELD,0,1,nil) 
	and Duel.SelectEffectYesNo(tp,e:GetHandler(),96) end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,0,0,tp,1000)
end
function c44460066.value(e,c)
	return c:IsControler(e:GetHandlerPlayer()) and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT))
end
function c44460066.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460066.repfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Recover(tp,1000,REASON_EFFECT)
end
function c44460066.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c44460066.dfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(c44460066.repfilter,tp,0,LOCATION_ONFIELD,1,nil) 
	and Duel.SelectEffectYesNo(tp,e:GetHandler(),96) end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,0,0,tp,1000)
end
function c44460066.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460066.repfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Recover(tp,1000,REASON_EFFECT)
end