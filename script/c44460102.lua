--古夕幻历-秉烛夜读
function c44460102.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44460102)
	e1:SetTarget(c44460102.target)
	e1:SetOperation(c44460102.activate)
	c:RegisterEffect(e1)
	--remain field
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e3)
	--tohand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(44460102,1))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCondition(c44460102.condition)
	e4:SetTarget(c44460102.thtg)
	e4:SetOperation(c44460102.thop)
	c:RegisterEffect(e4)
	--untargetable
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e11:SetRange(LOCATION_SZONE)
	e11:SetTargetRange(0,LOCATION_MZONE)
	e11:SetValue(c44460102.atlimit)
	c:RegisterEffect(e11)
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e12:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e12:SetRange(LOCATION_SZONE)
	e12:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e12:SetTarget(c44460102.tglimit)
	e12:SetValue(aux.tgoval)
	c:RegisterEffect(e12)
end
function c44460102.filter(c)
	return c:IsSetCard(0x64d) and not c:IsForbidden() and c:IsType(TYPE_MONSTER)
end
function c44460102.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460102.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	e:GetHandler():SetTurnCounter(0)
	--destroy
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c44460102.descon)
	e1:SetOperation(c44460102.desop)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	e:GetHandler():RegisterEffect(e1)
	e:GetHandler():RegisterFlagEffect(1082946,RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,2)
	c44460102[e:GetHandler()]=e1
end
function c44460102.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44460102.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c44460102.descon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c44460102.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==2 then
		Duel.Destroy(c,REASON_RULE)
		c:ResetFlagEffect(1082946)
	end
end
--untargetable
function c44460102.atlimit(e,c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsLevel(1)
end
function c44460102.tglimit(e,c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsLevel(1)
end
--tohand
function c44460102.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and not e:GetHandler():IsLocation(LOCATION_DECK)
end
function c44460102.rmfilter(c)
	return not c:IsCode(44460102) and c:IsAbleToHand() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c44460102.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460102.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c44460102.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c44460102.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44460102.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,99,aux.ExceptThisCard(e))
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end