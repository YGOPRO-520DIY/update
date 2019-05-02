--古夕幻历-极南仙境
function c44460077.initial_effect(c)
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
	e11:SetCountLimit(1,44460077)
	e11:SetCode(EVENT_SUMMON_SUCCESS)
	e11:SetTarget(c44460077.stg)
	e11:SetOperation(c44460077.sop)
	c:RegisterEffect(e11)
end
--sset
function c44460077.setfilter(c)
	return c:IsSetCard(0x679) and not c:IsForbidden() and c:IsType(SUMMON_MONSTER) 
end
function c44460077.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return Duel.IsExistingMatchingCard(c44460077.setfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil)
	and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 
	and tc:IsSetCard(0x677)
	and tc:GetControler()==tp end
	tc:CreateEffectRelation(e)
end
function c44460077.sop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44460077.setfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,1,nil)
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