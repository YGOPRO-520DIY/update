--风元素魔法 全向薰风
function c17500010.initial_effect(c)
	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c17500010.damcon)
	e1:SetTarget(c17500010.damtg)
	e1:SetOperation(c17500010.damop)
	c:RegisterEffect(e1)
end
c17500010.setname="ElementalSpell"
function c17500010.damfil(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsAttribute(ATTRIBUTE_WIND) and c:IsFaceup()
end
function c17500010.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17500010.damfil,tp,LOCATION_MZONE,0,1,nil)
end
function c17500010.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,0,LOCATION_GRAVE)
end
function c17500010.damop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end

