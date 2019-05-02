--古夕幻历-白玉鹿角
function c44460093.initial_effect(c)
	c:SetUniqueOnField(1,0,44460093)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c44460093.target)
	e1:SetOperation(c44460093.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c44460093.eqlimit)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(44460093,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,44460093)
	e3:SetTarget(c44460093.thtg2)
	e3:SetOperation(c44460093.thop2)
	c:RegisterEffect(e3)
	--disable
	local e44=Effect.CreateEffect(c)
	e44:SetType(EFFECT_TYPE_EQUIP)
	e44:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e44)
	local e45=Effect.CreateEffect(c)
	e45:SetType(EFFECT_TYPE_EQUIP)
	e45:SetCode(EFFECT_DISABLE_EFFECT)
	c:RegisterEffect(e45)
	--can not attack
	local e52=Effect.CreateEffect(c)
	e52:SetType(EFFECT_TYPE_FIELD)
	e52:SetCode(EFFECT_CANNOT_ATTACK)
	e52:SetRange(LOCATION_SZONE)
	e52:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e52:SetTarget(c44460093.atarget)
	c:RegisterEffect(e52)
end
--can not attack
function c44460093.atarget(e,c)
	local ec=e:GetHandler():GetEquipTarget()
	return c:GetAttack()>ec:GetAttack() and c:IsType(TYPE_EFFECT)
end

function c44460093.filter(c)
	return c:IsFaceup() and not c:IsDisabled()
end
function c44460093.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c44460093.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44460093.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c44460093.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c44460093.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c44460093.eqlimit(e,c)
	return c:IsFaceup() 
end
--tohand
function c44460093.thcfilter(c)
	return c:IsSetCard(0x679) and c:IsAbleToGrave()
end
function c44460093.thcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460093.thcfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460093.thcfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c44460093.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToHand() 
	and Duel.IsExistingMatchingCard(c44460093.thfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
end
function c44460093.thop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460093.thfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	if g:GetCount()>0 then
	Duel.SendtoGrave(g,REASON_EFFECT)
	local c=e:GetHandler()
	    if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	    end
	end
end

