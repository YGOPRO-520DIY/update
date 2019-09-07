--从者Caster 玉藻前
function c22001020.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,2,nil,nil,99)
	c:EnableReviveLimit()
	--handes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22001020,0))
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetLabel(3)
	e1:SetCondition(c22001020.effcon)
	e1:SetCost(c22001020.cost)
	e1:SetTarget(c22001020.target)
	e1:SetOperation(c22001020.operation)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22001020,1))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c22001020.discon)
	e2:SetCost(c22001020.cost1)
	e2:SetTarget(c22001020.distg)
	e2:SetOperation(c22001020.disop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(22001020,2))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetLabel(9)
	e3:SetCondition(c22001020.effcon)
	e3:SetCost(c22001020.cost2)
	e3:SetTarget(c22001020.target1)
	e3:SetOperation(c22001020.operation1)
	c:RegisterEffect(e3)
	--material
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(22001020,3))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c22001020.mttg)
	e4:SetOperation(c22001020.mtop)
	c:RegisterEffect(e4)
end
function c22001020.effcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()>=e:GetLabel()
end
function c22001020.discon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and e:GetHandler():GetOverlayCount()>=6
end
function c22001020.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c22001020.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,0,0,1-tp,1)
end
function c22001020.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND,nil)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
end
function c22001020.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c22001020.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c22001020.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c22001020.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,3,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,3,3,REASON_COST)
end
function c22001020.filter(c)
	return c:IsAbleToHand()
end
function c22001020.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22001020.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c22001020.operation1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c22001020.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c22001020.filter0(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c22001020.tfilter(c)
	return not c:IsType(TYPE_TOKEN)
end
function c22001020.target0(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetMatchingGroup(c22001020.filter0,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
		return g:GetCount()>0 and not g:IsExists(c22001020.tfilter,1,nil)
	end
	local g=Duel.GetMatchingGroup(c22001020.filter0,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,2,0,0)
end
function c22001020.activate0(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler()
	if not tc then return end
	local g=Duel.GetMatchingGroup(c22001020.filter0,tp,0,LOCATION_GRAVE,nil)
	Duel.Overlay(e:GetHandler(),g)
end
function c22001020.mtfilter(c,e)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c22001020.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ)
		and Duel.IsExistingMatchingCard(c22001020.mtfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e) end
end
function c22001020.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c22001020.mtfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
