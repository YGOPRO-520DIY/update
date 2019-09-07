--久远的元素法师 米拉
function c17500019.initial_effect(c)
	--special summon
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_HAND)
	e0:SetCondition(c17500019.spcon)
	c:RegisterEffect(e0)
	 --confirm
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1)
	e1:SetTarget(c17500019.target)
	e1:SetOperation(c17500019.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
c17500019.setname="ElementalWizard"
function c17500019.confil(c)
	return c.setname=="ElementalWizard"
end
function c17500019.spcon(e,c)
	if c==nil then return true end
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c17500019.confil,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c17500019.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) and Duel.GetLocationCount(tp,LOCATION_DECK)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetChainLimit(c17500019.chlimit)
end
function c17500019.chlimit(e,ep,tp)
	return tp==ep
end
function c17500019.thfil(c,tc)
	return ((c:GetType()==TYPE_MONSTER and tc:GetType()==TYPE_MONSTER) or (c:GetType()==TYPE_SPELL and tc:GetType()==TYPE_SPELL) or (c:GetType()==TYPE_TRAP and tc:GetType()==TYPE_TRAP)) and c:IsAbleToHand()
end
function c17500019.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
		Duel.ConfirmCards(tp,tc)
			local g=Duel.SelectMatchingCard(tp,c17500019.thfil,tp,LOCATION_DECK,0,1,1,nil,tc)
			if g:GetCount()>0 then
				Duel.SendtoHand(g,tp,REASON_EFFECT)
				Duel.ConfirmCards(tp,g)
			else
				local sg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
				Duel.ConfirmCards(1-tp,sg)
				Duel.ShuffleDeck(tp)
			end
	end
end