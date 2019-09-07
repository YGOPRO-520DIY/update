--自成仙体-天依·锦鲤
function c44460116.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460116.matfilter,1,1)
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460116,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460116.xycost)
	e1:SetTarget(c44460116.xytg)
	e1:SetOperation(c44460116.xyop)
	c:RegisterEffect(e1)
	--sword x
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460116,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1,44460116)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c44460116.scon)
	e2:SetTarget(c44460116.ktg)
	e2:SetOperation(c44460116.kop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c44460116.matfilter(c,lc,sumtype,tp)
	return c:IsLinkCode(44460012) 
end
--xy
function c44460116.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.PayLPCost(tp,1000)
end
function c44460116.tfilter(c)
	return c:IsSetCard(0x64b) and c:IsAbleToGrave()
end
function c44460116.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsType(TYPE_NORMAL) and tc:GetControler()==tp and tc:IsAttribute(ATTRIBUTE_WATER)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-1
		and Duel.IsExistingMatchingCard(c44460116.tfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460116.climit)
end
function c44460116.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460116.tfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
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
function c44460116.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--sword x tohand
function c44460116.sfilter(c,tp)
	return c:IsFaceup() and c:IsControler(1-tp)
end
function c44460116.scon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460116.sfilter,1,nil,tp)
end
function c44460116.rmfilter(c)
	return c:IsAbleToHand() 
end
function c44460116.ktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460116.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g1=Duel.GetMatchingGroup(c44460116.rmfilter,tp,LOCATION_ONFIELD,0,nil)
	local g2=Duel.GetMatchingGroup(c44460116.rmfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g2,1,0,0)
end
function c44460116.kop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
	local g1=Duel.SelectMatchingCard(tp,c44460116.rmfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.HintSelection(g1)
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		local g2=Duel.SelectMatchingCard(tp,c44460116.rmfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	    if g2:GetCount()>0 then
		Duel.HintSelection(g2)
		Duel.SendtoHand(g2,nil,REASON_EFFECT)
	    end 
	end
end