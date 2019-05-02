local m=13571316
local cm=_G["c"..m]
cm.name="歪秤 狂岚石像鬼"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Fusion Material
	aux.AddFusionProcFun2(c,cm.mfilter1,cm.mfilter2,true)
	--Fusion Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(cm.spcon)
	e1:SetOperation(cm.spop)
	e1:SetValue(SUMMON_TYPE_FUSION)
	c:RegisterEffect(e1)
	--Return Hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(cm.condition)
	e2:SetTarget(cm.target)
	e2:SetOperation(cm.operation)
	c:RegisterEffect(e2)
	--Revive
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(m,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCondition(cm.revcon)
	e3:SetTarget(cm.revtg)
	e3:SetOperation(cm.revop)
	c:RegisterEffect(e3)
end
--Fusion Material
function cm.mfilter1(c)
	return c:IsRace(RACE_FIEND)
end
function cm.mfilter2(c)
	return c:IsAttribute(ATTRIBUTE_WIND)
end
--Fusion Summon
function cm.matfilter(c,fc)
	return c:IsFaceup() and (cm.mfilter1(c) or cm.mfilter2(c))
		and c:IsCanBeFusionMaterial(fc) and c:IsAbleToDeckOrExtraAsCost()
end
function cm.spfilter1(c,tp,g)
	return g:IsExists(cm.spfilter2,1,c,tp,c)
end
function cm.spfilter2(c,tp,mc)
	return (cm.mfilter1(c) and cm.mfilter2(mc)
		or cm.mfilter1(mc) and cm.mfilter2(c))
		and Duel.GetLocationCountFromEx(tp,tp,Group.FromCards(c,mc))>0
end
function cm.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(cm.matfilter,tp,LOCATION_MZONE,0,nil,c)
	return g:IsExists(cm.spfilter1,1,nil,tp,g)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(cm.matfilter,tp,LOCATION_MZONE,0,nil,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=g:FilterSelect(tp,cm.spfilter1,1,1,nil,tp,g)
	local mc=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g2=g:FilterSelect(tp,cm.spfilter2,1,1,mc,tp,mc)
	g1:Merge(g2)
	c:SetMaterial(g1)
	Duel.SendtoDeck(g1,nil,2,REASON_COST)
end
--Return Hand
function cm.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(cm.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(cm.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
--Revive
function cm.revcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function cm.revtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function cm.revop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end