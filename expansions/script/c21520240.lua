--星曜反射
function c21520240.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--trigger effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21520240,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c21520240.trcon)
	e1:SetTarget(c21520240.trtg)
	e1:SetOperation(c21520240.trop)
	c:RegisterEffect(e1)
	--add name
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_ONFIELD+LOCATION_GRAVE)
	e2:SetValue(21520133)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(21520240,1))
	e3:SetCategory(CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(c21520240.thcost)
	e3:SetTarget(c21520240.thtg)
	e3:SetOperation(c21520240.thop)
	c:RegisterEffect(e3)
end
function c21520240.trfilter(c,lv)
	return c:IsAbleToGrave() and c:IsLevelBelow(lv) and c:IsType(TYPE_MONSTER)
end
function c21520240.trcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():IsControler(tp) and eg:GetFirst():IsSetCard(0x491)
end
function c21520240.trtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21520240.trfilter,tp,LOCATION_DECK,0,1,nil,eg:GetFirst():GetLevel()) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c21520240.trop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local g=Duel.GetMatchingGroup(c21520240.trfilter,tp,LOCATION_DECK,0,nil,eg:GetFirst():GetLevel())
	if g:GetCount()>0 then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
function c21520240.thfilter(c)
	return c:IsAbleToHand() and c:IsCode(21520133)
end
function c21520240.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c21520240.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21520240.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c21520240.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c21520240.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
