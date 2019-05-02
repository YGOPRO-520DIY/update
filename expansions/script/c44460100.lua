--古夕幻历-神剑残思
function c44460100.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44460100+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c44460100.target)
	e1:SetOperation(c44460100.activate)
	c:RegisterEffect(e1)
	--remain field
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e3)
	--to extra
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	e11:SetCode(EVENT_LEAVE_FIELD)
	e11:SetCondition(c44460100.tdcon)
	e11:SetTarget(c44460100.tdtg)
	e11:SetOperation(c44460100.tdop)
	c:RegisterEffect(e11)
end
function c44460100.filter(c)
	return c:IsSetCard(0x699) and not c:IsForbidden() and c:IsType(TYPE_MONSTER)
end
function c44460100.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460100.filter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	--destroy
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c44460100.descon)
	e1:SetOperation(c44460100.desop)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	e:GetHandler():RegisterEffect(e1)
	e:GetHandler():RegisterFlagEffect(1082946,RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,2)
	c44460100[e:GetHandler()]=e1
end
function c44460100.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44460100.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c44460100.descon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c44460100.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==2 then
		Duel.Destroy(c,REASON_RULE)
		c:ResetFlagEffect(1082946)
	end
end
--to extra
function c44460100.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and c:GetLocation()~=LOCATION_DECK
end
function c44460100.tefilter(c)
	return c:IsCode(44460111) and c:IsAbleToExtra()
end
function c44460100.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460100.tefilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c44460100.tefilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,g:GetCount(),0,0)
end
function c44460100.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c44460100.tefilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
		local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_EXTRA)
	    if ct>0 then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	    end
	end
end
