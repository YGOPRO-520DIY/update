local m=13520121
local tg={13520120,13520131}
local flag=13520127
local cm=_G["c"..m]
cm.name="机宇魔盒 潘多拉"
function cm.initial_effect(c)
	--Dual Summon
	aux.EnableDualAttribute(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(cm.chkcon1)
	e1:SetCost(cm.spcost)
	e1:SetTarget(cm.sptg)
	e1:SetOperation(cm.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(cm.chkcon2)
	c:RegisterEffect(e2)
end
function cm.isset(c)
	return c:GetCode()>tg[1] and c:GetCode()<tg[2]
end
--Quick
function cm.chkcon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsDualState() and not Duel.IsPlayerAffectedByEffect(tp,flag)
end
function cm.chkcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsDualState() and Duel.IsPlayerAffectedByEffect(tp,flag)
end
--Special Summon
function cm.spfilter(c,e,sp)
	return cm.isset(c) and c:IsType(TYPE_LINK) and c:IsLink(2) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function cm.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function cm.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCountFromEx(tp,tp,e:GetHandler())>0
		and Duel.IsExistingTarget(cm.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCountFromEx(tp)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,cm.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end