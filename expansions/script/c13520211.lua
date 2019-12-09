local m=13520211
local tg={13520200,13520230}
local cm=_G["c"..m]
cm.name="花骑士 太平洋菊"
function cm.initial_effect(c)
	--Extra Tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_EXTRA_TRIBUTE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTargetRange(LOCATION_SZONE,0)
	e1:SetTarget(cm.tribute)
	e1:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e1)
	--Set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(cm.settg)
	e2:SetOperation(cm.setop)
	c:RegisterEffect(e2)
	--Send Replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_TO_GRAVE_REDIRECT_CB)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e3:SetCondition(cm.repcon)
	e3:SetOperation(cm.repop)
	c:RegisterEffect(e3)
end
function cm.flower(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Extra Tribute
function cm.tribute(e,c)
	return c:IsFaceup() and cm.flower(c) and c:IsType(TYPE_TRAP)
end
--Set
function cm.setfilter(c)
	return cm.flower(c) and not c:IsForbidden()
end
function cm.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(cm.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function cm.setop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,cm.setfilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(TYPE_TRAP+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		tc:RegisterEffect(e1)
	end
end
--Send Replace
function cm.repcon(e)
	local c=e:GetHandler()
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsReason(REASON_RELEASE)
end
function cm.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(TYPE_TRAP+TYPE_CONTINUOUS)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
	c:RegisterEffect(e1)
end