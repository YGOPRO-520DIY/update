--双子鲤
function c44554460.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44554460.matfilter,1)
	--fusion substitute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44554460,1))
	--e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,44554460)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c44554460.target)
	e1:SetOperation(c44554460.operation)
	c:RegisterEffect(e1)
	--search
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44554460,0))
	e11:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	e11:SetCode(EVENT_BE_MATERIAL)
	e11:SetCountLimit(1,44554461)
	e11:SetCondition(c44554460.condition)
	e11:SetTarget(c44554460.tg)
	e11:SetOperation(c44554460.op)
	c:RegisterEffect(e11)
end
function c44554460.matfilter(c)
	return c:GetDefense()>=2500
end
function c44554460.filter(c)
	return c:IsFaceup()
end
function c44554460.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c44554460.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44554460.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c44554460.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c44554460.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
	    --fusion substitute
	    local e2=Effect.CreateEffect(e:GetHandler())
	    e2:SetType(EFFECT_TYPE_SINGLE)
	    e2:SetCode(EFFECT_FUSION_SUBSTITUTE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
	    e2:SetCondition(c44554460.subcon)
	    tc:RegisterEffect(e2)
	end
end
function c44554460.subcon(e)
	return e:GetHandler():IsLocation(LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE)
end
--search
function c44554460.condition(e,tp,eg,ep,ev,re,r,rp)
	return (e:GetHandler():IsLocation(LOCATION_GRAVE)
	or e:GetHandler():IsLocation(LOCATION_REMOVED))
	and r==REASON_FUSION
end
function c44554460.cfilter(c)
	return c:IsCode(24094653)
	and c:IsAbleToHand()
end
function c44554460.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44554460.cfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44554460.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44554460.cfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end


