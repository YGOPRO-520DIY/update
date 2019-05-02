--散落飘零
function c44470210.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE+0x1c0)
	e1:SetCondition(c44470210.condition)
	e1:SetTarget(c44470210.target)
	e1:SetOperation(c44470210.activate)
	c:RegisterEffect(e1)
	--act in set turn
	--local e2=Effect.CreateEffect(c)
	--e2:SetType(EFFECT_TYPE_SINGLE)
	--e2:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	--e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	--e2:SetCondition(c44470210.actcon)
	--c:RegisterEffect(e2)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c44470210.handcon)
	c:RegisterEffect(e2)
end
function c44470210.sfilter(c)
	return c:IsCode(44470221) and c:IsAbleToGrave()
end
function c44470210.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44470210.sfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil)
end
function c44470210.filter(c,e,tp)
	return c:IsFaceup() and c:IsCanBeSpecialSummoned(e,0,tp,true,false,POS_FACEUP_DEFENSE,1-tp)
end
function c44470210.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(1-tp) and c44470210.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0
		and Duel.IsExistingTarget(c44470210.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c44470210.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c44470210.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,1-tp,true,false,POS_FACEUP_DEFENSE)
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
	    e6:SetValue(0)
	    tc:RegisterEffect(e6)
		local e7=e1:Clone()
	    e7:SetCode(EFFECT_SET_BASE_DEFENSE)
	    e7:SetValue(0)
	    tc:RegisterEffect(e7)
	end
	
end

--act in set turn
function c44470210.handcon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil,44470221)
end