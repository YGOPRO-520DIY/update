--刀鸣散华·式神 鬼切
local m=77295101
local set=0xee7
local cm=_G["c"..m]
function cm.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0xee7),1)
	c:EnableReviveLimit()
	--double atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(2)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetCondition(cm.atkcon)
	e3:SetOperation(cm.atkop)
	c:RegisterEffect(e3)
	--remove
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetDescription(aux.Stringid(m,2))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,m)
	e4:SetTarget(cm.target)
	e4:SetOperation(cm.operation)
	c:RegisterEffect(e4)
	--to grave
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(m,6))
	e5:SetCategory(CATEGORY_TODECK)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCountLimit(1,77295102)
	e5:SetCost(cm.tdcost)
	e5:SetTarget(cm.tdtg)
	e5:SetOperation(cm.tdop)
	c:RegisterEffect(e5)
end
	--atkup
function cm.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttackTarget()==nil
end
function cm.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetValue(900)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END,2)
		c:RegisterEffect(e1)
	end
end
	--remove
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,0,0)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsControler(tp) and Duel.Remove(c,nil,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		if Duel.GetCurrentPhase()==PHASE_STANDBY then
			e1:SetLabel(Duel.GetTurnCount())
			e1:SetCondition(cm.retcon)
			e1:SetReset(RESET_PHASE+PHASE_STANDBY,2)
		else
			e1:SetReset(RESET_PHASE+PHASE_STANDBY)
		end
		e1:SetLabelObject(c)
		e1:SetCountLimit(1)
		e1:SetOperation(cm.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function cm.retcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==e:GetLabel()
end
function cm.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetHandler())
	e:Reset()
end
	--to grave
function cm.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_COST)
end
function cm.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(m,5))
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function cm.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=tg:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_RETURN)
	end
end
