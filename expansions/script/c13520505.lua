local m=13520505
local list={13520510,13520530}
local cm=_G["c"..m]
cm.name="历史中诞生的记忆"
function cm.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(cm.target)
	e1:SetOperation(cm.activate)
	c:RegisterEffect(e1)
end
function cm.isset(c)
	return c:GetCode()>=list[1] and c:GetCode()<=list[2]
end
--Activate
function cm.ctfilter(c)
	return cm.isset(c) and c:IsType(TYPE_MONSTER)
end
function cm.filter(c,e,tp,rank)
	return cm.isset(c) and c:IsType(TYPE_XYZ) and c:IsRankBelow(rank)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
		and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(cm.ctfilter,tp,LOCATION_GRAVE,0,nil)
	local ct=g:GetClassCount(Card.GetAttribute)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) and e:GetHandler():IsCanOverlay()
		and Duel.IsExistingMatchingCard(cm.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,ct) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function cm.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(cm.ctfilter,tp,LOCATION_GRAVE,0,nil)
	local ct=g:GetClassCount(Card.GetAttribute)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,cm.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,ct)
	if sg:GetCount()>0 and Duel.SpecialSummon(sg,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)~=0
		and e:GetHandler():IsRelateToEffect(e) then
		Duel.BreakEffect()
		e:GetHandler():CancelToGrave()
		Duel.Overlay(sg:GetFirst(),Group.FromCards(e:GetHandler()))
	end
end