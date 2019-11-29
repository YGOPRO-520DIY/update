local m=15000001
local cm=_G["c"..m]
cm.name="人间异物01·虚吾伊德"
function c15000001.initial_effect(c)
	local e1=Effect.CreateEffect(c)  
	e1:SetDescription(aux.Stringid(15000001,0))  
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)  
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)  
	e1:SetProperty(EFFECT_FLAG_DELAY)  
	e1:SetCountLimit(1,15000001)  
	e1:SetTarget(c15000001.target)  
	e1:SetOperation(c15000001.operation)  
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(15000001,2))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,15010001)
	e2:SetCondition(c15000001.spcon)
	e2:SetCost(c15000001.spcost) 
	e2:SetTarget(c15000001.sptg)
	e2:SetOperation(c15000001.spop)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(15000001,ACTIVITY_SPSUMMON,c15000001.counterfilter)
end
function c15000001.counterfilter(c)  
	return c:GetSummonLocation()~=LOCATION_EXTRA or c:IsSetCard(0xf30)  
end
function c15000001.filter(c,e,tp)
	return c:IsSetCard(0xf30) and not c:IsCode(15000001) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function c15000001.xfilter(c,e,tp)
	return c:IsSetCard(0xf31)
end
function c15000001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c15000001.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c15000001.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local h=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c15000001.xfilter),tp,LOCATION_HAND+LOCATION_SZONE,0,1,1,nil,e,tp)
	if h:GetCount()>0 then
		Duel.ConfirmCards(1-tp,h)
		Duel.SendtoGrave(h,REASON_COST+REASON_DISCARD+REASON_DESTROY)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c15000001.filter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
function c15000001.cfilter(c,tp)
	return c:IsPosition(POS_FACEDOWN_DEFENSE) and c:IsSetCard(0xf30) and c:IsControler(tp) and not c:IsCode(15000001)
end
function c15000001.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c15000001.cfilter,1,nil,tp)
end
function c15000001.spcost(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return Duel.GetCustomActivityCount(15000001,tp,ACTIVITY_SPSUMMON)==0 end  
	local e1=Effect.CreateEffect(e:GetHandler())  
	e1:SetType(EFFECT_TYPE_FIELD)  
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)  
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)  
	e1:SetTargetRange(1,0)  
	e1:SetTarget(c15000001.splimit)  
	e1:SetReset(RESET_PHASE+PHASE_END)  
	Duel.RegisterEffect(e1,tp)  
end
function c15000001.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c15000001.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)~=0 then
		Duel.ConfirmCards(1-tp,c)
	end
end
function c15000001.splimit(e,c,sump,sumtype,sumpos,targetp)  
	return c:IsLocation(LOCATION_EXTRA) and not c:IsSetCard(0xf30)  
end