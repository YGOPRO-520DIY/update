--神稚儿帕图纳克斯
function c44471104.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,12,3)
	c:EnableReviveLimit()
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44471104,2))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,44471104)
	e1:SetTarget(c44471104.mattg)
	e1:SetOperation(c44471104.matop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44471104,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCountLimit(1,44471104)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c44471104.spcon)
	e2:SetCost(c44471104.spcost)
	e2:SetTarget(c44471104.stg)
	e2:SetOperation(c44471104.sop)
	c:RegisterEffect(e2)
	--atk
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_SINGLE)
	e22:SetCode(EFFECT_UPDATE_ATTACK)
	e22:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e22:SetRange(LOCATION_MZONE)
	e22:SetValue(c44471104.atkval)
	c:RegisterEffect(e22)
end
--material
function c44471104.matfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON) and c:IsType(TYPE_XYZ)
end
function c44471104.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c44471104.matfilter(chkc) end
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING)
		and Duel.IsExistingTarget(c44471104.matfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c44471104.matfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c44471104.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
--spsummon
function c44471104.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c44471104.spcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function c44471104.spfilter(c,e,tp)
	return c:IsRace(RACE_DRAGON) and (c:IsLevel(12) or c:IsRank(12)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c44471104.stg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c44471104.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c44471104.sop(e,tp,eg,ep,ev,re,r,rp)
		if Duel.GetLocationCountFromEx(tp)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c44471104.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
end
--atk
function c44471104.atkval(e,c)
	return c:GetOverlayCount()*500
end