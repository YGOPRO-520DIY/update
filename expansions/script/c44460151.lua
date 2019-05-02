--古夕幻历-神依再生
function c44460151.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c44460151.target)
	e1:SetOperation(c44460151.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c44460151.eqlimit)
	c:RegisterEffect(e2)
	--Indes
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_EQUIP)
	e21:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e21:SetCondition(c44460151.escon)
	e21:SetValue(1)
	c:RegisterEffect(e21)
	local e31=e21:Clone()
	e31:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e31:SetCondition(c44460151.escon)
	c:RegisterEffect(e31)
	--disable
	local e44=Effect.CreateEffect(c)
	e44:SetType(EFFECT_TYPE_EQUIP)
	e44:SetCode(EFFECT_DISABLE)
	e44:SetCondition(c44460151.descon)
	c:RegisterEffect(e44)
	local e45=Effect.CreateEffect(c)
	e45:SetType(EFFECT_TYPE_EQUIP)
	e45:SetCode(EFFECT_DISABLE_EFFECT)
	e45:SetCondition(c44460151.descon)
	c:RegisterEffect(e45)
	--to hand
	local e51=Effect.CreateEffect(c)
	e51:SetCategory(CATEGORY_TOHAND)
	e51:SetDescription(aux.Stringid(44460151,1))
	e51:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e51:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e51:SetCode(EVENT_TO_GRAVE)
	e51:SetTarget(c44460151.thtg)
	e51:SetOperation(c44460151.thop)
	c:RegisterEffect(e51)
end
function c44460151.escon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget():IsCode(44460067)
end
function c44460151.descon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():GetEquipTarget():IsCode(44460067)
end
--Activate
function c44460151.filter(c)
	return c:IsFaceup() 
end
function c44460151.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c44460151.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44460151.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c44460151.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c44460151.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c44460151.eqlimit(e,c)
	return c:GetLevel()==1 or c:GetRank()==1
end
--to hand
function c44460151.thfilter(c)
	return c:IsSetCard(0x677) and c:IsType(TYPE_SPELL)
	and c:IsAbleToHand() and c:IsType(TYPE_EQUIP) and not c:IsCode(44460151) 
end
function c44460151.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460151.thfilter,tp,LOCATION_GRAVE,0,1,nil) 
	and Duel.IsExistingMatchingCard(c44460151.desfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c44460151.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44460151.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c44460151.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x680) 
end