--神依-仙芝灵鹿
function c44460064.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460064.matfilter,2)
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460064,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460064.xycost)
	e1:SetTarget(c44460064.xytg)
	e1:SetOperation(c44460064.xyop)
	c:RegisterEffect(e1)
	--recover
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_RECOVER)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e11:SetRange(LOCATION_ONFIELD)
	e11:SetCode(EVENT_SUMMON_SUCCESS)
	e11:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e11:SetCountLimit(1,44460064)
	e11:SetTarget(c44460064.target)
	e11:SetOperation(c44460064.operation)
	c:RegisterEffect(e11)
end
function c44460064.matfilter(c)
	return not c:IsLinkType(TYPE_TOKEN)
end
--sy
function c44460064.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460064.tfilter(c)
	return c:IsSetCard(0x679) and c:IsAbleToGrave()
end
function c44460064.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return (tc:IsCode(44460001) or tc:IsCode(44460004))
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-2
        and Duel.IsExistingMatchingCard(c44460064.tfilter,tp,LOCATION_ONFIELD,0,2,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460064.climit)
end
function c44460064.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460064.tfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
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
function c44460064.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--recover
function c44460064.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x679)
end
function c44460064.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	local rec=Duel.GetMatchingGroupCount(c44460064.filter1,tp,LOCATION_ONFIELD,0,nil)*500
	if chk==0 then return tc:IsType(TYPE_NORMAL)
		and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 and rec>0 end
	tc:CreateEffectRelation(e)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c44460064.operation(e,tp,eg,ep,ev,re,r,rp)
	local rec=Duel.GetMatchingGroupCount(c44460064.filter1,tp,LOCATION_ONFIELD,0,nil)*500
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Recover(p,rec,REASON_EFFECT)
end