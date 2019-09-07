--穗姬·白米·中二型
function c44470226.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44470226.matfilter,1,1)
	--sp
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetCode(EVENT_TO_GRAVE)
	e11:SetCountLimit(1,44470226)
	e11:SetCondition(c44470226.tgcon)
	e11:SetTarget(c44470226.tg)
	e11:SetOperation(c44470226.operation)
	c:RegisterEffect(e11)
end
function c44470226.matfilter(c,lc,sumtype,tp)
	return c:IsLinkCode(44470222)
end
--sp
function c44470226.tgcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end

function c44470226.spfilter(c,e,sp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsCanBeSpecialSummoned(e,0,sp,true,false)
end
function c44470226.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,1000,1500,4,RACE_PLANT,ATTRIBUTE_FIRE)
	and Duel.IsExistingMatchingCard(c44470226.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c44470226.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c44470226.spfilter),tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,0,0,0x11,1000,1500,4,RACE_PLANT,ATTRIBUTE_FIRE) then
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
	    e4:SetValue(RACE_PLANT)
	    tc:RegisterEffect(e4)
	    local e5=e1:Clone()
	    e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	    e5:SetValue(ATTRIBUTE_FIRE)
	    tc:RegisterEffect(e5)
		local e6=e1:Clone()
	    e6:SetCode(EFFECT_SET_BASE_ATTACK)
	    e6:SetValue(1000)
	    tc:RegisterEffect(e6)
		local e7=e1:Clone()
	    e7:SetCode(EFFECT_SET_BASE_DEFENSE)
	    e7:SetValue(1500)
	    tc:RegisterEffect(e7)
		local e11=e1:Clone()
		e11:SetCode(EFFECT_CHANGE_CODE)
	    e11:SetValue(44470222)
		tc:RegisterEffect(e11)
		end
	end
	Duel.SpecialSummonComplete()
end