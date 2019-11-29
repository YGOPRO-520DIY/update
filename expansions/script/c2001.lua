--宝具 穿刺之死棘枪
function c2001.initial_effect(c)
	c:EnableReviveLimit()
	--Activate Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,2001)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTarget(c2001.target)
	e1:SetOperation(c2001.activate)
	c:RegisterEffect(e1)
	--CATEGORY REMOVE
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetOperation(c2001.deactivate)
	c:RegisterEffect(e2)
	--Atk up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--leave field
	--local e5=Effect.CreateEffect(c)
	--e5:SetCategory(CATEGORY_TODECK)
	--e5:SetCondition(c2001.sumcon)
	--e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	--e5:SetCode(EVENT_TO_GRAVE)
	--e5:SetTarget(c2001.rettg)
	--e5:SetOperation(c2001.leave)
	--c:RegisterEffect(e5)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e5:SetCondition(c2001.recon)
	e5:SetValue(LOCATION_DECK)
	c:RegisterEffect(e5)
	--equipment
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_EQUIP)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e6:SetCode(EVENT_REMOVE)
	e6:SetTarget(c2001.eqtg)
	e6:SetOperation(c2001.eqop)
	c:RegisterEffect(e6)
	--return
	local e7=Effect.CreateEffect(c)
	e7:SetCategory(CATEGORY_TODECK)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e7:SetCode(EVENT_PHASE+PHASE_END)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCountLimit(1)
	--e7:SetCondition(c2001.retcon1)
	e7:SetTarget(c2001.rettgg)
	e7:SetOperation(c2001.retop)
	c:RegisterEffect(e7)
	--local e8=e7:Clone()
	--e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	--e8:SetProperty(0)
	--e8:SetCondition(c2001.retcon2)
	--c:RegisterEffect(e8)
end
function c2001.deactivate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e)  then
		Duel.Remove(c,POS_FACEUP,REASON_EFFECT)
	end
end
function c2001.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c2001.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc:IsRelateToEffect(e) and c:IsRelateToEffect(e)  then
	Duel.Destroy(tc,REASON_EFFECT)
	Duel.Destroy(c,REASON_EFFECT)
end
end
function c2001.sumcon(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c2001.recon(e)
	local c=e:GetHandler()
	return c:IsFaceup()
end
--function c2001.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	--if chk==0 then return true end
	--Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
--end 
--function c2001.leave(e,tp,eg,ep,ev,re,r,rp)
	--if e:GetHandler():IsRelateToEffect(e) then
		--Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
	--end
--end
function c2001.filter(c)
	return (c:IsSetCard(0xc904) or c:IsCode(2003) or c:IsCode(2055)) and c:IsFaceup()
end
function c2001.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and  c2001.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c2001.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c2001.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c2001.eqlimit(e,c)
	return  c:GetControler()==e:GetHandlerPlayer() or e:GetHandler():GetEquipTarget()==c
end
function c2001.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Equip(tp,c,tc)
		--Add Equip limit
		local e6=Effect.CreateEffect(tc)
		e6:SetType(EFFECT_TYPE_SINGLE)
		e6:SetCode(EFFECT_EQUIP_LIMIT)
		e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e6:SetReset(RESET_EVENT+0x1fe0000)
		e6:SetValue(c2001.eqlimit)
		c:RegisterEffect(e6)
	end
end
function c2001.retcon1(e,tp,eg,ep,ev,re,r,rp,chk)
	return not e:GetHandler():IsHasEffect(42015635)
end
function c2001.retcon2(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():IsHasEffect(42015635)
end
function c2001.rettgg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtra() end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c2001.retop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
end