function c82228100.initial_effect(c)  
	--pendulum summon  
	aux.EnablePendulumAttribute(c)  
	--to hand  
	local e1=Effect.CreateEffect(c)   
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND)  
	e1:SetType(EFFECT_TYPE_IGNITION)  
	e1:SetRange(LOCATION_PZONE)  
	e1:SetCountLimit(1,82228100)
	e1:SetCondition(c82228100.pcon)  
	e1:SetTarget(c82228100.ptg)  
	e1:SetOperation(c82228100.pop)  
	c:RegisterEffect(e1)  
end
 
function c82228100.pcon(e,tp,eg,ep,ev,re,r,rp)  
	return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_PZONE,0,1,e:GetHandler(),0xfd)  
end  
 
function c82228100.pfilter(c)  
	return c:IsSetCard(0xfd) and c:IsAbleToHand()
end  
 
function c82228100.ptg(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return e:GetHandler():IsDestructable()  
		and Duel.IsExistingMatchingCard(c82228100.pfilter,tp,LOCATION_DECK,0,1,nil) end  
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)  
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)  
end  
 
function c82228100.pop(e,tp,eg,ep,ev,re,r,rp)  
	if not e:GetHandler():IsRelateToEffect(e) then return end  
	if Duel.Destroy(e:GetHandler(),REASON_EFFECT)~=0 then  
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)  
		local g=Duel.SelectMatchingCard(tp,c82228100.pfilter,tp,LOCATION_DECK,0,1,1,nil)  
		local tc=g:GetFirst()  
		if tc then  
			Duel.SendtoHand(tc,tp,REASON_EFFECT)  
		end  
	end  
end  