--薰风元素法师 薇茵
function c17500018.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WIND),1)
	c:EnableReviveLimit()
	--search and todeck
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c17500018.tg)
	e1:SetOperation(c17500018.op)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c17500018.tdcost)
	e2:SetTarget(c17500018.tdtg)
	e2:SetOperation(c17500018.tdop)
	c:RegisterEffect(e2)
end
function c17500018.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil,REASON_COST) end
	local num=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD+LOCATION_GRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsDiscardable,tp,LOCATION_HAND,0,1,num,nil,REASON_COST)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
	e:SetLabel(g:GetCount())
end
function c17500018.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,1,nil) end
	local num=e:GetLabel()
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,num,1-tp,LOCATION_ONFIELD+LOCATION_GRAVE)
	e:GetHandler():RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(17500018,0))
end
function c17500018.tdop(e,tp,eg,ep,ev,re,r,rp)
	local num=e:GetLabel()
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,num,num,nil)
	if g:GetCount()==num then
		Duel.HintSelection(g)
		Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
		local sg=Duel.GetDecktopGroup(1-tp,num)
		Duel.ConfirmCards(tp,sg)
		Duel.SortDecktop(tp,1-tp,num)
	end
end
function c17500018.filter(c)
	return c.setname=="ElementalSpell" and c:IsAbleToHand()
end
function c17500018.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17500018.filter,tp,LOCATION_DECK,0,1,nil) and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_ONFIELD+LOCATION_GRAVE)
end
function c17500018.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c17500018.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		if Duel.SendtoHand(g,tp,REASON_EFFECT)~=0 then
			Duel.ConfirmCards(1-tp,g)
			local tdg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,1,1,nil)
			if tdg:GetCount()>0 then
				Duel.HintSelection(tdg)
				Duel.SendtoDeck(tdg,nil,0,REASON_EFFECT)
			end
		end
	end
end
