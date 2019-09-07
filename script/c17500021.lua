--虚无之露易丝
function c17500021.initial_effect(c)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,0,17500021)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c17500021.spcon)
	e2:SetOperation(c17500021.spop)
	c:RegisterEffect(e2)
	--immune spell
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c17500021.efilter)
	c:RegisterEffect(e3)
	--mill
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetOperation(c17500021.sumsuc)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetCountLimit(1)
	e5:SetCondition(c17500021.condition)
	e5:SetOperation(c17500021.operation)
	c:RegisterEffect(e5)
end
function c17500021.spfilter(c,tp)
	return c:IsCode(17500021) and c:IsControler(tp) and c:IsReleasable() and Duel.IsExistingMatchingCard(c17500021.spfilter2,tp,LOCATION_MZONE,0,1,c,tp)
end
function c17500021.spfilter2(c,tp)
	return c:IsControler(tp) and c:IsReleasable()
end
function c17500021.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>-1 and Duel.IsExistingMatchingCard(c17500021.spfilter,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c17500021.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.SelectReleaseGroup(tp,c17500021.spfilter,1,1,nil,tp)
	local c=g:GetFirst()
	local g2=Duel.SelectMatchingCard(tp,c17500021.spfilter2,tp,LOCATION_MZONE,0,1,1,c,tp)
	g:Merge(g2)
	Duel.Release(g,REASON_COST)
end
function c17500021.efilter(e,te)
	return te:GetOwnerPlayer()==e:GetHandlerPlayer() and te:GetOwner()~=e:GetHandler()
end

function c17500021.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(17500021,RESET_EVENT+0x1ec0000+RESET_PHASE+PHASE_END,0,1)
end
function c17500021.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(17500021)~=0
end
function c17500021.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
end