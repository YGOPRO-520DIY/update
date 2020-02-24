--灰姑娘女孩·高垣枫
function c81007013.initial_effect(c)
	c:SetSPSummonOnce(81007013)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WIND),10,2,c81007013.ovfilter,aux.Stringid(81007013,0),2,c81007013.xyzop)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81007013,1))
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,81007013)
	e1:SetCondition(c81007013.discon)
	e1:SetCost(c81007013.discost)
	e1:SetTarget(c81007013.distg)
	e1:SetOperation(c81007013.disop)
	c:RegisterEffect(e1)
	--material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,81007913)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c81007013.mattg)
	e2:SetOperation(c81007013.matop)
	c:RegisterEffect(e2)
end
function c81007013.ovfilter(c)
	return c:IsFaceup() and c:IsXyzType(TYPE_XYZ) and c:IsRank(7,8,9) and c:IsAttribute(ATTRIBUTE_WIND)
end
function c81007013.xyzop(e,tp,chk,mc)
	if chk==0 then return mc:CheckRemoveOverlayCard(tp,2,REASON_COST) end
	mc:RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c81007013.discon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c81007013.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c81007013.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c81007013.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
function c81007013.xyzfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND) and c:IsType(TYPE_XYZ)
end
function c81007013.matfilter(c)
	return c:IsType(TYPE_LINK) and c:IsType(TYPE_MONSTER)
end
function c81007013.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c81007013.xyzfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c81007013.xyzfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c81007013.matfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c81007013.xyzfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c81007013.matop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,c81007013.matfilter,tp,LOCATION_GRAVE,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.Overlay(tc,g)
		end
	end
end
