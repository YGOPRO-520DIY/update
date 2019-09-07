--玛姬
function c44470219.initial_effect(c)
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
	e11:SetCountLimit(1,44470219)
	e11:SetRange(LOCATION_SZONE)
	e11:SetTarget(c44470219.target)
	e11:SetOperation(c44470219.operation)
	c:RegisterEffect(e11)
	--indes
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e12:SetValue(1)
	c:RegisterEffect(e12)
	--atk/def
	local e61=Effect.CreateEffect(c)
	e61:SetType(EFFECT_TYPE_SINGLE)
	e61:SetCode(EFFECT_UPDATE_ATTACK)
	e61:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e61:SetRange(LOCATION_MZONE)
	e61:SetValue(1500)
	c:RegisterEffect(e61)
end
--special summon1
function c44470219.spfilter(c,e,sp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsCanBeSpecialSummoned(e,0,sp,true,false)
end
function c44470219.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,0,500,2,RACE_SPELLCASTER,ATTRIBUTE_EARTH)
	and Duel.IsExistingMatchingCard(c44470219.spfilter,tp,LOCATION_ONFIELD,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_ONFIELD)
end
function c44470219.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c44470219.spfilter),tp,LOCATION_ONFIELD,0,1,1,nil,e,tp)
	if Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,0,500,2,RACE_SPELLCASTER,ATTRIBUTE_EARTH)
	and g:GetCount()>0 then
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
	    e2:SetValue(2)
	    tc:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_ADD_TYPE)
		e3:SetValue(TYPE_TUNER)
		tc:RegisterEffect(e3)
	    local e4=e1:Clone()
	    e4:SetCode(EFFECT_CHANGE_RACE)
	    e4:SetValue(RACE_SPELLCASTER)
	    tc:RegisterEffect(e4)
	    local e5=e1:Clone()
	    e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	    e5:SetValue(ATTRIBUTE_EARTH)
	    tc:RegisterEffect(e5)
		local e6=e1:Clone()
	    e6:SetCode(EFFECT_SET_BASE_ATTACK)
	    e6:SetValue(0)
	    tc:RegisterEffect(e6)
		local e7=e1:Clone()
	    e7:SetCode(EFFECT_SET_BASE_DEFENSE)
	    e7:SetValue(500)
	    tc:RegisterEffect(e7)
		end
	end
	Duel.SpecialSummonComplete()
	Duel.BreakEffect()
	Duel.Destroy(c,REASON_EFFECT)
end