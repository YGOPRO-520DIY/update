--古夕幻历-神龙偃月杀刃
function c44460092.initial_effect(c)
	c:SetUniqueOnField(1,0,44460092)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c44460092.target)
	e1:SetOperation(c44460092.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c44460092.eqlimit)
	c:RegisterEffect(e2)
	--to hand
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_TOHAND)
	e11:SetDescription(aux.Stringid(44460091,1))
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e11:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e11:SetCode(EVENT_TO_GRAVE)
	e11:SetTarget(c44460092.thtg)
	e11:SetOperation(c44460092.thop)
	c:RegisterEffect(e11)
	--negate
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e21:SetCode(EVENT_ATTACK_ANNOUNCE)
	e21:SetRange(LOCATION_SZONE)
	e21:SetCondition(c44460092.negcon1)
	e21:SetOperation(c44460092.negop1)
	c:RegisterEffect(e21)
	local e31=Effect.CreateEffect(c)
	e31:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e31:SetCode(EVENT_BE_BATTLE_TARGET)
	e31:SetRange(LOCATION_SZONE)
	e31:SetCondition(c44460092.negcon2)
	e31:SetOperation(c44460092.negop2)
	c:RegisterEffect(e31)
	--Atk Change
	local e42=Effect.CreateEffect(c)
	e42:SetType(EFFECT_TYPE_EQUIP)
	e42:SetCode(EFFECT_SET_ATTACK_FINAL)
	e42:SetValue(c44460092.value)
	c:RegisterEffect(e42)
	local e44=Effect.CreateEffect(c)
	e44:SetType(EFFECT_TYPE_EQUIP)
	e44:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e44)
	local e45=Effect.CreateEffect(c)
	e45:SetType(EFFECT_TYPE_EQUIP)
	e45:SetCode(EFFECT_DISABLE_EFFECT)
	c:RegisterEffect(e45)
end
function c44460092.filter(c)
	return c:IsFaceup() and (c:GetLevel()==1 or c:GetRank()==1)
end
function c44460092.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c44460092.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44460092.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c44460092.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c44460092.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c44460092.eqlimit(e,c)
	return c:GetLevel()==1 or c:GetRank()==1
end
--to hand
function c44460092.thfilter(c)
	return c:IsAbleToHand() and not c:IsType(TYPE_TOKEN) and not c:IsType(TYPE_NORMAL)
end
function c44460092.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460092.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c44460092.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c44460092.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
	local g=Duel.SelectMatchingCard(tp,c44460092.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
--negate
function c44460092.negcon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget()==Duel.GetAttacker()
end
function c44460092.negop1(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d~=nil then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		d:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		d:RegisterEffect(e2)
	end
end
function c44460092.negcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget()==Duel.GetAttackTarget()
end
function c44460092.negop2(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if a~=nil then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		a:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		a:RegisterEffect(e2)
	end
end
--Atk Change
function c44460092.value(e,c)
	local p=e:GetHandler():GetControler()
	return c:GetAttack()*2
end