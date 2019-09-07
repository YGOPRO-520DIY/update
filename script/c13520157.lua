local m=13520157
local cm=_G["c"..m]
cm.name="翠雾仙 青莲"
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
	--To Grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,2))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_MOVE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(cm.tgcon)
	e2:SetTarget(cm.tgtg)
	e2:SetOperation(cm.tgop)
	c:RegisterEffect(e2)
end
--Fusion
function cm.mfilter1(c)
	return c:IsFusionType(TYPE_FLIP)
end
function cm.mfilter2(c)
	return c:IsFusionAttribute(ATTRIBUTE_WATER)
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
--To Grave
function cm.tgfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGrave()
end
function cm.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_MZONE) and e:GetHandler():IsLocation(LOCATION_MZONE)
end
function cm.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.tgfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,PLAYER_ALL,LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function cm.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,cm.tgfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		if Duel.SendtoGrave(g,REASON_EFFECT)~=0 then
			Duel.Recover(tp,1000,REASON_EFFECT)
		end
	end
end