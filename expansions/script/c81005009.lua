--鲜为人知的王女
function c81005009.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1,1)
	c:EnableReviveLimit()
	--banish
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81005009,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c81005009.rmcond)
	e1:SetTarget(c81005009.rmtg)
	e1:SetOperation(c81005009.rmop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(81005009,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,81005009)
	e2:SetCondition(c81005009.spcon)
	e2:SetCost(c81005009.spcost)
	e2:SetTarget(c81005009.sptg)
	e2:SetOperation(c81005009.spop)
	c:RegisterEffect(e2)
	--activate limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,1)
	e3:SetCondition(c81005009.condition)
	e3:SetValue(c81005009.aclimit)
	c:RegisterEffect(e3)
end
function c81005009.rmcond(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetMaterial():IsExists(Card.IsCode,1,nil,81005007) and c:IsRelateToBattle() and c:IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c81005009.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c81005009.rmop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
function c81005009.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetMaterial():IsExists(Card.IsCode,1,nil,81005008) and c:IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c81005009.costfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsFaceup()
end
function c81005009.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81005009.costfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c81005009.costfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c81005009.spfilter(c,e,tp,tid)
	return c:GetTurnID()==tid and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c81005009.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tid=Duel.GetTurnCount()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c81005009.spfilter,tp,0,LOCATION_GRAVE,1,nil,e,tp,tid) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c81005009.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tid=Duel.GetTurnCount()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c81005009.spfilter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp,tid)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c81005009.condition(e)
	local c=e:GetHandler()
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE and c:IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c81005009.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
