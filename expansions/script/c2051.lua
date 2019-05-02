--神装-妄想幻想
local m=2051
local cm=_G["c"..m]
function cm.initial_effect(c)
	rsfv.GraveRemovefun(c)
	rsfv.EquipFun(c)
	--dice2
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetOperation(cm.operation)
	c:RegisterEffect(e1)	
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.TossDice(tp,1)
	local ct1=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
	if d<=5 then
		if ct1==d then Duel.Destroy(g,REASON_EFFECT) end
	else
		if ct1==#g then Duel.Destroy(g2,REASON_EFFECT) end
	end
end
