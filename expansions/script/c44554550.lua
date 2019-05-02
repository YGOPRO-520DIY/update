--青之森的妖精
function c44554550.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44554550.matfilter,1)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c44554550.matcheck)
	c:RegisterEffect(e1)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44554550,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c44554550.condition)
	e1:SetTarget(c44554550.target)
	e1:SetOperation(c44554550.operation)
	c:RegisterEffect(e1)
end
function c44554550.matfilter(c)
	return c:GetAttack()>=1900
end
function c44554550.matcheck(e,c)
	local g=c:GetMaterial():Filter(c44554550.matfilter,nil)
	local atk=g:GetSum(Card.GetCode)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
--search
function c44554550.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE)
	and r==REASON_FUSION
end
function c44554550.filter(c)
	return c:IsType(TYPE_RITUAL) and not c:IsType(TYPE_MONSTER)
	and c:IsAbleToHand()
end
function c44554550.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44554550.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44554550.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44554550.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
