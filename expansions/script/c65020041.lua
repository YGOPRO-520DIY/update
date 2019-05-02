--缚灵咒 亡车
function c65020041.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_ZOMBIE),2,2,c65020041.lcheck)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1,65020041)
	e1:SetTarget(c65020041.hsptg)
	e1:SetOperation(c65020041.hspop)
	c:RegisterEffect(e1)
	--sp from gy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCountLimit(1,65020042)
	e2:SetCondition(c65020041.spgcon)
	e2:SetTarget(c65020041.spgtg)
	e2:SetOperation(c65020041.spgop)
	c:RegisterEffect(e2)
end

function c65020041.lcfil(c)
	return c:GetLevel()>=5 and c:IsType(TYPE_TUNER)
end

function c65020041.lcheck(g,lc)
	return g:IsExists(c65020041.lcfil,1,nil)
end

function c65020041.hspfilter(c,e,tp)
	return c:IsType(TYPE_TUNER) and c:IsLevelAbove(5) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c65020041.hsptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c65020041.hspfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c65020041.hspop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c65020041.hspfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c65020041.spgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) 
end
function c65020041.spgfil(c,e,tp)
	return c:IsSetCard(0x3da4) and not c:IsCode(65020041) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c65020041.spgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65020041.spgfil,tp,LOCATION_GRAVE,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c65020041.spgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c65020041.spgfil,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end