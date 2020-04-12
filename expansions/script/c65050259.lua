--凝望彩恋 梦幻少女
function c65050259.initial_effect(c)
	 --link summon
	aux.AddLinkProcedure(c,nil,2,2,c65050259.lcheck)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,65050259)
	e1:SetCost(c65050259.cost)
	e1:SetTarget(c65050259.target)
	e1:SetOperation(c65050259.activate)
	c:RegisterEffect(e1)
	--spsummon from szone
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(65050259,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,65050260)
	e2:SetCost(c65050259.spcost1)
	e2:SetTarget(c65050259.sptg1)
	e2:SetOperation(c65050259.spop1)
	c:RegisterEffect(e2)
end
function c65050259.lcheck(g,lc)
	return g:IsExists(Card.IsSetCard,1,nil,0x9da9)
end
function c65050259.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c65050259.filter(c,e,tp)
	return c:IsSetCard(0x9da9) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and not Duel.IsExistingMatchingCard(c65050259.filter1,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,c,c:GetCode())
end
function c65050259.filter1(c,code)
	return c:IsFaceup() and c:IsCode(code) 
end
function c65050259.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler(),tp)>0
		and Duel.IsExistingMatchingCard(c65050259.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c65050259.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c65050259.filter),tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c65050259.cfilter1(c,tp)
	return c:GetOwner()~=tp
end
function c65050259.spcost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c65050259.cfilter1,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c65050259.cfilter1,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c65050259.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c65050259.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end