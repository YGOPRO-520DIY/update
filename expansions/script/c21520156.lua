--小宇宙觉醒
function c21520156.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21520156,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c21520156.target)
	e1:SetOperation(c21520156.operation)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520156,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetCondition(c21520156.thcon)
	e2:SetCost(c21520156.thcost)
	e2:SetTarget(c21520156.thtg)
	e2:SetOperation(c21520156.thop)
	c:RegisterEffect(e2)
end
function c21520156.rfilter(c,e,tp)
	return c:IsAbleToRemove() and c:IsLevelBelow(8) and c:IsFaceup() 
		and Duel.IsExistingMatchingCard(c21520156.spfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,c,e,tp)
end
function c21520156.spfilter(c,lc,e,tp)
	if c:IsLocation(LOCATION_EXTRA) then 
		return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsSetCard(0xa491) and not c:IsCode(lc:GetCode()) and c:IsLevel(lc:GetLevel()) 
			and Duel.GetLocationCountFromEx(tp,tp,lc,c)>0 
	elseif c:IsLocation(LOCATION_GRAVE) then 
		return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsSetCard(0xa491) and not c:IsCode(lc:GetCode()) and c:IsLevel(lc:GetLevel()) 
			and Duel.GetMZoneCount(tp,lc)>0 end
end
function c21520156.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c21520156.rfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c21520156.rfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectTarget(tp,c21520156.rfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,rg,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_EXTRA+LOCATION_GRAVE)
end
function c21520156.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then 
		local g=Duel.GetMatchingGroup(c21520156.spfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,nil,tc,e,tp)
		if g:GetCount()>0 then 
			Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:Select(tp,1,1,nil)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
			sg:GetFirst():CompleteProcedure()
		end
	end
end
function c21520156.effectfilter(c)
	return c:IsCode(21520133) and c:IsFaceup() and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c21520156.thfilter(c)
	return c:IsSetCard(0x491) and c:IsAbleToRemoveAsCost()
end
function c21520156.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c21520156.effectfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c21520156.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21520156.thfilter,tp,LOCATION_GRAVE,0,2,e:GetHandler()) end
	Duel.Hint(HINTMSG_SPSUMMON,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,c21520156.thfilter,tp,LOCATION_GRAVE,0,2,2,e:GetHandler())
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520156.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c21520156.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then 
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end
