local m=13571439
local cm=_G["c"..m]
cm.name="歪秤精灵 可可"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Link
	aux.AddLinkProcedure(c,cm.mfilter,1,1)
	--Cannot Link Material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--To Grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCountLimit(1,m)
	e2:SetCondition(cm.condition)
	e2:SetTarget(cm.target)
	e2:SetOperation(cm.operation)
	c:RegisterEffect(e2)
end
--Link
function cm.mfilter(c)
	return not c:IsLinkType(TYPE_TOKEN)
end
--To Grave
function cm.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function cm.attrfilter(c)
	return c:IsType(TYPE_MONSTER)
end
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,cm.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT)~=0 then
		local tc=Duel.GetOperatedGroup():GetFirst()
		if tc then
			local attr=tc:GetAttribute()
			local sg=Duel.GetMatchingGroup(cm.attrfilter,tp,LOCATION_GRAVE,0,nil)
			local sc=sg:GetFirst()
			while sc do
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
				e1:SetValue(attr)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
				sc:RegisterEffect(e1)
				sc=sg:GetNext()
			end
		end
	end
end