--自我改造
local m=2045
local cm=_G["c"..m]
function cm.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_DICE+CATEGORY_DRAW+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetOperation(cm.activate)
	c:RegisterEffect(e1)
end
function cm.filter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x299)
		and Duel.IsExistingMatchingCard(cm.eqfilter,tp,LOCATION_EXTRA,0,1,nil,c,tp)
end
function cm.eqfilter(c,tc,tp)
	return c:IsType(TYPE_FUSION) and not c:IsForbidden() and c:IsSetCard(0x299)
end
function cm.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.TossDice(tp,1)
	if d==1 or d==2 then
		Duel.Damage(tp,1000,REASON_EFFECT)
	elseif d==3 or d==4 then
		if Duel.Recover(tp,1000,REASON_EFFECT)>0 then Duel.Draw(tp,1,REASON_EFFECT) end
	elseif d>=5 then
		if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local tg=Duel.SelectMatchingCard(tp,cm.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
		if #tg<=0 then return end
		Duel.HintSelection(tg)
		local tc=tg:GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local tc2=Duel.SelectMatchingCard(tp,cm.eqfilter,tp,LOCATION_EXTRA,0,1,1,nil,tc,tp):GetFirst()
		if not tc2 then return end
		if not Duel.Equip(tp,tc2,tc) then return end
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(cm.eqlimit)
		tc2:RegisterEffect(e1)
	end
end
function cm.eqlimit(e,c)
	return e:GetOwner()==c
end
