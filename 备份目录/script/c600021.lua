--光波偏折龙
function c600021.initial_effect(c)
	aux.AddLinkProcedure(c,c600021.lfilter,3,3) 
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600021,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c600021.spcon)
	e1:SetOperation(c600021.spop)
	c:RegisterEffect(e1)  
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600021,2))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetCondition(c600021.immcon)
	e2:SetValue(c600021.efilter)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c600021.target)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e4)
	--search
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(600021,1))
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,600021)
	e5:SetCost(c600021.thcost)
	e5:SetTarget(c600021.thtg)
	e5:SetOperation(c600021.thop)
	c:RegisterEffect(e5)
end
function c600021.lfilter(c)
	return c:IsSetCard(0xe5)
end
function c600021.spfilter1(c,tp)
	return c:IsFaceup() and c:IsCode(18963306) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c600021.spfilter2,tp,LOCATION_MZONE,0,1,c)
end
function c600021.spfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0xe5) and c:IsAbleToGraveAsCost()
end
function c600021.spcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c600021.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c600021.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c600021.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c600021.spfilter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	c:SetMaterial(g1)
	Duel.SendtoGrave(g1,REASON_COST)
end
function c600021.immcon(e)
	return e:GetHandler():GetSummonLocation()==LOCATION_EXTRA
end
function c600021.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c600021.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code) and c:IsSetCard(0xe5)
end
function c600021.target(e,c)
	return Duel.IsExistingMatchingCard(c600021.cfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetCode())
end
function c600021.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c600021.thfilter(c,tp)
	return c:IsType(TYPE_QUICKPLAY) and c:IsSetCard(0x95)
end
function c600021.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c600021.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c600021.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c600021.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end