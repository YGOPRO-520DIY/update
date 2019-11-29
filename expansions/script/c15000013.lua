local m=15000013
local cm=_G["c"..m]
cm.name="柯西蔓弦"
function cm.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15000013,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SEARCH)  
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,15020013+EFFECT_COUNT_CODE_OATH)  
	e1:SetOperation(c15000013.activate)
	c:RegisterEffect(e1)
	--change effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(15000013,1))
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,15000013)
	e2:SetCondition(c15000013.chcon)
	e2:SetCost(c15000013.chcost)
	e2:SetTarget(c15000013.chtg)
	e2:SetOperation(c15000013.chop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e3)
	--search  
	local e5=Effect.CreateEffect(c)  
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)  
	e5:SetType(EFFECT_TYPE_IGNITION)  
	e5:SetRange(LOCATION_GRAVE)  
	e5:SetCountLimit(1,15010013)  
	e5:SetCost(c15000013.thcost)  
	e5:SetTarget(c15000013.thtg)  
	e5:SetOperation(c15000013.thop)  
	c:RegisterEffect(e5) 
end
function c15000013.thfilter(c)  
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x10b) and c:IsAbleToGrave()  
end  
function c15000013.activate(e,tp,eg,ep,ev,re,r,rp)  
	if not e:GetHandler():IsRelateToEffect(e) then return end  
	local g=Duel.GetMatchingGroup(c15000013.thfilter,tp,LOCATION_DECK,0,nil)  
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(15000013,0)) then  
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)  
		local sg=g:Select(tp,1,1,nil)  
		Duel.SendtoGrave(sg,nil,REASON_EFFECT)  
	end  
end
function c15000013.chcon(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetCurrentChain()
	if ct<2 then return end
	local te,p=Duel.GetChainInfo(ct-1,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER)
	return te and te:GetHandler():IsSetCard(0x10b) and p==tp and rp==1-tp
end
function c15000013.chcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c15000013.wfilter(c)  
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c15000013.chtg(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return Duel.IsExistingMatchingCard(c15000013.wfilter,rp,0,LOCATION_MZONE,1,nil) end  
end
function c15000013.chop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c15000013.repop)
end
function c15000013.repop(e,tp,eg,ep,ev,re,r,rp)  
	local c=e:GetHandler()  
	if c:GetType()==TYPE_SPELL or c:GetType()==TYPE_TRAP then  
		c:CancelToGrave(false)  
	end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)  
	local g=Duel.SelectMatchingCard(tp,c15000013.wfilter,tp,0,LOCATION_MZONE,1,1,nil)  
	if g:GetCount()>0 then  
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)  
	end  
end

function c15000013.cfilter(c)  
	return c:IsSetCard(0x10b) and c:IsDiscardable()  
end  
function c15000013.thcost(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()  
		and Duel.IsExistingMatchingCard(c15000013.cfilter,tp,LOCATION_HAND,0,1,nil) end  
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)  
	Duel.DiscardHand(tp,c15000013.cfilter,1,1,REASON_COST+REASON_DISCARD)  
end  
function c15000013.filter(c)  
	return c:IsCode(15000013) and c:IsAbleToHand()  
end  
function c15000013.thtg(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return Duel.IsExistingMatchingCard(c15000013.filter,tp,LOCATION_DECK,0,1,nil) end  
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)  
end  
function c15000013.thop(e,tp,eg,ep,ev,re,r,rp)  
	local tc=Duel.GetFirstMatchingCard(c15000013.filter,tp,LOCATION_DECK,0,nil)  
	if tc then  
		Duel.SendtoHand(tc,nil,REASON_EFFECT)  
		Duel.ConfirmCards(1-tp,tc)  
	end  
end 