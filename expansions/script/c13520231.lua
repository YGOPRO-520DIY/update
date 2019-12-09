local m=13520231
local tg={13520200,13520230}
local cm=_G["c"..m]
cm.name="空之舞蹈"
function cm.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,m+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(cm.target)
	e1:SetOperation(cm.activate)
	c:RegisterEffect(e1)
end
function cm.flower(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Activate
function cm.tdfilter(c,e)
	return cm.flower(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck() and c:IsCanBeEffectTarget(e)
end
function cm.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function cm.check(g,e,tp)
	return g:GetClassCount(Card.GetAttribute)==g:GetCount() and g:IsExists(cm.spfilter,1,nil,e,tp)
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=Duel.GetMatchingGroup(cm.tdfilter,tp,LOCATION_GRAVE,0,nil,e)
	if chk==0 then return Duel.GetMZoneCount(tp)>0 and g:CheckSubGroup(cm.check,3,5,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	sg=g:SelectSubGroup(tp,cm.check,false,3,5,e,tp)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,sg:GetCount(),0,0)
end
function cm.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if Duel.GetMZoneCount(tp)>0 and g:IsExists(cm.spfilter,1,nil,e,tp) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:FilterSelect(tp,cm.spfilter,1,1,nil,e,tp)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		g:Sub(sg)
	end
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end