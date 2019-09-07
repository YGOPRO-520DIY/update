--神依-天轮星磐
function c44460999.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode4(c,44460001,44460002,44460003,44460004,true,true)
	--ssy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460999,3))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460999.xycost)
	e1:SetTarget(c44460999.xytg)
	e1:SetOperation(c44460999.xyop)
	c:RegisterEffect(e1)
	--End kill
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460999,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1,44460999)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c44460999.ktg)
	e2:SetOperation(c44460999.kop)
	c:RegisterEffect(e2)
end
--sy
function c44460999.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c44460999.tfilter(c)
	return c:IsSetCard(0x64c) and c:IsAbleToGrave()
end
function c44460999.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460009)
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-2
        and Duel.IsExistingMatchingCard(c44460999.tfilter,tp,LOCATION_ONFIELD,0,2,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460999.climit)
end
function c44460999.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460999.tfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
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
function c44460999.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--End kill
function c44460999.rmfilter(c)
	return c:IsFaceup() and c:IsAbleToRemove() 
end
function c44460999.ktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460999.rmfilter,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c44460999.rmfilter,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c44460999.kop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44460999.rmfilter,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	
		local tc=g:GetFirst()
		local tpe=tc:GetType()
	    if bit.band(tpe,TYPE_TOKEN)~=0 then return end
		Duel.BreakEffect()
	    local dg=Duel.GetMatchingGroup(Card.IsCode,tc:GetControler(),LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,nil,tc:GetCode())
	    Duel.Remove(dg,POS_FACEUP,REASON_EFFECT)
	end
end