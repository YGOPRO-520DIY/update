--森绿色吉他少女
function c65040048.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--destroy and set
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,65040048)
	e1:SetCondition(c65040048.condition)
	e1:SetTarget(c65040048.target)
	e1:SetOperation(c65040048.operation)
	c:RegisterEffect(e1)
end
function c65040048.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldCard(tp,LOCATION_PZONE,0) and Duel.GetFieldCard(tp,LOCATION_PZONE,1)
end
function c65040048.spfilter(c,e,tp)
	local lsc=Duel.GetFieldCard(tp,LOCATION_PZONE,0):GetLeftScale()
	local rsc=Duel.GetFieldCard(tp,LOCATION_PZONE,1):GetRightScale()
	if lsc>rsc then lsc,rsc=rsc,lsc end
	local lv=c:GetLevel()
	return c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_PENDULUM,tp,false,false) and lv>lsc and lv<rsc
end
function c65040048.thfilter(c,tp)
	local lsc=Duel.GetFieldCard(tp,LOCATION_PZONE,0):GetLeftScale()
	local rsc=Duel.GetFieldCard(tp,LOCATION_PZONE,1):GetRightScale()
	if lsc>rsc then lsc,rsc=rsc,lsc end
	local lv=c:GetLevel()
	return c:IsFaceup() and c:IsAbleToHand() and lv>lsc and lv<rsc
end
function c65040048.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65040048.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) and Duel.GetMZoneCount(tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c65040048.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMZoneCount(tp)<=0 then return end
	if Duel.IsExistingMatchingCard(c65040048.thfilter,tp,LOCATION_EXTRA,0,1,nil,tp) and Duel.SelectYesNo(tp,aux.Stringid(65040048,0)) then
		local g=Duel.SelectMatchingCard(tp,c65040048.thfilter,tp,LOCATION_EXTRA,0,1,1,nil,tp)
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	local mg=Duel.SelectMatchingCard(tp,c65040048.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if mg:GetCount()>0 then
		Duel.SpecialSummon(mg,SUMMON_TYPE_PENDULUM,tp,tp,false,false,POS_FACEUP)
	end
end