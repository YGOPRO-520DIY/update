--古夕幻历-灵纹雕
function c44460030.initial_effect(c)
	--DESTROY AND DESTROY
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460030,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,44460030)
	e1:SetCondition(c44460030.con)
	e1:SetCost(c44460030.cost)
	e1:SetTarget(c44460030.target)
	e1:SetOperation(c44460030.operation)
	c:RegisterEffect(e1)
end
function c44460030.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c44460030.con(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c44460030.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c44460030.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c44460030.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGrave()
end
function c44460030.dfilter(c)
	return c:IsType(TYPE_MONSTER) 
end
function c44460030.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c44460030.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c44460030.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,CATEGORY_TOGRAVE)
	local g=Duel.SelectTarget(tp,c44460030.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c44460030.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
	    if tc and Duel.SendtoGrave(tc,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_GRAVE) and tc:IsSetCard(0x679)
		and Duel.IsExistingMatchingCard(c44460030.dfilter,tp,0,LOCATION_MZONE,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(44460030,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g1=Duel.SelectMatchingCard(tp,c44460030.dfilter,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.Destroy(g1,REASON_EFFECT)
		end
	end
end