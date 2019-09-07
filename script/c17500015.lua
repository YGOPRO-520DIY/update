--元素魔法 瞬间闪现
function c17500015.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,17500015+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c17500015.condition)
	e1:SetTarget(c17500015.target)
	e1:SetOperation(c17500015.activate)
	c:RegisterEffect(e1)
end
c17500015.setname="ElementalSpell"
function c17500015.exfil(c)
	return c.setname=="ElementalWizard" and c:IsFaceup()
end
function c17500015.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17500015.exfil,tp,LOCATION_MZONE,0,1,nil)
end
function c17500015.filter(c,e,tp)
	return c.setname=="ElementalWizard" and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17500015.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c17500015.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c17500015.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17500015.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
