--十二宫·摩羯座
function c44470460.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44470460,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCountLimit(1,44472460)
	e2:SetCondition(c44470460.spcon)
	e2:SetOperation(c44470460.spop)
	c:RegisterEffect(e2)
	--special summon1
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44470460,0))
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetCode(EVENT_SPSUMMON_SUCCESS)
	e11:SetCountLimit(1,44470460)
	e11:SetCondition(c44470460.condition)
	e11:SetTarget(c44470460.tg)
	e11:SetOperation(c44470460.operation)
	c:RegisterEffect(e11)
	--ds deck
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(44470460,1))
	e12:SetCategory(CATEGORY_DESTROY)
	e12:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e12:SetProperty(EFFECT_FLAG_DELAY)
	e12:SetCode(EVENT_REMOVE)
	e12:SetCountLimit(1,44471460)
	e12:SetCondition(c44470460.condition)
	e12:SetTarget(c44470460.target2)
	e12:SetOperation(c44470460.operation2)
	c:RegisterEffect(e12)
	--atkup
	local e14=Effect.CreateEffect(c)
	--e14:SetCategory(CATEGORY_ATKCHANGE)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e14:SetCode(EFFECT_SET_ATTACK_FINAL)
	e14:SetRange(LOCATION_MZONE)
	e14:SetValue(c44470460.val)
	c:RegisterEffect(e14)
end
function c44470460.acfilter(c)
	return c:IsCode(44470460)
end
function c44470460.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c44470460.acfilter,tp,LOCATION_DECK,0,1,nil)
end
--special summon
function c44470460.cfilter(c)
	return c:IsSetCard(0x64f) and c:IsType(TYPE_MONSTER)
	and c:IsAbleToRemoveAsCost()
	and (not c:IsLocation(LOCATION_MZONE))
end
function c44470460.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c44470460.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler())
		or (Duel.IsExistingMatchingCard(c44470460.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0)
end
function c44470460.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c44470460.cfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)

end

--special summon1
function c44470460.spfilter(c,e,sp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsCanBeSpecialSummoned(e,0,sp,true,false)
end
function c44470460.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,500,500,1,RACE_BEAST,ATTRIBUTE_EARTH)
	and Duel.IsExistingMatchingCard(c44470460.spfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
end
function c44470460.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c44470460.spfilter),tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,500,500,1,RACE_BEAST,ATTRIBUTE_EARTH) then
	local tc=g:GetFirst()
	if Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
	    e1:SetValue(TYPE_NORMAL+TYPE_MONSTER)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	    local e2=e1:Clone()
	    e2:SetCode(EFFECT_CHANGE_LEVEL)
	    e2:SetValue(10)
	    tc:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_ADD_TYPE)
		e3:SetValue(TYPE_TUNER)
		tc:RegisterEffect(e3)
	    local e4=e1:Clone()
	    e4:SetCode(EFFECT_CHANGE_RACE)
	    e4:SetValue(RACE_BEAST)
	    tc:RegisterEffect(e4)
	    local e5=e1:Clone()
	    e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	    e5:SetValue(ATTRIBUTE_DARK)
	    tc:RegisterEffect(e5)
		local e6=e1:Clone()
	    e6:SetCode(EFFECT_SET_BASE_ATTACK)
	    e6:SetValue(0)
	    tc:RegisterEffect(e6)
		local e7=e1:Clone()
	    e7:SetCode(EFFECT_SET_BASE_DEFENSE)
	    e7:SetValue(0)
	    tc:RegisterEffect(e7)
		end
	end
	Duel.SpecialSummonComplete()
end
--ds deck
function c44470460.dkfilter(c)
	return c:IsSetCard(0x64f)
end
function c44470460.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470460.dkfilter,tp,LOCATION_DECK,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c44470460.dkfilter,tp,LOCATION_DECK,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c44470460.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c44470460.dkfilter,tp,LOCATION_DECK,0,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
--atk
function c44470460.deffilter(c)
	return c:GetBaseAttack()>=0 
	and c:IsFaceup() and c:IsSetCard(0x64f)
end
function c44470460.val(e,c)
	local g=Duel.GetMatchingGroup(c44470460.deffilter,c:GetControler(),LOCATION_REMOVED,0,c)
	return g:GetSum(Card.GetBaseAttack)
end
