--云城巨龙
function c44491000.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,c44491000.mfilter,8,2,c44491000.ovfilter,aux.Stringid(44491000,0),3,c44491000.xyzop)
	c:EnableReviveLimit()
	--mat
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44491000,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c44491000.matcost)
	e1:SetTarget(c44491000.mattg)
	e1:SetOperation(c44491000.matop)
	c:RegisterEffect(e1)
end
function c44491000.matcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c44491000.ovfilter(c)
	return c:IsFaceup() and c:GetRank()==8
	and (c:IsRace(RACE_DRAGON) or c:IsRace(RACE_WYRM))
end
function c44491000.mfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c44491000.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,44491000)==0 end
	Duel.RegisterFlagEffect(tp,44491000,RESET_PHASE+PHASE_END,0,1)
end
function c44491000.matfilter(c)
	return c:IsType(TYPE_MONSTER)
end
function c44491000.rfilter(c)
	return c:IsAbleToRemove() and (c:IsRace(RACE_DRAGON) or c:IsRace(RACE_WYRM))
end
function c44491000.mattg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44491000.matfilter,tp,LOCATION_EXTRA,LOCATION_EXTRA,1,nil)
		and Duel.IsExistingMatchingCard(c44491000.rfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function c44491000.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c44491000.matfilter),tp,LOCATION_EXTRA,LOCATION_EXTRA,nil)
	if g:GetCount()>0 then
	   Duel.ConfirmCards(tp,g)
	   Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	   local og=g:Select(tp,1,1,nil)
	   Duel.Overlay(c,og)
	   Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	   local rg=Duel.SelectMatchingCard(tp,c44491000.rfilter,tp,LOCATION_DECK,0,1,1,nil)
		if rg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,rg)
		end
	end
end