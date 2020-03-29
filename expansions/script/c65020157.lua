--神奇术士 漫游法师
function c65020157.initial_effect(c)
	--summon with s/t
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_ADD_EXTRA_TRIBUTE)
	e0:SetTargetRange(LOCATION_SZONE,0)
	e0:SetTarget(c65020157.ettg)
	e0:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e0)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c65020157.cost)
	e1:SetTarget(c65020157.tg)
	e1:SetOperation(c65020157.op)
	c:RegisterEffect(e1)
	--Add counter2
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e6:SetCode(EVENT_LEAVE_FIELD_P)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(c65020157.addcon)
	e6:SetOperation(c65020157.addop)
	c:RegisterEffect(e6)
end
function c65020157.ettg(e,c)
	return c:IsType(TYPE_CONTINUOUS) and c:IsType(TYPE_SPELL)
end
function c65020157.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCounter(tp,LOCATION_ONFIELD,0,0x1da2)>0 end
	 Duel.RemoveCounter(tp,LOCATION_ONFIELD,0,0x1da2,1,REASON_COST)
end
function c65020157.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c65020157.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x1da2,1)
		tc=g:GetNext()
	end
end


function c65020157.addcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c65020157.addfil,tp,LOCATION_SZONE,0,1,nil) and e:GetHandler():GetFlagEffect(65020157)==0
end
function c65020157.addfil(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL) and c:IsType(TYPE_CONTINUOUS)
end
function c65020157.addop(e,tp,eg,ep,ev,re,r,rp)
	local count=0
	local c=eg:GetFirst()
	while c~=nil do
		if  c:IsLocation(LOCATION_ONFIELD) then
			count=count+c:GetCounter(0x1da2)
		end
		c=eg:GetNext()
	end
	if count>0 and Duel.SelectYesNo(tp,aux.Stringid(65020157,0)) then
		local g=Duel.SelectMatchingCard(tp,c65020157.addfil,tp,LOCATION_SZONE,0,1,1,nil)
		local tc=g:GetFirst()
		tc:AddCounter(0x1da2,count)
		e:GetHandler():RegisterFlagEffect(65020157,RESET_PHASE+PHASE_END,0,1)
	end
end