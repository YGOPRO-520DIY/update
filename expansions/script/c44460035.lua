--仙依-蝴蝶
function c44460035.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460035.matfilter,2)
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460035,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460035.xycost)
	e1:SetTarget(c44460035.xytg)
	e1:SetOperation(c44460035.xyop)
	c:RegisterEffect(e1)
	--act limit
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e11:SetCode(EFFECT_CANNOT_ACTIVATE)
	e11:SetRange(LOCATION_ONFIELD)
	e11:SetTargetRange(0,1)
	e11:SetCondition(c44460035.con)
	e11:SetValue(c44460035.aclimit)
	c:RegisterEffect(e11)
end
function c44460035.matfilter(c)
	return not c:IsLinkType(TYPE_TOKEN) and c:IsLinkType(TYPE_NORMAL)
end
--xy
function c44460035.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460035.tfilter(c)
	return c:IsSetCard(0x679) and c:IsAbleToGrave()
end
function c44460035.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsType(TYPE_NORMAL) and tc:GetControler()==tp and tc:IsAttribute(ATTRIBUTE_WIND)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-1
		and Duel.IsExistingMatchingCard(c44460035.tfilter,tp,LOCATION_ONFIELD,0,1,nil)  end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460035.climit)
end
function c44460035.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460035.tfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
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
function c44460035.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--act limit
function c44460035.cfilter(c)
	return c:IsFaceup() and not c:IsType(TYPE_TOKEN) and c:IsType(TYPE_NORMAL)
end
function c44460035.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
	and not Duel.IsExistingMatchingCard(c44460035.cfilter,tp,0,LOCATION_ONFIELD,1,nil)
end
function c44460035.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER) 
end