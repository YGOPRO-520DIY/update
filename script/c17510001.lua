--折返的亡灵 幽幽子
function c17510001.initial_effect(c)
	--todeck
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_DECK)
	e1:SetCountLimit(1,17510001)
	e1:SetCondition(c17510001.tdcon)
	e1:SetTarget(c17510001.tdtg)
	e1:SetOperation(c17510001.tdop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,17510002)
	e2:SetTarget(c17510001.sumtg)
	e2:SetOperation(c17510001.sumop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
c17510001.setname="FloWBacK"
function c17510001.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c17510001.spfilter(c,e,tp)
	return c.setname=="FloWBacK" and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17510001.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17510001.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c17510001.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17510001.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c17510001.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_GRAVE,0,1,nil) and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,2,0,LOCATION_GRAVE)
end
function c17510001.sumop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_GRAVE,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.HintSelection(g1) 
		if Duel.SendtoDeck(g1,nil,2,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		local g2=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,0,LOCATION_GRAVE,1,1,nil)
		if g2:GetCount()>0 then
			Duel.HintSelection(g2)
			Duel.SendtoDeck(g2,nil,2,REASON_EFFECT)
		end
		end
	end
end