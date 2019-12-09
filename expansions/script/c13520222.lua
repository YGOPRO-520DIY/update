local m=13520222
local tg={13520200,13520230}
local cm=_G["c"..m]
cm.name="魔女花骑士 金雀儿"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_LEAVE_GRAVE+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(cm.eqcon)
	e1:SetTarget(cm.eqtg)
	e1:SetOperation(cm.eqop)
	c:RegisterEffect(e1)
	--Return Grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,1))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(cm.rgcost)
	e2:SetTarget(cm.rgtg)
	e2:SetOperation(cm.rgop)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e2)
end
function cm.flower(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Equip
function cm.eqfilter(c)
	return cm.flower(c) and c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function cm.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function cm.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and cm.eqfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(cm.eqfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local ct=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ct>3 then ct=3 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,cm.eqfilter,tp,LOCATION_GRAVE,0,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,g:GetCount(),0,0)
end
function cm.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if c:IsFacedown() or not c:IsRelateToEffect(e) or ft<g:GetCount() then return end
	local tc=g:GetFirst()
	while tc do
		if Duel.Equip(tp,tc,c,true,true) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetValue(cm.eqlimit)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
		end
		tc=g:GetNext()
	end
	Duel.EquipComplete()
end
function cm.eqlimit(e,c)
	return e:GetOwner()==c and not c:IsDisabled()
end
--Return Grave
function cm.rfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EQUIP) and c:IsReleasable()
end
function cm.rgfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function cm.rgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.rfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,cm.rfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function cm.rgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_REMOVED) and cm.rgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(cm.rgfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(m,2))
	local g=Duel.SelectTarget(tp,cm.rgfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,800)
end
function cm.rgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoGrave(tc,REASON_EFFECT+REASON_RETURN)~=0 then
		Duel.Recover(tp,800,REASON_EFFECT)
	end
end