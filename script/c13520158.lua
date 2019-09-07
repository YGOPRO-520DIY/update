local m=13520158
local cm=_G["c"..m]
cm.name="翠雾仙 南瓜"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Fusion
	aux.AddFusionProcFun2(c,cm.mfilter1,cm.mfilter2,true)
	--Change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(cm.chtg)
	e1:SetOperation(cm.chop)
	c:RegisterEffect(e1)
	--Draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,2))
	e2:SetCategory(CATEGORY_DRAW+CATEGORY_HANDES)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_MOVE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(cm.drcon)
	e2:SetTarget(cm.drtg)
	e2:SetOperation(cm.drop)
	c:RegisterEffect(e2)
end
--Fusion
function cm.mfilter1(c)
	return c:IsFusionType(TYPE_FLIP)
end
function cm.mfilter2(c)
	return c:IsFusionAttribute(ATTRIBUTE_FIRE)
end
--Change
function cm.chfilter(c)
	return c:GetSequence()<5
end
function cm.chtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(cm.chfilter,tp,LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(m,1))
	Duel.SelectTarget(tp,cm.chfilter,tp,LOCATION_MZONE,0,2,2,nil)
end
function cm.chop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()==2 then
		local tc1=sg:GetFirst()
		local tc2=sg:GetNext()
		Duel.SwapSequence(tc1,tc2)
	end
end
--Draw
function cm.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_MZONE) and e:GetHandler():IsLocation(LOCATION_MZONE)
end
function cm.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,1)
	local ct1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if ct1>ct2 then
		Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
	elseif ct2>ct1 then
		Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
	end
end
function cm.drop(e,tp,eg,ep,ev,re,r,rp)
	local d1=Duel.Draw(tp,1,REASON_EFFECT)
	local d2=Duel.Draw(1-tp,1,REASON_EFFECT)
	if d1==0 or d2==0 then return end
	local ct1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if ct1>ct2 then
		Duel.BreakEffect()
		Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_EFFECT+REASON_DISCARD)
	elseif ct2>ct1 then
		Duel.BreakEffect()
		Duel.DiscardHand(1-tp,Card.IsDiscardable,1,1,REASON_EFFECT+REASON_DISCARD)
	end
end