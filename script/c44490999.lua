--青眼魔圣龙
function c44490999.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,c44490999.mfilter,8,2,c44490999.ovfilter,aux.Stringid(44490999,0),3,c44490999.xyzop)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c44490999.ctcon)
	e1:SetValue(c44490999.atkval)
	c:RegisterEffect(e1)
	--mat
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44490999,1))
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCountLimit(1,44491999)
	e11:SetCategory(CATEGORY_ATKCHANGE)
	e11:SetCost(c44490999.matcost)
	e11:SetTarget(c44490999.mattg)
	e11:SetOperation(c44490999.matop)
	c:RegisterEffect(e11)
	--tohand
	local e31=Effect.CreateEffect(c)
	e31:SetDescription(aux.Stringid(44490999,2))
	e31:SetCountLimit(1,44490999)
	e31:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e31:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e31:SetCode(EVENT_REMOVE)
	e31:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e31:SetTarget(c44490999.thtg)
	e31:SetOperation(c44490999.thop)
	c:RegisterEffect(e31)
end
function c44490999.ovfilter(c)
	return c:IsFaceup() and c:IsCode(89631139)
end
function c44490999.mfilter(c)
	return c:IsFaceup()
end
function c44490999.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,44490999)==0 end
	Duel.RegisterFlagEffect(tp,44490999,RESET_PHASE+PHASE_END,0,1)
end
--atk
function c44490999.atkval(e,c)
	return c:GetOverlayCount()*500
end
function c44490999.ctcon(e)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsSetCard,1,nil,0xdd)
end
--mat
function c44490999.matcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c44490999.matfilter(c)
	return c:IsType(TYPE_MONSTER)
end
function c44490999.mattg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44490999.matfilter,tp,LOCATION_EXTRA,0,1,nil) end

end
function c44490999.atkfilter(c)
	return c:IsSetCard(0xdd)
end
function c44490999.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c44490999.matfilter),tp,LOCATION_EXTRA,0,nil)
	if g:GetCount()>0 then
	   --Duel.ConfirmCards(tp,g)
	   Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	   local og=g:Select(tp,1,1,nil)
	   Duel.Overlay(c,og)
	   --local ct=Duel.GetOperatedGroup():FilterCount(c82697249.ctfilter,nil)
		--local g=e:GetHandler():GetOverlayGroup():Filter(c44490999.atkfilter,nil)
	    --return g:GetSum(Card.GetAttack)
	end
end
--tohand
function c44490999.filter(c)
	return c:IsSetCard(0xdd)
	and c:IsType(TYPE_MONSTER)
	and c:IsAbleToHand()
end
function c44490999.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44490999.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44490999.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44490999.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
