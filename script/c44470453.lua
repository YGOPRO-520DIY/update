--十二宫·双子座
function c44470453.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MONSTER_SSET)
	e1:SetValue(TYPE_SPELL)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	--e2:SetType(EFFECT_TYPE_ACTIVATE+EFFECT_TYPE_QUICK_O)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,44470453)
	e2:SetCondition(c44470453.condition)
	e2:SetCost(c44470453.scost)
	e2:SetTarget(c44470453.target)
	e2:SetOperation(c44470453.activate)
	c:RegisterEffect(e2)
	--sp
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetCode(EVENT_REMOVE)
	e11:SetCountLimit(1,44471453)
	e11:SetCondition(c44470453.condition)
	e11:SetTarget(c44470453.tg)
	e11:SetOperation(c44470453.operation)
	c:RegisterEffect(e11)
end
--Activate
function c44470453.cfilter(c)
	return c:IsCode(44470453)
end
function c44470453.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c44470453.cfilter,tp,LOCATION_DECK,0,1,nil)
end
function c44470453.csfilter(c,ft,tp)
	return c:IsType(TYPE_NORMAL) and not c:IsType(TYPE_TOKEN)
		and (ft>0 or c:IsControler(tp)) and (c:IsControler(tp) or c:IsFaceup())
end
function c44470453.scost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if chk==0 then return ft>0 and Duel.CheckReleaseGroup(tp,c44470453.csfilter,1,nil,ft,tp) end
	local g=Duel.SelectReleaseGroup(tp,c44470453.csfilter,1,1,nil,ft,tp)
	Duel.Release(g,REASON_COST)
end
function c44470453.sfilter(c)
	return c:IsSetCard(0x64f) and c:IsType(TYPE_MONSTER) and c:IsSSetable()
end
function c44470453.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c44470453.sfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c44470453.activate(e,tp,eg,ep,ev,re,r,rp)
    local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	if ft>1 then ft=2 end
	local g=Duel.SelectMatchingCard(tp,c44470453.sfilter,tp,LOCATION_DECK,0,1,ft,nil)
		if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
		Duel.SSet(tp,tc)
		tc=g:GetNext()
		end
		Duel.ConfirmCards(1-tp,g)
	end
end
--sp
function c44470453.filter(c,e,tp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c44470453.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470453.filter,tp,LOCATION_DECK,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c44470453.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c44470453.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,700,700,3,RACE_FAIRY,ATTRIBUTE_WIND) then
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
	    e2:SetValue(3)
	    tc:RegisterEffect(e2)
	    local e4=e1:Clone()
	    e4:SetCode(EFFECT_CHANGE_RACE)
	    e4:SetValue(RACE_FAIRY)
	    tc:RegisterEffect(e4)
	    local e5=e1:Clone()
	    e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	    e5:SetValue(ATTRIBUTE_WIND)
	    tc:RegisterEffect(e5)
		local e6=e1:Clone()
	    e6:SetCode(EFFECT_SET_BASE_ATTACK)
	    e6:SetValue(700)
	    tc:RegisterEffect(e6)
		local e7=e1:Clone()
	    e7:SetCode(EFFECT_SET_BASE_DEFENSE)
	    e7:SetValue(700)
	    tc:RegisterEffect(e7)
		    end
		end
	end
	    if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(1-tp,c44470453.filter,1-tp,LOCATION_DECK,0,1,1,nil,e,1-tp)
		if g:GetCount()>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,700,700,3,RACE_FAIRY,ATTRIBUTE_WIND) then
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
	    e2:SetValue(3)
	    tc:RegisterEffect(e2)
	    local e4=e1:Clone()
	    e4:SetCode(EFFECT_CHANGE_RACE)
	    e4:SetValue(RACE_FAIRY)
	    tc:RegisterEffect(e4)
	    local e5=e1:Clone()
	    e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	    e5:SetValue(ATTRIBUTE_WIND)
	    tc:RegisterEffect(e5)
		local e6=e1:Clone()
	    e6:SetCode(EFFECT_SET_BASE_ATTACK)
	    e6:SetValue(700)
	    tc:RegisterEffect(e6)
		local e7=e1:Clone()
	    e7:SetCode(EFFECT_SET_BASE_DEFENSE)
	    e7:SetValue(700)
	    tc:RegisterEffect(e7)
		    end
		end
	end
	Duel.SpecialSummonComplete()
end