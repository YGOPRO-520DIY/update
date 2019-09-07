--穗姬·白米·傲娇型
function c44470224.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c44470224.matfilter,1,1)
	c:EnableReviveLimit()
	--code
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetValue(44470222)
	c:RegisterEffect(e2)
	--special summon
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44470224,0))
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetCountLimit(1,44470224)
	e11:SetCode(EVENT_RELEASE)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	e11:SetCost(c44470224.spcost)
	e11:SetTarget(c44470224.sptg)
	e11:SetOperation(c44470224.spop)
	c:RegisterEffect(e11)
end
function c44470224.matfilter(c)
	return not c:IsLinkType(TYPE_TOKEN) and c:IsLinkType(TYPE_NORMAL)
end
--special summon
function c44470224.spfilter(c,e,tp)
	return c:IsCode(44470222) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) 
end
function c44470224.cfilter(c)
	return c:IsAbleToRemoveAsCost() and c:IsCode(44470222)
end
function c44470224.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470224.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44470224.cfilter,tp,LOCATION_GRAVE,0,1,ft,nil)
	e:SetLabel(g:GetCount())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c44470224.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470224.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	ct=e:GetLabel()
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,0,0)
end
function c44470224.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local ct=e:GetLabel()
	if ft<ct then ct=ft end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local dg=Duel.SelectMatchingCard(tp,c44470224.spfilter,tp,LOCATION_DECK,0,ct,ct,nil,e,tp)
	if dg:GetCount()>0 then
	local tc=dg:GetFirst()
		while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_REMOVE_TYPE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(TYPE_TUNER)
		tc:RegisterEffect(e1)
		tc=dg:GetNext()
		end
	end
	Duel.SpecialSummonComplete()
end