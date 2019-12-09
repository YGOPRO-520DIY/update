--凶饿毒强欲龙
function c600072.initial_effect(c)
	--fusion material
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_DARK),c600072.ffilter2,true)
	c:EnableReviveLimit()
	--Disable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600072,0))
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,600072)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c600072.distg)
	e1:SetOperation(c600072.disop)
	c:RegisterEffect(e1)  
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600072,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,6000072)
	e2:SetTarget(c600072.damtg)
	e2:SetOperation(c600072.damop)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(600072,2))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_REMOVED)
	e3:SetCountLimit(1,6000172)
	e3:SetCondition(c600072.rmcon)
	e3:SetTarget(c600072.rmtg)
	e3:SetOperation(c600072.rmop)
	c:RegisterEffect(e3)
end
function c600072.ffilter2(c)
	return c:GetOriginalLevel()>=10 and c:IsFusionType(TYPE_FUSION)
end
function c600072.disfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and not c:IsDisabled()
end
function c600072.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c600072.disfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c600072.disfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c600072.disfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c600072.disop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local atk=tc:GetAttack()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_UPDATE_ATTACK)
		e3:SetValue(atk)
		e3:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e3)
	end
end
function c600072.cfilter(c)
	return c:IsFaceup()
end
function c600072.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c600072.cfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c600072.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c600072.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c600072.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(2800)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		tc:RegisterEffect(e1)
	end
end
function c600072.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==e:GetHandler():GetTurnID()+1
end
function c600072.rgfilter(c)
	return c:IsFaceup()  
end
function c600072.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c600072.rgfilter,tp,LOCATION_REMOVED,0,1,nil)
		and Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(600072,2))
	local g1=Duel.SelectTarget(tp,c600072.rgfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g1,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g2,1,0,0)
end
function c600072.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local lc=tg:GetFirst()
	if lc==tc then lc=tg:GetNext() end
	if tc:IsRelateToEffect(e) and Duel.SendtoGrave(tc,REASON_EFFECT+REASON_RETURN)~=0 and lc:IsRelateToEffect(e) and lc:IsControler(1-tp) then
		Duel.Remove(lc,POS_FACEUP,REASON_EFFECT)
	end
end