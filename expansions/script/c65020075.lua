--闪耀之晶月魔印
function c65020075.initial_effect(c)
	 --xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),4,2,nil,nil,99)
	c:EnableReviveLimit()
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65020075,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c65020075.con)
	e1:SetCost(c65020075.cost)
	e1:SetTarget(c65020075.tg)
	e1:SetOperation(c65020075.op)
	c:RegisterEffect(e1)
	 --attach
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(65020075,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,65020075)
	e2:SetCondition(c65020075.xcon)
	e2:SetTarget(c65020075.xtg)
	e2:SetOperation(c65020075.xop)
	c:RegisterEffect(e2)
end
function c65020075.con(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp 
end
function c65020075.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c65020075.desfilter(c)
	return c:IsFaceup() and c:IsAttackAbove(1) and c:IsSetCard(0x9da3)
end
function c65020075.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c65020075.desfilter(chkc) and chkc:IsLocation(LOCATION_MZONE) and c:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(c65020075.desfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SelectTarget(tp,c65020075.desfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c65020075.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=tc:GetAttack()
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	local gc=g:GetFirst()
	while gc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		gc:RegisterEffect(e1)
		gc=g:GetNext()
	end
	end
end

function c65020075.xcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp
		and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function c65020075.xfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x9da3)
end
function c65020075.xtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c65020075.xfilter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c65020075.xfilter,tp,LOCATION_MZONE,0,1,c)
		and c:IsCanOverlay() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c65020075.xfilter,tp,LOCATION_MZONE,0,1,1,c)
end
function c65020075.xop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		local mg=c:GetOverlayGroup()
		if mg:GetCount()>0 then Duel.Overlay(tc,mg) end
		Duel.Overlay(tc,Group.FromCards(c))
	end
end