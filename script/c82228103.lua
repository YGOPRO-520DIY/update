function c82228103.initial_effect(c)  
	--pendulum summon  
	aux.EnablePendulumAttribute(c)  
	--search  
	local e1=Effect.CreateEffect(c)  
	e1:SetDescription(aux.Stringid(82228103,0))  
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)  
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)  
	e1:SetCode(EVENT_SUMMON_SUCCESS)  
	e1:SetProperty(EFFECT_FLAG_DELAY)  
	e1:SetCountLimit(1,21893603)  
	e1:SetTarget(c82228103.thtg1)  
	e1:SetOperation(c82228103.thop1)  
	c:RegisterEffect(e1)  
	local e2=e1:Clone()  
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)  
	c:RegisterEffect(e2)  
	--to hand  
	local e3=Effect.CreateEffect(c)  
	e3:SetDescription(aux.Stringid(82228103,1))  
	e3:SetCategory(CATEGORY_TOHAND)  
	e3:SetType(EFFECT_TYPE_IGNITION)  
	e3:SetRange(LOCATION_GRAVE)  
	e3:SetCountLimit(1,21893604)  
	e3:SetCost(c82228103.thcost2)  
	e3:SetTarget(c82228103.thtg2)  
	e3:SetOperation(c82228103.thop2)  
	c:RegisterEffect(e3)  
	--to hand  
	local e4=Effect.CreateEffect(c)   
	e4:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND)  
	e4:SetType(EFFECT_TYPE_IGNITION)  
	e4:SetRange(LOCATION_PZONE)  
	e4:SetCountLimit(1,82228103)
	e4:SetCondition(c82228103.pcon)  
	e4:SetTarget(c82228103.ptg)  
	e4:SetOperation(c82228103.pop)  
	c:RegisterEffect(e4)  
end
 
function c82228103.pcon(e,tp,eg,ep,ev,re,r,rp)  
	return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_PZONE,0,1,e:GetHandler(),0xfd)  
end  
 
function c82228103.pfilter(c)  
	return c:IsSetCard(0xfd) and c:IsAbleToHand()
end  
 
function c82228103.ptg(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return e:GetHandler():IsDestructable()  
		and Duel.IsExistingMatchingCard(c82228103.pfilter,tp,LOCATION_DECK,0,1,nil) end  
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)  
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)  
end  
 
function c82228103.pop(e,tp,eg,ep,ev,re,r,rp)  
	if not e:GetHandler():IsRelateToEffect(e) then return end  
	if Duel.Destroy(e:GetHandler(),REASON_EFFECT)~=0 then  
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)  
		local g=Duel.SelectMatchingCard(tp,c82228103.pfilter,tp,LOCATION_DECK,0,1,1,nil)  
		local tc=g:GetFirst()  
		if tc then  
			Duel.SendtoHand(tc,tp,REASON_EFFECT)  
		end  
	end  
end  
 
function c82228103.thfilter(c)  
	return c:IsSetCard(0xfd) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()  
end  

function c82228103.thtg1(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return Duel.IsExistingMatchingCard(c82228103.thfilter,tp,LOCATION_DECK,0,1,nil) end  
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)  
end  

function c82228103.thop1(e,tp,eg,ep,ev,re,r,rp)  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)  
	local g=Duel.SelectMatchingCard(tp,c82228103.thfilter,tp,LOCATION_DECK,0,1,1,nil)  
	if g:GetCount()>0 then  
		Duel.SendtoHand(g,nil,REASON_EFFECT)  
		Duel.ConfirmCards(1-tp,g)  
	end  
end  

function c82228103.thcfilter(c)  
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()  
end  

function c82228103.thcost2(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return Duel.IsExistingMatchingCard(c82228103.thcfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)  
	local g=Duel.SelectMatchingCard(tp,c82228103.thcfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)  
	Duel.SendtoGrave(g,REASON_COST)  
end  

function c82228103.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)  
	local c=e:GetHandler()  
	if chk==0 then return c:IsAbleToHand() end  
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)  
end  

function c82228103.thop2(e,tp,eg,ep,ev,re,r,rp)  
	local c=e:GetHandler()  
	if c:IsRelateToEffect(e) then  
		Duel.SendtoHand(c,nil,REASON_EFFECT)  
	end  
end  