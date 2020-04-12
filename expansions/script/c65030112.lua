--失络者的自言
function c65030112.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--lostactesis
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_DRAW)
	e1:SetRange(LOCATION_FZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c65030112.cost)
	e1:SetOperation(c65030112.op)
	c:RegisterEffect(e1)
end
function c65030112.costfil(c)
	return c:IsSetCard(0xada9) and c:IsAbleToGraveAsCost()
end
function c65030112.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65030112.costfil,tp,LOCATION_DECK,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,c65030112.costfil,tp,LOCATION_DECK,0,1,3,nil)
	local num=Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(num)
end
function c65030112.op(e,tp,eg,ep,ev,re,r,rp)
	local num=e:GetLabel()
	if num>=1 then
		 --level
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetValue(c65030112.val)
	Duel.RegisterEffect(e2,tp)
	end
	if num>=2 then
		local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCondition(c65030112.acon)
	e1:SetOperation(c65030112.aop)
	Duel.RegisterEffect(e1,tp)
		local e3=e1:Clone()
		e3:SetCode(EVENT_REMOVE)
		Duel.RegisterEffect(e3,tp)
	end
	if num==3 then
		--cannot set
	local e4=Effect.CreateEffect(e:GetHandler())
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_SSET)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	e4:SetTarget(c65030112.atg)
	e4:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e4,tp)
	end
end
function c65030112.atg(e,c)
	return c:IsSetCard(0xada9) and c:IsPublic()
end
function c65030112.aconfil(c)
	return c:IsSetCard(0xada9) and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousLocation(LOCATION_HAND)
end
function c65030112.acon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c65030112.aconfil,1,nil) and not Duel.GetCurrentPhase()==PHASE_END 
end
function c65030112.aop(e,tp,eg,ep,ev,re,r,rp)
	local sg=eg:Filter(c65030112.aconfil,nil)
	local tc=sg:GetFirst()
	while tc do
		Duel.SendtoHand(tc,tc:GetPreviousControler(),REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PUBLIC)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1)
	tc:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(65030110,1))
		tc=sg:GetNext()
	end
end
function c65030112.valfil(c)
	return c:IsSetCard(0xada9) and c:IsFaceup()
end
function c65030112.val(e,c)
	local p=c:GetControler()
	return 0-Duel.GetMatchingGroupCount(c65030112.valfil,tp,0xff,0,nil)*200
end