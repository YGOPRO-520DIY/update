local m=13520210
local tg={13520200,13520230}
local cm=_G["c"..m]
cm.name="花骑士 油橄榄"
function cm.initial_effect(c)
	c:SetSPSummonOnce(m)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(cm.spcost)
	e1:SetTarget(cm.sptg)
	e1:SetOperation(cm.spop)
	c:RegisterEffect(e1)
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
--Special Summon
function cm.costfilter(c,tp)
	return c:IsFaceup() and cm.flower(c) and c:IsReleasable() and Duel.GetMZoneCount(tp,c)>0
end
function cm.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.costfilter,tp,LOCATION_ONFIELD,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,cm.costfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function cm.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,1)
		e1:SetValue(cm.actlimit)
		Duel.RegisterEffect(e1,tp)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_SSET)
		e2:SetTarget(cm.setlimit)
		Duel.RegisterEffect(e2,tp)
	end
end
function cm.actlimit(e,re,tp)
	return re:IsActiveType(TYPE_FIELD) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function cm.setlimit(e,c,tp)
	return c:IsType(TYPE_FIELD)
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