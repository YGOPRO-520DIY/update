--诅咒的二重阴影
function c65030022.initial_effect(c)
	aux.EnableDualAttribute(c)
	--SPSUMMON
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65030022,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,65030022)
	e1:SetCost(c65030022.spcost)
	e1:SetTarget(c65030022.sptg)
	e1:SetOperation(c65030022.spop)
	c:RegisterEffect(e1)
	--effect!
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCondition(aux.IsDualState)
	e5:SetCost(c65030022.cost)
	e5:SetTarget(c65030022.tg)
	e5:SetOperation(c65030022.op)
	c:RegisterEffect(e5)
end
function c65030022.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c65030022.tgfilter(c)
	return c:IsFaceup() and not c:IsType(TYPE_EFFECT)
end
function c65030022.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c65030022.tgfilter(chkc) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(c65030022.tgfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SelectTarget(tp,c65030022.tgfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c65030022.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		--cannot target
	local e4=Effect.CreateEffect(e:GetHandler())
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
	e4:SetValue(aux.tgoval)
	tc:RegisterEffect(e4)
		tc:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,2,0,aux.Stringid(65030022,1))
		if tc:IsType(TYPE_DUAL) and Duel.SelectYesNo(tp,aux.Stringid(65030022,0)) then
			Duel.BreakEffect()
			tc:EnableDualState()
		end
	end
end
function c65030022.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_DISCARD+REASON_COST)
end
function c65030022.sptgfil(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsCode(65030022)
end
function c65030022.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c65030022.sptgfil,tp,LOCATION_GRAVE,0,1,c,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c65030022.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMZoneCount(tp)<=0 then return end
	local g=Duel.SelectMatchingCard(tp,c65030022.sptgfil,tp,LOCATION_GRAVE,0,1,1,e:GetHandler(),e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end