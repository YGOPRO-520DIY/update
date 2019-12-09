--黑崎智秋的学生时代
function c81019022.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,81019022+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c81019022.condition)
	e1:SetCost(c81019022.cost)
	e1:SetTarget(c81019022.target)
	e1:SetOperation(c81019022.activate)
	c:RegisterEffect(e1)
end
function c81019022.ntfil(c)
	return not c:IsType(TYPE_SPELL)
end
function c81019022.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_MAIN1 and Duel.GetMatchingGroupCount(c81019022.ntfil,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)==0 
end
function c81019022.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_NORMALSUMMON)==0 and Duel.GetActivityCount(tp,ACTIVITY_SPSUMMON)==0
	and Duel.GetActivityCount(tp,ACTIVITY_FLIPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_MSET)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	Duel.RegisterEffect(e3,tp)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	Duel.RegisterEffect(e4,tp)
end
function c81019022.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c81019022.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81019022.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c81019022.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c81019022.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,0)
	e1:SetValue(c81019022.aclimit)
	Duel.RegisterEffect(e1,tp)
end
function c81019022.aclimit(e,re,tp)
	return not re:IsActiveType(TYPE_SPELL)
end
