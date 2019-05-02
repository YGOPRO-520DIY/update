--暗杀
local m=2046
local cm=_G["c"..m]
function cm.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_DICE+CATEGORY_DRAW+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCondition(function(e,tp) return Duel.IsExistingMatchingCard(cm.cfilter,tp,LOCATION_MZONE,0,1,nil) end)
	e1:SetTarget(cm.target)
	e1:SetOperation(cm.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	c:RegisterEffect(e2)	
end
function cm.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x299)
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_MZONE,1,nil) end
end
function cm.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.TossDice(tp,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPPO)
	if d==3 or d==4 then
		local dg=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
		if #dg>0 then cm.rmop(dg,tp) end
	elseif d==5 then 
		local dg=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
		if #dg>0 and cm.rmop(dg,tp)>0 then
			Duel.BreakEffect()
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	elseif d>=6 then
		local dg=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
		if #dg>0 and cm.rmop(dg,tp)>0 and c:IsRelateToEffect(e) and c:IsAbleToHand() then
			Duel.BreakEffect()
			c:CancelToGrave()
			Duel.SendtoHand(c,nil,REASON_EFFECT)
		end
	end
end
function cm.rmop(g,tp)
	Duel.HintSelection(g)
	local tc=g:GetFirst()
	local ct=0
	if tc:IsAbleToRemove() and Duel.SelectYesNo(tp,aux.Stringid(m,0)) then
		ct=Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	else
		ct=Duel.Destroy(tc,REASON_EFFECT)
	end
	return ct
end