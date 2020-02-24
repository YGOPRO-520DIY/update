--从者Archer 织田信长
function c22000570.initial_effect(c)
	c:EnableReviveLimit()
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(22000570,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c22000570.atkcost)
	e4:SetTarget(c22000570.tktg)
	e4:SetOperation(c22000570.tkop)
	c:RegisterEffect(e4)
end
function c22000570.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c22000570.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c22000570.tkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,22000571,0,0x4011,1000,1000,1,RACE_WARRIOR,ATTRIBUTE_EARTH)
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,22000571,0,0x4011,1000,1000,1,RACE_WARRIOR,ATTRIBUTE_EARTH,1-tp) 
		or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local token1=Duel.CreateToken(tp,22000571)
	local token2=Duel.CreateToken(tp,22000571)
	Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP)
	Duel.SpecialSummonStep(token2,0,tp,1-tp,false,false,POS_FACEUP)
	Duel.SpecialSummonComplete()
end
