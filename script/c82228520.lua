function c82228520.initial_effect(c)  
	--Activate  
	local e1=Effect.CreateEffect(c)  
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)  
	e1:SetType(EFFECT_TYPE_ACTIVATE)  
	e1:SetCode(EVENT_FREE_CHAIN)  
	e1:SetTarget(c82228520.target)  
	e1:SetOperation(c82228520.activate)  
	c:RegisterEffect(e1)  
	--cannot be target  
	local e2=Effect.CreateEffect(c)  
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)  
	e2:SetType(EFFECT_TYPE_FIELD)  
	e2:SetRange(LOCATION_SZONE)  
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)  
	e2:SetTargetRange(LOCATION_MZONE,0)  
	e2:SetTarget(c82228520.tgtg)  
	e2:SetValue(aux.tgoval)  
	c:RegisterEffect(e2)  
end
function c82228520.mtfilter(c)  
	return c:IsSetCard(0x291) and c:IsType(TYPE_MONSTER)  
end  
function c82228520.valcheck(e,c)  
	if c:GetMaterial():IsExists(c82228520.mtfilter,1,nil) then  
		c:RegisterFlagEffect(82228520,RESET_EVENT+0x4fe0000+RESET_PHASE+PHASE_END,0,1)  
	end  
end  
function c82228520.filter(c)  
	return c:IsSetCard(0x291) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()  
end  
function c82228520.target(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return Duel.IsExistingMatchingCard(c82228520.filter,tp,LOCATION_DECK,0,1,nil) end  
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)  
end  
function c82228520.activate(e,tp,eg,ep,ev,re,r,rp)  
	if not e:GetHandler():IsRelateToEffect(e) then return end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)  
	local g=Duel.SelectMatchingCard(tp,c82228520.filter,tp,LOCATION_DECK,0,1,1,nil)  
	if g:GetCount()>0 then  
		Duel.SendtoHand(g,nil,REASON_EFFECT)  
		Duel.ConfirmCards(1-tp,g)  
	end  
end  
function c82228520.tgtg(e,c)  
	return c:IsSetCard(0x291)  
end  