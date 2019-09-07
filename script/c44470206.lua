--樱虾水缸
function c44470206.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsCode,44470221))
	e2:SetValue(2000)
	c:RegisterEffect(e2)
	--untarget
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetRange(LOCATION_ONFIELD)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsCode,44470221))
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--def1
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_FIELD)
	e21:SetCode(EFFECT_UPDATE_DEFENSE)
	e21:SetRange(LOCATION_ONFIELD)
	e21:SetTargetRange(LOCATION_MZONE,0)
	e21:SetTarget(aux.TargetBoolFunction(Card.IsCode,44470206))
	e21:SetValue(2000)
	c:RegisterEffect(e21)
	--untarget1
	local e31=Effect.CreateEffect(c)
	e31:SetType(EFFECT_TYPE_FIELD)
	e31:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e31:SetRange(LOCATION_ONFIELD)
	e31:SetTargetRange(LOCATION_MZONE,0)
	e31:SetTarget(aux.TargetBoolFunction(Card.IsCode,44470221))
	e31:SetValue(1)
	c:RegisterEffect(e31)
	--sset
	local e44=Effect.CreateEffect(c)
	e44:SetDescription(aux.Stringid(44470206,1))
	e44:SetProperty(EFFECT_FLAG_DELAY)
	e44:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e44:SetCode(EVENT_REMOVE)
	e44:SetCountLimit(1,44470206)
	e44:SetTarget(c44470206.tg)
	e44:SetOperation(c44470206.op)
	c:RegisterEffect(e44)
end
--sset
function c44470206.filter(c)
	return c:IsCode(44470221) and not c:IsForbidden() 
end
function c44470206.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470206.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44470206.op(e,tp,eg,ep,ev,re,r,rp)
	--if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44470206.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	end
end