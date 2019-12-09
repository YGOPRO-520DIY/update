local m=13520219
local tg={13520200,13520230}
local cm=_G["c"..m]
cm.name="花骑士 酢浆草"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Link Summon
	aux.AddLinkProcedure(c,cm.mfilter,1,1)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,m)
	e1:SetTarget(cm.sptg)
	e1:SetOperation(cm.spop)
	c:RegisterEffect(e1)
	--Atk Up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(cm.atkval)
	c:RegisterEffect(e2)
	--Message
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetOperation(cm.msg)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function cm.flower(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Link Summon
function cm.mfilter(c)
	return c:IsLinkRace(RACE_PLANT) and c:IsSummonType(SUMMON_TYPE_NORMAL)
end
--Special Summon
function cm.spfilter(c,e,tp,zone)
	return c:IsFaceup() and cm.flower(c) and not c:IsLocation(LOCATION_FZONE+LOCATION_PZONE)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE,tp,zone)
end
function cm.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local zone=bit.band(e:GetHandler():GetLinkedZone(tp),0x1f)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_SZONE) and cm.spfilter(chkc,e,tp,zone) end
	if chk==0 then return Duel.GetMZoneCount(tp)>0 and Duel.IsExistingTarget(cm.spfilter,tp,LOCATION_SZONE,0,1,nil,e,tp,zone) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,cm.spfilter,tp,LOCATION_SZONE,0,1,1,nil,e,tp,zone)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local zone=bit.band(c:GetLinkedZone(tp),0x1f)
	if tc:IsRelateToEffect(e) and zone~=0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE,zone)
	end
end
--Atk Up
function cm.val(c)
	if c:IsFaceup() and c:IsRace(RACE_PLANT) then return c:GetDefense()
	else return 0 end
end
function cm.atkval(e,c)
	return c:GetLinkedGroup():GetSum(cm.val)
end
--Message
function cm.msg(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(m,1))
	Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(m,2))
	Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(m,3))
end