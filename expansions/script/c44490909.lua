--青色眼睛的辉华
function c44490909.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44490909+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c44490909.cost)
	e1:SetTarget(c44490909.target)
	e1:SetOperation(c44490909.activate)
	c:RegisterEffect(e1)
    --set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44490909,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(c44490909.scost)
	e2:SetTarget(c44490909.settg)
	e2:SetOperation(c44490909.setop)
	c:RegisterEffect(e2)
end
c44490909.card_code_list={89631139}
function c44490909.filter(c)
	return c:IsSetCard(0xdd) and c:IsAbleToGraveAsCost()
end
function c44490909.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44490909.filter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44490909.filter,tp,LOCATION_EXTRA,0,1,1,nil)

	Duel.SendtoGrave(g,REASON_COST)
	local gc=g:GetFirst():GetCode()
	e:SetLabel(gc)
end
function c44490909.sfilter(c,e,tp)
	return c:IsCode(89631139) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c44490909.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c44490909.sfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c44490909.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c44490909.sfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		
	    --local tc=g:GetFirst()
		--local e1=Effect.CreateEffect(e:GetHandler())
		--e1:SetType(EFFECT_TYPE_SINGLE)
		--e1:SetCode(EFFECT_CHANGE_CODE)
		--e1:SetReset(RESET_EVENT+0x1fe0000)
		--e1:SetValue(e:GetLabel())
		--tc:RegisterEffect(e1)
	end
end
--set
function c44490909.cfilter(c)
	return c:IsSetCard(0xdd) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c44490909.scost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44490909.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c44490909.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c44490909.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsSSetable() end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function c44490909.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsSSetable() then
		Duel.SSet(tp,c)
		Duel.ConfirmCards(1-tp,c)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x47e0000)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1)
	end
end



