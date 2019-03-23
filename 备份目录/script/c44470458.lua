--十二宫·天蝎座
function c44470458.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MONSTER_SSET)
	e1:SetValue(TYPE_SPELL)
	c:RegisterEffect(e1)
	--Activate spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,44470458)
	e2:SetCondition(c44470458.condition)
	e2:SetCost(c44470458.cost)
	e2:SetTarget(c44470458.target)
	e2:SetOperation(c44470458.activate)
	c:RegisterEffect(e2)
	--disable
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_DISABLE)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetCode(EVENT_REMOVE)
	e11:SetCountLimit(1,44472458)
	e11:SetCondition(c44470458.condition1)
	e11:SetTarget(c44470458.tg)
	e11:SetOperation(c44470458.op)
	c:RegisterEffect(e11)
end
function c44470458.cfilter(c)
	return c:IsCode(44470458)
end
function c44470458.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c44470458.cfilter,tp,LOCATION_DECK,0,1,nil)
end
function c44470458.condition1(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c44470458.cfilter,tp,LOCATION_DECK,0,1,nil)
end
function c44470458.thfilter(c)
	return c:IsSetCard(0x140) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c44470458.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470458.thfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44470458.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c44470458.hspfilter(c,e,tp)
	return c:IsSetCard(0x140) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c44470458.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c44470458.hspfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c44470458.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c44470458.hspfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_ADD_ATTRIBUTE)
	    e1:SetValue(ATTRIBUTE_WIND+ATTRIBUTE_WATER+ATTRIBUTE_FIRE+ATTRIBUTE_EARTH+ATTRIBUTE_LIGHT+ATTRIBUTE_DARK)
	    e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
	Duel.SpecialSummonComplete()
end
--disable
function c44470458.filter(c)
	return c:IsFaceup() and not c:IsDisabled()
end
function c44470458.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c44470458.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44470458.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44470458.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c44470458.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsDisabled() then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	    local e21=Effect.CreateEffect(c)
		e21:SetType(EFFECT_TYPE_SINGLE)
	    e21:SetCode(EFFECT_CHANGE_RACE)
	    e21:SetValue(RACE_CYBERSE+RACE_FAIRY+RACE_WARRIOR+RACE_SPELLCASTER+RACE_FIEND+RACE_ZOMBIE+RACE_MACHINE+RACE_AQUA+RACE_PYRO+RACE_ROCK+RACE_WINDBEAST+RACE_PLANT+RACE_INSECT+RACE_THUNDER+RACE_DRAGON+RACE_BEAST+RACE_BEASTWARRIOR+RACE_DINOSAUR+RACE_FISH+RACE_SEASERPENT+RACE_REPTILE+RACE_PSYCHO+RACE_DEVINE+RACE_CREATORGOD)
	    e21:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e21)
		local e22=e1:Clone()
		e22:SetCode(EFFECT_ADD_TYPE)
	    e22:SetValue(TYPE_NORMAL)
	    tc:RegisterEffect(e22)	
	end
end