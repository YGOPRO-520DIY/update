--古夕幻历-里桃花
function c44460029.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_NORMAL),1,1)
	c:EnableReviveLimit()
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460029,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460029.xycost)
	e1:SetTarget(c44460029.xytg)
	e1:SetOperation(c44460029.xyop)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460029,1))
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1,44460029)
	e2:SetTarget(c44460029.target)
	e2:SetOperation(c44460029.operation)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c44460029.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c44460029.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsSetCard(0x677) and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460029.climit)
end
function c44460029.xyop(e,tp,eg,ep,ev,re,r,rp)
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
function c44460029.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--summon
function c44460029.sfilter(c)
	return c:IsLevelBelow(4) and c:IsType(TYPE_NORMAL) and c:IsSummonable(true,e)
end
function c44460029.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460029.sfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c44460029.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c44460029.sfilter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
     	Duel.Summon(tp,tc,true,nil)
	end
end
