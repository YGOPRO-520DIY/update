local m=13520522
local list={13520510,13520530}
local cm=_G["c"..m]
cm.name="血式少女 灰姑娘"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon
	aux.AddXyzProcedure(c,cm.xyzmat,6,2,cm.ovfilter,aux.Stringid(m,0))
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,m)
	e1:SetTarget(cm.sptg)
	e1:SetOperation(cm.spop)
	c:RegisterEffect(e1)
end
function cm.isset(c)
	return c:GetCode()>=list[1] and c:GetCode()<=list[2]
end
--Xyz Summon
function cm.xyzmat(c)
	return c:IsAttribute(ATTRIBUTE_EARTH)
end
function cm.ovfilter(c)
	return cm.isset(c) and c:IsLevel(6)
end
--Special Summon
function cm.spfilter(c,e,tp)
	return cm.isset(c) and c:IsDefenseAbove(0) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function cm.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local og=e:GetHandler():GetOverlayGroup()
	if chk==0 then return Duel.GetMZoneCount(tp)>0 and og:IsExists(cm.spfilter,1,nil,e,tp) end
	local g=og:Filter(cm.spfilter,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local og=e:GetHandler():GetOverlayGroup()
	local g=og:FilterSelect(tp,cm.spfilter,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.Recover(tp,g:GetFirst():GetDefense(),REASON_EFFECT)
	end
end