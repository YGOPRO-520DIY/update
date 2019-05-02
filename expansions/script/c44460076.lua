--古夕幻历-东皇天都
function c44460076.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--sset1
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e11:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e11:SetRange(LOCATION_FZONE)
	e11:SetCountLimit(1,44460076)
	e11:SetCode(EVENT_SUMMON_SUCCESS)
	e11:SetTarget(c44460076.stg)
	e11:SetOperation(c44460076.sop)
	c:RegisterEffect(e11)
end
--sset
function c44460076.setfilter(c)
	return c:IsSetCard(0x680) and not c:IsForbidden() and c:IsType(SUMMON_MONSTER) 
end
function c44460076.tfilter(c)
	return c:IsSetCard(0x679) and c:IsAbleToGrave()
end
function c44460076.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return Duel.IsExistingMatchingCard(c44460076.setfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil)
	and Duel.IsExistingMatchingCard(c44460076.tfilter,tp,LOCATION_ONFIELD,0,1,nil)
	and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 
	and tc:IsSetCard(0x677)
	and tc:GetControler()==tp end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
end
function c44460076.sop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460076.tfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	if g:GetCount()>0 then
	Duel.SendtoGrave(g,REASON_EFFECT)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44460076.setfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,1,nil)
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
end