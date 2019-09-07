--艾儿
function c44470220.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44470220+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c44470220.target)
	e1:SetOperation(c44470220.activate)
	c:RegisterEffect(e1)
	--attribute
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCode(EFFECT_ADD_ATTRIBUTE)
	e11:SetValue(ATTRIBUTE_WIND)
	c:RegisterEffect(e11)
	--indes
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e12:SetValue(1)
	c:RegisterEffect(e12)
end
function c44470220.filter(c)
	return ((c:IsAttribute(ATTRIBUTE_WATER) and c:GetLevel()<5)
	or c:IsCode(44470221) or c:IsCode(44470219)) and not c:IsForbidden() 
	    --or (c:IsAttribute(ATTRIBUTE_EARTH) and c:GetLevel()<4)
end
function c44470220.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470220.filter,tp,LOCATION_DECK,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44470220.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44470220.filter,tp,LOCATION_DECK,0,1,1,nil)
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