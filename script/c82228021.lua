function c82228021.initial_effect(c)  
	--link summon  
	aux.AddLinkProcedure(c,c82228021.matfilter,1,1)  
	c:EnableReviveLimit() 
	--destroy  
	local e2=Effect.CreateEffect(c)	
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)  
	e2:SetType(EFFECT_TYPE_IGNITION)  
	e2:SetRange(LOCATION_MZONE)  
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)  
	e2:SetCountLimit(1,82228021)  
	e2:SetTarget(c82228021.destg)  
	e2:SetOperation(c82228021.desop)  
	c:RegisterEffect(e2)  
	--spsummon  
	local e3=Effect.CreateEffect(c)  
	e3:SetDescription(aux.Stringid(82228010,0))	
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)  
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)  
	e3:SetCode(EVENT_TO_GRAVE)  
	e3:SetProperty(EFFECT_FLAG_DELAY) 
	e2:SetCountLimit(1,82238021)  
	e3:SetCondition(c82228021.spcon2)  
	e3:SetTarget(c82228021.sptg2)  
	e3:SetOperation(c82228021.spop2)  
	c:RegisterEffect(e3)  
end  
 
function c82228021.matfilter(c)  
	return c:IsLinkSetCard(0x9e) and not c:IsLinkCode(82228021)  
end  
 
function c82228021.desfilter(c,ft)  
	return ft>0 or (c:IsLocation(LOCATION_MZONE) and c:GetSequence()<5)  
end  

function c82228021.spfilter(c,e,tp)  
	return c:IsRace(RACE_WYRM) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)  
end  

function c82228021.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)  
	if chkc then return false end  
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)  
	if chk==0 then return ft>-1  
		and Duel.IsExistingTarget(c82228021.desfilter,tp,LOCATION_ONFIELD,0,1,nil,ft)  
		and Duel.IsExistingTarget(c82228021.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)  
	local g1=Duel.SelectTarget(tp,c82228021.desfilter,tp,LOCATION_ONFIELD,0,1,1,nil,ft)  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)  
	local g2=Duel.SelectTarget(tp,c82228021.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)  
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,1,0,0)  
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g2,1,0,0)  
end  
 
function c82228021.desop(e,tp,eg,ep,ev,re,r,rp)  
	local c=e:GetHandler()
	local ex,g1=Duel.GetOperationInfo(0,CATEGORY_DESTROY)  
	local ex,g2=Duel.GetOperationInfo(0,CATEGORY_SPECIAL_SUMMON)  
	local tc1=g1:GetFirst()  
	local tc2=g2:GetFirst()  
	if tc1:IsRelateToEffect(e) and tc2:IsRelateToEffect(e) and Duel.Destroy(tc1,REASON_EFFECT)~=0 and Duel.SpecialSummonStep(tc2,0,tp,tp,false,false,POS_FACEUP) then  
		local e1=Effect.CreateEffect(c)  
		e1:SetType(EFFECT_TYPE_SINGLE)  
		e1:SetCode(EFFECT_DISABLE)  
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)  
		tc2:RegisterEffect(e1,true)  
		local e2=Effect.CreateEffect(c)  
		e2:SetType(EFFECT_TYPE_SINGLE)  
		e2:SetCode(EFFECT_DISABLE_EFFECT)  
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)  
		tc2:RegisterEffect(e2,true)  
		Duel.SpecialSummonComplete()	
	end  
end  
 
function c82228021.spcon2(e,tp,eg,ep,ev,re,r,rp)  
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and e:GetHandler():GetPreviousControler()==tp   
end  
 
function c82228021.spfilter2(c,e,tp)  
	return c:IsRace(RACE_WYRM) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)  
end  
 
function c82228021.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0  
		and Duel.IsExistingMatchingCard(c82228021.spfilter2,tp,LOCATION_HAND,0,1,nil,e,tp) end  
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)  
end  
 
function c82228021.spop2(e,tp,eg,ep,ev,re,r,rp)  
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)  
	local g=Duel.GetMatchingGroup(c82228021.spfilter2,tp,LOCATION_HAND,0,nil,e,tp)  
	if ft<1 or g:GetCount()==0 then return end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)  
	local sg=g:Select(tp,1,1,nil)  
	g:Remove(Card.IsCode,nil,sg:GetFirst():GetCode())  
	if ft>1 and g:GetCount()>0 and not Duel.IsPlayerAffectedByEffect(tp,59822133) and Duel.SelectYesNo(tp,aux.Stringid(82228021,0)) then  
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)  
		local sg2=g:Select(tp,1,1,nil)  
		sg:AddCard(sg2:GetFirst())  
	end  
	Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)  
end  