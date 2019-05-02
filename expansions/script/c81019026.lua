--链·破坏者
function c81019026.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81019026,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,81019026)
	e1:SetCost(c81019026.cost)
	e1:SetTarget(c81019026.target)
	e1:SetOperation(c81019026.operation)
	c:RegisterEffect(e1)
end
function c81019026.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c81019026.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(1-tp,3) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,3)
end
function c81019026.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,3,REASON_EFFECT)
end
