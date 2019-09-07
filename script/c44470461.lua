--十二宫·水瓶座
function c44470461.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MONSTER_SSET)
	e1:SetValue(TYPE_SPELL)
	c:RegisterEffect(e1)
	--Activate spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_ACTIVATE+EFFECT_TYPE_QUICK_O)
	--e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,44470461)
	e2:SetCondition(c44470461.condition)
	e2:SetCost(c44470461.cost)
	e2:SetTarget(c44470461.target)
	e2:SetOperation(c44470461.activate)
	c:RegisterEffect(e2)
	--sp
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetCode(EVENT_REMOVE)
	e11:SetCountLimit(1,44471461)
	e11:SetCondition(c44470461.condition)
	e11:SetTarget(c44470461.tg)
	e11:SetOperation(c44470461.operation)
	c:RegisterEffect(e11)
end
function c44470461.cfilter(c)
	return c:IsCode(44470461)
end
function c44470461.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c44470461.cfilter,tp,LOCATION_DECK,0,1,nil)
end
function c44470461.thfilter(c)
	return c:IsSetCard(0x64f) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c44470461.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470461.thfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44470461.thfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c44470461.spfilter(c,e,sp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsCanBeSpecialSummoned(e,0,sp,true,false)
end
function c44470461.sfilter(c)
	return c:IsType(TYPE_MONSTER) 
end
function c44470461.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470461.sfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44470461.activate(e,tp,eg,ep,ev,re,r,rp)
	--if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44470461.sfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_TRAP+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	end
end
--sp
function c44470461.filter(c,e,tp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c44470461.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470461.filter,tp,LOCATION_HAND,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c44470461.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c44470461.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g:GetCount()>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,1000,3000,11,RACE_AQUA,ATTRIBUTE_WATER) then
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
	    e2:SetValue(11)
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
	    e6:SetValue(1000)
	    tc:RegisterEffect(e6)
		local e7=e1:Clone()
	    e7:SetCode(EFFECT_SET_BASE_DEFENSE)
	    e7:SetValue(3000)
	    tc:RegisterEffect(e7)
		    end
		end
	end
	    if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(1-tp,c44470461.filter,1-tp,LOCATION_HAND,0,1,1,nil,e,1-tp)
		if g:GetCount()>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,1000,3000,11,RACE_AQUA,ATTRIBUTE_WATER) then
		local tc=g:GetFirst()
	    if Duel.SpecialSummonStep(tc,0,1-tp,1-tp,true,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
	    e1:SetValue(TYPE_NORMAL+TYPE_MONSTER)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	    local e2=e1:Clone()
	    e2:SetCode(EFFECT_CHANGE_LEVEL)
	    e2:SetValue(11)
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
	    e6:SetValue(1000)
	    tc:RegisterEffect(e6)
		local e7=e1:Clone()
	    e7:SetCode(EFFECT_SET_BASE_DEFENSE)
	    e7:SetValue(3000)
	    tc:RegisterEffect(e7)
		    end
		end
	end
	Duel.SpecialSummonComplete()
end