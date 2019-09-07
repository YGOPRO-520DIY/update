--仙依-乐正白鹤
function c44460201.initial_effect(c)
--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460201.matfilter,1,1)
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460201,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460201.xycost)
	e1:SetTarget(c44460201.xytg)
	e1:SetOperation(c44460201.xyop)
	c:RegisterEffect(e1)
	--sword x
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460201,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1,44460201)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	--e2:SetCondition(c44460201.scon)
	e2:SetTarget(c44460201.ktg)
	e2:SetOperation(c44460201.kop)
	c:RegisterEffect(e2)
	--local e3=e2:Clone()
	--e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	--c:RegisterEffect(e3)
end
function c44460201.matfilter(c,lc,sumtype,tp)
	return c:IsLinkCode(44460010) 
end
--xy
function c44460201.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.PayLPCost(tp,1000)
end
function c44460201.tfilter(c)
	return c:IsSetCard(0x64b) and c:IsAbleToGrave()
end
function c44460201.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsType(TYPE_NORMAL) and tc:GetControler()==tp and tc:IsAttribute(ATTRIBUTE_WIND)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-1
		and Duel.IsExistingMatchingCard(c44460201.tfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460201.climit)
end
function c44460201.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460201.tfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
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
function c44460201.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--sword x tohand
function c44460201.sfilter(c,tp)
	return c:IsFaceup()
end
function c44460201.scon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460201.sfilter,1,nil,tp)
end
function c44460201.rmfilter(c)
	return c:IsAbleToHand() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c44460201.ktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460201.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g1=Duel.GetMatchingGroup(c44460201.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,1,0,0)
end
function c44460201.kop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
	local g1=Duel.SelectMatchingCard(tp,c44460201.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g1:GetCount()>0 then
		Duel.HintSelection(g1)
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
	end
end
