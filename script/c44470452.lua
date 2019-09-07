--十二宫·金牛座
function c44470452.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MONSTER_SSET)
	e1:SetValue(TYPE_SPELL)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	--e2:SetType(EFFECT_TYPE_ACTIVATE+EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	--e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,44470452)
	e2:SetCondition(c44470452.condition)
	e2:SetTarget(c44470452.target)
	e2:SetOperation(c44470452.activate)
	c:RegisterEffect(e2)
	--remove
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_REMOVE)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetCode(EVENT_REMOVE)
	e11:SetCountLimit(1,44471452)
	e11:SetCondition(c44470452.condition)
	e11:SetTarget(c44470452.tg)
	e11:SetOperation(c44470452.operation)
	c:RegisterEffect(e11)
end
function c44470452.cfilter(c)
	return c:IsCode(44470452)
end
function c44470452.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c44470452.cfilter,tp,LOCATION_DECK,0,1,nil)
end
function c44470452.thfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x64f) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c44470452.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_REMOVED) and c44470452.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44470452.thfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c44470452.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c44470452.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
--remove
function c44470452.rmfilter(c)
	return c:IsAbleToRemove() and c:IsSetCard(0x64f)
end
function c44470452.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470452.rmfilter,tp,LOCATION_DECK,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c44470452.rmfilter,tp,LOCATION_DECK,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c44470452.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44470452.rmfilter,tp,LOCATION_DECK,0,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end