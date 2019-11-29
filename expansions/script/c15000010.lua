local m=15000010
local cm=_G["c"..m]
cm.name="异兽对抗"
function cm.initial_effect(c)
	--Activate  
	local e1=Effect.CreateEffect(c)  
	e1:SetDescription(aux.Stringid(15000010,0))  
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)  
	e1:SetType(EFFECT_TYPE_ACTIVATE)  
	e1:SetCode(EVENT_CHAINING)  
	e1:SetCountLimit(1,15000010)  
	e1:SetCondition(c15000010.condition)  
	e1:SetTarget(c15000010.target)  
	e1:SetOperation(c15000010.activate)  
	c:RegisterEffect(e1) 
	--back  
	local e2=Effect.CreateEffect(c)  
	e2:SetDescription(aux.Stringid(15000010,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)  
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)   
	e2:SetProperty(EFFECT_FLAG_DELAY)  
	e2:SetRange(LOCATION_GRAVE)  
	e2:SetCountLimit(1,15000010)  
	e2:SetCondition(c15000010.tgcon)  
	e2:SetOperation(c15000010.tgop)  
	c:RegisterEffect(e2)
end
function c15000010.cfilter(c)  
	return c:IsType(TYPE_MONSTER) and (c:IsFacedown() or c:IsSetCard(0xf30))
end  
function c15000010.condition(e,tp,eg,ep,ev,re,r,rp)  
	if not Duel.IsExistingMatchingCard(c15000010.cfilter,tp,LOCATION_MZONE,0,1,nil) then return false end  
	if not Duel.IsChainNegatable(ev) then return false end  
	return re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)  
end  
function c15000010.target(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return true end  
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)  
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then  
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)  
	end  
end  
function c15000010.activate(e,tp,eg,ep,ev,re,r,rp)  
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then  
		Duel.Destroy(eg,REASON_EFFECT)  
	end  
end 
function c15000010.xfilter(c,e,tp)
	return c:IsSetCard(0xf31) and not c:IsCode(15000010)
end
function c15000010.tgcon(e,tp,eg,ep,ev,re,r,rp)  
	local at=Duel.GetAttacker()  
	return at:GetControler()~=tp
end
function c15000010.tgop(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	if at:GetControler()==tp then return end
	local c=e:GetHandler()  
	if c:IsRelateToEffect(e) then  
		Duel.NegateAttack()  
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
		local g=Duel.SelectMatchingCard(tp,c15000010.xfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		local c=e:GetHandler()
		if g:GetCount()>0 then
			Duel.SendtoHand(g,tp,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
			Duel.ConfirmCards(1-tp,c)
			Duel.SendtoDeck(c,nil,3,REASON_EFFECT)
		end
	end
end