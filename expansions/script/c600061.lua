--圣诞信使 礼物车小鹿
function c600061.initial_effect(c)
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600061,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,600061)
	e1:SetCost(c600061.spcost)
	e1:SetTarget(c600061.sptg)
	e1:SetOperation(c600061.spop)
	c:RegisterEffect(e1)  
	--position
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600061,1))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCountLimit(1,6000061)
	e2:SetCondition(c600061.poscon)
	e2:SetCost(c600061.poscost)
	e2:SetTarget(c600061.postg)
	e2:SetOperation(c600061.posop)
	c:RegisterEffect(e2)	
end
function c600061.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c600061.spfilter(c,e,tp)
	return c:IsSetCard(0x600) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function c600061.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133) and Duel.GetLocationCount(tp,LOCATION_MZONE)>=1
		and Duel.IsExistingMatchingCard(c600061.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
		and Duel.IsExistingMatchingCard(c600061.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_HAND+LOCATION_DECK)
end
function c600061.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) or Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g1=Duel.GetMatchingGroup(c600061.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(c600061.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg2=g2:Select(tp,1,1,nil)
	sg1:Merge(sg2)
	if Duel.SpecialSummon(sg1,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)~=0 then
	   local og=Duel.GetOperatedGroup()
	   Duel.ConfirmCards(1-tp,og)
	   if Duel.SelectYesNo(tp,aux.Stringid(600061,2)) then
		  Duel.BreakEffect()
		  local sg=Duel.GetMatchingGroup(c600061.ssfilter,tp,LOCATION_MZONE,0,nil)
		  Duel.ShuffleSetCard(sg)
	   end
	end
end
function c600061.ssfilter(c)
	return c:IsFacedown() and c:GetSequence()<5
end
function c600061.poscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c600061.poscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
end
function c600061.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,nil,1,tp,0)
end
function c600061.posop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_FACEDOWN)
	local g=Duel.SelectMatchingCard(1-tp,Card.IsFacedown,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
	   Duel.HintSelection(g)
	   Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	end
end