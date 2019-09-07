--雪暴猎鹰的强袭
function c43694486.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c43694486.cost)
	e1:SetTarget(c43694486.target)
	e1:SetOperation(c43694486.activate)
	c:RegisterEffect(e1)
end
function c43694486.costfil(c,tp)
	return c:GetAttack()>c:GetBaseAttack() and c:IsFaceup() and c:IsRace(RACE_WINDBEAST) and c:IsAttribute(ATTRIBUTE_WATER) and c:IsReleasable() and Duel.GetMZoneCount(tp,c)>0
end
function c43694486.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c43694486.costfil,tp,LOCATION_MZONE,0,1,nil,tp) end
	local g=Duel.SelectMatchingCard(tp,c43694486.costfil,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c43694486.filter(c,e,tp)
	return (c:IsSetCard(0x436) or c:IsCode(43694481)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c43694486.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c43694486.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c43694486.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c43694486.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
