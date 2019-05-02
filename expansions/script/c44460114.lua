--自成仙体-天依·月下姮娥
function c44460114.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460114.matfilter,1,1)
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460114,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460114.xycost)
	e1:SetTarget(c44460114.xytg)
	e1:SetOperation(c44460114.xyop)
	c:RegisterEffect(e1)
	--cp
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460114,1))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c44460114.cptg)
	e2:SetOperation(c44460114.cpop)
	c:RegisterEffect(e2)
end
function c44460114.matfilter(c,lc,sumtype,tp)
	return c:IsLinkCode(44460015) 
end
--xy
function c44460114.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460114.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsSetCard(0x699) and tc:GetControler()==tp
	and tc:IsAttribute(ATTRIBUTE_DARK)
	and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460114.climit)
end
function c44460114.xyop(e,tp,eg,ep,ev,re,r,rp)
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
function c44460114.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--cp
function c44460114.cpfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanTurnSet() and c:IsType(TYPE_MONSTER)
end
function c44460114.cptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460114.cpfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c44460114.cpfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c44460114.cpop(e,tp,eg,ep,ev,re,r,rp)
	local cg=Duel.SelectMatchingCard(tp,c44460114.cpfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	if cg:GetCount()>0 then
       Duel.ChangePosition(cg,POS_FACEDOWN_DEFENSE)
	end
end