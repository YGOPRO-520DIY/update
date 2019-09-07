--十二宫·双鱼座
function c44470462.initial_effect(c)
	--sp
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44470462,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE+LOCATION_REMOVED)
	e1:SetCountLimit(1,44470462)
	e1:SetCondition(c44470462.condition)
	e1:SetCost(c44470462.spcost)
	e1:SetTarget(c44470462.sptg)
	e1:SetOperation(c44470462.spop)
	c:RegisterEffect(e1)
	--special summon1
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetCode(EVENT_REMOVE)
	e11:SetCountLimit(1,44471462)
	e11:SetCondition(c44470462.condition)
	e11:SetTarget(c44470462.tg)
	e11:SetOperation(c44470462.operation)
	c:RegisterEffect(e11)
end
--sp
function c44470462.cfilter(c)
	return c:IsCode(44470462)
end
function c44470462.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c44470462.cfilter,tp,LOCATION_DECK,0,1,nil)
end
function c44470462.thfilter(c)
	return c:IsSetCard(0x64f) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c44470462.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470462.thfilter,tp,LOCATION_GRAVE,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44470462.thfilter,tp,LOCATION_GRAVE,0,3,3,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c44470462.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetTargetCard(e:GetHandler())
end
function c44470462.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(4000)
		e1:SetReset(RESET_EVENT+0xfe0000)
		c:RegisterEffect(e1)
		local e11=Effect.CreateEffect(c)
		e11:SetType(EFFECT_TYPE_SINGLE)
		e11:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e11:SetReset(RESET_EVENT+0x47e0000)
		e11:SetValue(LOCATION_DECKBOT)
		c:RegisterEffect(e11,true)
	end
end
--special summon1
function c44470462.spfilter(c,e,sp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsCanBeSpecialSummoned(e,0,sp,true,false)
end
function c44470462.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,0,0,12,RACE_FISH,ATTRIBUTE_WATER)
	and Duel.IsExistingMatchingCard(c44470462.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c44470462.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c44470462.spfilter),tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,0,0,12,RACE_FISH,ATTRIBUTE_WATER) then
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
	    e2:SetValue(12)
	    tc:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_ADD_TYPE)
		e3:SetValue(TYPE_TUNER)
		tc:RegisterEffect(e3)
	    local e4=e1:Clone()
	    e4:SetCode(EFFECT_CHANGE_RACE)
	    e4:SetValue(RACE_FISH)
	    tc:RegisterEffect(e4)
	    local e5=e1:Clone()
	    e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	    e5:SetValue(ATTRIBUTE_WATER)
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