--从者Alterego 热情迷唇
function c22000730.initial_effect(c)
	  --fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,21000030,aux.FilterBoolFunction(Card.IsFusionSetCard,0xfff),1,true,false)
	--effect gain
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MUST_ATTACK)
	e1:SetValue(1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(c22000730.eftg)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--special summon (hand/grave)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(22000730,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,22000730)
	e3:SetCondition(c22000730.spcon)
	e3:SetTarget(c22000730.sptg)
	e3:SetOperation(c22000730.spop)
	c:RegisterEffect(e3)
end
function c22000730.eftg(e,c)
	return c:IsFaceup()
end
function c3422200.spcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c22000730.spfilter(c,e,tp)
	return c:IsType(TYPE_LINK) and c:IsRace(RACE_CYBERSE) and c:IsLink(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c22000730.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCountFromEx(tp)>0
		and Duel.IsExistingMatchingCard(c22000730.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c22000730.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCountFromEx(tp)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c22000730.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
