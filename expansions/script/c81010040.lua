--果不其然被吓个半死
function c81010040.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,81010040+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c81010040.condition)
	e1:SetCost(c81010040.cost)
	e1:SetTarget(c81010040.target)
	e1:SetOperation(c81010040.activate)
	c:RegisterEffect(e1)
end
function c81010040.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
end
function c81010040.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
end
function c81010040.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp)
		and Duel.IsExistingMatchingCard(nil,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,0,nil)
	local cn=g:GetCount()
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,cn,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,cn-1)
end
function c81010040.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,0,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct==0 then return end
	Duel.Draw(tp,ct-1,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.SelectOption(1-tp,aux.Stringid(81010040,0))
end
