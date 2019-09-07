--穗姬·白米·贤妻型
function c44470229.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44470229.matfilter,1,1)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12421694,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCost(c44470229.thcost)
	e1:SetTarget(c44470229.thtg)
	e1:SetOperation(c44470229.thop)
	c:RegisterEffect(e1)
end
function c44470229.matfilter(c,lc,sumtype,tp)
	return c:IsLinkCode(44470222)
end
function c44470229.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c44470229.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c44470229.thfilter(c)
	return c:IsCode(44470222) and c:IsAbleToHand()
end
function c44470229.filter(c)
	return c:IsCode(44470222) and c:IsReleasableByEffect()
end
function c44470229.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470229.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c44470229.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c44470229.thfilter),tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		local rg=Duel.GetMatchingGroup(c44470229.filter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,nil)
		if rg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(44470229,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)

			
			local rg=Duel.SelectMatchingCard(tp,c44470229.filter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,e:GetHandler())
	        Duel.Release(rg,REASON_EFFECT)
		end
	end
end
