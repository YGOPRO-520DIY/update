--神依-金元圣灵
function c44460063.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x64a),2)
	c:EnableReviveLimit()
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460063,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,44460063)
	--e1:SetCondition(c44460063.xycon)
	--e1:SetCost(c44460063.xycost)
	e1:SetTarget(c44460063.xytg)
	e1:SetOperation(c44460063.xyop)
	c:RegisterEffect(e1)
	--damage	
	local e21=Effect.CreateEffect(c)
	e21:SetCategory(CATEGORY_DAMAGE+CATEGORY_TOGRAVE)
	e21:SetDescription(aux.Stringid(44460063,1))
	e21:SetType(EFFECT_TYPE_IGNITION)
	e21:SetRange(LOCATION_ONFIELD)
	e21:SetCountLimit(1,44460063)
	e21:SetTarget(c44460063.damtg)
	e21:SetOperation(c44460063.damop)
	c:RegisterEffect(e21)

end
--sy
function c44460063.cfilter(c)
	return (c:IsSetCard(0x64b) or c:IsSetCard(0x64c)) and c:IsAbleToGraveAsCost()
end
function c44460063.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460063.cfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460063.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c44460063.tfilter(c)
	return (c:IsSetCard(0x64b) or c:IsSetCard(0x64c)) and c:IsAbleToGrave()
end
function c44460063.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>-1
        and Duel.IsExistingMatchingCard(c44460063.tfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	--Duel.SetChainLimit(c44460063.climit)
end
function c44460063.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460063.tfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	if g:GetCount()>0 then
	Duel.SendtoGrave(g,REASON_EFFECT)
	local tc=g:GetFirst()
	Duel.Recover(tp,tc:GetAttack(),REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,c)
		local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    c:RegisterEffect(e1)
	end
end
function c44460063.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--damage
function c44460063.damfilter(c)
	return c:IsAbleToGrave()
	and (c:IsSetCard(0x64b) or c:IsSetCard(0x64c))
end
function c44460063.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460063.damfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c44460063.damop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460063.damfilter,tp,LOCATION_ONFIELD,0,1,99,nil)
	if g:GetCount()>0 then
		local ct=Duel.SendtoGrave(g,REASON_EFFECT)
		--if ct>7 then ct=7 end
		Duel.Damage(1-tp,ct*500,REASON_EFFECT)
	    if ct>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetValue(ct*500)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	    end

	end
end
