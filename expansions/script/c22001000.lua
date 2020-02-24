--星之从者 贝狄威尔
function c22001000.initial_effect(c)
	c:EnableCounterPermit(0xfee)
	c:SetCounterLimit(0xfee,10)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c22001000.lcheck)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22001000,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c22001000.thcon)
	e1:SetTarget(c22001000.thtg)
	e1:SetOperation(c22001000.thop)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetOperation(c22001000.ctop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetDescription(aux.Stringid(22001000,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,22001000+EFFECT_COUNT_CODE_DUEL)
	e3:SetCost(c22001000.spcost)
	e3:SetTarget(c22001000.sptg)
	e3:SetOperation(c22001000.spop)
	c:RegisterEffect(e3)
end
function c22001000.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c22001000.lcheck(g,lc)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0x5098)
end
function c22001000.thfilter(c)
	return c:IsCode(23000020) and c:IsAbleToHand()
end
function c22001000.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22001000.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c22001000.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c22001000.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c22001000.ctfilter(c,tp)
	return c:IsControler(tp) and c:IsSetCard(0xfff) and c:IsType(TYPE_MONSTER)
end
function c22001000.ctop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c22001000.ctfilter,1,nil,tp) then
		e:GetHandler():AddCounter(0xfee,2)
	end
end
function c22001000.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	e:SetLabel(e:GetHandler():GetCounter(0xfee))
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c22001000.spfilter(c,lv,e,tp)
	return c:IsLevelBelow(lv) and c:IsSetCard(0xff9) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c22001000.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCountFromEx(tp)>0
		and Duel.IsExistingMatchingCard(c22001000.spfilter,tp,LOCATION_EXTRA,0,1,nil,e:GetHandler():GetCounter(0xfee),e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c22001000.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCountFromEx(tp)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c22001000.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e:GetLabel(),e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
