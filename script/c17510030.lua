--折返的瞬间
function c17510030.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_DECK)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,17510030)
	e1:SetCondition(c17510030.con)
	e1:SetTarget(c17510030.target)
	e1:SetOperation(c17510030.activate)
	c:RegisterEffect(e1)
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_DECK)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,17510031)
	e2:SetCondition(c17510030.tdcon)
	e2:SetTarget(c17510030.tdtg)
	e2:SetOperation(c17510030.tdop)
	c:RegisterEffect(e2)
end
c17510030.setname="FloWBacK"

function c17510030.confil(c)
	return c.setname=="FloWBacK" and c:IsPreviousPosition(POS_FACEUP)
end
function c17510030.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c17510030.confil,1,nil)
end
function c17510030.filter(c,e,tp)
	return c.setname=="FloWBacK" and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17510030.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17510030.filter,tp,LOCATION_DECK,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c17510030.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c17510030.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c17510030.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c17510030.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	 if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED)
end
function c17510030.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end