--圣刻龙-普塔龙
function c88990382.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c88990382.ffilter,2,false)	  
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88990382,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c88990382.incon)
	e1:SetTarget(c88990382.intg)
	e1:SetValue(c88990382.indct)
	c:RegisterEffect(e1)
	--spsummon2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88990382,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,88990382)
	e2:SetCost(c88990382.thcost)
	e2:SetTarget(c88990382.thtg)
	e2:SetOperation(c88990382.thop)
	c:RegisterEffect(e2) 
end
function c88990382.ffilter(c)
	return  c:IsRace(RACE_DRAGON)
end
function c88990382.incon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c88990382.intg(e,c)
	return c:IsSetCard(0x69)
end
function c88990382.indct(e,re,r,rp)
	if bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0 then
		return 1
	else return 0 end
end
function c88990382.cfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsReleasable()
end
function c88990382.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local loc=LOCATION_MZONE+LOCATION_HAND 
	if chk==0 then return Duel.IsExistingMatchingCard(c88990382.cfilter,tp,loc,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c88990382.cfilter,tp,loc,0,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c88990382.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,1-tp,LOCATION_ONFIELD)
end
function c88990382.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)>0 then
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end