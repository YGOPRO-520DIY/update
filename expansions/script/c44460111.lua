--自成仙体-天依神剑
function c44460111.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460111.matfilter,1,1)
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460111,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460111.xycon)
	e1:SetCost(c44460111.xycost)
	e1:SetTarget(c44460111.xytg)
	e1:SetOperation(c44460111.xyop)
	c:RegisterEffect(e1)
	--sword kill
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460111,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1,44460111)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c44460111.ktg)
	e2:SetOperation(c44460111.kop)
	c:RegisterEffect(e2)
end
function c44460111.matfilter(c,lc,sumtype,tp)
	return c:IsLinkSetCard(0x699)
end
--xy
function c44460111.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460111.filter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x699) 
end
function c44460111.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460111.filter,1,nil,tp)
end
function c44460111.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsSetCard(0x699) and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460111.climit)
end
function c44460111.xyop(e,tp,eg,ep,ev,re,r,rp)
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
function c44460111.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--sword kill
function c44460111.kfilter(c)
	return c:IsSetCard(0x679) 
end
function c44460111.ktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460111.kfilter,tp,0xc,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,0xc,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,0,0xc,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c44460111.kop(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(Card.IsAbleToGrave,tp,0,0xc,nil)
	local rg=Duel.SelectMatchingCard(tp,c44460111.kfilter,tp,0xc,0,1,ct1,nil)
	Duel.SendtoGrave(rg,REASON_EFFECT)
	local ct2=rg:GetCount()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local dg=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,0xc,ct2,ct2,nil)
	Duel.HintSelection(dg)
	Duel.SendtoGrave(dg,REASON_EFFECT)
end