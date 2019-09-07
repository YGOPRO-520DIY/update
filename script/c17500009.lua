--地元素魔法 大地裂缝
function c17500009.initial_effect(c)
	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c17500009.damcon)
	e1:SetTarget(c17500009.damtg)
	e1:SetOperation(c17500009.damop)
	c:RegisterEffect(e1)
end
c17500009.setname="ElementalSpell"
function c17500009.damfil(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsAttribute(ATTRIBUTE_EARTH) and c:IsFaceup()
end
function c17500009.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17500009.damfil,tp,LOCATION_MZONE,0,1,nil)
end
function c17500009.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,1-tp,LOCATION_MZONE)
end
function c17500009.damop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
