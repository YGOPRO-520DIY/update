--失络症 自戕
function c65030110.initial_effect(c)
	 --tohand
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1)
	e1:SetCondition(c65030110.con)
	e1:SetOperation(c65030110.op)
	c:RegisterEffect(e1)
	 --activate cost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_ACTIVATE_COST)
	e2:SetRange(0xff)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetCost(c65030110.costchk)
	e2:SetOperation(c65030110.costop)
	c:RegisterEffect(e2)
	--accumulate
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(0x10000000+65030110)
	e7:SetRange(0xff)
	e7:SetCondition(c65030110.cdcon)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e7:SetTargetRange(1,0)
	c:RegisterEffect(e7)
	if c65030110.counter==nil then
		c65030110.counter=true
		c65030110[0]=0
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		e2:SetOperation(c65030110.resetcount)
		Duel.RegisterEffect(e2,0)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e3:SetCode(EVENT_DESTROYED)
		e3:SetOperation(c65030110.addcount)
		Duel.RegisterEffect(e3,0)
	end
end
function c65030110.cdcon(e,c)
	return e:GetHandler():IsFaceup()
end
function c65030110.resetcount(e,tp,eg,ep,ev,re,r,rp)
	c65030110[0]=0
end
function c65030110.addcount(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if tc:IsCode(65030107) then
			c65030110[0]=c65030110[0]+1
		end
		tc=eg:GetNext()
	end
end
function c65030110.con(e,tp,eg,ep,ev,re,r,rp)
	return c65030110[0]>0
end
function c65030110.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SendtoHand(e:GetHandler(),1-tp,REASON_EFFECT)~=0 then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PUBLIC)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e:GetHandler():RegisterEffect(e1)
	e:GetHandler():RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(65030110,1))
	end
end

function c65030110.costckfil(c)
	return not c:IsSetCard(0xada9)
end
function c65030110.costchk(e,te_or_c,tp)
	local ct=Duel.GetFlagEffect(tp,65030110)
	return Duel.GetMatchingGroupCount(c65030110.costckfil,tp,LOCATION_HAND,0,c)>=ct and Duel.IsPlayerCanDraw(tp,ct) 
end
function c65030110.costop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsFaceup() then
	Duel.Hint(HINT_CARD,0,65030110)
	local g=Duel.SelectMatchingCard(tp,c65030110.costckfil,tp,LOCATION_HAND,0,1,1,c)
	Duel.SendtoHand(g,1-tp,REASON_COST)
	Duel.Draw(tp,1,REASON_COST)
	end
end

