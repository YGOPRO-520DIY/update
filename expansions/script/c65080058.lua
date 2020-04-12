--岩石机关触动
function c65080058.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	 --change pos
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(65080058,1))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c65080058.poscon2)
	e2:SetTarget(c65080058.postg)
	e2:SetOperation(c65080058.posop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCondition(c65080058.poscon)
	c:RegisterEffect(e3)
	--select
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(65080058,0))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_FLIP)
	e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1,65080058)
	e4:SetTarget(c65080058.tg1)
	e4:SetOperation(c65080058.op1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetDescription(aux.Stringid(65080058,1))
	e5:SetCategory(CATEGORY_DISABLE)
	e5:SetCountLimit(1,65080059)
	e5:SetTarget(c65080058.tg2)
	e5:SetOperation(c65080058.op2)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetDescription(aux.Stringid(65080058,2))
	e6:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e6:SetCountLimit(1,65080060)
	e6:SetTarget(c65080058.tg3)
	e6:SetOperation(c65080058.op3)
	c:RegisterEffect(e6)
end
function c65080058.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,0,LOCATION_MZONE,1,nil) and e:GetHandler():GetFlagEffect(65080058)==0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,1-tp,LOCATION_MZONE)
	e:GetHandler():RegisterFlagEffect(65080058,RESET_CHAIN,0,1)
end
function c65080058.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
function c65080058.mfilter(c)
	return c:IsType(TYPE_EFFECT) and not c:IsDisabled()
end
function c65080058.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65080058.mfilter,tp,0,LOCATION_MZONE,1,nil) and e:GetHandler():GetFlagEffect(65080058)==0 end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,nil,1,1-tp,LOCATION_MZONE)
	e:GetHandler():RegisterFlagEffect(65080058,RESET_CHAIN,0,1)
end
function c65080058.op2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.SelectMatchingCard(tp,c65080058.mfilter,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		Duel.HintSelection(g)
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
function c65080058.mfilter2(c)
	return c:IsAttribute(ATTRIBUTE_EARTH) and c:IsRace(RACE_ROCK) and c:IsAbleToHand()
end
function c65080058.tg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65080058.mfilter2,tp,LOCATION_DECK,0,1,nil) and e:GetHandler():GetFlagEffect(65080058)==0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	e:GetHandler():RegisterFlagEffect(65080058,RESET_CHAIN,0,1)
end
function c65080058.op3(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c65080058.mfilter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c65080058.poscon(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp 
end
function c65080058.poscon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp 
end
function c65080058.filter(c)
	return c:IsRace(RACE_ROCK) and c:IsFacedown() and c:IsDefensePos()
end
function c65080058.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65080058.filter,tp,LOCATION_MZONE,0,1,nil) and e:GetHandler():GetFlagEffect(65080058)==0 end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,nil,1,0,0)
	e:GetHandler():RegisterFlagEffect(65080058,RESET_CHAIN,0,1)
end
function c65080058.posop(e,tp,eg,ep,ev,re,r,rp,chk)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectMatchingCard(tp,c65080058.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
	end
end