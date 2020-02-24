--束缚的二重阴影
function c65030024.initial_effect(c)
	aux.EnableDualAttribute(c)
	--SPSUMMON
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65030024,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,65030024)
	e1:SetCost(c65030024.spcost)
	e1:SetTarget(c65030024.sptg)
	e1:SetOperation(c65030024.spop)
	c:RegisterEffect(e1)
	--effect!
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCondition(aux.IsDualState)
	e5:SetCost(c65030024.cost)
	e5:SetTarget(c65030024.tg)
	e5:SetOperation(c65030024.op)
	c:RegisterEffect(e5)
end
function c65030024.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c65030024.tgfilter(c,e,tp)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c65030024.spfil,tp,LOCATION_DECK,0,1,nil,e,tp,c:GetCode()) and not c:IsType(TYPE_EFFECT)
end
function c65030024.spfil(c,e,tp,code)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsSetCard(0xcda1) and not c:IsCode(code)
end
function c65030024.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c65030024.tgfilter(chkc) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(c65030024.tgfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.SelectTarget(tp,c65030024.tgfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
end
function c65030024.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local g=Duel.SelectMatchingCard(tp,c65030024.spfil,tp,LOCATION_DECK,0,1,1,nil,e,tp,tc:GetCode())
		if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 and tc:IsType(TYPE_DUAL) and Duel.SelectYesNo(tp,aux.Stringid(65030024,0)) then
			Duel.BreakEffect()
			tc:EnableDualState()
		end
	end
end
function c65030024.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_DISCARD+REASON_COST)
end
function c65030024.sptgfil(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and c:IsSetCard(0xcda1) and not c:IsCode(65030024)
end
function c65030024.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c65030024.sptgfil,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65030024.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c65030024.sptgfil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end