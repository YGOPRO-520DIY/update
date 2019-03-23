--雪尘精灵
function c65080003.initial_effect(c)
	--DNA
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,65080009)
	e1:SetCost(c65080003.thcost)
	e1:SetTarget(c65080003.thtg)
	e1:SetOperation(c65080003.thop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,65080003)
	e2:SetCondition(c65080003.spcon)
	e2:SetTarget(c65080003.sptg)
	e2:SetOperation(c65080003.spop)
	c:RegisterEffect(e2)
end

function c65080003.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c65080003.spfil,tp,LOCATION_MZONE,0,nil)>0 
end

function c65080003.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCount(tp,LOCATION_MZONE,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,tp,LOCATION_HAND)
end
function c65080003.spfil(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsFaceup()
end

function c65080003.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
			Duel.BreakEffect()
			local cg=Duel.GetMatchingGroup(c65080003.spfil,tp,LOCATION_MZONE,0,nil)
			local ct=cg:GetCount()
			local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
			if g:GetCount()==0 then return end
			for i=1,ct do
				Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(65080003,1))
				local tc=g:Select(tp,1,1,nil):GetFirst()
				tc:AddCounter(0x1015,1)
			end
		end
	end
end

function c65080003.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCounter(tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0x1015)>0 end
	Duel.RemoveCounter(tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0x1015,1,REASON_COST)
end

function c65080003.thfil(c)
	return c:IsRace(RACE_WINDBEAST+RACE_SPELLCASTER) and c:IsAttribute(ATTRIBUTE_WATER) and c:IsAbleToHand()
end

function c65080003.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65080003.thfil,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end

function c65080003.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c65080003.thfil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
