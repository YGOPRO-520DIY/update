--光元素魔法 久远占卜
function c17500022.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c17500022.con)
	e1:SetTarget(c17500022.target)
	e1:SetOperation(c17500022.activate)
	c:RegisterEffect(e1)
end
c17500022.setname="ElementalSpell"
function c17500022.damfil(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsFaceup()
end
function c17500022.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17500022.damfil,tp,LOCATION_MZONE,0,1,nil)
end
function c17500022.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function c17500022.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	Duel.ConfirmDecktop(tp,1)
	if tc:IsType(TYPE_MONSTER) or tc:IsType(TYPE_SPELL) then
		Duel.SendtoHand(tc,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	elseif tc:IsType(TYPE_TRAP) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end