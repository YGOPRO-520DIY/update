--百绘罗衣·式神 彼岸花
local m=77295111
local set=0xee7
local cm=_G["c"..m]
function cm.initial_effect(c)
	c:EnableCounterPermit(0x18)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2,99,cm.lcheck)
	c:EnableReviveLimit()
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,m)
	e1:SetCost(cm.ctcost)
	e1:SetOperation(cm.ctop)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetCountLimit(1,77295112)
	e2:SetTarget(cm.reptg)
	e2:SetOperation(cm.repop)
	c:RegisterEffect(e2)
	--Negate damage (direct)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(m,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetCountLimit(1,77295113)
	e3:SetCondition(cm.dmcon)
	e3:SetCost(cm.dmcost)
	e3:SetOperation(cm.dmop)
	c:RegisterEffect(e3)
	--damage1
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetOperation(cm.regop1)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_CHAIN_SOLVED)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(cm.dagcon)
	e5:SetOperation(cm.dagop)
	c:RegisterEffect(e5)
	--damage2
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_TO_HAND)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(cm.damcon1)
	e6:SetOperation(cm.damop1)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e7:SetCode(EVENT_TO_HAND)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCondition(cm.regcon2)
	e7:SetOperation(cm.regop2)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e8:SetCode(EVENT_CHAIN_SOLVED)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCondition(cm.damcon2)
	e8:SetOperation(cm.damop2)
	c:RegisterEffect(e8)
	--damage3
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e9:SetCode(EVENT_CHAINING)
	e9:SetRange(LOCATION_MZONE)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e9:SetOperation(cm.regop3)
	c:RegisterEffect(e9)
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EVENT_CHAIN_SOLVED)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCondition(cm.damcon3)
	e10:SetOperation(cm.damop3)
	c:RegisterEffect(e10)
end
	--link summon
function cm.lcheck(g,lc)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0xee7)
end
	--counter
function cm.cffilter(c)
	return c:IsSetCard(0xee7) and not c:IsPublic()
end
function cm.ctcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.cffilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,cm.cffilter,tp,LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
end
function cm.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		c:AddCounter(0x18,1)
	end
end
	--destroy replace
function cm.repfilter(c,e)
	return c:IsSetCard(0xee7)
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
end
function cm.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
		and Duel.IsExistingMatchingCard(cm.repfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,c,e) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,cm.repfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,c,e)
		Duel.SetTargetCard(g)
		g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	else return false end
end
function cm.repop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(g,REASON_EFFECT+REASON_REPLACE)
end
	--Negate damage (direct)
function cm.dmcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function cm.dmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_COST)
end
function cm.dmop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(cm.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function cm.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
	--damage1
function cm.regop1(e,tp,eg,ep,ev,re,r,rp)
	if rp==1-tp and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then
		e:GetHandler():RegisterFlagEffect(m,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_CHAIN,0,1)
	end
end
function cm.dagcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep~=tp and c:GetFlagEffect(m)~=0
end
function cm.dagop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,m)
	local ct=e:GetHandler():GetCounter(0x18)
	Duel.Damage(1-tp,ct*200,REASON_EFFECT)
end
	--damage2
function cm.damcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,1-tp)
		and (not re or not re:IsHasType(EFFECT_TYPE_ACTIONS) or re:IsHasType(EFFECT_TYPE_CONTINUOUS))
end
function cm.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,m)
	local ct=eg:FilterCount(Card.IsControler,nil,1-tp)
	local ct=e:GetHandler():GetCounter(0x18)
	Duel.Damage(1-tp,ct*200,REASON_EFFECT)
end
function cm.regcon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,1-tp)
		and re and re:IsHasType(EFFECT_TYPE_ACTIONS) and not re:IsHasType(EFFECT_TYPE_CONTINUOUS)
end
function cm.regop2(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(Card.IsControler,nil,1-tp)
	e:GetHandler():RegisterFlagEffect(m,RESET_EVENT+RESETS_STANDARD+RESET_CHAIN,0,1,ct)
end
function cm.damcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(m)>0
end
function cm.damop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,m)
	local labels={e:GetHandler():GetFlagEffectLabel(m)}
	local ct=0
	for i=1,#labels do ct=ct+labels[i] end
	e:GetHandler():ResetFlagEffect(m)
	local ct=e:GetHandler():GetCounter(0x18)
	Duel.Damage(1-tp,ct*200,REASON_EFFECT)
end
	--damage3
function cm.regop3(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	e:GetHandler():RegisterFlagEffect(m,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_CHAIN,0,1)
end
function cm.damcon3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep~=tp and c:GetFlagEffect(m)~=0 and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function cm.damop3(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,m)
	local ct=e:GetHandler():GetCounter(0x18)
	Duel.Damage(1-tp,ct*200,REASON_EFFECT)
end