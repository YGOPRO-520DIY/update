--古夕幻历-风花府邸
function c44460070.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetDescription(aux.Stringid(44460070,0))
	e1:SetCountLimit(1,44460070)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c44460070.target)
	e1:SetOperation(c44460070.activate)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,44461070)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c44460070.tg)
	e2:SetOperation(c44460070.op)
	c:RegisterEffect(e2)
end
function c44460070.thfilter(c)
	return c:IsCode(44460001) and c:IsAbleToHand()
end
function c44460070.tgfilter(c)
	return c:GetLevel()==1 and c:IsAbleToGrave()
end
function c44460070.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460070.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c44460070.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460070.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_GRAVE) and tc:IsType(TYPE_NORMAL)
		and Duel.IsExistingMatchingCard(c44460070.thfilter,tp,LOCATION_DECK,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(44460070,2)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=Duel.SelectMatchingCard(tp,c44460070.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
	end
end
--tohand
function c44460070.sumfilter(c,tp)
	return c:IsFaceup() and c:GetLevel()==1
end
function c44460070.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460070.sumfilter,1,nil,tp)
end
function c44460070.filter(c)
	return c:GetLevel()==1 and c:IsAbleToHand() and c:IsType(TYPE_NORMAL)
end
function c44460070.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460070.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c44460070.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44460070.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end