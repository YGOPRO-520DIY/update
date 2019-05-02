--伞折的缚灵
function c65020031.initial_effect(c)
	--
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e0:SetValue(1)
	c:RegisterEffect(e0)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,65020031)
	e1:SetCost(c65020031.spcost)
	e1:SetTarget(c65020031.sptg)
	e1:SetOperation(c65020031.spop)
	c:RegisterEffect(e1)
	--sp dot
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,65020032)
	e2:SetTarget(c65020031.spdtg)
	e2:SetOperation(c65020031.spdop)
	c:RegisterEffect(e2)
	--SERCH
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,65020031)
	e3:SetCondition(c65020031.thcon)
	e3:SetTarget(c65020031.thtg)
	e3:SetOperation(c65020031.thop)
	c:RegisterEffect(e3)
end
function c65020031.cfilter(c)
	return c:IsDiscardable() and c:IsAbleToGraveAsCost()
end
function c65020031.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65020031.cfilter,tp,LOCATION_HAND,0,2,e:GetHandler()) end
	Duel.DiscardHand(tp,c65020031.cfilter,2,2,REASON_COST+REASON_DISCARD,e:GetHandler())
end
function c65020031.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c65020031.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end

function c65020031.spdfil(c,e,tp)
	return c:IsCode(65020027) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c65020031.spdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c65020031.spdfil,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end

function c65020031.spdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c65020031.spdfil,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c65020031.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_HAND 
end
function c65020031.thfil(c)
	return c:IsSetCard(0x3da4) and c:IsAbleToHand()
end
function c65020031.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c65020031.thfil,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65020031.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c65020031.thfil,tp,LOCATION_DECK,0,1,1,e,tp)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end