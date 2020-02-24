--渊眼少女
function c88990379.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88990379,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c88990379.spcon)
	e1:SetTarget(c88990379.sptg)
	e1:SetOperation(c88990379.spop)
	c:RegisterEffect(e1)
	--spsummmon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,88990379)
	e2:SetCost(c88990379.cost)
	e2:SetTarget(c88990379.tg)
	e2:SetOperation(c88990379.op)
	c:RegisterEffect(e2)
	--atk&def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c88990379.val)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e4)
	--battle target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c88990379.imcon)
	e5:SetValue(aux.imval1)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_IMMUNE_EFFECT)
	e6:SetValue(c88990379.efilter)
	c:RegisterEffect(e6)
end
function c88990379.valfil(c)
	return c:IsFaceup() and c:GetFlagEffect(88990379)>0
end
function c88990379.val(e,c)
	local tp=e:GetHandlerPlayer()
	local g=Duel.GetMatchingGroup(c88990379.valfil,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local lv=0
		local tc=g:GetFirst()
		while tc do
			lv=lv+tc:GetLevel()
			tc=g:GetNext()
		end
		return lv*300
	else return 0 end
end
function c88990379.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c88990379.imconfil(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c88990379.imcon(e,c)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c88990379.imconfil,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c88990379.cfilter(c)
	return c:IsFacedown() or not (c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_DRAGON))
end
function c88990379.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroup(tp,LOCATION_MZONE,0)>0 not Duel.IsExistingMatchingCard(c88990379.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c88990379.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c88990379.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c88990379.costfil(c,tp)
	return c:IsRace(RACE_DRAGON) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsReleasable() and Duel.GetMZoneCount(tp,c)>0
end
function c88990379.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88990379.costfil,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,tp) end
	local g=Duel.SelectMatchingCard(tp,c88990379.costfil,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c88990379.tgfil(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_DRAGON)
end
function c88990379.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88990379.tgfil,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c88990379.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMZoneCount(tp)<=0 then return end
	local g=Duel.SelectMatchingCard(tp,c88990379.tgfil,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		local gc=g:GetFirst()
		Duel.SpecialSummon(gc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		gc:RegisterFlagEffect(88990379,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET,0,1)
	end
end