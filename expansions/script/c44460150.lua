--古夕幻历-香兰誓约
function c44460150.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indes
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e11:SetRange(LOCATION_SZONE)
	e11:SetTargetRange(LOCATION_ONFIELD,0)
	e11:SetTarget(c44460150.indtg)
	e11:SetValue(1)
	c:RegisterEffect(e11)
	--atkdown
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD)
	e22:SetCode(EFFECT_UPDATE_ATTACK)
	e22:SetRange(LOCATION_SZONE)
	e22:SetTargetRange(0,LOCATION_MZONE)
	e22:SetTarget(c44460150.atarget)
	e22:SetValue(-600)
	c:RegisterEffect(e22)
	--sset
	local e24=Effect.CreateEffect(c)
	e24:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e24:SetRange(LOCATION_ONFIELD)
	e24:SetCountLimit(1,44460150)
	e24:SetCode(EVENT_SUMMON_SUCCESS)
	e24:SetCondition(c44460150.condition)
	e24:SetTarget(c44460150.stg)
	e24:SetOperation(c44460150.sop)
	c:RegisterEffect(e24)
	--sset
	local e25=Effect.CreateEffect(c)
	e25:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e25:SetRange(LOCATION_ONFIELD)
	e25:SetCountLimit(1,44460150)
	e25:SetCode(EVENT_SUMMON_SUCCESS)
	e25:SetCondition(c44460150.condition2)
	e25:SetTarget(c44460150.stg2)
	e25:SetOperation(c44460150.sop2)
	c:RegisterEffect(e25)
end
--indes
function c44460150.indtg(e,c)
	return (c:IsSetCard(0x677) or c:IsSetCard(0x679)) and c~=e:GetHandler()
end
function c44460150.atarget(e,c)
	return c:IsType(TYPE_EFFECT) 
end
--sset
function c44460150.cfilter(c)
	return c:IsFaceup() and c:IsCode(44460054)
end
function c44460150.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44460150.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c44460150.setfilter(c)
	return c:IsCode(44460050) and not c:IsForbidden() 
end
function c44460150.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460150.setfilter,tp,LOCATION_EXTRA,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44460150.sop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44460150.setfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	end
end
--sset2
function c44460150.cfilter2(c)
	return c:IsFaceup() and c:IsCode(44460050)
end
function c44460150.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44460150.cfilter2,tp,LOCATION_MZONE,0,1,nil)
end
function c44460150.setfilter2(c)
	return c:IsCode(44460054) and not c:IsForbidden() 
end
function c44460150.stg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460150.setfilter2,tp,LOCATION_EXTRA,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44460150.sop2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44460150.setfilter2,tp,LOCATION_EXTRA,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	end
end