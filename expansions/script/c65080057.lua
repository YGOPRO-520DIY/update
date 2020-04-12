--遗迹守护神
function c65080057.initial_effect(c)
	 c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c65080057.spcon)
	c:RegisterEffect(e1)
	 --spsummon limit
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e2)
	--turn facedown
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c65080057.condition)
	e3:SetTarget(c65080057.target)
	e3:SetOperation(c65080057.activate)
	c:RegisterEffect(e3)
	--wudi
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PHASE+PHASE_DRAW)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c65080057.wudicon)
	e4:SetOperation(c65080057.wudiop)
	c:RegisterEffect(e4)
end
function c65080057.wudicon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_MZONE,0,1,nil)
end
function c65080057.wudiop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,65080057)
	local g=Duel.SelectMatchingCard(tp,Card.IsFacedown,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.HintSelection(g)
	Duel.ConfirmCards(1-tp,g)
	local tc=g:GetFirst()
	if tc:IsAttribute(ATTRIBUTE_EARTH) and tc:IsRace(RACE_ROCK) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetCondition(c65080057.wdcon)
		e1:SetTarget(c65080057.wdop)
		e1:SetValue(c65080057.efilter)
		e1:SetOwnerPlayer(tp)
		e1:SetLabelObject(e:GetHandler())
		Duel.RegisterEffect(e1,tp)
	end
end
function c65080057.wdcon(e,c)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_MZONE,0,1,nil)
end
function c65080057.wdop(e,c)
	return c==e:GetLabelObject() or c:IsFacedown()
end
function c65080057.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
function c65080057.condition(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return rc:IsControler(tp) and rc:IsLocation(LOCATION_MZONE) and rc:IsRace(RACE_ROCK) and rc:IsCanTurnSet() and rc~=e:GetHandler()
end
function c65080057.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local rc=re:GetHandler()
	if chk==0 then return e:GetHandler():GetFlagEffect(65080057)==0 end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,rc,1,0,0)
	e:GetHandler():RegisterFlagEffect(65080057,RESET_CHAIN,0,1)
end
function c65080057.activate(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if rc:IsRelateToEffect(re) and rc:IsCanTurnSet() then
		Duel.ChangePosition(rc,POS_FACEDOWN_DEFENSE)
	end
end
function c65080057.spcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)<=0 then return false end
	local g=Duel.GetMatchingGroup(Card.IsFacedown,c:GetControler(),LOCATION_MZONE,0,nil)
	return g:GetCount()>=2
end