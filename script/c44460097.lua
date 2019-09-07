--古夕幻历-时空接岸
function c44460097.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--instant
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(44460097,0))
	e3:SetCategory(CATEGORY_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,0x1c0+TIMING_MAIN_END+TIMING_BATTLE_START+TIMING_BATTLE_END)
	e3:SetCountLimit(1)
	e3:SetCondition(c44460097.condition)
	e3:SetTarget(c44460097.target)
	e3:SetOperation(c44460097.activate)
	c:RegisterEffect(e3)
end
function c44460097.condition(e,tp,eg,ep,ev,re,r,rp)
	local tn=Duel.GetTurnPlayer()
	local ph=Duel.GetCurrentPhase()
	return tn~=tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE))
end
function c44460097.sfilter(c)
	return c:IsLevelBelow(1) and c:IsType(TYPE_NORMAL) and c:IsSummonable(true,e)
end
function c44460097.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460097.sfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c44460097.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c44460097.sfilter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
     	Duel.Summon(tp,tc,true,nil)
	end
end
