--廓尔喀的龙鹰
function c10173062.initial_effect(c)
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10173062,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,10173262)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c10173062.destg)
	e1:SetOperation(c10173062.desop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10173062,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCountLimit(1,10173062)
	e2:SetCondition(c10173062.spcon)
	e2:SetTarget(c10173062.sptg)
	e2:SetOperation(c10173062.spop)
	c:RegisterEffect(e2)
	--SpecialSummon2
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10173062,2))
	e3:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,0x1e0)
	e3:SetCountLimit(1,10173162)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetTarget(c10173062.sptg2)
	e3:SetOperation(c10173062.spop2)
	c:RegisterEffect(e3)
end
function c10173062.spfilter2(c,e,tp)
	return c:IsCode(10173063) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10173062.rcfilter(c)
   return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c10173062.cfilter2(c,e,tp,rc)
   local g=Group.FromCards(c,rc)
   return c10173062.rcfilter(c) and Duel.IsExistingMatchingCard(c10173062.cfilter3,tp,LOCATION_GRAVE,0,1,g,e,tp,g)
end
function c10173062.cfilter3(c,e,tp,g)
   local g2=g:Clone()
   g2:AddCard(c)
   return c10173062.rcfilter(c) and Duel.IsExistingMatchingCard(c10173062.spfilter2,tp,0x13,0,1,g2,e,tp)
end
function c10173062.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c10173061.cfilter2,tp,LOCATION_GRAVE,0,1,c,e,tp,c) and c:IsAbleToRemove() and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,c,3,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c10173062.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c,rg=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c10173062.rcfilter,tp,LOCATION_GRAVE,0,c)
	local g1=Duel.GetMatchingGroup(c10173062.cfilter2,tp,LOCATION_GRAVE,0,c,e,tp,c)
	if g:GetCount()<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	if g1:GetCount()<1 then
	   rg=g:Select(tp,2,2,nil)
	   rg:AddCard(c)
	else
	   rg=g1:Select(tp,1,1,nil)
	   rg:AddCard(c)
	   Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)   
	   local rg2=Duel.SelectMatchingCard(tp,c10173062.cfilter3,tp,LOCATION_GRAVE,0,1,1,rg,e,tp,rg)
	   rg:Merge(rg2)
	end
	if Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)~=0 and g:IsExists(Card.IsLocation,1,nil,LOCATION_REMOVED) and Duel.IsExistingMatchingCard(c10173062.spfilter2,tp,0x13,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
	   Duel.BreakEffect()
	   Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	   local g=Duel.SelectMatchingCard(tp,c10173062.spfilter2,tp,0x13,0,1,1,nil,e,tp)
	   if g:GetCount()>0 then
		  Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	   end
	end
end
function c10173062.cfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsPreviousLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp and c:IsSetCard(0xc332)
end
function c10173062.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10173062.cfilter,1,nil,tp)
end
function c10173062.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,LOCATION_GRAVE)
end
function c10173062.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c10173062.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c10173062.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then 
	   Duel.Destroy(tc,REASON_EFFECT)
	end
end