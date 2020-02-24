--继承的二重阴影
function c65030023.initial_effect(c)
	aux.EnableDualAttribute(c)
	--SPSUMMON
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65030023,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,65030023)
	e1:SetCost(c65030023.spcost)
	e1:SetTarget(c65030023.sptg)
	e1:SetOperation(c65030023.spop)
	c:RegisterEffect(e1)
	--effect!
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCondition(aux.IsDualState)
	e5:SetCost(c65030023.cost)
	e5:SetTarget(c65030023.tg)
	e5:SetOperation(c65030023.op)
	c:RegisterEffect(e5)
end
function c65030023.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c65030023.tgfilter(c)
	return c:IsFaceup() and not c:IsType(TYPE_EFFECT)
end
function c65030023.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c65030023.tgfilter(chkc) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(c65030023.tgfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SelectTarget(tp,c65030023.tgfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c65030023.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		tc:RegisterFlagEffect(65030023,RESET_EVENT+RESETS_STANDARD,0,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_LEAVE_FIELD)
		e1:SetLabelObject(tc)
		e1:SetCondition(c65030023.thcon)
		e1:SetOperation(c65030023.thop)
		Duel.RegisterEffect(e1,tp)
		if tc:IsType(TYPE_DUAL) and Duel.SelectYesNo(tp,aux.Stringid(65030023,0)) then
			Duel.BreakEffect()
			tc:EnableDualState()
		end
	end
end
function c65030023.thcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return eg:IsContains(tc)
end
function c65030023.spfil(c,e,tp)
	return c:IsSetCard(0xcda1) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c65030023.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c65030023.spfil,tp,LOCATION_DECK,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_CARD,0,65030023)
		local num=1
		if Duel.GetFlagEffect(tp,65030023)==0 then num=2 end
		local g2=Duel.SelectMatchingCard(tp,c65030023.spfil,tp,LOCATION_DECK,0,1,num,nil,e,tp)
		if Duel.SpecialSummon(g2,0,tp,tp,false,false,POS_FACEUP)==2 then
			Duel.RegisterFlagEffect(tp,65030023,RESET_PHASE+PHASE_END,0,1)
		end
	end
	e:Reset()
end
function c65030023.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_DISCARD+REASON_COST)
end
function c65030023.sptgfil(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand() and c:IsSetCard(0xcda1)
end
function c65030023.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c65030023.sptgfil,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65030023.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c65030023.sptgfil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end