--动物朋友·最上静香
require("expansions/script/c81000000")
function c81018017.initial_effect(c)
	Tenka.Shizuka(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c81018017.dacon)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,81018017)
	e2:SetCondition(c81018017.spcon)
	e2:SetTarget(c81018017.sptg)
	e2:SetOperation(c81018017.spop)
	c:RegisterEffect(e2)
end
function c81018017.cfilter(c)
	return c:IsFaceup() and c:GetAttack()>c:GetBaseAttack()
end
function c81018017.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c81018017.cfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c81018017.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c81018017.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c81018017.dacon(e)
	local c=e:GetHandler()
	return c:GetAttack()<c:GetDefense()
end
