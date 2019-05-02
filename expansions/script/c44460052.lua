--仙依-笔仙
function c44460052.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_NORMAL),2,2)
	c:EnableReviveLimit()
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460052,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460052.xycon)
	e1:SetCost(c44460052.xycost)
	e1:SetTarget(c44460052.xytg)
	e1:SetOperation(c44460052.xyop)
	c:RegisterEffect(e1)
	--name change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460052,1))
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1)
	e2:SetTarget(c44460052.target)
	e2:SetOperation(c44460052.operation)
	c:RegisterEffect(e2)
end
--xy
function c44460052.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c44460052.filter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x677) 
end
function c44460052.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460052.filter,1,nil,tp)
end
function c44460052.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsSetCard(0x677) and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460052.climit)
end
function c44460052.xyop(e,tp,eg,ep,ev,re,r,rp)
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
function c44460052.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--name change
function c44460052.tgfilter(c)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c44460052.cfilter,c:GetControler(),LOCATION_DECK,0,1,nil,c)
end
function c44460052.cfilter(c,tc)
	return c:IsSetCard(0x677) and not c:IsCode(tc:GetCode()) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c44460052.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c44460052.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44460052.tgfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44460052.tgfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c44460052.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460052.cfilter,tp,LOCATION_DECK,0,1,1,nil,tc)
	if g:GetCount()>0 then
		local gc=g:GetFirst()
		if Duel.SendtoGrave(gc,REASON_EFFECT)~=0 and gc:IsLocation(LOCATION_GRAVE) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_CODE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(gc:GetCode())
			tc:RegisterEffect(e1)
		end
	end
end