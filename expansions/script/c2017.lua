--宝具 妄想之音
function c2017.initial_effect(c)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetOperation(c2017.deactivate)
	c:RegisterEffect(e1)
	--leave field
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetCondition(c2017.sumcon)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetTarget(c2017.rettg)
	e2:SetOperation(c2017.leave)
	c:RegisterEffect(e2)
	--equipment
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_EQUIP)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_REMOVE)
	e3:SetTarget(c2017.eqtg)
	e3:SetOperation(c2017.eqop)
	c:RegisterEffect(e3)
	--return
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TODECK)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c2017.retcon1)
	e4:SetTarget(c2017.rettgg)
	e4:SetOperation(c2017.retop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(0)
	e5:SetCondition(c2017.retcon2)
	c:RegisterEffect(e5)
	--destroy
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetCode(EVENT_BATTLE_START)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCondition(c2017.descon)
	e6:SetTarget(c2017.destg)
	e6:SetOperation(c2017.desop)
	c:RegisterEffect(e6)
end
function c2017.deactivate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e)  then
		Duel.Remove(c,POS_FACEUP,REASON_EFFECT)
	end
end
function c2017.sumcon(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c2017.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end 
function c2017.leave(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
	end
end
function c2017.filter(c)
	return (c:IsCode(2041) or c:IsCode(2012)) and c:IsFaceup()
end
function c2017.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and  c2017.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c2017.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c2017.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c2017.eqlimit(e,c)
	return  c:GetControler()==e:GetHandlerPlayer() or e:GetHandler():GetEquipTarget()==c
end
function c2017.eqop(e,tp,eg,ep,ev,re,r,rp)
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
		e6:SetValue(c2017.eqlimit)
		c:RegisterEffect(e6)
	end
end
function c2017.retcon1(e,tp,eg,ep,ev,re,r,rp,chk)
	return not e:GetHandler():IsHasEffect(42015635)
end
function c2017.retcon2(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():IsHasEffect(42015635)
end
function c2017.rettgg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtra() end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c2017.retop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
end
function c2017.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler():GetEquipTarget()
	local bc=c:GetBattleTarget()
	return bc and bit.band(bc:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c2017.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetEquipTarget():GetBattleTarget()
	if chk==0 then return tc and tc:IsControler(1-tp) end
	local g=Group.FromCards(tc,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c2017.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetEquipTarget():GetBattleTarget()
	if tc:IsRelateToBattle() and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Destroy(c,REASON_EFFECT)
	end
end
