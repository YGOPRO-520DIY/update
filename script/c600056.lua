--闪电共鸣者
function c600056.initial_effect(c)
	aux.AddLinkProcedure(c,c600056.lfilter,1,1) 
	c:EnableReviveLimit()   
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600056,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,600056)
	e1:SetCondition(c600056.spcon)
	e1:SetTarget(c600056.sptg)
	e1:SetOperation(c600056.spop)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600056,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,6000056)
	e2:SetCondition(aux.exccon)
	e2:SetTarget(c600056.tdtg)
	e2:SetOperation(c600056.tdop)
	c:RegisterEffect(e2)
end
function c600056.lfilter(c)
	return c:IsSetCard(0x57) and c:IsLevelBelow(2)
end
function c600056.spcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c600056.spfilter(c,e,tp,zone)
	return c:IsSetCard(0x57) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE,tp,zone)
end
function c600056.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local zone=bit.band(e:GetHandler():GetLinkedZone(tp),0x1f)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c600056.spfilter(chkc,e,tp,zone) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c600056.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,zone) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c600056.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,zone)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c600056.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local zone=bit.band(e:GetHandler():GetLinkedZone(tp),0x1f)
	if tc:IsRelateToEffect(e) and zone~=0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE,zone)
	end
end
function c600056.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsAbleToDeck() and chkc~=e:GetHandler() end
	if chk==0 then return e:GetHandler():IsAbleToExtra()
		and Duel.IsExistingTarget(Card.IsAbleToDeck,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,2,0,0)
end
function c600056.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		local g=Group.FromCards(c,tc)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end
