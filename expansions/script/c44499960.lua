--青眼少女-琪莎拉
function c44499960.initial_effect(c)
	--code
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetRange(LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetValue(89631139)
	c:RegisterEffect(e2) 
	--search
	local e21=Effect.CreateEffect(c)
	e21:SetDescription(aux.Stringid(44499960,1))
	e21:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e21:SetType(EFFECT_TYPE_IGNITION)
	e21:SetRange(LOCATION_GRAVE)
	e21:SetCountLimit(1,44499960)
	e21:SetCost(c44499960.thcost)
	e21:SetTarget(c44499960.thtg)
	e21:SetOperation(c44499960.thop)
	c:RegisterEffect(e21)
end
function c44499960.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c44499960.filter2(c)
	return aux.IsCodeListed(c,89631139) and c:IsType(TYPE_SPELL+TYPE_TRAP)
    and c:IsAbleToHand()
end
function c44499960.filter1(c)
	return c:IsSetCard(0xdd) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c44499960.thfilter(c)
	return ((aux.IsCodeListed(c,89631139) and c:IsType(TYPE_SPELL+TYPE_TRAP))
		or (c:IsSetCard(0xdd) and c:IsType(TYPE_MONSTER))) and c:IsAbleToHand()
end
function c44499960.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
	and Duel.IsExistingMatchingCard(c44499960.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44499960.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)
	and tc:IsFaceup() and not tc:IsSetCard(0xdd) then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,c44499960.filter1,tp,LOCATION_DECK,0,1,1,nil)
	    if g1:GetCount()>0 then
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
		end
	elseif tc:IsRelateToEffect(e)
	and tc:IsFaceup() and tc:IsSetCard(0xdd) then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g2=Duel.SelectMatchingCard(tp,c44499960.filter2,tp,LOCATION_DECK,0,1,1,nil)
	    if g2:GetCount()>0 then
		Duel.SendtoHand(g2,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g2)
		end
	end
end