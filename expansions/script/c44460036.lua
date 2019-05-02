--仙依-西行鹤
function c44460036.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460036.matfilter,2)
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460036,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460036.xycost)
	e1:SetTarget(c44460036.xytg)
	e1:SetOperation(c44460036.xyop)
	c:RegisterEffect(e1)
	--kill hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460036,1))
	e2:SetCategory(CATEGORY_HANDES)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1,44460036)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c44460036.hdtg)
	e2:SetOperation(c44460036.hdop)
	c:RegisterEffect(e2)
end
function c44460036.matfilter(c)
	return not c:IsLinkType(TYPE_TOKEN) and c:IsLinkType(TYPE_NORMAL)
end
--xy
function c44460036.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460036.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460004) and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_ONFIELD,0,1,nil,0x679) end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460036.climit)
end
function c44460036.xyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,c)
		local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    c:RegisterEffect(e1)
end
function c44460036.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_MONSTER) 
end
--kill hand
function c44460036.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsType(TYPE_NORMAL)
		and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	tc:CreateEffectRelation(e)
    Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c44460036.hdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(tp,1)
	Duel.SendtoGrave(sg,REASON_EFFECT)
end