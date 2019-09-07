--绚樱
function c44470221.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_EQUIP)
	c:RegisterEffect(e1)
	--special summon1
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetCountLimit(1,44470221)
	e11:SetRange(LOCATION_SZONE)
	e11:SetCost(c44470221.cost)
	e11:SetTarget(c44470221.target)
	e11:SetOperation(c44470221.operation)
	c:RegisterEffect(e11)
	--atk/def
	local e61=Effect.CreateEffect(c)
	e61:SetType(EFFECT_TYPE_SINGLE)
	e61:SetCode(EFFECT_UPDATE_ATTACK)
	e61:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e61:SetRange(LOCATION_MZONE)
	e61:SetValue(c44470221.atkval)
	c:RegisterEffect(e61)
end
--special summon1
function c44470221.cfilter(c)
	return c:IsType(TYPE_CONTINUOUS) and c:IsAbleToRemoveAsCost()
end
function c44470221.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470221.cfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44470221.cfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c44470221.spfilter(c,e,sp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsCanBeSpecialSummoned(e,0,sp,true,false)
end
function c44470221.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,1600,900,4,RACE_AQUA,ATTRIBUTE_WATER)
	and Duel.IsExistingMatchingCard(c44470221.spfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_ONFIELD)
end
function c44470221.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c44470221.spfilter),tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,1600,900,4,RACE_AQUA,ATTRIBUTE_WATER) then
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
	    e2:SetValue(4)
	    tc:RegisterEffect(e2)
	    local e4=e1:Clone()
	    e4:SetCode(EFFECT_CHANGE_RACE)
	    e4:SetValue(RACE_AQUA)
	    tc:RegisterEffect(e4)
	    local e5=e1:Clone()
	    e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	    e5:SetValue(ATTRIBUTE_WATER)
	    tc:RegisterEffect(e5)
		local e6=e1:Clone()
	    e6:SetCode(EFFECT_SET_BASE_ATTACK)
	    e6:SetValue(1600)
	    tc:RegisterEffect(e6)
		local e7=e1:Clone()
	    e7:SetCode(EFFECT_SET_BASE_DEFENSE)
	    e7:SetValue(900)
	    tc:RegisterEffect(e7)
		end
	end
	Duel.SpecialSummonComplete()
end
--atk/def
function c44470221.atkval(e,c)
	return c:GetDefense()
end
