--吸血鬼魅惑
function c88990371.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,88990371+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c88990371.con)
	e1:SetTarget(c88990371.target)
	e1:SetOperation(c88990371.activate)
	c:RegisterEffect(e1)
	--to hand
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_GRAVE)
	--e5:SetCountLimit(1,88990371)
	e5:SetCost(c88990371.cost1)
	e5:SetTarget(c88990371.thtg)
	e5:SetOperation(c88990371.thop)
	c:RegisterEffect(e5)
end
function c88990371.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_MZONE)
	and c:GetPreviousControler()==1-tp
	
end
function c88990371.cfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x8e)
end
function c88990371.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c88990371.cfilter,1,nil,tp)
	and Duel.IsExistingMatchingCard(c88990371.cfilter2,tp,LOCATION_MZONE,0,1,nil)
end


function c88990371.filter(c,e,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsControler(1-tp) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and c:IsCanBeEffectTarget(e)
end
function c88990371.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and c88990371.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and eg:IsExists(c88990371.filter,1,nil,e,tp) end
	local g=eg:Filter(c88990371.filter,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,1)
end

function c88990371.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		Duel.DiscardDeck(1-tp,1,REASON_EFFECT)
		local g=Duel.GetMatchingGroup(c88990371.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
		if tc and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.SelectYesNo(tp,aux.Stringid(88990371,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
--to hand
function c88990371.costfilter(c,tp)
	return c:IsSetCard(0x8e) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsAbleToGraveAsCost()
	--and Duel.GetMZoneCount(tp,c)>0
end
function c88990371.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88990371.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c88990371.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c88990371.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c88990371.thop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
		Duel.ConfirmCards(tp,e:GetHandler())
	end
end