--烈火元素法师 希塔
function c17500011.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c17500011.matfil,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),true)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c17500011.target)
	e1:SetOperation(c17500011.operation)
	c:RegisterEffect(e1)
	 --Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c17500011.damtg)
	e2:SetOperation(c17500011.damop)
	c:RegisterEffect(e2)
end
c17500011.setname="ElementalWizard"
function c17500011.matfil(c)
	return c:IsFusionAttribute(ATTRIBUTE_FIRE) and c:IsRace(RACE_SPELLCASTER)
end
function c17500011.filter(c)
	return c.setname=="ElementalSpell" and c:IsAbleToHand()
end
function c17500011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17500011.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,1000)
end
function c17500011.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c17500011.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
end
function c17500011.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_SPELL)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct*200)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,ct*200)
	e:GetHandler():RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(17500011,0))
end
function c17500011.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end