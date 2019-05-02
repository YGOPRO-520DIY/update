--神装-空想电脑
local m=2049
local cm=_G["c"..m]
function cm.initial_effect(c)
	rsfv.GraveRemovefun(c)
	rsfv.EquipFun(c)
	--dice2
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1,2037)
	e1:SetOperation(cm.operation)
	c:RegisterEffect(e1)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.TossDice(tp,1)
	if d==1 then
		if not c:IsRelateToEffect(e) then return end
		Duel.Destroy(c,REASON_EFFECT)
	elseif d>=3 and d<=5 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		if #g>0 then Duel.Destroy(g,REASON_EFFECT) end
	elseif d>=6 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		if #g<=0 or Duel.Destroy(g,REASON_EFFECT)<=0 then return end  
		local sg=Duel.GetFieldGroup(tp,0,LOCATION_HAND+LOCATION_ONFIELD)
		if #sg<=0 then return end
		Duel.ConfirmCards(tp,sg)
		local dg=sg:Filter(Card.IsCode,nil,g:GetFirst():GetCode())
		if #dg>0 then Duel.Destroy(dg,REASON_EFFECT) end
	end
end
