local m=15000014
local cm=_G["c"..m]
cm.name="UB03·电束木"
function cm.initial_effect(c)
	--flip  
	local e1=Effect.CreateEffect(c)  
	e1:SetDescription(aux.Stringid(15000014,0))  
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)  
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)  
	e1:SetProperty(EFFECT_FLAG_DELAY)  
	e1:SetCountLimit(1,15000014)  
	e1:SetTarget(c15000014.target)  
	e1:SetOperation(c15000014.operation)  
	c:RegisterEffect(e1) 
	local e2=Effect.CreateEffect(c)  
	e2:SetDescription(aux.Stringid(15000014,1))  
	e2:SetCategory(CATEGORY_NEGATE)  
	e2:SetType(EFFECT_TYPE_QUICK_O)  
	e2:SetCode(EVENT_CHAINING)  
	e2:SetRange(LOCATION_HAND)  
	e2:SetCountLimit(1,15010014)  
	e2:SetCondition(c15000014.condition)  
	e2:SetCost(c15000014.cost)  
	e2:SetTarget(c15000014.tg)  
	e2:SetOperation(c15000014.op)  
	c:RegisterEffect(e2) 
end
function c15000014.filter(c)  
	return c:IsSetCard(0xf30) and (c:IsAbleToHand() or c:IsCanBeSpecialSummoned(e,0,tp,false,false)) and not c:IsCode(15000014)
end  
function c15000014.target(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return Duel.IsExistingMatchingCard(c15000014.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end  
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)  
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK) 
end  
function c15000014.operation(e,tp,eg,ep,ev,re,r,rp)  
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(15000014,0))  
	local g=Duel.SelectMatchingCard(tp,c15000014.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)  
	if g:GetCount()>0 then  
		local sc=g:GetFirst()  
		if sc then  
			if sc:IsCanBeSpecialSummoned(e,0,tp,false,false)  
				and (not sc:IsAbleToHand() or Duel.SelectOption(tp,1190,1191)==1) then  
				Duel.SendtoGrave(sc,REASON_EFFECT) 
			else  
				Duel.SendtoHand(sc,nil,REASON_EFFECT)  
				Duel.ConfirmCards(1-tp,sc)  
			end  
		end  
	end  
end
function c15000014.filter1(c)  
	return (c:IsFaceup() and c:IsSetCard(0xf30)) or c:IsFacedown()
end  
function c15000014.condition(e,tp,eg,ep,ev,re,r,rp)  
	return ep~=tp and Duel.IsExistingMatchingCard(c15000014.filter1,tp,LOCATION_MZONE,0,1,nil)
end  
function c15000014.cost(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end  
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)  
end  
function c15000014.tg(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return true end   
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)  
end  
function c15000014.op(e,tp,eg,ep,ev,re,r,rp)   
		Duel.NegateActivation(ev)  
end