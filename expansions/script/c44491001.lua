--龙使
function c44491001.initial_effect(c)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44491001,0))
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,44491001)
	e1:SetCost(c44491001.scost)
	e1:SetTarget(c44491001.stg)
	e1:SetOperation(c44491001.sop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44491001,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,44491101)
	e2:SetTarget(c44491001.sptg)
	e2:SetOperation(c44491001.spop)
	c:RegisterEffect(e2)
end
function c44491001.scost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c44491001.filter(c,e)
	return c:GetLevel()==8 and c:IsRace(RACE_DRAGON) and c:IsSummonable(true,nil)
end
function c44491001.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c44491001.filter,tp,LOCATION_HAND,0,1,nil,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c44491001.sop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c44491001.filter,tp,LOCATION_HAND,0,1,1,nil,e:GetHandler())
	local tc=g:GetFirst()
	--local se=e:GetLabelObject()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(44491001,1))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetReset(RESET_EVENT+RESET_TOFIELD)
	e1:SetCondition(c44491001.ntcon)
	if tc then
		tc:RegisterEffect(e1)
		Duel.Summon(tp,tc,true,nil)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetProperty(EFFECT_FLAG_OATH)
	    e1:SetCode(EFFECT_CANNOT_ATTACK)
	    e1:SetReset(RESET_EVENT+0xff0000+RESET_PHASE+PHASE_END)
	    tc:RegisterEffect(e1)
	end
end
function c44491001.ntcon(e,c)
	if c==nil then return true end
	return c:GetLevel()>0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
--spsummon
function c44491001.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c44491001.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
	end
	Duel.SpecialSummonComplete()
end