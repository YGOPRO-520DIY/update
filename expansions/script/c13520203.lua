local m=13520203
local tg={13520200,13520230}
local cm=_G["c"..m]
cm.name="花骑士 番红花"
function cm.initial_effect(c)
	--Set & Draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(cm.setcon)
	e1:SetTarget(cm.settg)
	e1:SetOperation(cm.setop)
	c:RegisterEffect(e1)
	--Damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,2))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_RELEASE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCondition(cm.damcon)
	e2:SetTarget(cm.damtg)
	e2:SetOperation(cm.damop)
	c:RegisterEffect(e2)
end
function cm.flower(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Set & Draw
function cm.cfilter(c)
	return c:GetSequence()<5
end
function cm.setcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(cm.cfilter,tp,LOCATION_SZONE,0,1,nil)
end
function cm.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsForbidden() end
end
function cm.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and not c:IsForbidden() then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e1=Effect.CreateEffect(c)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(TYPE_TRAP+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		c:RegisterEffect(e1)
		if Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,aux.Stringid(m,1)) then
			Duel.BreakEffect()
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
--Damage
function cm.damfilter(c)
	return cm.flower(c) and c:IsFaceup()
end
function cm.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function cm.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.damfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local dam=Duel.GetMatchingGroupCount(cm.damfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)*100
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function cm.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetMatchingGroupCount(cm.damfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)*100
	Duel.Damage(p,dam,REASON_EFFECT)
end