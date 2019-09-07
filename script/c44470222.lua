--穗姬
function c44470222.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MONSTER_SSET)
	e1:SetValue(TYPE_SPELL)
	c:RegisterEffect(e1)
	--special summon
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44470222,0))
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetCountLimit(1,44470222)
	e11:SetCode(EVENT_RELEASE)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	--e11:SetCondition(c44470222.spcon)
	e11:SetCost(c44470222.spcost)
	e11:SetTarget(c44470222.sptg)
	e11:SetOperation(c44470222.spop)
	c:RegisterEffect(e11)
end
--special summon
function c44470222.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c44470222.spfilter(c,e,tp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) 
end

function c44470222.cfilter(c)
	return c:IsAbleToRemoveAsCost() and c:IsCode(44470222)
end
function c44470222.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470222.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44470222.cfilter,tp,LOCATION_GRAVE,0,1,ft,nil)
	e:SetLabel(g:GetCount())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c44470222.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470222.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	ct=e:GetLabel()
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,0,0)
end
function c44470222.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local ct=e:GetLabel()
	if ft<ct then ct=ft end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local dg=Duel.SelectMatchingCard(tp,c44470222.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,ct,ct,nil,e,tp)
	if dg:GetCount()>0 then
	local tc=dg:GetFirst()
		while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP)
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
	    local e4=e1:Clone()
	    e4:SetCode(EFFECT_CHANGE_RACE)
	    e4:SetValue(RACE_PLANT)
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
	    e7:SetValue(1500)
	    tc:RegisterEffect(e7)
		tc=dg:GetNext()
		end
	end
	Duel.SpecialSummonComplete()
end