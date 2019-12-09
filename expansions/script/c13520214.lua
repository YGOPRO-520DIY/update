local m=13520214
local tg={13520200,13520230}
local cm=_G["c"..m]
cm.name="花骑士 杏"
function cm.initial_effect(c)
	--Set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,m)
	e1:SetCost(cm.setcost)
	e1:SetTarget(cm.settg)
	e1:SetOperation(cm.setop)
	c:RegisterEffect(e1)
	--Recover Conversion
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_REVERSE_RECOVER)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function cm.flower(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Set
function cm.costfilter(c)
	return cm.flower(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function cm.setfilter(c)
	return cm.flower(c) and not c:IsForbidden()
end
function cm.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(cm.costfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,cm.costfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
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