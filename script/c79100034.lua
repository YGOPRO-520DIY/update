--灵噬·艾灵
function c79100034.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x791),2)
	c:EnableReviveLimit()
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79100034,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,79100034)
	e1:SetTarget(c79100034.sumtg)
	e1:SetOperation(c79100034.sumop)
	c:RegisterEffect(e1)
	--revive
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(aux.exccon)
	e2:SetCountLimit(1,79100035)
	e2:SetCost(c79100034.spcost2)
	e2:SetTarget(c79100034.sptg2)
	e2:SetOperation(c79100034.spop2)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(79100034,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_START)
	e3:SetCountLimit(1,79100034)
	e3:SetTarget(c79100034.rmtg)
	e3:SetOperation(c79100034.rmop)
	c:RegisterEffect(e3)
end
function c79100034.filter(c,e,tp)
	return c:IsSetCard(0x791) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c79100034.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c79100034.filter,tp,LOCATION_HAND+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_REMOVED)
end
function c79100034.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c79100034.filter,tp,LOCATION_HAND+LOCATION_REMOVED,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c79100034.cfilter2(c,tp)
	return c:IsSetCard(0x791) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost() and Duel.GetMZoneCount(tp,c)>0
end
function c79100034.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79100034.cfilter2,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c79100034.cfilter2,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c79100034.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c79100034.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c79100034.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetBattleTarget()
	if chk==0 then return tc and tc:IsControler(1-tp) and tc:IsAbleToRemove() and not tc:IsType(TYPE_TOKEN) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,tc,1,0,0)
end
function c79100034.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if tc:IsRelateToBattle() then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end